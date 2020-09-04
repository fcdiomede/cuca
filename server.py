from flask import Flask, render_template, jsonify, request, session
from model import connect_to_db
import crud
import requests
import os
import time
import hashlib
from random import choices

# CLOUDINARY_UPLOAD_URL = "https://api.cloudinary.com/v1_1/deglaze/image/upload"
# CLOUDINARY_API_KEY = os.environ['API_KEY']
# CLOUDINARY_API_SECRET = os.environ['API_SECRET']

app = Flask(__name__)
app.secret_key = "outofthefryingpan"

@app.route('/')
def root():
    return render_template("root.html")

@app.route('/hello')
def hello():
    return jsonify("hello")

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



@app.route('/api/login', methods=['POST'])
def authenticate_user():
    data = request.get_json()
    email = data["email"]
    password = data["password"]

    user = crud.get_user_by_email(email)

    user_data = {"user_id": '', "name":'', "profile_picture":''}

    if user and password == user.password:
        session["user_id"] = user.user_id
        status = "success"
        user_data["user_id"] = user.user_id
        user_data["name"] = user.fname
        user_data["profile_picture"] = user.profile_picture
    else:
        status = "error"


    return jsonify({'status':status, 'user_data':user_data})


@app.route('/api/user/<user_id>')
def get_user_data(user_id):
    user = crud.get_user_by_id(user_id)

    user_data = {
                "user_id":user.user_id,
                "name": user.fname,
                "profile_picture": user.profile_picture}
        
    return jsonify(user_data)

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
    else:
        status = "success"
        new_user = crud.create_user(
                        fname=fname,
                        lname=lname,
                        email=email,
                        password=password)
        session["user_id"] = new_user.user_id
    
    return jsonify({'status':status})


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
                            cover_img="https://res.cloudinary.com/deglaze/image/upload/v1599161258/Heart_font_awesome_ysrcui.png",
                            user_id=user_id)
        cookbook_id = favorite_cookbook.cookbook_id
    
    favorite_recipe = crud.create_recipe(title, cookbook_id, ingredients, time_required, servings, media)
    for index, step in enumerate(steps):
        crud.create_step(favorite_recipe.recipe_id, index+1, step["body"], step["photo"])

    return jsonify("Success")


@app.route('/api/update-user-profile', methods=['POST'])
def update_user_profile():
    data = request.get_json()
    fname = data.get("fname", None)
    profile_picture = data.get("photo", "/static/img/chef_hat.png")

    user_id = session["user_id"]

    user = crud.update_user(user_id, fname, profile_picture)

    user_data = {"name": user.fname, "profile_picture": user.profile_picture}

    return jsonify(user_data)

@app.route('/api/delete-recipe', methods=['POST'])
def delete_recipe():
    recipe_id = request.get_json()

    crud.delete_recipe(recipe_id)

    return jsonify("Deleted")


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


@app.route('/api/random-data')
def random_data():
    cookbooks = crud.all_cookbooks()

    random_cookbooks = choices(cookbooks, k=10)

    cookbook_data = []
    for c in random_cookbooks:
        cookbook_data.append({"key": c.cookbook_id,
                            "title": c.title, 
                            "imgUrl": c.cover_img
                                })

    print(random_cookbooks)

    return jsonify({'cookbooks':cookbook_data})


@app.route('/api/search/users', methods=['POST'])
def search():
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

    print(following_list)

    return jsonify(following_list)


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

if __name__ == '__main__':
    connect_to_db(app)
    app.run(host='0.0.0.0')

