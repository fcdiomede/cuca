from flask import Flask, render_template, jsonify, request, session
from model import connect_to_db
import crud
import requests
import os
import time
import hashlib

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

@app.route('/api/user-cookbooks')
def get_user_cookbooks():

    user_id = session["user_id"]
    
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
    recipes = crud.get_cookbook_recipes(cookbook_id)
    data = {}

    for recipe in recipes:
        data[recipe.recipe_id] = recipe.title
    
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
                    "body": step.body})
    
    
    return jsonify(data)



@app.route('/api/login', methods=['POST'])
def authenticate_user():
    data = request.get_json()
    email = data["email"]
    password = data["password"]

    user = crud.get_user_by_email(email)

    if user and password == user.password:
        session["user_id"] = user.user_id
        status = "success"
    else:
        status = "error"
    
    return jsonify({'status':status})

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
        crud.create_step(recipe_id, index+1, step)

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
                    "body": step.body})
    
    
    return jsonify(data)


@app.route('/api/delete-recipe', methods=['POST'])
def delete_recipe():
    recipe_id = request.get_json()

    crud.delete_recipe(recipe_id)

    return jsonify("Deleted")


@app.route('/api/new-cookbook', methods=['POST'])
def save_cookbook():
    data = request.get_json()
    title = data["title"]
    photo = data["photo"]

    user_id = session["user_id"]

    crud.create_cookbook(title, photo, user_id)

    return jsonify('success')


@app.route('/api/delete-cookbook')
def delete_cookbook():
    cookbook_id = session["cookbook_id"]

    crud.delete_cookbook(cookbook_id)

    return jsonify('cookbook deleted')

if __name__ == '__main__':
    connect_to_db(app)
    app.run(host='0.0.0.0')

