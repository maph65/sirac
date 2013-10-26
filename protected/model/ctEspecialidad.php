<?php
Doo::loadCore('db/DooModel');
class ctEspecialidad extends DooModel{
    private $idEspecialidad;
    private $especialidad;
    
    private $_table = 'ct_especialidad';
    private $_primarykey = 'id_especialidad';
    private $_fields = array('id_especialidad','especialidad');
    
    function __construct(){
        parent::$className = __CLASS__;
    }
    
    public function getIdEspecialidad() {
        return $this->idEspecialidad;
    }

    public function setIdEspecialidad($idEspecialidad) {
        $this->idEspecialidad = $idEspecialidad;
    }

    public function getEspecialidad() {
        return $this->especialidad;
    }

    public function setEspecialidad($especialidad) {
        $this->especialidad = $especialidad;
    }
}
?>
