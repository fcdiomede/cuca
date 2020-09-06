import React from "react";
import { CreateNewCookbook, CookbookContainer, NewCookbookForm } from './cookbook';
import { useParams, useHistory } from 'react-router-dom';

//user profile components

export function ProfilePicture(props) {

    const editProfile = () => {
        props.setShowUserModal(true);
    };

    const handleLogout = () => {
        props.setLoggedIn(false);
      };
    

    return (
        <div class="nav-item dropdown dropleft">
            <img src={props.userData.profile_picture}
                class="profile-pic nav-link dropdown-toggle"
                id="navbarDropdown"
                role="button"
                data-toggle="dropdown"
                aria-haspopup="true"
                aria-expanded="false" />
            <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                <p class="dropdown-item" onClick={editProfile}>Edit Profile</p>
                <div class="dropdown-divider"></div>
                <p class="dropdown-item" onClick={handleLogout}>Logout</p>
            </div>
        </div>
    );
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
            method: 'POST',
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
            });
    };


    const cancel = () => props.setShowUserModal(false);

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


function FollowUserButton(props) {

    const followUser = () => {
        fetch('/api/follow-user', {
            method: 'POST',
            body: JSON.stringify(props.userId),
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            }
        })
            .then((res) => res.json())
            .then((data) => props.setCurrentlyFollowed(true));
    };

    return (<button onClick={followUser}>Follow</button>);
}

function UnfollowUserButton(props) {

    const unfollowUser = () => {
        fetch('/api/unfollow-user', {
            method: 'POST',
            body: JSON.stringify(props.userId),
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            }
        })
            .then((res) => res.json())
            .then((data) => props.setCurrentlyFollowed(false));
    };

    return (<button onClick={unfollowUser}>Unfollow</button>);
}


//other user's profile view only
export function UserProfile(props) {
    const [user, setUser] = React.useState('');
    const [currentlyFollowed, setCurrentlyFollowed] = React.useState('');

    let { userId } = useParams();

    React.useEffect(() => {
        fetch(`/api/user/${userId}`)
            .then((res) => res.json())
            .then((data) => {
                console.log(data);
                setUser(data);
            });
    }, [userId]);

    React.useEffect(() => {
        fetch('/api/check-connection', {
            method: 'POST',
            body: JSON.stringify(userId),
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            }
        })
            .then((res) => res.json())
            .then((data) => {
                setCurrentlyFollowed(data);
            });
    }, [userId]);

    return (
        <React.Fragment>
            <h1>Chef {user.name}</h1>
            <img src={user.profile_picture} />
            {currentlyFollowed ? <UnfollowUserButton userId={userId}
                setCurrentlyFollowed={setCurrentlyFollowed} /> :
                <FollowUserButton userId={userId}
                    setCurrentlyFollowed={setCurrentlyFollowed} />}
            <CookbookContainer userId={props.userId} />
            <FollowedUsers userId={userId} />
        </React.Fragment>
    );


}


function FollowedUserCard(props) {

    let history = useHistory();

    const goToUserPage = () => {
        // console.log('Sure would be nice to see your friends page, huh?')
        history.push(`/user/${props.friendId}`);
    };

    return (
        <div onClick={goToUserPage}>
            <h2>{props.name}</h2>
            <img src={props.profilePicture} />
        </div>
    );
}


function FollowedUsers(props) {

    const [followedUsers, setFollowedUsers] = React.useState('Checking who is in the kitchen...');

    React.useEffect(() => {
        fetch(`/api/connections/${props.userId}`)
            .then((res) => res.json())
            .then((data) => {
                setFollowedUsers(data);
            });
    }, [props.userId]);

    const connections = [];
    for (const user of followedUsers) {
        connections.push(
            <FollowedUserCard
                key={user.friend_id}
                friendId={user.friend_id}
                name={user.friend_name}
                profilePicture={user.friend_picture}
            />
        );
    }

    return (
        <div>
            <h2>Sous Chefs</h2>
            <div>{connections}</div>
        </div>
    );
}


//main page component
function Homepage(props) {

    const [showCookbookCreation, setShowCookbookCreation] = React.useState(false);

    return (
        <React.Fragment>
            <h1>Welcome, Chef {props.name}!</h1>
            {showCookbookCreation ? <NewCookbookForm setShowCookbookCreation={setShowCookbookCreation}
                mode='new' /> :
                <div>
                    <CreateNewCookbook setShowCookbookCreation={setShowCookbookCreation} />
                    <CookbookContainer showCookbookCreation={showCookbookCreation}
                        userId={props.userId} />
                </div>}
            <FollowedUsers userId={props.userId} />
        </React.Fragment>
    );
}

export default Homepage;