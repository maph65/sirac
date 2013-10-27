<?php
class loginController extends DooController{

    public function login(){
        Doo::loadModel('ctUsuario');
        Doo::autoload('DooDbExpression');
        $result = array();
	if(!isset($_GET['email']) || !isset($_GET['passwd'])){
            $result = array('error'=>'incompleto');
        }else{
            $usuario = new ctUsuario();
            $usuario->email = stripslashes($_GET['email']);
            $usuario->passwd = stripslashes($_GET['passwd']);
            $usuario = $this->db()->find($usuario,array('limit'=>1));
            //print_r($usuario);
            if($usuario){
                //El usuario y la contraseñas son correctas
                $usuario->ultimo_acceso = new DooDbExpression("NOW()");
                $usuario->token = md5(date("Ymd").$usuario->email);
                $usuario->update();
                $result = array(
                            'usuario'=>$usuario->email,
                            //'ultimoAcceso' => $usuario->ultimo_acceso,
                            'token'=>$usuario->token
                        );
            }else{
                //Error de usuario y contraseña
                $result = array('error'=>'incorrecto');
                
            }
        }
        echo json_encode($result);
    }
}
?>
