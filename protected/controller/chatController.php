<?php

/**
 * Description of chatController
 *
 * @author Miguel Pérez
 */
class chatController extends DooController {

    public function getNumeroMensajesNuevos() {
        Doo::loadClass('validaLogin');
        Doo::loadModel('htMensajesUsuario');
        $token = $this->params['token'];
        $usuario = $this->params['usuario'];
        $result = array();
        if (validaLogin::validaToken($token, $usuario)) {
            $result = array('acceso' => 'correcto');
            $mensajes = new htMensajesUsuario();
            $mensajes->receptor = $usuario;
            $mensajes->leido = 0;
            $arrayMensajes = $this->db()->find($mensajes);
            $result['sinLeer'] = sizeof($arrayMensajes);
        } else {
            $result = array('acceso' => 'denegado');
        }
        //Imprimimos la respuesta como objeto json
        echo json_encode($result);
    }

    public function getListaUsuarios() {
        Doo::loadClass('validaLogin');
        Doo::loadModel('ctUsuario');
        $token = $this->params['token'];
        $usuario = $this->params['usuario'];
        if (isset($_POST['q'])) {
            $query = strip_tags(stripslashes($_POST['q']));
            $result = array();
            if (validaLogin::validaToken($token, $usuario)) {
                $result = array('acceso' => 'correcto');
                $consultaUsuarios = $this->db()->find(new ctUsuario(), array('where' => ' (nombre LIKE \'%' . $query . '%\' OR apaterno LIKE \'%' . $query . '%\' OR amaterno LIKE \'%' . $query . '%\') AND usuario!=\'' . $usuario . '\''));
                $result['numUsuarios'] = sizeof($consultaUsuarios);
                if (!empty($consultaUsuarios)) {
                    foreach ($consultaUsuarios as $usr) {
                        $temp = array();
                        $temp['nombre'] = utf8_encode($usr->nombre . ' ' . $usr->apaterno . ' ' . $usr->amaterno);
                        $temp['usuario'] = $usr->usuario;
                        $result['usuarios'][] = $temp;
                    }
                }
            } else {
                $result = array('acceso' => 'denegado');
            }
            //Imprimimos la respuesta como objeto json
            echo json_encode($result);
        } else {
            echo '<h1>Error 404. Not found.</h1>';
        }
    }

    public function getConversacion() {
        Doo::loadClass('validaLogin');
        Doo::loadModel('htMensajesUsuario');
        Doo::loadModel('ctUsuario');
        $token = $this->params['token'];
        $usuario = $this->params['usuario'];
        $segundoUsuario = $this->params['segundoUsuario'];
        $segundoUsr = new ctUsuario();
        $segundoUsr->usuario = $segundoUsuario;
        $segundoUsr = $this->db()->find($segundoUsr,array('limit'=>1));
        $result = array();
        if (validaLogin::validaToken($token, $usuario) &&  $segundoUsr) {
            $result = array('acceso' => 'correcto');
            $result['segundoUsuario'] = $segundoUsr->nombre;
            //Buscamos la conversacion completa, solo los ultimos 20 mensajes de la conversacion
            $arrayMensajes = $this->db()->find(new htMensajesUsuario(),array('where'=>'(emisor = \''.$usuario.'\' AND receptor = \''.$segundoUsuario.'\') OR (emisor = \''.$segundoUsuario.'\' AND receptor = \''.$usuario.'\')','custom'=>'ORDER BY fecha_envio DESC LIMIT 20'));
            //print_r($this->db()->showSQL());
            foreach($arrayMensajes as $msj){
                $temp = array();
                //Marcamos los mensajes como leidos y actualizamos
                if($msj->receptor==$usuario){
                    $msj->leido = 1;
                    $msj->update();
                    //Esta variable indica si el mensaje es para nosotros o nosotros lo enviamos
                    $temp['recibido'] = TRUE;
                }else{
                    //Esta variable indica si el mensaje es para nosotros o nosotros lo enviamos
                    $temp['recibido'] = FALSE;
                }
                $temp['mensaje'] = htmlentities(utf8_decode($msj->mensaje));
                $temp['fecha'] = $msj->fecha_envio;
                $result['mensajes'][] = $temp;
            }
        } else {
            $result = array('acceso' => 'denegado');
        }
        //Imprimimos la respuesta como objeto json
        echo json_encode($result);
    }

    public function enviarMensaje() {
        Doo::autoload('DooDbExpression');
        Doo::loadClass('validaLogin');
        Doo::loadModel('htMensajesUsuario');
        Doo::loadModel('ctUsuario');
        $token = $this->params['token'];
        $usuario = $this->params['usuario'];
        $result = array();
        if (validaLogin::validaToken($token, $usuario)) {
            $result = array('acceso' => 'correcto');
            if (isset($_POST['mensaje']) && isset($_POST['destinatario'])) {
                $destinatario = stripslashes(htmlentities($_POST['destinatario']));
                $mensaje = stripslashes($_POST['mensaje']);
                if (strlen($mensaje) > 0 && strlen($destinatario) > 0) {
                    $ctUsuario = new ctUsuario();
                    $ctUsuario->usuario = $destinatario;
                    if ($ctUsuario->find()) {
                        $objMensaje = new htMensajesUsuario();
                        $objMensaje->emisor = $usuario;
                        $objMensaje->receptor = $destinatario;
                        $objMensaje->leido = 0;
                        $objMensaje->mensaje = $mensaje;
                        $objMensaje->fecha_envio = new DooDbExpression('NOW()');
                        if ($objMensaje->insert()) {
                            $result['registro'] = 'exitoso';
                        } else {
                            $result['registro'] = 'error';
                            $result['error'] = 'No se pudo insertar en la base de datos.';
                        }
                    } else {
                        $result['registro'] = 'error';
                        $result['error'] = 'No existe el usuario.';
                    }
                } else {
                    $result['registro'] = 'error';
                    $result['error'] = 'El mensaje esta vacío.';
                }
            } else {
                $result['registro'] = 'error';
                $result['error'] = 'No se recibío el mensaje o el usuario destinatario';
            }
        } else {
            $result = array('acceso' => 'denegado');
        }
        //Imprimimos la respuesta como objeto json
        echo json_encode($result);
    }

    public function getUltimasConversaciones() {
        Doo::loadClass('validaLogin');
        Doo::loadModel('htMensajesUsuario');
        Doo::loadModel('ctUsuario');
        $token = $this->params['token'];
        $usuario = $this->params['usuario'];
        $result = array();
        if (validaLogin::validaToken($token, $usuario)) {
            $result = array('acceso' => 'correcto');
            $query = "SELECT DISTINCT ct_usuario.* FROM ct_usuario, ht_mensajes_usuario WHERE (ht_mensajes_usuario.emisor = ct_usuario.usuario OR ht_mensajes_usuario.receptor = ct_usuario.usuario) AND (ht_mensajes_usuario.emisor = '" . $usuario . "' OR ht_mensajes_usuario.receptor = '" . $usuario . "') AND ct_usuario.usuario != '" . $usuario . "'";
            $resultadoQuery = $this->db()->fetchAll($query);
            foreach ($resultadoQuery as $obj) {
                $arrayUsuarios[] = $this->db()->toObject($obj, 'ctUsuario');
            }
            foreach ($arrayUsuarios as $usr) {
                $temp = array();
                $temp['nombre'] = utf8_encode($usr->nombre . ' ' . $usr->apaterno . ' ' . $usr->amaterno);
                $temp['usuario'] = $usr->usuario;
                $result['usuarios'][] = $temp;
            }
        } else {
            $result = array('acceso' => 'denegado');
        }
        //Imprimimos la respuesta como objeto json
        echo json_encode($result);
    }

}

?>
