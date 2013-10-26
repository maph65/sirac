<?php
Doo::loadCore('db/DooModel');
class ctPotencial extends DooModel{
    private $idPotencial;
    private $descripcion;
    
    private $_table = 'ct_potencial';
    private $_primarykey = 'id_potencial';
    private $_fields = array('id_potencial','descripcion');
    
    function __construct(){
        parent::$className = __CLASS__;
    }
    
    public function getIdPotencial() {
        return $this->idPotencial;
    }

    public function setIdPotencial($idPotencial) {
        $this->idPotencial = $idPotencial;
    }

    public function getDescripcion() {
        return $this->descripcion;
    }

    public function setDescripcion($descripcion) {
        $this->descripcion = $descripcion;
    }


}
?>
