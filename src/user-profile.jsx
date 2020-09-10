import React from "react";
import { CookbookContainer } from './cookbook';
import { useParams, useHistory } from 'react-router-dom';

//user profile components

export function ProfilePicture(props) {

    const [editProfile, setEditProfile] = React.useState(false);

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
                <p class="dropdown-item" onClick={() => setEditProfile(true)}>Edit Profile</p>
                <div class="dropdown-divider"></div>
                <p class="dropdown-item" onClick={handleLogout}>Logout</p>
            </div>

            { editProfile &&  <UserProfileModal userData={props.userData}
                                setEditProfile={setEditProfile}/>}
           
        </div>
    );
}

function UserProfileModal(props) {

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
                props.setEditProfile(false);
                props.setUserData(data);
            });
    };


    // const cancel = () => props.setShowUserModal(false);

    return(
        <div class="cb-modal" id="profileModal" role="dialog">
            <div class="modal-bg-overlay"></div>
            <div class="modal-dialog cascading-modal modal-avatar modal-sm" role="document">
                <div class="modal-content cb-modal-content">

                    
                    <div class="modal-header">
                        <img src={photo} alt="profile-picture" 
                            class="rounded-circle img-responsive"
                            style={{backgroundColor:"white"}}
                            onClick={uploadWidget.open}></img>
                    </div>


                    <div class="modal-body mx-3">
                        <div class="md-form md-form mb-4">
                        <i class="fas fa-user prefix grey-text"></i>
                                <input type='text'
                                    id='fname'
                                    class="form-control validate"
                                    placeholder="Your First Name"
                                    onChange={(evt) => setFName(evt.target.value)}
                                    value={fname}></input>
                            </div>
                        </div>

                        <div class="d-flex justify-content-center">
                        <button type="button"
                                class="btn btn-success"
                                onClick={() => props.setEditProfile(false)}>Cancel</button>

                        <button type="button"
                            class="btn btn-warning"
                            onClick={closeModal}
                            data-dismiss="modal">Save</button>
                    </div>
                    </div>

                </div>
            </div>
    )
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

    return (<button class="btn btn-warning btn-sm d-block" onClick={followUser}>Follow</button>);
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

    return (<button class="btn btn-success btn-sm d-block" onClick={unfollowUser}>Unfollow</button>);
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
            <div class="cuca-standard-page container-fluid">
            <div class="d-flex">
                <div class="m-3">
                    <img src={user.profile_picture} class="large-profile-pic" />
                </div>
                <div class="d-flex flex-column justify-content-center">
                    <h1 class="cuca-red-text pt-3 d-block">Chef {user.name}</h1>
                    {currentlyFollowed ? <UnfollowUserButton userId={userId}
                    setCurrentlyFollowed={setCurrentlyFollowed} /> :
                    <FollowUserButton userId={userId}
                        setCurrentlyFollowed={setCurrentlyFollowed} />}
                </div>
            </div>
            <CookbookContainer userId={props.userId} />
            <FollowedUsers userId={userId} />
            </div>
        </React.Fragment>
    );


}


function FollowedUserCard(props) {

    let history = useHistory();

    const goToUserPage = () => {
        history.push(`/user/${props.friendId}`);
    };

    return (
        <div class="d-flex flex-column align-items-center mr-3" onClick={goToUserPage}>
            <div class="view overlay zoom">
                <img src={props.profilePicture} class="profile-pic" alt="profile pic"/>
            </div>
            <h6 class="d-block">{props.name}</h6>
        </div>
    );
}


function FollowedUsers(props) {

    const [followedUsers, setFollowedUsers] = React.useState('');

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
        <React.Fragment>
        <div class="row">
            <div class="col d-flex align-items-center">
            <h3 class="section-heading mt-5">Sous Chefs</h3>
            </div>
        </div>

        { followedUsers ? 
                        <div class="d-flex">
                            {connections}
                        </div> :
                        <div class="d-flex justify-content-center">
                        <div class="spinner-border" role="status">
                            <span class="sr-only">Loading...</span>
                        </div>
                        </div>
                        }
        
        </React.Fragment>
    );
}


//main page component
function Homepage(props) {

    return (
        <React.Fragment>
            <div class="cuca-standard-page container-fluid">
            <h1 class="cuca-red-text pt-3">Welcome, Chef {props.name}!</h1>
            <CookbookContainer userId={props.userId} creator_id={props.userId}/>
            <FollowedUsers userId={props.userId} />
            </div>
        </React.Fragment>
    );
}

export default Homepage;