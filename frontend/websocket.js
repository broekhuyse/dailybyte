var socket;

var connect = function(token) {
    socket = io("http://127.0.0.1:5000", {
        withCredentials: true
    });
    socket.emit("initial", {token});

    socket.on("services", (data) => {
        console.log(data);
        serviceData = data;
        displayServices();
    });

    socket.on("news", (data) => {
        console.log(data);
        newsData = data;
        displayNews();
    });

    socket.on("weather", (data) => {
        console.log(data);
        weatherData = data;
    });

    socket.on("covid", (data) => {
        console.log(data);
        covidData = data;
        displayCovid();
    });

    socket.on("stocks", (data) => {
        console.log(data);
    });
}
