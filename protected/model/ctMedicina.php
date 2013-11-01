<?php
Doo::loadCore('db/DooModel');
class ctMedicina extends DooModel{
    public $id_medicina;
    public $nombre;
    public $descripcion;
    
    public $_table = 'ct_medicina';
    public $_primarykey = 'id_medicina';
    public $_fields = array('id_medicina','nombre','descripcion');
    
    function __construct(){
        parent::$className = __CLASS__;
    }
}
?>
