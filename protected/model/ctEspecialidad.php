<?php
Doo::loadCore('db/DooModel');
class ctEspecialidad extends DooModel{
    public $id_especialidad;
    public $especialidad;
    
    public $_table = 'ct_especialidad';
    public $_primarykey = 'id_especialidad';
    public $_fields = array('id_especialidad','especialidad');
    
    function __construct(){
        parent::$className = __CLASS__;
    }
}
?>
