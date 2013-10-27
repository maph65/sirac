<?php
Doo::loadCore('db/DooModel');
class rlMedicoEspecialidad extends DooModel{
    public $id_medico;
    public $id_especialidad;
    public $cedula_especialidad;
    
    public $_table = 'rl_medico_especialidad';
    public $_primarykey = array('id_medico','id_especialidad');
    public $_fields = array('id_medico','id_especialidad','cedula_especialidad');
    
    function __construct(){
        parent::$className = __CLASS__;
    }
    
}
?>
