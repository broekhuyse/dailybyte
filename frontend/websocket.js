var socket;

var connect = function(token) {
    socket = io("http://127.0.0.1:5000", {
        withCredentials: true
    });
    socket.emit("message", JSON.stringify({type: "connect", token}));

    socket.on("news", (data) => {
        console.log(data);
    });

    socket.on("weather", (data) => {
        console.log(data);
    });

    socket.on("covid19", (data) => {
        console.log(data);
    });

    socket.on("stocks", (data) => {
        console.log(data);
    });
}