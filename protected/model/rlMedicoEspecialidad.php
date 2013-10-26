<?php
Doo::loadCore('db/DooModel');
class rlMedicoEspecialidad extends DooModel{
    private $idMedico;
    private $idEspecialidad;
    private $cedulaEspecialidad;
    
    private $_table = 'rl_medico_especialidad';
    private $_primarykey = array('id_medico','id_especialidad');
    private $_fields = array('id_medico','id_especialidad','cedula_especialidad');
    
    function __construct(){
        parent::$className = __CLASS__;
    }
    
    public function getIdMedico() {
        return $this->idMedico;
    }

    public function setIdMedico($idMedico) {
        $this->idMedico = $idMedico;
    }

    public function getIdEspecialidad() {
        return $this->idEspecialidad;
    }

    public function setIdEspecialidad($idEspecialidad) {
        $this->idEspecialidad = $idEspecialidad;
    }

    public function getCedulaEspecialidad() {
        return $this->cedulaEspecialidad;
    }

    public function setCedulaEspecialidad($cedulaEspecialidad) {
        $this->cedulaEspecialidad = $cedulaEspecialidad;
    }


}
?>
