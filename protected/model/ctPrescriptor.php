<?php

Doo::loadCore('db/DooModel');
class ctPrescriptor extends DooModel{
    public $id_prescriptor;
    public $tipo_prescriptor;
    
    public $_table = 'ct_prescriptor';
    public $_primarykey = 'id_prescriptor';
    public $_fields = array('id_prescriptor','tipo_prescriptor');
    
    function __construct(){
        parent::$className = __CLASS__;
    }
}
?>
