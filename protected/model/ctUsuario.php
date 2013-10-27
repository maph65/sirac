<?php
Doo::loadCore('db/DooModel');
class ctUsuario extends DooModel{
    public $usuario;
    public $clave;
    public $email;
    public $passwd;
    public $nombre;
    public $apaterno;
    public $amaterno;
    public $id_tipo_usuario;
    public $gerente;
    public $token;
    public $ultimo_acceso;
        
    public $_table = 'ct_usuario';
    public $_primarykey = 'usuario';
    public $_fields = array('usuario','clave','email','passwd','nombre','apaterno','amaterno','id_tipo_usuario','gerente','token','ultimo_acceso');
        
    function __construct(){
        parent::$className = __CLASS__;
    }
    
}
?>
