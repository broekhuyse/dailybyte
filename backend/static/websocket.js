var socket;

var connect = function(token) {
    socket = io("http://127.0.0.1:5000", {
        withCredentials: true
    });
    socket.emit("initial", {token});

    socket.on("services", (data) => {
        console.log(data);
        displayServices(data);
    });

    socket.on("news", (data) => {
        console.log(data);
        displayNews(data);
    });

    socket.on("covid", (data) => {
        console.log(data);
        displayCovid(data);
    });

    socket.on("weather", (data) => {
        console.log(data);
    });

    socket.on("stocks", (data) => {
        console.log(data);
    });
}
