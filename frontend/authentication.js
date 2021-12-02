function getFormData() {
    let email = document.getElementById("email").value;
    let password = document.getElementById("password").value;
    return {email,password};
}
let url = "http://127.0.0.1:5000";

window.authentication = function (path) {
    let input = getFormData();
    fetch(url+path, {
        method: 'POST',
        mode: 'cors',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(input),
    }).then(response => {
        return response.json();
    }).then(data => {
        localStorage.setItem("token", data.token);
        setTimeout(function(){ 
            window.location.replace("/frontend/main.html");
        }, 3000);
    })
}
