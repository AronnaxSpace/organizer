window.addEventListener( "load", function () {
  const tasks = document.getElementById( "tasks" );
  const newTaskForm = document.getElementById( "new-task-form" );

  newTaskForm.addEventListener( "submit", function ( event ) {
    event.preventDefault();

    let xhttp = new XMLHttpRequest();
    let params = new FormData( newTaskForm );

    xhttp.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 201) {
        addNewTask(JSON.parse(this.response));
      }
      if (this.readyState == 4 && this.status == 422) {
        console.log(JSON.parse(this.response));
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
    let destroyButton = document.createElement("button");

    titleTd.innerText = attrs.title;
    tr.appendChild(titleTd);

    deadlineTd.innerText = attrs.deadline === null ? '-' : (new Date(attrs.deadline)).toLocaleDateString('uk');
    deadlineTd.classList.add("ta-center");
    tr.appendChild(deadlineTd);

    destroyButton.innerHTML = "x";
    destroyButton.classList.add("btn-red");
    destroyTd.appendChild(destroyButton);
    tr.appendChild(destroyTd);

    tasks.appendChild(tr);
  }
} );
