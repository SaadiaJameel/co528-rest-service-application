//author- E/18/147 Saadia Jameel
//note  -   Disable browser CORS before running as the server and client make requests 
//          from different host addresses. Modern browsers block such javascript requests.
//      -   In code storage is used for the database.

var selectedRow= null;

// show alerts
function showAlert(message, className){
    const div = document.createElement("div");
    div.className = `alert alert-${className}`;

    div.appendChild(document.createTextNode(message));
    const container = document.querySelector(".container");
    const main = document.querySelector(".main");
    container.insertBefore(div, main);

    setTimeout(() => document.querySelector(".alert").remove(),3000);
}

// function to clear all fields
function clearFields(){
    document.querySelector("#firstName").value = "";
    document.querySelector("#lastName").value = "";
    document.querySelector("#regNo").value = "";
}

// function to fetch and display all users via API calls.
async function fetchUsers() {
    try {
        const response = await fetch('http://localhost:9090/social-media/users');
        console.log('Response:', response); // Log the response object
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        const users = await response.json();
        const userTable = document.querySelector("#student-list");
        userTable.innerHTML = ''; // Clear existing data

        //display the fetched users on the frontend table
        users.forEach(user => {
            const row = document.createElement("tr");
            row.setAttribute('data-id', user.id);
            row.innerHTML = `
                <td>${user.firstName}</td>
                <td>${user.lastName}</td>
                <td>${user.regNo}</td>
                <td>
                    <a href="#" class="btn btn-warning btn-sm edit">Edit</a>
                    <a href="#" class="btn btn-danger btn-sm delete">Delete</a>
                </td>
            `;
            userTable.appendChild(row);
        });
    } catch (error) {
        console.error('Failed to fetch users:', error);
    }
}

// async function to add users via API
async function addUser(firstName, lastName, regNo) {
    const url = 'http://localhost:9090/social-media/users';
    const userData = {
      firstName: firstName,
      lastName: lastName,
      regNo: regNo
    };
  
    try {
      const response = await fetch(url, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(userData)
      });
  
      if (!response.ok) {
        throw new Error('Network response was not ok');
      }
  
      const data = await response.json();
      console.log('User added successfully:', data);
      showAlert("Student Added", "success");
      fetchUsers();
    } catch (error) {
      console.error('Error adding user:', error);
    }
}

// async function to delete users via API
async function deleteUser(userId) {
    const url = `http://localhost:9090/social-media/users/${userId}`;
  
    try {
      const response = await fetch(url, {
        method: 'DELETE'
      });
  
      if (!response.ok) {
        throw new Error('Network response was not ok');
      }
  
      console.log(`User with ID ${userId} deleted successfully`);
      fetchUsers();
      showAlert(`User with ID ${userId} deleted successfully`, "success");
    } catch (error) {
      console.error('Error deleting user:', error);
    }
}

// async function to edit users via API
async function editUser(userId, firstName, lastName, regNo) {
    const url = `http://localhost:9090/social-media/users/${userId}`;
  
    const userData = {
        firstName: firstName,
        lastName: lastName,
        regNo: regNo
      };
    
      try {
        const response = await fetch(url, {
          method: 'PUT',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify(userData)
        });
    
        if (!response.ok) {
          throw new Error('Network response was not ok');
        }
    
        const data = await response.json();
        console.log('User edited successfully:', data);
        showAlert(`User with ID ${userId} edited successfully`, "success");
        fetchUsers();
      } catch (error) {
        console.error('Error adding user:', error);
      }
}

/* event listeners */

// Delete 
document.querySelector("#student-list").addEventListener("click", (e)=>{
    target = e.target;
    if(target.classList.contains("delete")){
        userRow = target.closest("tr");
        userId = userRow.getAttribute("data-id");

        deleteUser(userId);
    }
});

// Edit data 
document.querySelector("#student-list").addEventListener("click", (e)=>{
    target = e.target;
    if(target.classList.contains("edit")){
        selectedRow = target.parentElement.parentElement;
        document.querySelector("#firstName").value = selectedRow.children[0].textContent;
        document.querySelector("#lastName").value = selectedRow.children[1].textContent;
        document.querySelector("#regNo").value = selectedRow.children[2].textContent;
    }
});

// add data
document.querySelector("#student-form").addEventListener("submit", (e) =>{
    e.preventDefault();

    //get form values
    const firstName = document.querySelector("#firstName").value;
    const lastName = document.querySelector("#lastName").value;
    const regNo = document.querySelector("#regNo").value;


    //validate
    if(firstName == "" || lastName == "" || regNo == ""){
        showAlert("Please fill in all fields", "danger");
    } 
    else{
        if (selectedRow == null){   //add user
            addUser(firstName, lastName, regNo);
        } else{                     //edit user
            selectedRow.children[0].textContent = firstName;
            selectedRow.children[1].textContent = lastName;
            selectedRow.children[2].textContent = regNo;
            editUser(selectedRow.getAttribute("data-id"), firstName, lastName, regNo);
            selectedRow = null;
        }

        clearFields();
    }
});

