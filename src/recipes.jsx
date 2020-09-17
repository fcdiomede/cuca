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
import { useForm } from "react-hook-form";


function FavoriteRecipe(props) {

    const [clicked, setClicked] = React.useState('');

    let recipeId = props.recipeDetails?.recipe_id;

    const favoriteRecipe = () => {
        fetch(`/api/favorite/${recipeId}`, {
            method: 'POST',
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            }
        })
        .then(() => setClicked('cuca-red-text'))
    };

    React.useEffect(() => setClicked(''), [recipeId])

    return (<span class="icon-button my-auto" onClick={favoriteRecipe}>
        <i class={`fas fa-heart ${clicked}`}></i>
    </span>);
}

function RecipeDetails(props) {

    const [viewPhoneNumModal, toggleViewPhoneNumModal] = React.useState(false);

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

    const ingredients = props.recipeDetails?.ingredients?.split(',');

    let history = useHistory();

    const goToRecipe = () => {
        history.push(`/recipes/edit`);
    };

    const sendIngredients = () => {
        toggleViewPhoneNumModal(true)
    }

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
                    
                    <img src={props.recipeDetails.media} class="form-img mb-4"/>

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
                        <div class="icon-button my-auto" onClick={sendIngredients}>
                            <i class="fas fa-mobile" aria-hidden="true"></i>
                        </div>
                        { viewPhoneNumModal && <PhoneNumberModal 
                                                toggleViewPhoneNumModal={toggleViewPhoneNumModal}
                                                title={props.recipeDetails.title}
                                                ingredients={ingredients} /> }

                    <ul>
                        {ingredients?.map((ingredient,index) => {
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
                                <div>
                                <img src={step.photo} class="form-img mb-2"/>
                                </div>
                            </li>);
                        })}
                    </ol>
                    </div>
                </div> :
                <div class="d-flex justify-content-center">
                <div class="spinner-border" role="status">
                    <span class="sr-only">Loading...</span>
                </div>
                </div>}

        </React.Fragment>
    )
}


function PhoneNumberModal(props) {

    const { register, handleSubmit, errors } = useForm({
        mode: "onBlur",
      });


    const sendToPhone = (data) => {
        
        const phoneNum = data.phone

        const recipeData = {'title': props.title,
                    'ingredients': props.ingredients,
                    'phoneNum':phoneNum}

        fetch('/api/send-ingredients', {
            method: 'POST',
            body: JSON.stringify(recipeData),
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            }
        })
        .then((res) => res.json())
        .then((data) => {
            props.toggleViewPhoneNumModal(false);
            alert(data);
            window.$('#phoneNumberModal').modal('hide');
        })
    }

    return(
        <div class="cb-modal" id="phoneNumberModal" role="dialog">
            <div class="modal-bg-overlay"></div>
            <div class="modal-dialog" role="document">
                <div class="modal-content cb-modal-content">
                    <div class="modal-header text-center">
                    <h5 class="modal-title cuca-red-text w-100 font-weight-bold" id="sendToPhoneLabel">
                        Send Ingredients to Phone
                    </h5>
                    <button type="button" class="close" aria-label="Close" onClick={() => props.toggleViewPhoneNumModal(false)}>
                        <span aria-hidden="true">&times;</span>
                    </button>
                    </div>

                    <div class="modal-body mb-0">
                        <form onSubmit={handleSubmit(sendToPhone)}>

                            <div class="md-form mb-5">
                                <i class="fas fa-mobile prefix grey-text"></i>
                                <input type="phone"
                                name="phone"
                                id="input-phone"
                                class="form-control"
                                placeholder="Your Phone Number"
                                style={{borderColor: errors.phone && "red" }}
                                ref={register({ required: "Enter your email",
                                                    pattern: {
                                                        value: /^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$/i,
                                                        message: "Enter a valid phone number",
                                                    },
                                        })} 
                                />
                                {errors.phone && <p class="error-message">{errors.phone.message}</p>}
                            </div>

                            <div class="md-form mb-5 d-flex justify-content-center">
                                <button type="submit"    
                                        class="btn btn-success btn-lg"> Submit</button>
                            </div>
                        </form>
                    </div>

                </div>
            </div>
        </div>
    )
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
            destination.droppableId === source.droppableId &&
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
                            <img src={photo} class="form-img mb-4"></img>
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
                                                        
                                                        <img src={step.photo} class="form-img mb-4"></img>
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
                                <Link to={`${url}/${recipe.recipe_id}`} class="nav-link pl-0 cuca-black-text">{recipe.title}</Link>
                            </li>);
                        })}
                    </ul>

                    {props.viewOnly ? null :
                            <div class="d-flex w-100 justify-content-around border-top pt-2">
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
                    <div class="d-flex flex-column align-items-left">
                        <h1 class="cuca-red-text m-3 d-block">{props.cookbookTitle}</h1>
                        <img src={props.cookbookImg} class="cb-title-pg-img"/>
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


            </div>
        </React.Fragment>
    );
}

export default Recipes;