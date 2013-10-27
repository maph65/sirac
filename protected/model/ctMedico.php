<?php
Doo::loadCore('db/DooModel');
class ctMedico extends DooModel{
    public $id_medico;
    public $nombre;
    public $apaterno;
    public $amaterno;
    public $fecha_nac;
    public $cedula;
    public $universidad;
    public $celular;
    
    public $_table = 'ct_medico';
    public $_primarykey = 'id_medico';
    public $_fields = array('id_medico','nombre','apaterno','amaterno','fecha_nac','cedula','universidad','celular');
    
    function __construct(){
        parent::$className = __CLASS__;
    }
}
?>
