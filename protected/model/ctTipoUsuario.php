<?php
Doo::loadCore('db/DooModel');
class ctTipoUsuario extends DooModel{
    public $id_tipo_usuario;
    public $tipo_usuario;
        
    public $_table = 'ct_tipo_usuario';
    public $_primarykey = 'id_tipo_usuario';
    public $_fields = array('id_tipo_usuario','tipo_usuario');
        
    function __construct(){
        parent::$className = __CLASS__;
    }
    
}
?>
