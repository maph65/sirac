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

}

?>
