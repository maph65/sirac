<?php
Doo::loadCore('db/DooModel');
class ctCiclo extends DooModel{
    private $idCiclo;
    private $fechaInicio;
    private $fechaTermina;
    
    private $_table = 'ct_ciclo';
    private $_primarykey = 'id_ciclo';
    private $_fields = array('id_ciclo','fecha_inicio','fecha_termino');
    
    function __construct(){
        parent::$className = __CLASS__;
    }
    
    public function getIdCiclo() {
        return $this->idCiclo;
    }

    public function setIdCiclo($idCiclo) {
        $this->idCiclo = $idCiclo;
    }

    public function getFechaInicio() {
        return $this->fechaInicio;
    }

    public function setFechaInicio($fechaInicio) {
        $this->fechaInicio = $fechaInicio;
    }

    public function getFechaTermina() {
        return $this->fechaTermina;
    }

    public function setFechaTermina($fechaTermina) {
        $this->fechaTermina = $fechaTermina;
    }

    public function get_primarykey() {
        return $this->_primarykey;
    }

    public function set_primarykey($_primarykey) {
        $this->_primarykey = $_primarykey;
    }
}
?>
