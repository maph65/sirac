<?php
Doo::loadCore('db/DooModel');
class ctDiaSemana extends DooModel{
    private $idSemana;
    private $abreviatura;
    private $dia;
    
    private $_table = 'ct_dia_semana';
    private $_primarykey = 'id_semana';
    private $_fields = array('id_semana','abreviatura','dia');
    
    function __construct(){
        parent::$className = __CLASS__;
    }
    
    public function getIdSemana() {
        return $this->idSemana;
    }

    public function setIdSemana($idSemana) {
        $this->idSemana = $idSemana;
    }

    public function getAbreviatura() {
        return $this->abreviatura;
    }

    public function setAbreviatura($abreviatura) {
        $this->abreviatura = $abreviatura;
    }

    public function getDia() {
        return $this->dia;
    }

    public function setDia($dia) {
        $this->dia = $dia;
    }


}
?>
