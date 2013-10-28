<?php

class reportesController extends DooController {

    function getDoctoresReporte() {
        Doo::loadClass('validaLogin');
        Doo::loadModel('htPlanTrabajo');
        Doo::loadModel('ctMedico');
        Doo::loadModel('htReportePlanTrabajo');
        $token = $this->params['token'];
        $usuario = $this->params['usuario'];
        $result = array();
        if (validaLogin::validaToken($token, $usuario)) {
            $result = array('acceso' => 'correcto');
            $plan = new htPlanTrabajo();
            $plan->activo = 1;
            $plan->fecha_visita = date("Y-m-d");
            $plan->id_usuario = $usuario;
            $arrayHtPlan = $this->db()->relateMany($plan,array('ctMedico','htReportePlanTrabajo'));
            if(!empty($arrayHtPlan)){
                foreach ($arrayHtPlan as $planTrabajo){
                    $arrayReporteMedico = array(
                        'htPlanTrabajo' => $planTrabajo->id_ht_plan_trabajo,
                        'idMedico' => $planTrabajo->ctMedico->id_medico,
                        'nombreMedico' => $planTrabajo->ctMedico->nombre.' '.$planTrabajo->ctMedico->apaterno.' '.$planTrabajo->ctMedico->amaterno
                    );
                    if(empty($planTrabajo->htReportePlanTrabajo)){
                        $arrayReporteMedico['reportado'] = "No reportado";
                    }else{
                        $arrayReporteMedico['reportado'] = "Reportado";
                    }
                    $medico[] = $arrayReporteMedico;
                }
                $result['medicos'] = $medico;
            }
        } else {
            $result = array('acceso' => 'denegado');
        }
        //Imprimimos la respuesta como objeto json
        echo json_encode($result);
    }

}

?>
