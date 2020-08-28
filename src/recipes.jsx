import React from "react";
import { CreateNewCookbook } from "./cookbook";
import {
    useParams,
    Route,
    useRouteMatch,
    Link,
    BrowserRouter as Router,
    Switch
} from 'react-router-dom';
import cloudinaryUploader from "./uploadWidget";
// import {Image, Video, Transformation, CloudinaryContext} from 'cloudinary-react';


function RecipeDetails() {

    const [recipeDetails, setRecipeDetails] = React.useState(null);

    let { recipeId } = useParams();

    React.useEffect(() => {
        fetch(`/api/recipe-details/${recipeId}`, {
            method: 'POST',
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            }
        })
            .then(res => res.json())
            .then(data => setRecipeDetails(data));
    }, [recipeId]);

    return (
        <React.Fragment>
            {recipeDetails ?
                <div>
                    <EditRecipeButton recipeDetails={recipeDetails}/>
                    <div> Title: {recipeDetails.title}</div>
                    <img src={recipeDetails.media} />
                    <div> ingredients: {recipeDetails.ingredients}</div>
                    <div>
                        time required: {recipeDetails.time_required}
                        servings: {recipeDetails.servings}
                    </div>
                    <ol>
                        {recipeDetails.steps.map(step => {
                        return <li key={step.key}>{step.body}</li>;
                        })}
                    </ol>
                </div> :
                <p>Loading...</p>}
        </React.Fragment>
    )


        ;
}


function EditRecipeButton(props) {
    let { path, url } = useRouteMatch();

    return (
        <Router>
            <div>
                <Link to={`${url}/edit`}>
                    <button type="button">Edit</button>
                </Link>

                <Switch>
                    <Route exact path={`${path}/edit`}>
                        <RecipieForm recipeDetails={props.recipeDetails}/>
                    </Route>
                </Switch>
            </div>
        </Router>
    );
}


function RecipieForm(props) {

    //track what user is entering in fields
    const [title, setTitle] = React.useState(props.recipeDetails?.title);
    const [photo, setPhoto] = React.useState(props.recipeDetails?.media);
    const [mins, setMins] = React.useState(props.recipeDetails?.time_required);
    const [servings, setServings] = React.useState(props.recipeDetails?.servings);
    const [ingredients, setIngredients] = React.useState(props.recipeDetails?.ingredients);
    const [steps, setSteps] = React.useState(props.recipeDetails?.steps?.map(step => step.body));

    console.log(props.recipeDetails);

    // React.useEffect(() => {
    //     if (props.buttonClicked === 'edit') {
    //         const instructions = [];
    //         for (const step of props.recipeDetails.steps) {
    //             instructions.push(step.body);
    //         }
    //         setSteps(instructions);
    //     }
    // }, []);

    const addStep = (evt) => {
        evt.preventDefault();
        setSteps([...steps, '']);
    };

    const handleStepChange = (evt) => {
        const updatedSteps = [...steps];
        updatedSteps[evt.target.dataset.idx] = evt.target.value;
        setSteps(updatedSteps);
    };

    const deleteStep = (evt) => {
        const updatedSteps = [...steps];
        const deleteIndex = evt.target.dataset.idx;
        updatedSteps.splice(deleteIndex, 1);
        setSteps(updatedSteps);
    };


    const addAbove = (evt) => {
        const updatedSteps = [...steps];
        const addIndex = evt.target.dataset.idx;
        updatedSteps.splice(addIndex, 0, "");
        setSteps(updatedSteps);
    };

    const save = (evt) => {
        evt.preventDefault();

        const data = {
            'title': title,
            'readyInMins': mins,
            'servings': servings,
            'ingredients': ingredients,
            'steps': steps,
            'photo': photo
        };

        fetch('/api/save', {
            method: 'POST',
            body: JSON.stringify(data),
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            }
        })
            .then((res) => res.json())
            .then((data) => {
                props.setRecipeDetails(data);
                props.setShowRecipeDetails(true);
            });
    };


    //cloudinary config
    const uploadWidget = window.cloudinary.createUploadWidget({
        cloudName: "deglaze", uploadPreset: "cuca-preset"
    }, (error, result) => {
        if (result.event === 'success') {
            setPhoto(result.info.url);
        }
    });


    return (
        <form>
            <label>Title</label>
            <input type='text'
                id='title'
                onChange={(evt) => setTitle(evt.target.value)}
                value={title}></input>
            <label>Cover Photo</label>
            <input type='button' onClick={uploadWidget.open} value='Add Image' />
            <img src={photo}></img>
            <label>Ready in Mins:</label>
            <input type='text'
                id='readyMins'
                onChange={(evt) => setMins(evt.target.value)}
                value={mins}></input>
            <label>Servings:</label>
            <input type='text'
                id='servings'
                onChange={(evt) => setServings(evt.target.value)}
                value={servings}></input>
            <label>Ingredients (seperate each with comma)</label>
            <input type='area'
                id='ingredients'
                onChange={(evt) => setIngredients(evt.target.value)}
                value={ingredients}></input>
            <label>Steps:</label>
            <ol>
                {
                    steps.map((stepBody, index) => {
                        return (
                            <li key={`step-${index}`}>
                                <input type='area'
                                    value={stepBody}
                                    id={`step-${index}`}
                                    data-idx={index}
                                    onChange={handleStepChange}></input>
                                <input type='button'
                                    data-idx={index}
                                    onClick={addAbove}
                                    value='Add Step Above' />
                                <input type='button'
                                    data-idx={index}
                                    onClick={deleteStep}
                                    value='Delete' />
                                {/* <input type='button' 
                                     data-idx={index} 
                                     onClick={uploadWidget.open}
                                     value='Add image to this step!' /> */}
                                {/* <img src={photo} ></img> */}
                            </li>
                        );
                    })
                }
            </ol>
            <button onClick={addStep}>Add Step</button>
            <input type="submit" onClick={save}></input>
        </form>
    );
}

function ChangeRecipeButton(props) {

    const showForm = () => {
        if (props.caption === 'Edit Recipe') {
            props.setShowRecipeDetails([false, "edit"]);
        } else {
            props.setShowRecipeDetails([false, "new"]);
        }
    };

    return <button onClick={showForm}>{props.caption}</button>;
}

function BackButton(props) {

    const hideForm = () => {
        props.setShowRecipeDetails([true]);
    };

    return <button onClick={hideForm}>Back to Recipe Details</button>;

}

function RecipeNav(props) {

    console.log(props.recipes);

    let { path, url } = useRouteMatch();

    const recipeLinks = [];

    for (const recipeId in props.recipes) {
        recipeLinks.push(
            <li>
                <Link to={`${url}/${recipeId}`}>{props.recipes[recipeId]}</Link>
            </li>
        );
    }

    return (
        <Router>
            <div>
                <h2>Recipes</h2>
                <ul>
                    {recipeLinks}
                </ul>

                <Switch>
                    <Route exact path={`${path}/:recipeId`}>
                        <RecipeDetails />
                    </Route>
                </Switch>
            </div>
        </Router>
    );
}

function Recipes() {

    const [recipes, setRecipes] = React.useState([]);
    const [recipeDetails, setRecipeDetails] = React.useState('');
    const [showRecipeDetails, setShowRecipeDetails] = React.useState([true]);

    React.useEffect(() => {
        fetch('/api/cookbook-details')
            .then((res) => res.json())
            .then((data) => setRecipes(data));
    }, [showRecipeDetails]);

    //new button here: route to recipes/new

    return (
        <React.Fragment>
            <h2>This is a cookbook!</h2>
            <RecipeNav recipes={recipes} />
            {showRecipeDetails[0] ? <div>
                <CreateNewCookbook />
                <ChangeRecipeButton caption='Edit Recipe'
                    setShowRecipeDetails={setShowRecipeDetails} />
                <ChangeRecipeButton caption='New Recipe'
                    setShowRecipeDetails={setShowRecipeDetails} />
            </div>
                :
                <div>
                    <BackButton setShowRecipeDetails={setShowRecipeDetails} />
                    <RecipieForm recipeDetails={recipeDetails}
                        setRecipeDetails={setRecipeDetails}
                        buttonClicked={showRecipeDetails[1]}
                        setShowRecipeDetails={setShowRecipeDetails} />
                </div>}

        </React.Fragment>
    );
}

export default Recipes;