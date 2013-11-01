<?php
Doo::loadCore('db/DooModel');
class presentacionHasUsuario extends DooModel{
    public $id_presentacion;
    public $representante;
    public $fecha;
    
    public $_table = 'ct_presentacion_has_ct_usuario';
    public $_primarykey = array('id_presentacion','representante','fecha');
    public $_fields = array('id_presentacion','representante','fecha');
    
    function __construct(){
        parent::$className = __CLASS__;
    }
}
?>
