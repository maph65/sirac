<?php
Doo::loadCore('db/DooModel');
class htPlanTrabajo extends DooModel{
    public $id_ht_plan_trabajo;
    public $id_usuario;
    public $id_medico;
    public $id_sitio;
    public $id_ciclo;
    public $fecha_visita;
    public $hora_visita;
    public $activo;
    
    public $_table = 'ht_plan_trabajo';
    public $_primarykey = 'id_ht_plan_trabajo';
    public $_fields = array('id_ht_plan_trabajo','id_usuario','id_medico','id_sitio','id_ciclo','fecha_visita','hora_visita','activo');
    
    function __construct(){
        parent::$className = __CLASS__;
    }
    
    
}
?>
