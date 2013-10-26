<?php
class ctUsuario extends DooModel{
    private $usuario;
    private $clave;
    private $email;
    private $passwd;
    private $nombre;
    private $apaterno;
    private $amaterno;
    private $idTipoUsuario;
    private $idGerente;
    private $token;
    private $ultimoAcceso;
        
    private $_table = 'ct_usuario';
    private $_primarykey = 'usuario';
    private $_fields = array('usuario','clave','email','passwd','nombre','apaterno','amaterno','id_tipo_usuario','id_gerente','token','ultimo_acceso');
        
    function __construct(){
        parent::$className = __CLASS__;
    }
    
    public function getUsuario() {
        return $this->usuario;
    }

    public function setUsuario($usuario) {
        $this->usuario = $usuario;
    }

    public function getClave() {
        return $this->clave;
    }

    public function setClave($clave) {
        $this->clave = $clave;
    }

    public function getEmail() {
        return $this->email;
    }

    public function setEmail($email) {
        $this->email = $email;
    }

    public function getPasswd() {
        return $this->passwd;
    }

    public function setPasswd($passwd) {
        $this->passwd = $passwd;
    }

    public function getNombre() {
        return $this->nombre;
    }

    public function setNombre($nombre) {
        $this->nombre = $nombre;
    }

    public function getApaterno() {
        return $this->apaterno;
    }

    public function setApaterno($apaterno) {
        $this->apaterno = $apaterno;
    }

    public function getAmaterno() {
        return $this->amaterno;
    }

    public function setAmaterno($amaterno) {
        $this->amaterno = $amaterno;
    }

    public function getIdTipoUsuario() {
        return $this->idTipoUsuario;
    }

    public function setIdTipoUsuario($idTipoUsuario) {
        $this->idTipoUsuario = $idTipoUsuario;
    }

    public function getIdGerente() {
        return $this->idGerente;
    }

    public function setIdGerente($idGerente) {
        $this->idGerente = $idGerente;
    }

    public function getToken() {
        return $this->token;
    }

    public function setToken($token) {
        $this->token = $token;
    }

    public function getUltimoAcceso() {
        return $this->ultimoAcceso;
    }

    public function setUltimoAcceso($ultimoAcceso) {
        $this->ultimoAcceso = $ultimoAcceso;
    }


}
?>
