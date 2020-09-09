# <img src="https://res.cloudinary.com/deglaze/image/upload/v1599619675/cuca/mestre_cuca_color_gdptwp.svg" width="40%" alt="Mestre Cuca">
Cuca (pronounced Cook-Ah) is a recipe sharing web application that was inspired by the human need for connection, especially during Covid times. And what makes us feel closer to loved ones than enjoying a favorite family recipe? Through this application, users can quickly see anyone’s cookbook collections, save off favorite recipes, and edit recipes to best suit their own tastes. Cuca is a single page web app, built using React, a Python/Flask backend, and PostgresQL database to store user added data.

## About Me
Fernanda is an engineer with a curious mind. With a MS in Textile Engineering, she started her career as a Supply Chain Manager at a large manufacturer of performance wear. She fell in love with programming when she had to create a database to optimize supply chain decisions. She realized coding was her true calling and decided to change careers. She joined Epic, the healthcare software company, as a Techincal Support Engineer, helping users with system performance and efficiency. The position allowed her to take full advantage of her extensive communications and problem-solving skills, as well as experience firsthand the impact of good and bad code on users and, by extension, thousands of patients. Ultimately, she chose to pursue Hackbright because she wants to be the one writing the code, not just seeing its impact.

Fernanda is also a puzzle enthusiast and gamer. She loves solving complex problems, learning new concepts, and building solitions. Fernanda is eager to combine her technical skills and creative thinking into a career in Software Engineering.

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

#### Login Page
Users login or register for an account. 

#### Homepage
Once a user is logged in, they can view their cookbooks, favorited recipes, and friends list. From here, they can add a new cookbook, edit exisiting cookbook covers, or go into a cookbook to view the contents. 

#### Recipes
Once a user clicks on a cookbook, they can view the recipes stored in that cookbook. 

#### Recipe Editor
If they are the recipe owner, a user can edit or add recipes to the cookbook.

#### Searching
A user can go to the explore page to see a random collection of cookbooks or a user can search for specific recipes or other users on the app. 

#### Interaction with Other Users
A user can follow a specific user for easy access to that user's recipes, or favorite any recipe they wish to save.

## <a name="future"></a>Future State
The project roadmap for Cuca has several features planned out for the next sprint:
* Comments section on recipes for users to ask for clarification on any step
* Built-in unit conversion for recipe ingredients
* Saving a grocery list for a recipe, and sending that list to your phone
* Suggesting a recipe a user could make from their personal and saved recipes based on ingredients the user has on hand
* Image processing so the user can take a photo of a recipe and populate the recipe form fields automatically
* Newsfeed for a user to view recent activity by any user's they are following
* Use OAuth for authentication


## Installation

This project was bootstrapped with [Create React App](https://github.com/facebook/create-react-app).

## Available Scripts

In the project directory, you can run:

### `npm start`

Runs the app in the development mode.<br />
Open [http://localhost:3000](http://localhost:3000) to view it in the browser.

The page will reload if you make edits.<br />
You will also see any lint errors in the console.

### `npm test`

Launches the test runner in the interactive watch mode.<br />
See the section about [running tests](https://facebook.github.io/create-react-app/docs/running-tests) for more information.

### `npm run build`

Builds the app for production to the `build` folder.<br />
It correctly bundles React in production mode and optimizes the build for the best performance.

The build is minified and the filenames include the hashes.<br />
Your app is ready to be deployed!

See the section about [deployment](https://facebook.github.io/create-react-app/docs/deployment) for more information.

### `npm run eject`

**Note: this is a one-way operation. Once you `eject`, you can’t go back!**

If you aren’t satisfied with the build tool and configuration choices, you can `eject` at any time. This command will remove the single build dependency from your project.

Instead, it will copy all the configuration files and the transitive dependencies (webpack, Babel, ESLint, etc) right into your project so you have full control over them. All of the commands except `eject` will still work, but they will point to the copied scripts so you can tweak them. At this point you’re on your own.

You don’t have to ever use `eject`. The curated feature set is suitable for small and middle deployments, and you shouldn’t feel obligated to use this feature. However we understand that this tool wouldn’t be useful if you couldn’t customize it when you are ready for it.

## Learn More

You can learn more in the [Create React App documentation](https://facebook.github.io/create-react-app/docs/getting-started).

To learn React, check out the [React documentation](https://reactjs.org/).

### Code Splitting

This section has moved here: https://facebook.github.io/create-react-app/docs/code-splitting

### Analyzing the Bundle Size

This section has moved here: https://facebook.github.io/create-react-app/docs/analyzing-the-bundle-size

### Making a Progressive Web App

This section has moved here: https://facebook.github.io/create-react-app/docs/making-a-progressive-web-app

### Advanced Configuration

This section has moved here: https://facebook.github.io/create-react-app/docs/advanced-configuration

### Deployment

This section has moved here: https://facebook.github.io/create-react-app/docs/deployment

### `npm run build` fails to minify

This section has moved here: https://facebook.github.io/create-react-app/docs/troubleshooting#npm-run-build-fails-to-minify
