import React from "react";
import { useHistory } from "react-router-dom";

// function CookbookCover () {
//     <div className="cookbook" onClick={goToCookbook}>
//                 <p>Name: {props.title}</p>
//                 <img src={props.imgUrl} />
//             </div>
// }

// //component to hold all cookbook cards
// export function CookbookContainer(props) {

//     // make a call to the server to ask for information
//     //user's personal cookbooks to appear

//     const [cookbooks, updateCookbooks] = React.useState([]);
//     const [showCBModal, setShowCBModal] = React.useState(false);

//     React.useEffect(() => {
//         fetch('/api/user-cookbooks')
//             .then((res) => res.json())
//             .then((data) => updateCookbooks(data));
//     }, [props.showCookbookCreation, showCBModal]);

//     const userCookbooks = [];
//     for (const cookbook of cookbooks) {
//         userCookbooks.push(
//             <CookbookCover
//                 key={cookbook.key}
//                 cookbookId={cookbook.key}
//                 title={cookbook.title}
//                 imgUrl={cookbook.imgUrl}
//                 showCBModal={showCBModal}
//                 setShowCBModal={setShowCBModal}
//             />
//         );
//     }

//     return (
//         <div>{userCookbooks}</div>
//     );
// }

function SearchBar () {

    const [searchTerm, setSearchTerm] = React.useState('')

    return (
        <form>
            <input type='text'
                    placeholder = 'Search...'
                    value={searchTerm}
                    onChange={(evt) =>setSearchTerm(evt.target.value)}>
                    </input>
        </form>
    )
}

function Explore () {
    return (
        <React.Fragment>
            <h1>What's cooking?</h1>
            <SearchBar />
        </React.Fragment>
    )
}

export default Explore;
