<?php
Doo::loadCore('db/DooModel');
class ctMedico extends DooModel{
    private $idMedico;
    private $nombre;
    private $apaterno;
    private $amaterno;
    private $fechaNac;
    private $cedula;
    private $universidad;
    private $celular;
    
    private $_table = 'ct_medico';
    private $_primarykey = 'id_medico';
    private $_fields = array('id_medico','nombre','apaterno','amaterno','fecha_nac','cedula','universidad','celular');
    
    public function getIdMedico() {
        return $this->idMedico;
    }

    public function setIdMedico($idMedico) {
        $this->idMedico = $idMedico;
    }

    public function getNombre() {
        return $this->nombre;
    }

    public function setNombre($nombre) {
        $this->nombre = $nombre;
    }

    public function getApaterno() {
        return $this->apaterno;
    }

    public function setApaterno($apaterno) {
        $this->apaterno = $apaterno;
    }

    public function getAmaterno() {
        return $this->amaterno;
    }

    public function setAmaterno($amaterno) {
        $this->amaterno = $amaterno;
    }

    public function getFechaNac() {
        return $this->fechaNac;
    }

    public function setFechaNac($fechaNac) {
        $this->fechaNac = $fechaNac;
    }

    public function getCedula() {
        return $this->cedula;
    }

    public function setCedula($cedula) {
        $this->cedula = $cedula;
    }

    public function getUniversidad() {
        return $this->universidad;
    }

    public function setUniversidad($universidad) {
        $this->universidad = $universidad;
    }

    public function getCelular() {
        return $this->celular;
    }

    public function setCelular($celular) {
        $this->celular = $celular;
    }


    
}
?>
