<?php

class planTrabajoController extends DooController {

    public function obtenerPlanTrabajo() {
        Doo::loadClass('validaLogin');
        Doo::loadModel('htPlanTrabajo');
        $token = $this->params['token'];
        $usuario = $this->params['usuario'];
        $result = array();
        if (validaLogin::validaToken($token, $usuario)) {
            $result = array('acceso' => 'correcto');
            $planTrabajo = new htPlanTrabajo();
            $planTrabajo->fecha_visita(date("Y-m-d"));
            $arrayPlanTrabajo = $this->db()->find($planTrabajo);
            $cantidadVisitar = sizeof($arrayPlanTrabajo);
            if($cantidadVisitar>0){
                $result['numeroVisitas'] = $cantidadVisitar;
                foreach ($arrayPlanTrabajo as $visita){
                    
                }
            }
        } else {
            $result = array('acceso' => 'denegado');
        }
        //Imprimimos la respuesta como objeto json
        echo json_encode($result);
    }

}

?>
