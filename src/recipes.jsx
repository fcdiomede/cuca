import React from "react";
import {
    useParams,
    Route,
    useRouteMatch,
    Link,
    BrowserRouter as Router,
    Switch,
    useHistory
} from 'react-router-dom';
import { DragDropContext, Droppable, Draggable } from "react-beautiful-dnd";
import cloudinaryUploader from "./uploadWidget";
// import {Image, Video, Transformation, CloudinaryContext} from 'cloudinary-react';


function FavoriteRecipe(props) {

    let recipeId = props.recipeDetails?.recipe_id;

    const favoriteRecipe = () => {
        fetch(`/api/favorite/${recipeId}`, {
            method: 'POST',
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            }
        });
    };

    return (<span class="icon-button my-auto" onClick={favoriteRecipe}>
        <i class="fas fa-heart"></i>
    </span>);
}

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

    const ingredients = props.recipeDetails?.ingredients.split(',');

    let history = useHistory();

    const goToRecipe = () => {
        history.push(`/recipes/edit`);
    };

    return (
        <React.Fragment>
            {props.recipeDetails ?
                <div>
                    <div class="d-flex">
                        <h1 class="cuca-red-text m-3">
                            {props.recipeDetails.title}
                        </h1>
                        {props.viewOnly ?
                            <FavoriteRecipe recipeDetails={props.recipeDetails} /> :
                            <div class="icon-button my-auto" onClick={goToRecipe}>
                                <i class="fas fa-pen" aria-hidden="true"></i>
                            </div>}
                    </div>
                    
                    <img src={props.recipeDetails.media} />

                    <div class="my-3">
                        <span class="m-2">
                            <h7 class="cuca-red-text">time required:</h7>
                            {props.recipeDetails.time_required}
                        </span>
                        <span class="m-2">
                            <h7 class="cuca-red-text">servings: </h7>
                            {props.recipeDetails.servings}
                        </span>
                    </div>
                    
                    <div>
                    <h4 class="cuca-red-text">Ingredients:</h4>
                    <ul>
                        {ingredients.map((ingredient,index) => {
                            return (<li key={index}>
                                {ingredient}
                                </li>);
                        })}
                    </ul>
                    </div>
                    
                    <div>
                    <h4 class="cuca-red-text">Instructions:</h4>
                    <ol>
                        {props.recipeDetails.steps.map(step => {
                            return (<li key={step.key}>
                                {step.body}
                                <img src={step.photo} />
                            </li>);
                        })}
                    </ol>
                    </div>
                </div> :
                <p>Loading...</p>}
        </React.Fragment>
    )


        ;
}


function RecipieForm(props) {

    let history = useHistory();

    let recipeId = props.recipeDetails?.recipe_id;

    //track what user is entering in fields
    const [title, setTitle] = React.useState(props.recipeDetails?.title);
    const [photo, setPhoto] = React.useState(props.recipeDetails?.media);
    const [mins, setMins] = React.useState(props.recipeDetails?.time_required);
    const [servings, setServings] = React.useState(props.recipeDetails?.servings);
    const [ingredients, setIngredients] = React.useState(props.recipeDetails?.ingredients);
    const [steps, setSteps] = React.useState(props.recipeDetails?.steps);

    //for a new recipe, steps needs to be initalized as an empty array
    //so that we can loop through and add steps in the recipe form
    if (steps == null) {
        setSteps([{ 'body': '', 'photo': '' }]);
    }

    const addStep = (evt) => {
        evt.preventDefault();
        setSteps([...steps, { 'body': '', 'photo': '' }]);
    };

    const handleStepChange = (evt) => {
        const updatedSteps = [...steps];
        updatedSteps[evt.target.dataset.idx]["body"] = evt.target.value;
        setSteps(updatedSteps);
    };

    const handleImgUpload = (evt) => {

        const index = evt.target.dataset.idx;

        const stepUploadWidget = window.cloudinary.createUploadWidget({
            cloudName: "deglaze", uploadPreset: "cuca-preset"
        }, (error, result) => {
            if (result.event === 'success') {
                const updatedSteps = [...steps];
                updatedSteps[index]['photo'] = result.info.url;
                setSteps(updatedSteps);

            }
        });

        stepUploadWidget.open();

    };

    const deleteStep = (evt) => {
        const updatedSteps = [...steps];
        const deleteIndex = evt.target.dataset.idx;
        updatedSteps.splice(deleteIndex, 1);
        setSteps(updatedSteps);
    };


    const save = (evt) => {
        evt.preventDefault();

        const data = {
            'recipeId': recipeId,
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
                props.setRecipeEditCount(props.recipeEditCount + 1);
                history.push(`/recipes/${data.recipe_id}`);
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


    const cancel = () => {
        history.push('/recipes');
    };

    const deleteRecipe = () => {

        let confirmDelete = window.confirm(
            `This will delete your recipe ${title}. 
                This action cannot be undone. 
                To return to previous screen without saving, 
                try the cancel button instead.
                
                Are you sure you wish to continue?`);

        if (confirmDelete) {
            fetch('/api/delete-recipe', {
                method: 'POST',
                body: JSON.stringify(recipeId),
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                }
            })
                .then((res) => {
                    props.setRecipeEditCount(props.recipeEditCount + 1);
                    history.push('/recipes');
                });
        }
    };

    const reorder = (list, startIndex, endIndex) => {
        const result = Array.from(list);
        const [removed] = result.splice(startIndex, 1);
        result.splice(endIndex, 0, removed);
        return result;
    };

    const handleDragEnd = (result) => {
        const { destination, source } = result;

        //if there is no destination, exit
        if (!destination) {
            return;
        }

        //check to see if the location of the draggable changed
        if (
            destination.droppableId == source.droppableId &&
            destination.index === source.index
        ) {
            return;
        }

        const newStepIds = [...steps];
        const updatedStepOrder = reorder(newStepIds, source.index, destination.index);
        setSteps(updatedStepOrder);
    };



    return (
        <React.Fragment>
            <div class="icon-button mr-3 text-right" onClick={deleteRecipe}>
                <i class="fas fa-trash" aria-hidden="true"></i>
            </div>
            <DragDropContext onDragEnd={handleDragEnd}>
                <form>
                    <div class="form-group row">
                    <label class="col-sm-1 col-form-label form-label">Title: </label>
                    
                    <div class="col-sm-11 p-0 my-auto">
                    <input type='text'
                        id='title'
                        class="form-control validate"
                        onChange={(evt) => setTitle(evt.target.value)}
                        value={title}></input>
                    </div>
                    </div>

                    <div class="d-inline-flex">
                    { photo ?  
                        <div class="view overlay" onClick={uploadWidget.open}>
                            <img src={photo}></img>
                            <div class="mask flex-center waves-effect waves-light rgba-green-light">
                                <p id="edit-overlay-text">Edit Cover Photo</p>
                            </div>
                        </div> : 
                        <button class="btn btn-success" onClick={(evt) => {
                                                                    evt.preventDefault();
                                                                    uploadWidget.open();}}>
                            Add Photo
                        </button>}
                    </div>

                    <div class="my-3">
                    <label class="form-label" style={{fontSize: "large"}}>Ready in:</label>
                    <input type='text'
                        id='readyMins'
                        onChange={(evt) => setMins(evt.target.value)}
                        value={mins}></input>
                    <label class="form-label" style={{fontSize: "large"}}>Servings:</label>
                    <input type='text'
                        id='servings'
                        onChange={(evt) => setServings(evt.target.value)}
                        value={servings}></input>
                    </div>

                    <div class="mb-3">
                    <label>
                        <div class="form-label">Ingredients</div>
                        (seperate each with comma)
                    </label>
                    <textarea class="form-control validate"
                        id='ingredients'
                        onChange={(evt) => setIngredients(evt.target.value)}
                        value={ingredients}></textarea>
                    </div>

                    <div>
                    <label>
                        <div class="form-label">Steps:</div>
                        (Drag and drop to rearrange)
                    </label>
                    <Droppable droppableId='step-dnd'>
                        {(provided) => (
                            <ol
                                ref={provided.innerRef}
                                {...provided.droppableProps}
                            >
                                {
                                    steps?.map((step, index) => {
                                        const bodyId = `body-${index}`;
                                        const photoId = `photo-${index}`;
                                        return (
                                            <Draggable draggableId={`step-${index}`}
                                                index={index}>
                                                {(provided) => (
                                                    <li key={`step-${index}`}

                                                        ref={provided.innerRef}
                                                        {...provided.draggableProps}
                                                        {...provided.dragHandleProps}
                                                        innerRef={provided}
                                                    >
                                                        <div class="d-flex flex-row">
                                                        <textarea
                                                            value={step.body}
                                                            id={bodyId}
                                                            name={bodyId}
                                                            data-idx={index}
                                                            className="body step-text"
                                                            onChange={handleStepChange}></textarea>
                                                        </div>

                                                        <div class="d-flex flex-row">
                                                        <input type='button'
                                                            class="btn fa-input"
                                                            data-idx={index}
                                                            name={photoId}
                                                            onClick={handleImgUpload}
                                                            value="	&#xf03e;" />
                                                        <input type='button'
                                                            class="btn fa-input"
                                                            data-idx={index}
                                                            onClick={deleteStep}
                                                            value="&#xf1f8;" />
                                                        </div>
                                                        
                                                        <img src={step.photo}></img>
                                                    </li>
                                                )}
                                            </Draggable>
                                        );
                                    })
                                }
                                {provided.placeholder}
                            </ol>
                        )}
                    </Droppable>

                    <div class="mb-3 ml-4">
                        <button class="btn btn-warning btn-sm" onClick={addStep}>Add Step</button>
                    </div>
                    </div>


                    <div class="d-flex justify-content-end my-3">
                        <button type="button" class="btn btn-success" onClick={cancel}>Cancel</button>
                        <input type="submit" class="btn btn-warning" value="Save" onClick={save}></input>
                    </div>
                </form>
            </DragDropContext>
        </React.Fragment>
    );
}


function RecipeNav(props) {

    let { path, url } = useRouteMatch();

    let history = useHistory();

    const deleteCookbook = () => {
        let confirmDelete = window.confirm(
            `This will delete your entire cookbook.
            You will lose access to all of its contents. 
            This action cannot be undone. 
            
            Are you sure you wish to continue?`);

        if (confirmDelete) {
            fetch('/api/delete-cookbook')
                .then((res) => {
                    history.push('/');
                });
        }
    };

    return (
        <Router>
            <div class="row">
            <div class="col-3">
                <nav class="navbar h-100 justify-content-start flex-column" role="navigation">
                    <div>
                        <span class="navbar-header mb-0 h1">{props.cookbookTitle} Recipes</span>
                    </div>

                    <ul class="nav flex-column w-100 flex-grow-1">
                        {props.recipes?.map(recipe => {
                            return (<li class="nav-item text-left" key={recipe.recipe_id}>
                                <Link to={`${url}/${recipe.recipe_id}`} class="nav-link pl-0">{recipe.title}</Link>
                            </li>);
                        })}
                    </ul>

                    {props.viewOnly ? null :
                            <div class="d-flex">
                                <div>
                                <Link to={`${url}/new`}>
                                    <div class="icon-button mr">
                                        <i class="fas fa-plus"></i>
                                    </div>
                                </Link>
                                </div>
                                <div>
                                <div class="icon-button mr-3" onClick={deleteCookbook}>
                                    <i class="fas fa-trash" aria-hidden="true"></i>
                                </div>
                                </div>
                            </div>}

                </nav>
            </div>

            <div class="col-9">
                <Switch>
                    <Route exact path={`${path}`}>
                    <div>
                        <h2>{props.cookbookTitle}</h2>
                        <img src={props.cookbookImg} />
                    </div>
                    </Route>
                    <Route exact path={`${path}/new`}>
                        <RecipieForm recipeEditCount={props.recipeEditCount}
                            setRecipeEditCount={props.setRecipeEditCount} />
                    </Route>
                    <Route exact path={`${path}/edit`}>
                        <RecipieForm recipeDetails={props.recipeDetails}
                            recipeEditCount={props.recipeEditCount}
                            setRecipeEditCount={props.setRecipeEditCount} />
                    </Route>
                    <Route exact path={`${path}/:recipeId`}>
                        <RecipeDetails recipeDetails={props.recipeDetails}
                            setRecipeDetails={props.setRecipeDetails}
                            viewOnly={props.viewOnly} />
                    </Route>
                </Switch>
            </div>
            </div>
        </Router>
    );
}

function Recipes(props) {

    const [cookbookDetails, setCookbookDetails] = React.useState('');
    const [recipeDetails, setRecipeDetails] = React.useState(null);
    const [recipeEditCount, setRecipeEditCount] = React.useState(0);

    let { recipeId } = useParams();

    React.useEffect(() => {
        fetch('/api/cookbook-details')
            .then((res) => res.json())
            .then((data) => {
                setCookbookDetails(data);
            });
    }, [recipeEditCount]);


    const creatorId = cookbookDetails.creator_id;

    const viewOnly = (props.userId !== creatorId);



    return (
        <React.Fragment>
            <div class="cuca-standard-page container-fluid">


                <RecipeNav recipes={cookbookDetails.recipes}
                    recipeDetails={recipeDetails}
                    setRecipeDetails={setRecipeDetails}
                    recipeEditCount={recipeEditCount}
                    setRecipeEditCount={setRecipeEditCount}
                    viewOnly={viewOnly}
                    cookbookTitle={cookbookDetails.title}
                    cookbookImg={cookbookDetails.cover_img} />

                {/* {recipeId ? null :
                    <div>
                        <h2>{cookbookDetails.title}</h2>
                        <img src={cookbookDetails.cover_img} />

                    </div>} */}

            </div>
        </React.Fragment>
    );
}

export default Recipes;