<?php

class gerenteController extends DooController {

    public function getRepresentantesGerente() {
        Doo::loadClass('validaLogin');
        Doo::loadModel('ctUsuario');
        $token = $this->params['token'];
        $usuario = $this->params['usuario'];
        $result = array();
        if (validaLogin::validaToken($token, $usuario)) {
            $result = array('acceso' => 'correcto');
            $ctUsuario = new ctUsuario();
            $ctUsuario->gerente = $usuario;
            $arrayRepresentantes = $ctUsuario->find();
            $result['numRepresentantes'] = sizeof($arrayRepresentantes);
            if(!empty($arrayRepresentantes)){
                $arrayDatosRep = array();
                foreach($arrayRepresentantes as $representante){
                    $temp = array(
                        'idRepresentante' => $representante->usuario,
                        'nombreRepresentante' => utf8_encode($representante->nombre. ' ' .$representante->apaterno. ' '.$representante->amaterno)
                    );
                    array_push($arrayDatosRep, $temp);
                }
                $result['representantes'] = $arrayDatosRep;
            }
        }else{
            $result = array('acceso' => 'denegado');
        }
        //Imprimimos la respuesta como objeto json
        echo json_encode($result);
    }
    
    
    public function getPlanTrabajoActivo() {
        Doo::loadModel('htPlanTrabajo');
        Doo::loadClass('validaLogin');
        $token = $this->params['token'];
        $usuario = $this->params['usuario'];
        $representante = $this->params['representante'];
        $result = array();
        if (validaLogin::validaToken($token, $usuario)) {
            $result = array('acceso' => 'correcto');
            $planTrabajo = new htPlanTrabajo();
            $planTrabajo->id_usuario = $representante;
            $planTrabajo->fecha_visita = date("Y-m-d");
            $planTrabajo->activo = 1;
            $planTrabajo = $this->db()->find($planTrabajo, array('limit' => 1));
            if ($planTrabajo) {
                //Se encontraron planes de trabajo activo
                $result['planActivo'] = TRUE;
            } else {
                //No se encontraron planes de trabajo activo o no hay planes de trabajo
                $result['planActivo'] = FALSE;
            }
        } else {
            $result = array('acceso' => 'denegado');
        }
        echo json_encode($result);
    }

}

?>
