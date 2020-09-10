import React from "react";
import { useHistory } from "react-router-dom";
import { useForm } from "react-hook-form";

//login page components

//login form modal component
function LoginForm(props) {

    //used to push user to homepage on successful login
    let history = useHistory();

    const { register, handleSubmit, errors } = useForm({
        mode: "onBlur",
      });

    
    //sends server data on submit
    const onSubmit = (data) => {

        fetch('api/login', {
            method: 'POST',
            body: JSON.stringify(data),
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
                window.$('#modalLoginForm').modal('hide');
                history.push(`/homepage/${data.user_data.user_id}`);
            } else {
                alert('Incorrect Username/Password')
            }
        })
    }


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
                        <form onSubmit={handleSubmit(onSubmit)}>
                            <div class="md-form mb-5">
                                <i class="fas fa-envelope prefix grey-text"></i>
                                <input type='email'
                                    name="email"
                                    id="input-email"
                                    class="form-control"
                                    placeholder="Your Email"
                                    style={{borderColor: errors.email && "red" }}
                                    ref={register({ required: "Enter your email",
                                                    pattern: {
                                                        value: /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i,
                                                        message: "Enter a valid e-mail address",
                                                    },
                                        })} 
                                />
                                {errors.email && <p class="error-message">{errors.email.message}</p>}
                            </div>

                            <div class="md-form mb-4">
                                <i class="fas fa-lock prefix grey-text"></i>
                                <input type='password'
                                    name="password"
                                    id="input-password" 
                                    class="form-control"
                                    placeholder="Your password"
                                    style={{borderColor: errors.password && "red" }}
                                    ref={register({required: {
                                                        value: true,
                                                        message: "Enter your password"
                                                    },
                                                 })}
                                />
                                {errors.passwowrd && <p class="error-message">{errors.password.message}</p>}
                            </div>

                            <div class="modal-footer d-flex justify-content-center">
                                <button type="submit"
                                        class="btn btn-warning">Login</button>
                            </div>

                        </form>
                    </div>

                    
                </div>
            </div>
        </div>
    );
}

//sign up modal component
function SignUpModal(props) {

    let history = useHistory();

    const { register, handleSubmit, errors } = useForm({
        mode: "onBlur",
      });

    const onSubmit = (data) => {
        console.log(data);

        fetch('/api/create-account', {
            method: 'POST',
            body: JSON.stringify(data),
            headers:{
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            }
        })
        .then((res) => res.json())
        .then((data) => {
            if (data.status === "success") {
                props.setLoggedIn(true)
                props.setUserData(data.user_data);
                window.$('#signUpModal').modal('hide');
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

                    
                        <form onSubmit={handleSubmit(onSubmit)}>
                        <div class="modal-body mx-3">
                            <div class="md-form mb-4">
                                <i class="fas fa-user prefix grey-text"></i>
                                <input type='text'
                                    name="fname"
                                    id='input-fname'
                                    class="form-control"
                                    placeholder="Your First Name"
                                    style={{borderColor: errors.fname && "red"}}
                                    ref={register({ required: {
                                                        value: true,
                                                        message: "Enter your name"
                                        },
                                    })} 
                                />
                                {errors.fname && <p class="error-message">{errors.fname.message}</p>}
                            </div>

                            <div class="md-form mb-4">
                                <i class="fas fa-user prefix grey-text"></i>
                                <input type='text'
                                    name="lname"
                                    id='lname'
                                    class="form-control"
                                    placeholder="Your Last Name"
                                    ref={register}/>
                            </div>

                            <div class="md-form mb-5">
                                <i class="fas fa-envelope prefix grey-text"></i>
                                <input type='email'
                                    name="email"
                                    id="input-email"
                                    class="form-control"
                                    placeholder="Your Email"
                                    style={{borderColor: errors.email && "red" }}
                                    ref={register({ required: "Enter your email",
                                                    pattern: {
                                                        value: /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i,
                                                        message: "Enter a valid e-mail address",
                                                    },
                                        })} 
                                />
                                {errors.email && <p class="error-message">{errors.email.message}</p>}
                            </div>

                            <div class="md-form mb-5">
                                <i class="fas fa-lock prefix grey-text"></i>
                                <input type='password'
                                    name="password"
                                    id="input-password" 
                                    class="form-control"
                                    placeholder="Your password"
                                    style={{borderColor: errors.password && "red" }}
                                    ref={register({required: {
                                                        value: true,
                                                        message: "Enter your password"
                                                    },
                                                 })}
                                />
                                {errors.passwowrd && <p class="error-message">{errors.password.message}</p>}
                            </div>

                            </div>

                            <div class="modal-footer d-flex justify-content-center">
                                <button type="submit"
                                class="btn  btn-success">Create account</button>
                            </div>

                        </form>
                     
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