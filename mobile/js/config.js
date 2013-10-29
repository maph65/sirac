//var servidor = 'http://www.enginetec.com.mx/'; //'http://192.168.0.17/';
var servidor = window.location.protocol + "//" + window.location.host + "/";

function setToken(tk){
    window.localStorage.setItem("token",tk);
}

function getToken(){
    return window.localStorage.getItem("token");
}

function setUsuario(usr){
    window.localStorage.setItem("usuario",usr);
}

function getUsuario(){
    return window.localStorage.getItem("usuario");
}

function setTipoUsuario(tipo){
    window.localStorage.setItem("tipoUsuario",tipo);
}

function getTipoUsuario(){
    return window.localStorage.getItem("tipoUsuario");
}
