import React from "react";
import { useHistory } from "react-router-dom";
import {CreateNewCookbook, CookbookContainer} from './cookbook';


//user profile page components

//specific cookbook card component


//main page component
function Homepage() {

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
            <CreateNewCookbook />
            <CookbookContainer />
        </React.Fragment>
    ) 
}

export default Homepage;