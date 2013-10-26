<?php
Doo::loadCore('db/DooModel');
class htPlanTrabajo extends DooModel{
    private $idHtPlanTrabajo;
    private $idUsuario;
    private $idMedico;
    private $idSitio;
    private $idCiclo;
    private $fechaVisita;
    
    private $_table = 'ht_plan_trabajo';
    private $_primarykey = 'id_ht_plan_trabajo';
    private $_fields = array('id_ht_plan_trabajo','id_usuario','id_medico','id_sitio','id_ciclo','fecha_visita');
    
    function __construct(){
        parent::$className = __CLASS__;
    }
    
    public function getIdHtPlanTrabajo() {
        return $this->idHtPlanTrabajo;
    }

    public function setIdHtPlanTrabajo($idHtPlanTrabajo) {
        $this->idHtPlanTrabajo = $idHtPlanTrabajo;
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

    public function getIdCiclo() {
        return $this->idCiclo;
    }

    public function setIdCiclo($idCiclo) {
        $this->idCiclo = $idCiclo;
    }

    public function getFechaVisita() {
        return $this->fechaVisita;
    }

    public function setFechaVisita($fechaVisita) {
        $this->fechaVisita = $fechaVisita;
    }


}
?>
