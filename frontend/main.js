let token = localStorage.getItem("token");

if (token != null) {
    connect(token);
}
