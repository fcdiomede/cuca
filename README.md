# <img src="https://res.cloudinary.com/deglaze/image/upload/v1599619675/cuca/mestre_cuca_color_gdptwp.svg" width="40%" alt="Mestre Cuca">
Cuca (pronounced Cook-Ah) is a recipe sharing web application that was inspired by the human need for connection, especially during Covid times. And what makes us feel closer to loved ones than enjoying a favorite family recipe? Through this application, users can quickly see anyone’s cookbook collections, save off favorite recipes, and edit recipes to best suit their own tastes. Cuca is a single page web app, built using React, a Python/Flask backend, and PostgresQL database to store user added data.

## About Me
Fernanda is an engineer with a curious mind. With a MS in Textile Engineering, she started her career as a Supply Chain Manager at a large manufacturer of performance wear. She fell in love with programming when she had to create a database to optimize supply chain decisions. She realized coding was her true calling and decided to change careers. She joined Epic, the healthcare software company, as a Techincal Support Engineer, helping users with system performance and efficiency. The position allowed her to take full advantage of her extensive communications and problem-solving skills, as well as experience firsthand the impact of good and bad code on users and, by extension, thousands of patients. Ultimately, she chose to pursue Hackbright because she wants to be the one writing the code, not just seeing its impact.

Fernanda is also a puzzle enthusiast and gamer. She loves solving complex problems, learning new concepts, and building solutions. Fernanda is eager to combine her technical skills and creative thinking into a career in Software Engineering.

## Contents
* [Tech Stack](#tech-stack)
* [Features](#features)
* [Future State](#future)
* [Installation](#installation)

## <a name="tech-stack"></a>Technologies
* React
* Python
* Flask
* PostgreSQL
* SQLAlchemy ORM
* HTML
* CSS
* Bootstrap
* Cloundinary SDK

## <a name="features"></a>Features

#### Landing Page
The landing page is where users can login or sign up. Cuca uses React Hook Form to implement form validation. The form will not submit until valid input is provided. Once submitted, the front end makes a request to the backend to validate user email and password. Cuca uses Python's BCrypt library to salt and hash passwords stored in the database. 

Cuca 2.0 will use OAuth for more robust security. 

![alt text](https://github.com/fcdiomede/cuca/blob/master/static/Readme-imgs/Login.gif "Cuca landing page")

#### Homepage
Once a user is logged in, they can view their cookbooks, favorited recipes, and friends list. From here, they can add a new cookbook, edit exisiting cookbook covers, or go into a cookbook to view the contents. 

![alt text](https://github.com/fcdiomede/cuca/blob/master/static/Readme-imgs/hompage.png "Cuca Homepage")

#### Viewing Friend's Profiles
A user can easily see what any of their "Sous Chefs" are up to. Access to edit or add addtional cookbooks is restricted using React Conditional Rendering. If the content creator id does not match the logged in user id, the components that would allow editing are not rendered. 

![alt text](https://github.com/fcdiomede/cuca/blob/master/static/Readme-imgs/Screen%20Shot%202020-09-11%20at%204.50.28%20PM.png "User Profile page")

#### Searching
A user can go to the explore page to see a random collection of cookbooks or a user can search for specific recipes or other users on the app. 

![alt text](https://github.com/fcdiomede/cuca/blob/master/static/Readme-imgs/cuca-search.gif "Search Results page")

#### Viewing Recipes and Favoriting
Once a user clicks on a cookbook, they can view the recipes stored in that cookbook.  The user then has easy access to view and edit that recipe.

The user can favorite a recipe, which prompts the server to make a copy of that recipe and save it into a "Favorites" cookbook that belongs to the logged in user.

![alt text](https://github.com/fcdiomede/cuca/blob/master/static/Readme-imgs/cuca-favoriting.gif "Favorite a recipe")

The user then has easy access to view and edit their copy of that recipe.

![alt text](https://github.com/fcdiomede/cuca/blob/master/static/Readme-imgs/cuca-see-favorites.gif "View favorites")

#### Recipe Editor
If they are the recipe owner, a user can edit or add recipes to the cookbook.

The recipe editor features a drag and drop feature:

![alt text](https://github.com/fcdiomede/cuca/blob/master/static/Readme-imgs/cuca-dnd.gif "Drag and drop steps")

The recipe editor also integrates with Cloudinary for image uploading and storage. This allows users to either use pictures saved on their laptop, take pictures with a camera and upload it directly as they are cooking, or pull images from a social media account.

![alt text](https://github.com/fcdiomede/cuca/blob/master/static/Readme-imgs/cuca-img-uploading.gif "Cloudinary Uploader")

## <a name="future"></a>Future State
The project roadmap for Cuca has several features planned out for the next sprint:
* Comments section on recipes for users to ask for clarification on any step
* Built-in unit conversion for recipe ingredients
* Saving a grocery list for a recipe, and sending that list to your phone
* Suggesting a recipe a user could make from their personal and saved recipes based on ingredients the user has on hand
* Image processing so the user can take a photo of a recipe and populate the recipe form fields automatically
* Newsfeed for a user to view recent activity by any users they are following
* Use OAuth for authentication
* More complex search capabilities


## Installation

#### Prerequisites

You'll need some package managers.

- `npm`
- `pip`

#### Setup

For the backend:

```
virtualenv venv
source venv/bin/activate
pip install -r requirements.txt
```

For the frontend:

```
npm install
```

#### Setting up the databse

```
createdb recipeapp
python3 -i model.py
>>>db.create_all()
python3 seed.py
```

#### Running the app
To run locally, you will need two terminal windows. 
In the first window run:
```
source venv/bin/activate
python3 server.py
```

In the second window run:
```
source venv/bin/activate
npm start
```

You should now be able to access the site at localhost:3000

