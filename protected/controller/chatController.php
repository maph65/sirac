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
                $consultaUsuarios = $this->db()->find(new ctUsuario(), array('where' => 'nombre LIKE \'%' . $query . '%\' OR apaterno LIKE \'%' . $query . '%\' OR amaterno LIKE \'%' . $query . '%\''));
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
        $token = $this->params['token'];
        $usuario = $this->params['usuario'];
        $segundoUsuario = $this->params['segundoUsuario'];
        $result = array();
        if (validaLogin::validaToken($token, $usuario)) {
            $result = array('acceso' => 'correcto');
        } else {
            $result = array('acceso' => 'denegado');
        }
        //Imprimimos la respuesta como objeto json
        echo json_encode($result);
    }

    public function enviarMensaje() {
        Doo::loadClass('validaLogin');
        Doo::loadModel('htMensajesUsuario');
        Doo::loadModel('ctUsuario');
        Doo::autoload('DooDbExpression');
        $token = $this->params['token'];
        $usuario = $this->params['usuario'];
        $result = array();
        if (validaLogin::validaToken($token, $usuario)) {
            $result = array('acceso' => 'correcto');
            if (isset($_POST['mensaje']) && isset($_POST['destinatario'])) {
                $destinatario = stripslashes(htmlentities($_POST['destinatario']));
                $mensaje = stripslashes(htmlentities($_POST['mensaje']));
                if (strlen($mensaje) > 0 && strlen($destinatario) > 0) {
                    $ctUsuario = new ctUsuario();
                    $ctUsuario->usuario = $destinatario;
                    if ($ctUsuario->find()) {
                        $objMensaje = new htMensajesUsuario();
                        $objMensaje->emisor = $usuario;
                        $objMensaje->receptor = $destinatario;
                        $objMensaje->leido = 0;
                        $objMensaje->mensaje = $mensaje;
                        $objMensaje->fecha_envio = DooDbExpression('NOW()');
                    }else{
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
        $token = $this->params['token'];
        $usuario = $this->params['usuario'];
        $result = array();
        if (validaLogin::validaToken($token, $usuario)) {
            $result = array('acceso' => 'correcto');
            $arrayUsuarios = $this->db()->relate(new htMensajesUsuario(), 'ctUsuario', array('select' => 'DISTINCT emisor'));
            //print_r($arrayUsuarios);
            //print_r($this->db()->showSQL());
        } else {
            $result = array('acceso' => 'denegado');
        }
        //Imprimimos la respuesta como objeto json
        echo json_encode($result);
    }

}

?>
