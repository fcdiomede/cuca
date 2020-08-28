import React from "react";
import {CreateNewCookbook, CookbookContainer, NewCookbookForm} from './cookbook';


//user profile page components

//specific cookbook card component


//main page component
function Homepage() {

    const [showCookbookCreation, setShowCookbookCreation] = React.useState(false)

    return (
        <React.Fragment>
            {showCookbookCreation ? <NewCookbookForm setShowCookbookCreation={setShowCookbookCreation} /> :
                                     <div>
                                        <CreateNewCookbook setShowCookbookCreation={setShowCookbookCreation} />
                                        <CookbookContainer showCookbookCreation={showCookbookCreation} />
                                     </div>}
        </React.Fragment>
    ) 
}

export default Homepage;