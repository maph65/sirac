<?php
Doo::loadCore('db/DooModel');
class htMensajesUsuario extends DooModel{
    public $id_mensaje;
    public $mensaje;
    public $emisor;
    public $receptor;
    public $leido;
    public $fecha_envio;
    
    public $_table = 'ht_mensajes_usuario';
    public $_primarykey = 'id_mensaje';
    public $_fields = array('id_mensaje','mensaje','emisor','receptor','leido','fecha_envio');
    
    function __construct(){
        parent::$className = __CLASS__;
    }
}
?>
