<?php
Doo::loadCore('db/DooModel');
class ctPotencial extends DooModel{
    public $id_potencial;
    public $descripcion;
    
    public $_table = 'ct_potencial';
    public $_primarykey = 'id_potencial';
    public $_fields = array('id_potencial','descripcion');
    
    function __construct(){
        parent::$className = __CLASS__;
    }
    
}
?>
