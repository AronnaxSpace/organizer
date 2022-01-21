window.addEventListener( "load", function () {
  const tasks = document.getElementById( "tasks" );
  const newTaskForm = document.getElementById( "new-task-form" );

  showLoader= () => {
    let loader = document.createElement("div");
    loader.classList.add("loader");

    let loaderRing = document.createElement("span");
    loaderRing.classList.add("lds-dual-ring");
    loader.appendChild(loaderRing);

    document.body.appendChild(loader);
  }

  hideLoader = () => {
    let loader = document.getElementsByClassName("loader");

    for(let i = 0; i < loader.length; i++) {
      loader[i].remove();
    }
  }

  destroyTask = (event) => {
    event.preventDefault();

    showLoader();

    let xhttp = new XMLHttpRequest();

    xhttp.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 200) {
        document.getElementById(`task-${this.response}`).remove();

        hideLoader();
      }
    };

    xhttp.open("POST", event.target.action, true);
    xhttp.send();
  }

  newTaskForm.addEventListener( "submit", function ( event ) {
    event.preventDefault();

    showLoader();

    let xhttp = new XMLHttpRequest();
    let params = new FormData( newTaskForm );

    xhttp.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 201) {
        addNewTask(JSON.parse(this.response));

        newTaskForm.reset();
        hideLoader();
      }
      if (this.readyState == 4 && this.status == 422) {
        console.log(JSON.parse(this.response));

        hideLoader();
      }
    };

    xhttp.open("POST", "/tasks/create", true);
    xhttp.send(params);
  } );

  addNewTask = (attrs) => {
    let tr = document.createElement("tr");
    let titleTd = document.createElement("td");
    let deadlineTd = document.createElement("td");
    let destroyTd = document.createElement("td");
    let destroyForm = document.createElement("form");
    let destroyFormSubmitButton = document.createElement("button");

    tr.id = attrs.id

    titleTd.innerText = attrs.title;
    tr.appendChild(titleTd);

    deadlineTd.innerText = attrs.deadline === null ? '-' : (new Date(attrs.deadline)).toLocaleDateString('uk');
    deadlineTd.classList.add("ta-center");
    tr.appendChild(deadlineTd);

    destroyForm.setAttribute("action", `/tasks/${attrs.id}/destroy`);
    destroyForm.setAttribute("method", "post");
    destroyForm.setAttribute("onsubmit", "destroyTask(event)");

    destroyFormSubmitButton.innerHTML = "x";
    destroyFormSubmitButton.classList.add("btn-red");
    destroyFormSubmitButton.setAttribute("type", "submit")
    destroyForm.appendChild(destroyFormSubmitButton);

    destroyTd.appendChild(destroyForm);
    tr.appendChild(destroyTd);
    tasks.appendChild(tr);
  }
} );
