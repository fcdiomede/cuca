import React from "react";
import {CreateNewCookbook, CookbookContainer, NewCookbookForm} from './cookbook';


//user profile components

export function ProfilePicture(props) {
    
    return (<img src={props.userData.profile_picture} />)
}


//main page component
function Homepage(props) {

    const [showCookbookCreation, setShowCookbookCreation] = React.useState(false)
    

    return (
        <React.Fragment>
            <h1>Welcome, Chef {props.userName}!</h1>
            {showCookbookCreation ? <NewCookbookForm setShowCookbookCreation={setShowCookbookCreation} /> :
                                     <div>
                                        <CreateNewCookbook setShowCookbookCreation={setShowCookbookCreation} />
                                        <CookbookContainer showCookbookCreation={showCookbookCreation} />
                                     </div>}
        </React.Fragment>
    ) 
}

export default Homepage;