from flask import Flask, render_template, jsonify, request, session
from model import connect_to_db
import crud
import requests
import os
import time
import hashlib
from random import choices
from flask_bcrypt import Bcrypt
from twilio.rest import Client


app = Flask(__name__, static_folder='build', static_url_path='/')
app.secret_key = "outofthefryingpan"
bcrypt = Bcrypt()

# Twilio account SID
TWILIO_SID = os.environ["TWILIO_SID"]
# Twilio Auth Token
TWILIO_TOKEN = os.environ["TWILIO_TOKEN"]


@app.route('/')
def root():
    return app.send_static_file('index.html')


#User registration/authentication roots---------------------------------------#
@app.route('/api/login', methods=['POST'])
def authenticate_user():
    data = request.get_json()
    email = data["email"]
    password = data["password"]

    user = crud.get_user_by_email(email)

    user_data = {"user_id": '', "name":'', "profile_picture":''}

    if user and bcrypt.check_password_hash(user.password, password):
        session["user_id"] = user.user_id
        status = "success"
        user_data["user_id"] = user.user_id
        user_data["name"] = user.fname
        user_data["profile_picture"] = user.profile_picture
    else:
        status = "error"

    return jsonify({'status':status, 'user_data':user_data})


@app.route('/api/create-account', methods=['POST'])
def create_user():
    data = request.get_json()
    email = data["email"]
    password = data["password"]
    fname = data["fname"]
    lname = data["lname"]

    user = crud.get_user_by_email(email)

    if user:
        status = "error"
        user_data = ""
    else:
        status = "success"

        new_user = crud.create_user(
                        fname=fname,
                        lname=lname,
                        email=email,
                        password= bcrypt.generate_password_hash(password).decode('utf-8')
                    )
        session["user_id"] = new_user.user_id
        print(new_user)
        user_data = {
            "user_id": new_user.user_id,
            "name": new_user.fname,
            "profile_picture": new_user.profile_picture
        }
        
    return jsonify({'status':status, 'user_data':user_data})


#User's homepage routes-------------------------------------------------------#
@app.route('/api/user-cookbooks/<user_id>')
def get_user_cookbooks(user_id):

    cookbooks = crud.cookbooks_by_user_id(user_id)
    cookbook_list = []

    for c in cookbooks:
       cookbook_list.append({"key": c.cookbook_id,
                            "title": c.title, 
                            "imgUrl": c.cover_img})

    return jsonify(cookbook_list)


@app.route('/api/set-cookbook', methods=['POST'])
def set_cookbook():
    data = request.get_json()
    cookbook_id = data["cookbookId"]
    session["cookbook_id"] = cookbook_id
    print(session)
    return jsonify({"cookbook_id":cookbook_id})


@app.route('/api/update-user-profile', methods=['POST'])
def update_user_profile():
    data = request.get_json()
    fname = data.get("fname", None)
    profile_picture = data.get("photo", "/static/img/chef_hat.png")

    user_id = session["user_id"]

    user = crud.update_user(user_id, fname, profile_picture)

    user_data = {"name": user.fname, "profile_picture": user.profile_picture}

    return jsonify(user_data)


@app.route('/api/connections/<user_id>')
def get_user_connections(user_id):
    user = crud.get_user_by_id(user_id)

    connections = user.connections

    following_list = []
    for connection in connections:
        friend_id = connection.friend_id
        friend = crud.get_user_by_id(friend_id)
        following_list.append({
            "friend_id": friend_id,
            "friend_name" : friend.fname,
            "friend_picture" : friend.profile_picture
        })

    return jsonify(following_list)


#Viewing another user's profile routes-----------------------------------------#
@app.route('/api/user/<user_id>')
def get_user_data(user_id):
    user = crud.get_user_by_id(user_id)

    user_data = {
                "user_id":user.user_id,
                "name": user.fname,
                "profile_picture": user.profile_picture}
        
    return jsonify(user_data)


@app.route('/api/favorite/<recipe_id>', methods=['POST'])
def favorite_recipe(recipe_id):

    recipe = crud.get_recipe_by_id(recipe_id)
    user_id = session["user_id"]

    title =  recipe.title,
    ingredients = recipe.ingredients,
    time_required = recipe.time_required,
    servings = recipe.servings
    media = recipe.media
    steps = []
    
    recipe_steps = crud.get_steps_for_recipe(recipe_id)

    for step in recipe_steps:
        steps.append({"key": step.step_id,
                    "num": step.step_number, 
                    "body": step.body,
                    "photo": step.media})

    user_cookbooks = crud.cookbooks_by_user_id(user_id)

    for cookbook in user_cookbooks:
        if cookbook.title == "Favorites":
            cookbook_id = cookbook.cookbook_id
            break
    else:
        favorite_cookbook = crud.create_cookbook(title="Favorites",
                            cover_img="https://res.cloudinary.com/deglaze/image/upload/v1599794813/cuca/mk97fg3bmftk2zw9fsm0.jpg",
                            user_id=user_id)
        cookbook_id = favorite_cookbook.cookbook_id
    
    favorite_recipe = crud.create_recipe(title, cookbook_id, ingredients, time_required, servings, media)
    for index, step in enumerate(steps):
        crud.create_step(favorite_recipe.recipe_id, index+1, step["body"], step["photo"])

    return jsonify("Success")


@app.route('/api/check-connection', methods=['POST'])
def check_connection():
    logged_in_user_id = session["user_id"]
    user_following_id = request.get_json()

    logged_in_user = crud.get_user_by_id(logged_in_user_id)
    
    #Get the user's current connections
    connections = logged_in_user.connections
    
    #Get each of the user ids associated with the connections
    for connection in connections:
        friend_id = connection.friend_id
        
        if int(friend_id) == int(user_following_id):
            return jsonify(True)
    
    return jsonify(False)


@app.route('/api/follow-user', methods=['POST'])
def follow_user():
    logged_in_user_id = session["user_id"]
    user_to_follow_id = request.get_json()

    connection = crud.create_connection(logged_in_user_id, user_to_follow_id)

    return jsonify("Success")


@app.route('/api/unfollow-user', methods=['POST'])
def unfollow_user():
    logged_in_user_id = session["user_id"]
    user_to_unfollow_id = request.get_json()

    connection = crud.delete_connection(logged_in_user_id, user_to_unfollow_id)

    return jsonify("Deleted")


#User cookbook routes----------------------------------------------------------#
@app.route('/api/cookbook-details')
def get_cookbook_details():

    cookbook_id = session["cookbook_id"]
    creator = crud.get_user_id_for_cookbook(cookbook_id)
    creator_id = creator.user_id

    cookbook = crud.get_cookbook_by_id(cookbook_id)
    recipes = crud.get_cookbook_recipes(cookbook_id)

    data = {"creator_id": creator_id,
            "title": cookbook.title,
            "cover_img" : cookbook.cover_img,
             "recipes": []}

    for recipe in recipes:
        data["recipes"].append({
                            "recipe_id": recipe.recipe_id,
                            "title" : recipe.title
        })

    return jsonify(data)


@app.route('/api/recipe-details/<recipe_id>', methods=['POST'])
def get_recipe_steps(recipe_id):

    recipe = crud.get_recipe_by_id(recipe_id)

    data = {
            "recipe_id" : recipe_id,
            "title": recipe.title,
            "ingredients": recipe.ingredients,
            "time_required": recipe.time_required,
            "servings": recipe.servings,
            "media": recipe.media,
            "steps": []}
    
    steps = crud.get_steps_for_recipe(recipe_id)

    for step in steps:
        data["steps"].append({"key": step.step_id,
                    "num": step.step_number, 
                    "body": step.body,
                    "photo": step.media})
    
    
    return jsonify(data)


@app.route('/api/send-ingredients', methods=['POST'])
def send_ingredients():
    data = request.get_json()
    recipe_title = data.get("title", " ")
    ingredients = data.get("ingredients", " ")
    phone_number = data["phoneNum"]

    ingredients = ('\n').join(ingredients)

    client = Client(TWILIO_SID, TWILIO_TOKEN)

    message = client.messages.create(
        to=f'{phone_number}',
        from_="+13605260351",
        body=f'\nReady to get cooking?\n'
             f'{recipe_title} ingredients:\n'
             f'{ingredients}'
             )

    return jsonify('Ingredients sent to your phone!')


#Modifying a recipe routes-----------------------------------------------------#
@app.route('/api/save', methods=['POST'])
def save_recipe():
    data = request.get_json()
    recipe_id = data.get("recipeId", None)
    title = data["title"]
    time_required = data.get("readyInMins", None)
    servings = data.get("servings", None)
    ingredients = data.get("ingredients", None)
    steps = data.get("steps", None)
    photo= data.get("photo", None)

    if recipe_id:
        #if editing the recipe values, update the table row
        saved_recipe = crud.update_recipe(recipe_id, title, ingredients, 
                                            time_required, servings, photo)
    else:
        #if a new recipe (assumed to not have an id) is created, create a
        #new entry in recipe table
        cookbook_id = session['cookbook_id']
        saved_recipe = crud.create_recipe(title, cookbook_id, ingredients, time_required, servings, photo)
        
    recipe_id = saved_recipe.recipe_id
    
    #create the new steps
    for index, step in enumerate(steps):
        crud.create_step(recipe_id, index+1, step["body"], step["photo"])

    data = {
            "recipe_id": recipe_id,
            "title": saved_recipe.title,
            "ingredients": saved_recipe.ingredients,
            "time_required": saved_recipe.time_required,
            "servings": saved_recipe.servings,
            "media": saved_recipe.media,
            "steps": []}
    
    steps = crud.get_steps_for_recipe(recipe_id)

    for step in steps:
        data["steps"].append({"key": step.step_id,
                    "num": step.step_number, 
                    "body": step.body,
                    "photo": step.media})
    
    
    return jsonify(data)


@app.route('/api/delete-recipe', methods=['POST'])
def delete_recipe():
    recipe_id = request.get_json()

    crud.delete_recipe(recipe_id)

    return jsonify("Deleted")


#Modifying a cookbook routes---------------------------------------------------#
@app.route('/api/save-cookbook', methods=['POST'])
def save_cookbook():
    data = request.get_json()
    title = data["title"]
    photo = data["photo"]
    mode = data["mode"]
    cookbook_id = data.get("cookbookId", None)

    user_id = session["user_id"]

    if mode == "edit":
        crud.update_cookbook(title, photo, cookbook_id)
    else:
        crud.create_cookbook(title, photo, user_id)

    cookbook_data = {'title': title, 'photo': photo}

    return jsonify(cookbook_data)


@app.route('/api/delete-cookbook')
def delete_cookbook():
    cookbook_id = session["cookbook_id"]

    crud.delete_cookbook(cookbook_id)

    return jsonify('cookbook deleted')


#Explore page routes-----------------------------------------------------------#
@app.route('/api/random-data')
def random_data():
    cookbooks = crud.all_cookbooks()

    random_cookbooks = set(choices(cookbooks, k=10))

    cookbook_data = []
    for c in random_cookbooks:
        cookbook_data.append({"key": c.cookbook_id,
                            "title": c.title, 
                            "imgUrl": c.cover_img,
                            "creator_id" : c.user.user_id
                                })


    return jsonify({'cookbooks':cookbook_data})


@app.route('/api/search/users', methods=['POST'])
def search_users():
    data=request.get_json()
    search_term = data["searchTerm"]

    search_results = []
    users = crud.search_for_user(search_term)
    for user in users:
        search_results.append({"user_id": user.user_id,
                                "fname": user.fname,
                                "lname": user.lname,
                                "email": user.email,
                                "profile_picture": user.profile_picture
                                })

    return jsonify(search_results)


@app.route('/api/search/recipes', methods=['POST'])
def search_recipes():
    data=request.get_json()
    search_term = data["searchTerm"]

    search_results = []
    recipes = crud.search_for_recipe(search_term)
    for recipe in recipes:
        search_results.append({"recipe_id": recipe.recipe_id,
                                "title" : recipe.title,
                                "cover_photo": recipe.media,
                                "time_req": recipe.time_required,
                                "ingredients": recipe.ingredients,
                                "cookbook_id": recipe.cookbooks.cookbook_id
                                })

    return jsonify(search_results)



if __name__ == '__main__':
    connect_to_db(app)
    app.run(host='0.0.0.0')

