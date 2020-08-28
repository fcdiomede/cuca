import React from "react";
import { CreateNewCookbook } from "./cookbook";
import {
    useParams,
    Route,
    useRouteMatch,
    Link,
    BrowserRouter as Router,
    Switch,
    useHistory
} from 'react-router-dom';
import cloudinaryUploader from "./uploadWidget";
// import {Image, Video, Transformation, CloudinaryContext} from 'cloudinary-react';


function RecipeDetails(props) {

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
            .then(data => props.setRecipeDetails(data));
    }, [recipeId]);

    return (
        <React.Fragment>
            {props.recipeDetails ?
                <div>
                    <div> Title: {props.recipeDetails.title}</div>
                    <img src={props.recipeDetails.media} />
                    <div> ingredients: {props.recipeDetails.ingredients}</div>
                    <div>
                        time required: {props.recipeDetails.time_required}
                        servings: {props.recipeDetails.servings}
                    </div>
                    <ol>
                        {props.recipeDetails.steps.map(step => {
                        return <li key={step.key}>{step.body}</li>;
                        })}
                    </ol>
                </div> :
                <p>Loading...</p>}
        </React.Fragment>
    )


        ;
}


function RecipieForm(props) {

    let history = useHistory();

    //track what user is entering in fields
    const [title, setTitle] = React.useState(props.recipeDetails?.title);
    const [photo, setPhoto] = React.useState(props.recipeDetails?.media);
    const [mins, setMins] = React.useState(props.recipeDetails?.time_required);
    const [servings, setServings] = React.useState(props.recipeDetails?.servings);
    const [ingredients, setIngredients] = React.useState(props.recipeDetails?.ingredients);
    const [steps, setSteps] = React.useState(props.recipeDetails?.steps?.map(step => step.body));

    //for a new recipe, steps needs to be initalized as an empty array
    //so that we can loop through and add steps in the recipe form
    if (steps == null) {
        setSteps([''])
    }

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
                console.log(data);
                history.push(`/recipes/${data.recipe_id}`)       
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
                    steps?.map((stepBody, index) => {
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
    let { recipeId } = useParams();

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
                <Link to={`${url}/${recipeId}/edit`}>
                    <button type="button">Edit</button>
                </Link>
                <Link to={`${url}/new`}>
                    <button type="button">New</button>
                </Link>

                <Switch>
                    <Route exact path={`${path}/new`}>
                        <RecipieForm />
                    </Route>
                    <Route exact path={`${path}/:recipeId`}>
                        <RecipeDetails recipeDetails={props.recipeDetails}
                                        setRecipeDetails={props.setRecipeDetails}/>
                    </Route>
                    <Route exact path={`${path}/:recipeId/edit`}>
                        <RecipieForm recipeDetails={props.recipeDetails}/>
                    </Route>
                </Switch>
            </div>
        </Router>
    );
}

function Recipes() {

    const [recipes, setRecipes] = React.useState([]);
    const [recipeDetails, setRecipeDetails] = React.useState(null);
    // const [readView, setReadView] = React.useState([true]);

    React.useEffect(() => {
        fetch('/api/cookbook-details')
            .then((res) => res.json())
            .then((data) => setRecipes(data));
    }, []);

    return (
        <React.Fragment>
            <h2>This is a cookbook!</h2>
            <RecipeNav recipes={recipes}
                        recipeDetails={recipeDetails}
                        setRecipeDetails={setRecipeDetails} />
            {/* {readView ? <div>
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
                </div>} */}

        </React.Fragment>
    );
}

export default Recipes;