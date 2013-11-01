<?php
Doo::loadCore('db/DooModel');
class ctPresentacion extends DooModel{
    public $id_presentacion;
    public $id_medicina;
    public $tipo_presentacion;
    public $dosis;
    
    public $_table = 'ct_presentacion';
    public $_primarykey = 'id_presentacion';
    public $_fields = array('id_presentacion','id_medicina','tipo_presentacion','dosis');
    
    function __construct(){
        parent::$className = __CLASS__;
    }
}
?>
