<?php
Doo::loadCore('db/DooModel');
class htReportePlanTrabajo extends DooModel{
    private $idHtPlanTrabajo;
    private $idPotencial;
    private $farmacia;
    private $prescriptor;
    
    private $_table = 'ht_reporte_plan_trabajo';
    private $_primarykey = 'id_ht_plan_trabajo';
    private $_fields = array('id_ht_plan_trabajo','id_potencial','farmacia','prescriptor');
    
    function __construct(){
        parent::$className = __CLASS__;
    }
    
    public function getIdHtPlanTrabajo() {
        return $this->idHtPlanTrabajo;
    }

    public function setIdHtPlanTrabajo($idHtPlanTrabajo) {
        $this->idHtPlanTrabajo = $idHtPlanTrabajo;
    }

    public function getIdPotencial() {
        return $this->idPotencial;
    }

    public function setIdPotencial($idPotencial) {
        $this->idPotencial = $idPotencial;
    }

    public function getFarmacia() {
        return $this->farmacia;
    }

    public function setFarmacia($farmacia) {
        $this->farmacia = $farmacia;
    }

    public function getPrescriptor() {
        return $this->prescriptor;
    }

    public function setPrescriptor($prescriptor) {
        $this->prescriptor = $prescriptor;
    }


}
?>
