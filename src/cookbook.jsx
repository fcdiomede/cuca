import React from "react";
import { useHistory, useParams } from "react-router-dom";

export function CookbookCover(props) {

    let history = useHistory();


    const viewOnly = (props.userId != props.creator_id)

    const data = { 'cookbookId': props.cookbookId };

    const goToCookbook = () => {
        fetch('/api/set-cookbook', {
            method: 'POST',
            body: JSON.stringify(data),
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            }
        })
            .then(() => history.push('/recipes'));
    };


    return (
        <React.Fragment>
            <span class="card cookbook-card mr-2">
                <div class="view overlay zoom">
                <img src={props.imgUrl} class="card-img-top cb-cover-img" alt="cookbook-img" onClick={goToCookbook}></img>
                </div>
                <div class="card-body d-flex justify-content-between align-items-center p-3">
                    <h5 class="card-title m-0">{props.title}</h5>
                    <div>
                    { viewOnly ?  null :
                                <span class="icon-button mr-3" 
                                        data-toggle="modal"
                                        data-target="#cookbookFormModal">
                                     <i class="fas fa-pen" aria-hidden="true"></i>
                                </span>}
                    <span onClick={goToCookbook} class="icon-button">
                        <i class="fas fa-eye"></i>
                    </span>
                    </div>
                </div>

                <NewCookbookForm cookbookId={props.cookbookId} 
                                title={props.title} 
                                imgUrl={props.imgUrl} 
                                cookbookEdits={props.cookbookEdits}
                                setCookbookEdits={props.setCookbookEdits}
                                mode='edit' />
            </span>
            
        </React.Fragment>
    );
}


//component to hold all cookbook cards
export function CookbookContainer(props) {

    // make a call to the server to ask for information
    //user's personal cookbooks to appear

    const [cookbooks, updateCookbooks] = React.useState([]);
    const [cookbookEdits, setCookbookEdits] = React.useState(0);

    let { userId } = useParams();


    React.useEffect(() => {
        fetch(`/api/user-cookbooks/${userId}`)
            .then((res) => res.json())
            .then((data) => updateCookbooks(data));
    }, [cookbookEdits]);

    const userCookbooks = [];
    for (const cookbook of cookbooks) {
        userCookbooks.push(
            <CookbookCover
                key={cookbook.key}
                cookbookId={cookbook.key}
                title={cookbook.title}
                imgUrl={cookbook.imgUrl}
                userId={props.userId}
                creator_id={userId}
                cookbookEdits={cookbookEdits}
                setCookbookEdits={setCookbookEdits}
            />
        );
    }

    return (
        <React.Fragment>
         <div class="row">
             <div class="col d-flex align-items-center justify-content-between">
                <h3 class="section-heading mr-3">Cookbooks</h3>
                <CreateNewCookbook cookbookEdits={cookbookEdits}
                                    setCookbookEdits={setCookbookEdits}/>
             </div>
            
        </div>
        <div class="row">
            <div class="card-group mx-3">
            {userCookbooks}
            </div>
        </div>
        </React.Fragment>
    );
}

export function CreateNewCookbook(props) {

    return (
        <React.Fragment>
        <button data-toggle="modal" data-target="#cookbookFormModal"
                class="btn btn-success btn-circle btn-md">
                    <i class="fas fa-plus icon-button"></i>
        </button>

        <NewCookbookForm mode="new" imgUrl="https://res.cloudinary.com/deglaze/image/upload/v1599528712/cuca/dinner-plate-icon-png-7_gdchhk.png" 
                    cookbookEdits={props.cookbookEdits} setCookbookEdits={props.setCookbookEdits}/>
        </React.Fragment>
    );
}

export function NewCookbookForm(props) {


    //track what user is entering in fields
    const [title, setTitle] = React.useState(props.title);
    const [photo, setPhoto] = React.useState(props.imgUrl);

    //cloudinary config
    const uploadWidget = window.cloudinary.createUploadWidget({
        cloudName: "deglaze", uploadPreset: "cuca-preset"
    }, (error, result) => {
        if (result.event === 'success') {
            setPhoto(result.info.url);
        }
    });

    //callback after creating cookbook
    const saveCookbook = (evt) => {
        evt.preventDefault();

        const data = {
            'title': title,
            'photo': photo,
            'mode': props.mode,
            "cookbookId": props.cookbookId
        };

        fetch('/api/save-cookbook', {
            method: 'POST',
            body: JSON.stringify(data),
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            }
        })
        .then(()=> props.setCookbookEdits(props.cookbookEdits + 1))
    };


    //newcookbook form
    return (
        <div class="modal fade" id="cookbookFormModal" tabindex="-1" role="dialog" aria-labelledby="CookbookCoverModal"
        aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header text-center">
                        <h5 class="modal-title modal-text w-100 font-weight-bold" id="loginModalLabel">
                            Edit Cookbook Cover
                        </h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <div class="modal-body text-center mb-0">
                        <form>

                            <div class="md-form mb-5 view overlay" onClick={uploadWidget.open}>
                                <img src={photo} class="cb-modal-photo"></img>
                                <div class="mask flex-center waves-effect waves-light rgba-green-light">
                                <p id="edit-overlay-text">Edit Cover Photo</p>
                                </div>
                            </div>

                            <div class="md-form mb-5">
                                <input type="text"
                                id="cb-title"
                                class="form-control validate"
                                placeholder="Cookbook Title"
                                value={title}
                                onChange={(evt) => setTitle(evt.target.value)}></input>
                            </div>

                            <div class="md-form mb-5 d-flex justify-content-center">
                                <button class="btn btn-success btn-lg" 
                                        onClick={saveCookbook}  
                                        data-dismiss="modal"> Submit</button>
                            </div>
                        </form>
                    </div>
                

                </div>
            </div>
        </div>
    );
}