import React from "react";
import { CreateNewCookbook } from "./cookbook";
import cloudinaryUploader from "./uploadWidget";
// import {Image, Video, Transformation, CloudinaryContext} from 'cloudinary-react';



 function RecipeStep (props) {
     return (
             <li>{props.body} </li>
     )
 }
 
 function RecipeDetails (props) {
 
     if (!props.recipeDetails) {
         return <div></div>
     }
 
     
       const recipeSteps = []
       for (const step of props.recipeDetails.steps) {
         recipeSteps.push(
           <RecipeStep
             key={step.key}
             num={step.num}
             body={step.body}
           />
         );
       }
 
     return <div>
         <div> Title: {props.recipeDetails.title}</div>
         <img src={props.recipeDetails.media} />
         <div> ingredients: {props.recipeDetails.ingredients}</div>
         <div> 
             time required: {props.recipeDetails.time_required}
             servings: {props.recipeDetails.servings}
         </div>
         <ol>{recipeSteps}</ol>
     </div>
 }
 
 function RecipeListItem(props) {
 
     const goToRecipe = () => {
         fetch(`/api/recipe-details/${props.recipeId}`, {method: 'POST', 
         headers: {'Accept': 'application/json',
         'Content-Type': 'application/json'}})
         .then((res) => res.json())
         .then((data) => props.setRecipeDetails(data));
     }
 
     return <li onClick={goToRecipe}> {props.title} </li>
 }
 
 function RecipeList (props) {
 
     const cookbookRecipes = []
     for (const recipeId in props.recipes) {
         cookbookRecipes.push(
             <RecipeListItem
                 key={recipeId}
                 recipeId={recipeId}
                 title={props.recipes[recipeId]}
                 setRecipeDetails={props.setRecipeDetails}
             />
         )
     }
 
     return <ul>{cookbookRecipes}</ul>
 }
 
 function RecipieForm (props) {

      //track what user is entering in fields
      const [title, setTitle] = React.useState('');
      const [photo, setPhoto] = React.useState('');
      const [mins, setMins] = React.useState('');
      const [servings, setServings] = React.useState('');
      const [ingredients, setIngredients] = React.useState('');
      const [steps, setSteps] = React.useState(['']);
 
      console.log(props.recipeDetails)
 

         React.useEffect(() => {
            if (props.buttonClicked === 'edit') {
             setTitle(props.recipeDetails.title)
             setMins(props.recipeDetails.time_required)
             setServings(props.recipeDetails.servings)
             setIngredients(props.recipeDetails.ingredients)
             const instructions = [];
             for (const step of props.recipeDetails.steps) {
                 instructions.push(step.body);
             }
             setSteps(instructions);
         }},[])
     
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
         updatedSteps.splice(addIndex, 0,"");
         setSteps(updatedSteps);
     };
 
     const save = (evt) => {
         evt.preventDefault()
 
         const data = {
                 'title': title,
                 'readyInMins': mins,
                 'servings': servings,
                 'ingredients': ingredients,
                 'steps': steps,
                 'photo': photo
                 }
 
         fetch('/api/save', {method: 'POST', 
         body: JSON.stringify(data),
         headers: {'Accept': 'application/json',
         'Content-Type': 'application/json'}})
         .then((res) => res.json())
         .then((data) => {
             props.setRecipeDetails(data)
             props.setShowRecipeDetails(true)
         })
     }


     //cloudinary config
    const uploadWidget = window.cloudinary.createUploadWidget({ 
    cloudName: "deglaze", uploadPreset: "cuca-preset" }, (error, result) => {
        if (result.event === 'success') {
            setPhoto(result.info.url)
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
                     )
                 }) 
             }
             </ol>
             <button onClick={addStep}>Add Step</button>
             <input type="submit" onClick={save}></input>
         </form>
     )
 }
 
 function ChangeRecipeButton(props) {
 
     const showForm = () => {
         if (props.caption === 'Edit Recipe') {
             props.setShowRecipeDetails([false, "edit"])
         } else {
             props.setShowRecipeDetails([false, "new"])
         }
     }
 
     return <button onClick={showForm}>{ props.caption }</button>
 }
 
 function BackButton(props) {
 
     const hideForm = () => {
         props.setShowRecipeDetails([true])
     }
 
     return <button onClick={hideForm}>Back to Recipe Details</button>
 
 }
 
 function Recipes() {
 
     const [recipes, setRecipes] = React.useState([])
     const [recipeDetails, setRecipeDetails] = React.useState('')
     const [showRecipeDetails, setShowRecipeDetails] = React.useState([true])
 
     React.useEffect(() => {
         fetch('/api/cookbook-details')
         .then((res) => res.json())
         .then((data) => setRecipes(data))
     }, [showRecipeDetails]);
 
 
     return (
         <React.Fragment>
             <h2>This is a cookbook!</h2>
             <RecipeList recipes={recipes} setRecipeDetails={setRecipeDetails}/>
             { showRecipeDetails[0] ?  <div>
                                         <CreateNewCookbook />
                                         <ChangeRecipeButton caption='Edit Recipe'
                                                             setShowRecipeDetails={setShowRecipeDetails}/>
                                         <ChangeRecipeButton caption='New Recipe' 
                                                             setShowRecipeDetails={setShowRecipeDetails}/>
                                         <RecipeDetails  recipeDetails={recipeDetails}/> 
                                     </div>
                                     :
                                     <div>
                                         <BackButton setShowRecipeDetails={setShowRecipeDetails}/>
                                         <RecipieForm recipeDetails={recipeDetails}
                                                     setRecipeDetails={setRecipeDetails}
                                                         buttonClicked={showRecipeDetails[1]}
                                                         setShowRecipeDetails={setShowRecipeDetails}/>
                                     </div>}
            
        </React.Fragment>
     )
 }

 export default Recipes;