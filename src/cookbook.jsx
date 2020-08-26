import React from "react";
import { useHistory } from "react-router-dom";

function CookbookCover(props) {

    let history = useHistory()

    const data = {'cookbookId': props.cookbook_id}

    const goToCookbook = () => {
        fetch('/api/set-cookbook', {method: 'POST', 
        body: JSON.stringify(data), 
        headers: {'Accept': 'application/json',
        'Content-Type': 'application/json'}})
        .then(() => history.push('/cookbook'));
    }

    return (
        <div className="cookbook" onClick={goToCookbook}>
          <p>Name: {props.title}</p>
          <img src={props.imgUrl} />
        </div>
      );
    }


//component to hold all cookbook cards
export function CookbookContainer() {

    // make a call to the server to ask for information
    //user's personal cookbooks to appear

    const [cookbooks, updateCookbooks] = React.useState([]);

    React.useEffect(() => {
      fetch('/api/user-cookbooks')
      .then((res) => res.json())
      .then((data) => updateCookbooks(data))
    }, []);

    const userCookbooks = []
    for (const cookbook of cookbooks) {
        userCookbooks.push(
          <CookbookCover
            key={cookbook.key}
            cookbook_id={cookbook.key}
            title={cookbook.title}
            imgUrl={cookbook.imgUrl}
          />
        );
      }
     
      return (
        <div>{userCookbooks}</div>
      );
}

export function CreateNewCookbook(props) {

    // let history = useHistory();

    const goToCreateCookbookForm = () => {
        props.setShowCookbookCreation(true)
    }

    return (
        <button onClick={goToCreateCookbookForm}>Create New Cookbook</button>
    )
}

export function NewCookbookForm(props) {

    //track what user is entering in fields
    const [title, setTitle] = React.useState('');
    const [photo, setPhoto] = React.useState('');

    //cloudinary config
    const uploadWidget = window.cloudinary.createUploadWidget({ 
        cloudName: "deglaze", uploadPreset: "cuca-preset" }, (error, result) => {
            if (result.event === 'success') {
                setPhoto(result.info.url)
            }
         });

    //callback after creating cookbook
    const saveCookbook = (evt) => {
        evt.preventDefault();
        props.setShowCookbookCreation(false)
    }

    const cancel = (evt) => {
        evt.preventDefault();
        props.setShowCookbookCreation(false)
    }

    //newcookbook form
    return (
        <form>
            <label>Title</label>
             <input type='text'
                     id='title'
                     onChange={(evt) => setTitle(evt.target.value)}
                     value={title}></input>
             <label>Cover Photo</label>
            <input type='button' onClick={uploadWidget.open} value='Add Cover Image' />
            <img src={photo}></img>
            <button onClick={saveCookbook}>Create It!</button>
            <button onClick={cancel}>Cancel</button>
        </form>
    )
 }