<?php
Doo::loadCore('db/DooModel');
class ctCorreoUsuario extends DooModel{
    private $idCorreoUsuario;
    private $idUsuario;
    private $correo;
    
    private $_table = 'ct_correo_usuario';
    private $_primarykey = 'id_correo_usuario';
    private $_fields = array('id_correo_usuario','id_usuario','correo');
    
    function __construct(){
        parent::$className = __CLASS__;
    }
    
    public function getIdCorreoUsuario() {
        return $this->idCorreoUsuario;
    }

    public function setIdCorreoUsuario($idCorreoUsuario) {
        $this->idCorreoUsuario = $idCorreoUsuario;
    }

    public function getIdUsuario() {
        return $this->idUsuario;
    }

    public function setIdUsuario($idUsuario) {
        $this->idUsuario = $idUsuario;
    }

    public function getCorreo() {
        return $this->correo;
    }

    public function setCorreo($correo) {
        $this->correo = $correo;
    }


}
?>
