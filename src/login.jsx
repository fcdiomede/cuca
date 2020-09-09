import React from "react";
import { useHistory } from "react-router-dom";

//login page components

//login form modal component
function LoginForm(props) {
    //track email and password enters
    const [email, setEmail] = React.useState('');
    const [password, setPassword] = React.useState('');

    let history = useHistory();

    //callback for user login button
    //makes a server request to authenticate password typed in
    const authenticateUser = (event) => {
        event.preventDefault();

        //format user data to send to server        
        const user = { 'email': email, 'password': password };

        fetch('/api/login', {
            method: 'POST',
            body: JSON.stringify(user),
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            }
        })
            .then((res) => res.json())
            .then((data) => {
                if (data.status === "success") {
                    props.setLoggedIn(true);
                    props.setUserData(data.user_data);
                    history.push(`/homepage/${data.user_data.user_id}`);
                } else {
                    alert('Email/Password combination is incorrect.');
                }
            });
    };

    return (
        <div class="modal fade" id="modalLoginForm" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header text-center">
                        <h5 class="modal-title cuca-red-text w-100 font-weight-bold" id="loginModalLabel">Log In</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <div class="modal-body mx-3">
                        <form>
                            <div class="md-form mb-5">
                                <i class="fas fa-envelope prefix grey-text"></i>
                                <input type='text'
                                    id="defaultForm-email"
                                    class="form-control validate"
                                    placeholder="Your Email"
                                    onChange={(evt) => setEmail(evt.target.value)}
                                    value={email}>
                                </input>
                            </div>

                            <div class="md-form mb-4">
                                <i class="fas fa-lock prefix grey-text"></i>
                                <input type='password'
                                    id="defaultForm-pass" 
                                    class="form-control validate"
                                    placeholder="Your password"
                                    onChange={(evt) => setPassword(evt.currentTarget.value)}
                                    value={password}>
                                </input>
                            </div>
                        </form>
                    </div>

                    <div class="modal-footer d-flex justify-content-center">
                        <button type="button"
                            class="btn btn-warning"
                            onClick={authenticateUser}
                            data-dismiss="modal">Login</button>
                    </div>
                </div>
            </div>
        </div>
    );
}

//sign up modal component
function SignUpModal(props) {
    //track entered in data
    const [email, setEmail] = React.useState('');
    const [password, setPassword] = React.useState('');
    const [fname, setFName] = React.useState('');
    const [lname, setLName] = React.useState('');

    let history = useHistory();

    //callback for creating an account
    const addUser = () => {

    //format user data to send to server        
    const user = {
        'email': email,
        'password': password,
        'fname': fname,
        'lname': lname
    };

    fetch('/api/create-account', {
        method: 'POST',
        body: JSON.stringify(user),
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
        }
    })
        .then((res) => res.json())
        .then((data) => {
            if (data.status === "success") {
                alert("Success! Account has been created.");
                props.setLoggedIn(true)
                props.setUserData(data.user_data);
                history.push(`/homepage/${data.user_data.user_id}`);
            } else {
                alert('This user already exists. Try logging in.');
            }
        });
    };

    return (
        <div class="modal fade" id="signUpModal" tabindex="-1" aria-labelledby="signUpModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header text-center">
                        <h5 class="modal-title cuca-red-text w-100 font-weight-bold" id="loginModalLabel">Sign Up</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <div class="modal-body mx-3">
                        <form>
                            <div class="md-form mb-4">
                                <i class="fas fa-user prefix grey-text"></i>
                                <input type='text'
                                    id='fname'
                                    class="form-control validate"
                                    placeholder="Your First Name"
                                    onChange={(evt) => setFName(evt.target.value)}
                                    value={fname}></input>
                            </div>

                            <div class="md-form mb-4">
                                <i class="fas fa-user prefix grey-text"></i>
                                <input type='text'
                                    id='lname'
                                    class="form-control validate"
                                    placeholder="Your Last Name"
                                    onChange={(evt) => setLName(evt.target.value)}
                                    value={lname}></input>
                            </div>

                            <div class="md-form mb-5">
                                <i class="fas fa-envelope prefix grey-text"></i>
                                <input type='text'
                                    id="defaultForm-email"
                                    class="form-control validate"
                                    placeholder="Your email"
                                    onChange={(evt) => setEmail(evt.target.value)}
                                    value={email}>
                                </input>
                            </div>

                            <div class="md-form mb-5">
                                <i class="fas fa-lock prefix grey-text"></i>
                                <input type='password'
                                    id="defaultForm-pass" 
                                    class="form-control validate"
                                    placeholder="Your Password"
                                    onChange={(evt) => setPassword(evt.currentTarget.value)}
                                    value={password}>
                                </input>
                            </div>

                        </form>
                    </div>
                    
                    <div class="modal-footer d-flex justify-content-center">
                        <button type="button"
                            class="btn  btn-success"
                            onClick={addUser}
                            data-dismiss="modal">Create Account</button>
                    </div>
                </div>
            </div>
        </div>
    );

}

//About Page and Login
function Login(props) {

    return (
        <div class="about-page container-fluid">

            <div class="row">
                <div class="col d-flex justify-content-center">
                    <img src="https://res.cloudinary.com/deglaze/image/upload/v1599665720/mcuca_blackoutline_djrjaw.svg"
                        class="cuca-banner">
                    </img>
                </div>
            </div>

            <div class="row d-flex justify-content-center dictionary-def">
                <div class="col-6">
                    <p class="border-bottom dictionary_border">
                        [ˈmɛstɾi-ˈkuka]
                    <i> noun informal</i>
                    </p>
                    <p>Brazilian phrase meaning highly skilled cook. </p>
                    <p class="dictionary-ex-phrase"> 
                    "Aunt Cláudia always cooks the most delicious dishes. 
                    She is such a mestre cuca."
                    </p>
                </div>
            </div>

            <div class="row">
                <div class="col d-flex justify-content-center">
                    <h5>Ready to get cooking?</h5>
                </div>
            </div>

            <div class="row">
                <div class="col d-flex justify-content-center">
                    <button class="btn btn-warning mr-3 btn-lg"
                        data-toggle="modal"
                        data-target="#modalLoginForm">
                        Login
                    </button>

                    <button class="btn btn-success btn-lg"
                        data-toggle="modal"
                        data-target="#signUpModal">Sign Up
                    </button>
                </div>
            </div>

            <LoginForm setLoggedIn={props.setLoggedIn}
                setUserData={props.setUserData} />
            <SignUpModal setLoggedIn={props.setLoggedIn}
                setUserData={props.setUserData}/>

            <div class="row">
                <div class="col">
                    <footer class="page-footer font-small">
                        <div class="footer-copyright text-center py-3">© 2020 Copyright:
                        <a href="https://github.com/fcdiomede"> Diomede Industries </a>
                        </div>
                    </footer>
                </div>
            </div>

        </div>


    );
}

export default Login;