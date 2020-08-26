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

    //callback after creating cookbook
    const returnToContainer = (evt) => {
        evt.preventDefault();
        props.setShowCookbookCreation(false)
    }

    //newcookbook form
    return (
        <form>
            <label>Title:</label>
            <input type='text'
                id='title'>
            </input>
            <label>Cover Img:</label>
            <input type='file' 
                id='coverImg'
                accept="image/png, image/jpg"
                encType="multipart/form-data">
            </input>
            <button onClick={returnToContainer}>Create It!</button>
        </form>
    )
 }