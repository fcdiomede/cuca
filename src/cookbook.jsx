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
            <span class="card cookbook-card m-2">
                <div class="view overlay zoom">
                <img src={props.imgUrl} class="card-img-top cb-cover-img" alt="cookbook-img" onClick={goToCookbook}></img>
                </div>
                <div class="card-body d-flex justify-content-between align-items-center p-3">
                    <h5 class="card-title m-0">{props.title}</h5>
                    <div>
                    { viewOnly ?  null :
                                <span class="icon-button mr-3" 
                                        onClick={() => props.setEditedCookbookId(props.cookbookId)}>
                                     <i class="fas fa-pen" aria-hidden="true"></i>
                                </span>}
                    <span onClick={goToCookbook} class="icon-button">
                        <i class="fas fa-eye"></i>
                    </span>
                    </div>
                </div>

                
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
    const [editedCookbookId, setEditedCookbookId] = React.useState(''); 

    let { userId } = useParams();

    const viewOnly = (props.userId !== props.creator_id)

    const [editedCBData] = cookbooks.filter(cookbook => cookbook.key === editedCookbookId);

    React.useEffect(() => {
        fetch(`/api/user-cookbooks/${userId}`)
            .then((res) => res.json())
            .then((data) => {
                updateCookbooks(data)
            });
    }, [cookbookEdits, userId]);

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
                setEditedCookbookId={setEditedCookbookId}
            />
        );
    }

    return (
        <React.Fragment>
        
         <div class="row">
             <div class="col d-flex align-items-center justify-content-between">
                <h3 class="section-heading mr-3">Cookbooks</h3>
                { viewOnly ? null: 
                            <CreateNewCookbook cookbookEdits={cookbookEdits}
                                            setCookbookEdits={setCookbookEdits}/>
                }
             </div>
            
        </div>
        
        <div class="row">
        { cookbooks ? 
                        <div class="card-group mx-3">
                            {userCookbooks}
                        </div> : 
                        <div class="d-flex justify-content-center">
                            <div class="spinner-border" role="status">
                                <span class="sr-only">Loading...</span>
                            </div>
                        </div>}
        </div>
        

        { editedCookbookId &&        
        <NewCookbookForm cookbookId={editedCookbookId} 
                                title={editedCBData.title} 
                                imgUrl={editedCBData.imgUrl} 
                                cookbookEdits={cookbookEdits}
                                setCookbookEdits={setCookbookEdits}
                                mode='edit' 
                                closeModal={setEditedCookbookId}/>
        }

        </React.Fragment>
    );
}

function CreateNewCookbook(props) {

    const [createNew, setCreateNew] = React.useState('');
    return (
        <React.Fragment>
        <button 
                class="btn btn-success btn-circle btn-md" onClick={() => setCreateNew(true)}>
                    <i class="fas fa-plus icon-button"></i>
        </button>

        { createNew && <NewCookbookForm mode='new'
                        imgUrl="https://res.cloudinary.com/deglaze/image/upload/v1599528712/cuca/dinner-plate-icon-png-7_gdchhk.png"
                        closeModal={setCreateNew}
                        cookbookEdits={props.cookbookEdits}
                        setCookbookEdits={props.setCookbookEdits} />}
        </React.Fragment>
    );
}

function NewCookbookForm(props) {


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
        .then(()=> {
            props.closeModal('');
            props.setCookbookEdits(props.cookbookEdits + 1);})
    };


    //newcookbook form
    return (
        <React.Fragment>
        <div class="cb-modal" id="cookbookFormModal" role="dialog">
            <div class="modal-bg-overlay"></div>
            <div class="modal-dialog modal-dialog-scrollable" role="document">
                <div class="modal-content cb-modal-content">
                    <div class="modal-header text-center">
                        <h5 class="modal-title cuca-red-text w-100 font-weight-bold" id="loginModalLabel">
                            Edit Cookbook Cover
                        </h5>
                        <button type="button" class="close" aria-label="Close" onClick={() => props.closeModal('')}>
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <div class="modal-body text-center mb-0">
                        <form>

                            <div class="md-form mb-5 view overlay" onClick={uploadWidget.open}>
                                <img src={photo} class="cb-modal-photo mx-auto"></img>
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
        </React.Fragment>
    );
}