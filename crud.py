"""CRUD operations."""

from model import db, connect_to_db, Cookbook, Recipe, Step, User, Connection

#CRUD ops that return users---------------------------------------------------#
def create_user(fname, lname, email, password, 
                profile_picture="/static/img/chef_hat.png"):
    """Create and return a new user"""

    user = User(fname=fname, lname=lname, email=email, password=password,
                profile_picture=profile_picture)

    db.session.add(user)
    db.session.commit()

    return user


def all_users():
    """Return a list of all users"""

    return User.query.all()


def get_user_by_email(user_email):
    """Return a specifc user by email address"""

    return User.query.filter_by(email=user_email).first()


def get_user_by_id(user_id):
    """Return a specific user by their id"""

    return User.query.get(user_id)


def update_user(user_id, fname, profile_picture):
    """Update a user's name and profile picture"""

    user = get_user_by_id(user_id)
    user.fname = fname
    user.profile_picture = profile_picture

    db.session.commit()

    return user


def get_user_id_for_cookbook(cookbook_id):
    """Return user associated with cookbook id"""

    cookbook = Cookbook.query.get(cookbook_id)

    user = cookbook.user

    return user


def search_for_user(search_term):
    """Search for a user based on a search term"""

    users = []

    similar_first_name = User.query.filter(User.fname.ilike(f'%{search_term}%'))
    similar_last_name =  User.query.filter(User.lname.ilike(f'%{search_term}%'))
    similar_email = User.query.filter(User.email.ilike(f'%{search_term}%'))

    users.extend(similar_first_name)
    users.extend(similar_last_name)
    users.extend(similar_email)

    #eliminate duplicate results
    users = set(users)

    return users


#CRUD ops that return Cookbooks------------------------------------------------#
def create_cookbook(title, cover_img, user_id, deleted=False):
    """Create and return and new cookbook"""

    cookbook = Cookbook(title=title, cover_img=cover_img, user_id=user_id,
                        deleted=deleted)

    db.session.add(cookbook)
    db.session.commit()

    return cookbook


def update_cookbook(title, cover_img, cookbook_id):
    """Update a cookbook"""

    cookbook = get_cookbook_by_id(cookbook_id)

    cookbook.title = title
    cookbook.cover_img = cover_img

    db.session.commit()

    return cookbook



def all_cookbooks():
    """Return a list of all cookbooks that are not deleted"""

    return Cookbook.query.filter_by(deleted=False).all() 


def cookbooks_by_user_id(user_id):
    """Return a list of all cookbooks for a particular user"""

    user = User.query.get(user_id)

    user_cookbooks = Cookbook.query.filter(Cookbook.user_id == user_id, 
                                            Cookbook.deleted == False)

    return user_cookbooks.all()


def get_cookbook_by_id(cookbook_id):
    """Return cookbook object for specific cookbook id"""

    return Cookbook.query.get(cookbook_id)


def delete_cookbook(cookbook_id):
    """Mark a cookbook as deleted"""

    cookbook = get_cookbook_by_id(cookbook_id)
    cookbook.deleted = True

    db.session.commit()


#CRUD ops that return Recipes__------------------------------------------------#
def create_recipe(title, cookbook_id, ingredients, time_required, servings, 
                    media=None, deleted=False):
    """Create and return a new recipe"""

    recipe = Recipe(title=title, cookbook_id=cookbook_id, ingredients=ingredients, 
                    time_required=time_required, servings=servings, media=media,
                    deleted=deleted)

    db.session.add(recipe)
    db.session.commit()

    return recipe


def update_recipe(recipe_id, title, ingredients, time_required, 
                    servings, media=None):
    """Update an exisiting recipe"""
    
    recipe = get_recipe_by_id(recipe_id)

    recipe.title = title
    recipe.ingredients = ingredients
    recipe.time_required = time_required
    recipe.servings = servings
    recipe.media = media

    delete_recipe_steps(recipe_id)

    db.session.commit()

    return recipe
    
    
def delete_recipe_steps(recipe_id):
    current_steps = get_steps_for_recipe(recipe_id)

    for step in current_steps:
        db.session.delete(step)
    
    db.session.commit()


def all_recipes():
    """Returns all recipes not marked as deleted"""
    
    return Recipe.query.filter(Recipe.deleted == False).all()


def get_cookbook_recipes(cookbook_id):
    """Return all recipes associated with a cookbook"""

    cookbook = get_cookbook_by_id(cookbook_id)

    cookbook_recipes = Recipe.query.filter( (Recipe.cookbook_id == cookbook_id) &
                                            (Recipe.deleted == False) )


    return cookbook_recipes.all()


def get_recipe_by_id(recipe_id):
    """Returns a recipe object that matches id input"""

    return Recipe.query.get(recipe_id)


def delete_recipe(recipe_id):
    """Marks a recipe as deleted"""

    recipe = get_recipe_by_id(recipe_id)
    recipe.deleted = True
    print(recipe.deleted)

    db.session.commit()


def search_for_recipe(search_term):
    """Search for a recipe based on a search term"""

    recipes = []

    similar_title = Recipe.query.filter(Recipe.title.ilike(f'%{search_term}%'))
    similar_ingredients = Recipe.query.filter(Recipe.ingredients.ilike(f'%{search_term}%'))

    recipes.extend(similar_title)
    recipes.extend(similar_ingredients)

    return recipes


#CRUD ops that return Steps---------------------------------------------------#
def create_step(recipe_id, step_number, body, media=None):
    """Create and return a recipe step"""

    step = Step(recipe_id=recipe_id, step_number=step_number, 
                body=body, media=media)

    db.session.add(step)
    db.session.commit()

    return step


def get_steps_for_recipe(recipe_id):
    """Returns steps for a specific recipe"""
    
    recipe = get_recipe_by_id(recipe_id)

    return recipe.steps


#CRUD ops that return Connection between Users--------------------------------#
def create_connection(user_id, friend_id):

    connection = Connection(user_id=user_id, friend_id=friend_id)

    db.session.add(connection)
    db.session.commit()

    return connection


def delete_connection(user_id, friend_id):

    connection = Connection.query.filter( (Connection.user_id == user_id) &
                                            (Connection.friend_id == friend_id) ).one()

    db.session.delete(connection)
    db.session.commit()





if __name__ == '__main__':
    from server import app
    connect_to_db(app)