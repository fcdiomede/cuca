import React from "react";
import { useHistory } from "react-router-dom";
import {CreateNewCookbook, CookbookContainer, NewCookbookForm} from './cookbook';


//user profile page components

//specific cookbook card component


//main page component
function Homepage() {

    const [showCookbookCreation, setShowCookbookCreation] = React.useState(false)


    // let history = useHistory();

    // fetch('/api/check-cookies')
    // .then((res) => res.json())
    // .then((data) => {
    //     if (!data) {
    //         history.push('/login')
    //     }
    // })

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