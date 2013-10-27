<?php
Doo::loadCore('db/DooModel');
class ctCorreoUsuario extends DooModel{
    public $id_correo_usuario;
    public $id_usuario;
    public $correo;
    
    public $_table = 'ct_correo_usuario';
    public $_primarykey = 'id_correo_usuario';
    public $_fields = array('id_correo_usuario','id_usuario','correo');
    
    function __construct(){
        parent::$className = __CLASS__;
    }
    
}
?>
