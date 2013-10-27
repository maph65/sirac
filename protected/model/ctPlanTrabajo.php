<?php
Doo::loadCore('db/DooModel');
class ctPlanTrabajo extends DooModel{
    public $id_plan_trabajo;
    public $id_usuario;
    public $id_medico;
    public $id_sitio;
    public $semana;
    public $id_dia;
    public $territorio;
    
    public $_table = 'ct_plan_trabajo';
    public $_primarykey = 'id_plan_trabajo';
    public $_fields = array('id_plan_trabajo','id_usuario','id_medico','id_sitio','semana','id_dia','territorio');
    
    function __construct(){
        parent::$className = __CLASS__;
    }
    
}
?>
