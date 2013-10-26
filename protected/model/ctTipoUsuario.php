<?php
class ctTipoUsuario extends DooModel{
    private $idTipoUsuario;
    private $tipoUsuario;
        
    private $_table = 'ct_tipo_usuario';
    private $_primarykey = 'id_tipo_usuario';
    private $_fields = array('id_tipo_usuario','tipo_usuario');
        
    function __construct(){
        parent::$className = __CLASS__;
    }
    
    public function getIdTipoUsuario() {
        return $this->idTipoUsuario;
    }

    public function setIdTipoUsuario($idTipoUsuario) {
        $this->idTipoUsuario = $idTipoUsuario;
    }

    public function getTipoUsuario() {
        return $this->tipoUsuario;
    }

    public function setTipoUsuario($tipoUsuario) {
        $this->tipoUsuario = $tipoUsuario;
    }


}
?>
