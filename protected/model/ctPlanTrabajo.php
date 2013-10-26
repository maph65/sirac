<?php
Doo::loadCore('db/DooModel');
class ctPlanTrabajo extends DooModel{
    private $idPlanTrabajo;
    private $idUsuario;
    private $idMedico;
    private $idSitio;
    private $semana;
    private $idDia;
    private $territorio;
    
    private $_table = 'ct_plan_trabajo';
    private $_primarykey = 'id_plan_trabajo';
    private $_fields = array('id_plan_trabajo','id_usuario','id_medico','id_sitio','semana','id_dia','territorio');
    
    function __construct(){
        parent::$className = __CLASS__;
    }
    
    public function getIdPlanTrabajo() {
        return $this->idPlanTrabajo;
    }

    public function setIdPlanTrabajo($idPlanTrabajo) {
        $this->idPlanTrabajo = $idPlanTrabajo;
    }

    public function getIdUsuario() {
        return $this->idUsuario;
    }

    public function setIdUsuario($idUsuario) {
        $this->idUsuario = $idUsuario;
    }

    public function getIdMedico() {
        return $this->idMedico;
    }

    public function setIdMedico($idMedico) {
        $this->idMedico = $idMedico;
    }

    public function getIdSitio() {
        return $this->idSitio;
    }

    public function setIdSitio($idSitio) {
        $this->idSitio = $idSitio;
    }

    public function getSemana() {
        return $this->semana;
    }

    public function setSemana($semana) {
        $this->semana = $semana;
    }

    public function getIdDia() {
        return $this->idDia;
    }

    public function setIdDia($idDia) {
        $this->idDia = $idDia;
    }

    public function getTerritorio() {
        return $this->territorio;
    }

    public function setTerritorio($territorio) {
        $this->territorio = $territorio;
    }


}
?>
