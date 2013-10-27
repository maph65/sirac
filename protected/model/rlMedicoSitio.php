<?php
Doo::loadCore('db/DooModel');
class rlMedicoSitio extends DooModel{
    public $id_medico;
    public $id_sitio;
    public $telefono_consultorio;
    public $farmacia;
    
    public $_table = 'rl_medico_sitio';
    public $_primarykey = array('id_medico','id_sitio');
    public $_fields = array('id_medico','id_sitio','telefono_consultorio','farmacia');
    
    function __construct(){
        parent::$className = __CLASS__;
    }
}
?>
