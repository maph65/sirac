<?php
Doo::loadCore('db/DooModel');
class ctDiaSemana extends DooModel{
    public $id_semana;
    public $abreviatura;
    public $dia;
    
    public $_table = 'ct_dia_semana';
    public $_primarykey = 'id_semana';
    public $_fields = array('id_semana','abreviatura','dia');
    
    function __construct(){
        parent::$className = __CLASS__;
    }
    
}
?>
