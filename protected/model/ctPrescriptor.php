<?php
class ctPrescriptor extends DooModel{
    private $idPrescriptor;
    private $tipoPrescriptor;
    
    private $_table = 'ct_prescriptor';
    private $_primarykey = 'id_prescriptor';
    private $_fields = array('id_prescriptor','tipo_prescriptor');
    
    function __construct(){
        parent::$className = __CLASS__;
    }
    
    public function getIdPrescriptor() {
        return $this->idPrescriptor;
    }

    public function setIdPrescriptor($idPrescriptor) {
        $this->idPrescriptor = $idPrescriptor;
    }

    public function getTipoPrescriptor() {
        return $this->tipoPrescriptor;
    }

    public function setTipoPrescriptor($tipoPrescriptor) {
        $this->tipoPrescriptor = $tipoPrescriptor;
    }


}
?>
