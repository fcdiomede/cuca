"""CRUD operations."""

from model import db, connect_to_db, Cookbook, Recipe, Step, User

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


def create_cookbook(title, cover_img, user_id, deleted=False):
    """Create and return and new cookbook"""

    cookbook = Cookbook(title=title, cover_img=cover_img, user_id=user_id,
                        deleted=False)

    db.session.add(cookbook)
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


def get_cookbook_recipes(cookbook_id):
    """Return all recipes associated with a cookbook"""

    cookbook = get_cookbook_by_id(cookbook_id)

    return cookbook.recipes


def create_recipe(title, cookbook_id, ingredients=None, time_required=None, 
                    servings=None, media=None, deleted=False):
    """Create and return a new recipe"""

    recipe = Recipe(title=title, cookbook_id=cookbook_id, ingredients=ingredients, 
                    time_required=time_required, servings=servings, media=media)

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
    """Returns all recipes"""

    return Recipe.query.all()


def create_step(recipe_id, step_number, body, media=None):
    """Create and return a recipe step"""

    step = Step(recipe_id=recipe_id, step_number=step_number, 
                body=body, media=media)

    db.session.add(step)
    db.session.commit()

    return step


def get_recipe_by_id(recipe_id):

    return Recipe.query.get(recipe_id)

def get_steps_for_recipe(recipe_id):
    
    recipe = get_recipe_by_id(recipe_id)

    return recipe.steps


if __name__ == '__main__':
    from server import app
    connect_to_db(app)