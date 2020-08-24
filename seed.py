import os
import json
from random import choice, randint
from faker import Faker

import crud
import model
import server

from api import data_for_db

os.system('dropdb recipeapp')
os.system('createdb recipeapp')

model.connect_to_db(server.app)
model.db.create_all()

fake = Faker()

recipes_for_db = data_for_db()

#create fake users
for i in range(10):
    fname = fake.first_name()
    lname = fake.last_name()
    email = f"{fname[0]}{lname}@email.com"
    password = "test"

    user = crud.create_user(fname, lname, email, password)

#For each user, create 2 fake cookbooks
users = crud.all_users()

for user in users:
    for i in range(2):
        cookbook_title = choice(['Dinner', 'Lunch', 'Dessert','Breakfast'])
        cookbook_img = f"/static/img/cooking_{randint(1,7)}.jpg"

        cookbook = crud.create_cookbook(cookbook_title, cookbook_img, 
                                        user.user_id)

#create fake recipes
cookbooks = crud.all_cookbooks()

for cookbook in cookbooks:
    for i in range(2):
        random_recipe = choice(recipes_for_db)
        recipe_title = random_recipe['title']
        time_required = f"{random_recipe['time_required']} mins"
        servings = random_recipe['servings']
        media = random_recipe['image']
        ingredients = (", ").join(random_recipe['ingredients'])

        new_recipe = crud.create_recipe(recipe_title, cookbook.cookbook_id, ingredients, time_required, 
                                servings, media)


        steps = random_recipe['steps']['instructions']
        print(steps)
        for step_number, step in enumerate(steps):
            number = step_number + 1
            body = step
            
            crud.create_step(new_recipe.recipe_id, number, body)
