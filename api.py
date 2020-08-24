import requests # make http requestst o api
from pprint import pprint
from api_results import api_res
import os

# API_KEY = os.environ['SPOON_API_KEY']

# # spoonacular's api url
# url = "https://api.spoonacular.com/recipes/random"
#  # api parameters
# payload = {"apiKey": API_KEY, 
#             "number" : 1,
#             "tags" : ""
#             } 

# res = requests.get(url, params=payload)
# data = res.json()

#reads in saved off data from the api instead of needing to make another call
#for testing/seeding with test data
data = api_res()

print(data)

# # list of recipes
recipes_data = data['recipes']
# pprint(recipes_data)

def parse_recipe_instructions(recipe_data):
    """Prase recipe instructions from api response - helper function"""

    recipe_instructions = {}

    list_instructions = []

    data_instructions = recipe_data['analyzedInstructions'][0]['steps']

    for i, step in enumerate(data_instructions):
#         # instructions[str(i + 1)] = step['step']
        list_instructions.append(step['step'])

    recipe_instructions['instructions'] = list_instructions

    return recipe_instructions

def parse_recipe_ings(recipe_data):
    """Parse recipe ingredients from api response - helper function"""
    recipe_ingredients = recipe_data['extendedIngredients']

    recipe_ingredients_list = []
    for ingredient in recipe_ingredients:
        info = {}
        info['ingredient_name'] = ingredient['name']
        info['amount'] = ingredient['amount']
        info['unit'] = ingredient['unit']
        recipe_ingredients_list.append(info)


    return recipe_ingredients_list

def alt_parse_recipe_ings(recipe_data):
    recipe_ingredients = recipe_data['extendedIngredients']

    recipe_ingredients_list = []
    for ingredient in recipe_ingredients:
        recipe_ingredients_list.append(ingredient['originalString'])
    
    return recipe_ingredients_list

recipe_results = []
# # parse only details we need from api endpoint
for recipe in recipes_data:
    data = {}
    data['title'] = recipe['title']
    data['image'] = recipe['image']
    data['steps'] = parse_recipe_instructions(recipe)
    data['time_required'] = recipe['readyInMinutes']
    data['servings'] = recipe['servings']
    data['ingredients'] = alt_parse_recipe_ings(recipe)
    recipe_results.append(data)

print("##################################")
pprint(recipe_results)

def data_for_db():
    return recipe_results
