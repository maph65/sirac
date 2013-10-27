<?php
Doo::loadModel('ctUsuario');
class validaLogin{
        
    public static function  validaToken($token,$usr){
        $nuevoToken = md5(date("Ymd").$usr);
        if($token!=$nuevoToken){
            //El token recibido no es valido para la fecha actual o el usuario proporcionado
            return false;
        }else{
            $usuario = new ctUsuario();
            $usuario->usuario = $usr;
            $usuario->token = $token;
            $usuario = Doo::db()->find($usuario,array('limit'=>1));
            if($usuario){
                //El token es valido y pertenece al usuario
                return true;
            }else{
                //El token es valido pero no pertenece al usuario
                return false;
            }
        }
    }

    
}
?>
