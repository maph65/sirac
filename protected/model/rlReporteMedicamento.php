<?php
Doo::loadCore('db/DooModel');
class rlReporteMedicamento extends DooModel{
    public $id_ht_plan_trabajo;
    public $id_presentacion;
    public $cantidad;
    
    public $_table = 'ht_mensajes_usuario';
    public $_primarykey = array('id_ht_plan_trabajo','id_presentacion');
    public $_fields = array('id_ht_plan_trabajo','id_presentacion','cantidad');
    
    function __construct(){
        parent::$className = __CLASS__;
    }
}
?>
