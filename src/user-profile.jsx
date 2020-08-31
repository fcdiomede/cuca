import React from "react";
import { CreateNewCookbook, CookbookContainer, NewCookbookForm } from './cookbook';


//user profile components

export function ProfilePicture(props) {

    const editProfile = () => {
        props.setShowUserModal(true);
    };

    return (<img src={props.userData.profile_picture} onClick={editProfile} />);
}

export function UserProfileModal(props) {

    const [fname, setFName] = React.useState(props.userData.name);
    const [photo, setPhoto] = React.useState(props.userData.profile_picture);

    //cloudinary config
    const uploadWidget = window.cloudinary.createUploadWidget({
        cloudName: "deglaze", uploadPreset: "cuca-preset"
    }, (error, result) => {
        if (result.event === 'success') {
            setPhoto(result.info.url);
        }
    });

    const closeModal = () => {
        
        const user = {
            'fname': fname,
            'photo': photo
        };

        fetch('/api/update-user-profile', {
            method:'POST',
            body: JSON.stringify(user),
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            }
        })
            .then((res) => res.json())
            .then((data) => {
                props.setUserData(data);
                props.setShowUserModal(false);
            })
        };


    const cancel = () => props.setShowUserModal(false)

    return (
        <form>
            <label>First Name:</label>
            <input type='text'
                id='fname'
                onChange={(evt) => setFName(evt.target.value)}
                value={fname}></input>
            <label>Profile Photo</label>
            <input type='button' onClick={uploadWidget.open} value='Profile Image' />
            <img src={photo}></img>
            <input type='button' onClick={closeModal} value='Save' />
            <input type='button' onClick={cancel} value='Cancel' />'
        </form>
    );
}

//main page component
function Homepage(props) {

                    const [showCookbookCreation, setShowCookbookCreation] = React.useState(false);


                    return (
                        <React.Fragment>
                            <h1>Welcome, Chef {props.userName}!</h1>
                            {showCookbookCreation ? <NewCookbookForm setShowCookbookCreation={setShowCookbookCreation} 
                                                    mode='new' /> :
                                <div>
                                    <CreateNewCookbook setShowCookbookCreation={setShowCookbookCreation} />
                                    <CookbookContainer showCookbookCreation={showCookbookCreation} />
                                </div>}
                        </React.Fragment>
                    );
                }

export default Homepage;