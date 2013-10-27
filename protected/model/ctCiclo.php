<?php
Doo::loadCore('db/DooModel');
class ctCiclo extends DooModel{
    public $id_ciclo;
    public $fecha_inicio;
    public $fecha_termino;
    
    public $_table = 'ct_ciclo';
    public $_primarykey = 'id_ciclo';
    public $_fields = array('id_ciclo','fecha_inicio','fecha_termino');
    
    function __construct(){
        parent::$className = __CLASS__;
    }
    
}
?>
