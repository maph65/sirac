<?php
Doo::loadCore('db/DooModel');
class htReportePlanTrabajo extends DooModel{
    public $id_ht_plan_trabajo;
    public $id_potencial;
    public $farmacia;
    public $prescriptor;
    
    public $_table = 'ht_reporte_plan_trabajo';
    public $_primarykey = 'id_ht_plan_trabajo';
    public $_fields = array('id_ht_plan_trabajo','id_potencial','farmacia','prescriptor');
    
    function __construct(){
        parent::$className = __CLASS__;
    }
    
}
?>
