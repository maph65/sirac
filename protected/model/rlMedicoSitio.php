<?php
Doo::loadCore('db/DooModel');
class rlMedicoSitio extends DooModel{
    private $idMedico;
    private $idSitio;
    private $telefonoConsultorio;
    private $farmacia;
    
    private $_table = 'rl_medico_sitio';
    private $_primarykey = array('id_medico','id_sitio');
    private $_fields = array('id_medico','id_sitio','telefono_consultorio','farmacia');
    
    function __construct(){
        parent::$className = __CLASS__;
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

    public function getTelefonoConsultorio() {
        return $this->telefonoConsultorio;
    }

    public function setTelefonoConsultorio($telefonoConsultorio) {
        $this->telefonoConsultorio = $telefonoConsultorio;
    }

    public function getFarmacia() {
        return $this->farmacia;
    }

    public function setFarmacia($farmacia) {
        $this->farmacia = $farmacia;
    }

}
?>
