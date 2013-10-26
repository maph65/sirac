<?php
class ctSitio extends DooModel{
    private $idSitio;
    private $nombre;
    private $calle;
    private $numExterior;
    private $numInterior;
    private $colonia;
    private $cp;
    private $delegacion;
    private $estado;
    private $telefono;
    
    private $_table = 'ct_sitio';
    private $_primarykey = 'id_sitio';
    private $_fields = array('id_sitio','nombre','calle','num_exterior','num_interior','colonia','cp','delegacion','estado','telefono');
    
    function __construct(){
        parent::$className = __CLASS__;
    }
    
    public function getIdSitio() {
        return $this->idSitio;
    }

    public function setIdSitio($idSitio) {
        $this->idSitio = $idSitio;
    }

    public function getNombre() {
        return $this->nombre;
    }

    public function setNombre($nombre) {
        $this->nombre = $nombre;
    }

    public function getCalle() {
        return $this->calle;
    }

    public function setCalle($calle) {
        $this->calle = $calle;
    }

    public function getNumExterior() {
        return $this->numExterior;
    }

    public function setNumExterior($numExterior) {
        $this->numExterior = $numExterior;
    }

    public function getNumInterior() {
        return $this->numInterior;
    }

    public function setNumInterior($numInterior) {
        $this->numInterior = $numInterior;
    }

    public function getColonia() {
        return $this->colonia;
    }

    public function setColonia($colonia) {
        $this->colonia = $colonia;
    }

    public function getCp() {
        return $this->cp;
    }

    public function setCp($cp) {
        $this->cp = $cp;
    }

    public function getDelegacion() {
        return $this->delegacion;
    }

    public function setDelegacion($delegacion) {
        $this->delegacion = $delegacion;
    }

    public function getEstado() {
        return $this->estado;
    }

    public function setEstado($estado) {
        $this->estado = $estado;
    }

    public function getTelefono() {
        return $this->telefono;
    }

    public function setTelefono($telefono) {
        $this->telefono = $telefono;
    }
    
}
?>
