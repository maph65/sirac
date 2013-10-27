<?php
Doo::loadCore('db/DooModel');
class ctSitio extends DooModel{
    public $id_sitio;
    public $nombre;
    public $calle;
    public $num_exterior;
    public $num_interior;
    public $colonia;
    public $cp;
    public $delegacion;
    public $estado;
    public $telefono;
    
    public $_table = 'ct_sitio';
    public $_primarykey = 'id_sitio';
    public $_fields = array('id_sitio','nombre','calle','num_exterior','num_interior','colonia','cp','delegacion','estado','telefono');
    
    function __construct(){
        parent::$className = __CLASS__;
    }
    
}
?>
