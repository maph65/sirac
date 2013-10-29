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
            $arrayHtPlan = $this->db()->relateMany($plan, array('ctMedico', 'htReportePlanTrabajo'));
            if (!empty($arrayHtPlan)) {
                foreach ($arrayHtPlan as $planTrabajo) {
                    $arrayReporteMedico = array(
                        'htPlanTrabajo' => $planTrabajo->id_ht_plan_trabajo,
                        'idSitio' => $planTrabajo->id_sitio,
                        'idMedico' => $planTrabajo->ctMedico->id_medico,
                        'nombreMedico' => $planTrabajo->ctMedico->nombre . ' ' . $planTrabajo->ctMedico->apaterno . ' ' . $planTrabajo->ctMedico->amaterno
                    );
                    if (empty($planTrabajo->htReportePlanTrabajo)) {
                        $arrayReporteMedico['reportado'] = "No reportado";
                    } else {
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

    function guardarReporte() {
        Doo::loadClass('validaLogin');
        Doo::loadModel('ctPlanTrabajo');
        Doo::loadModel('htPlanTrabajo');
        Doo::loadModel('ctMedico');
        Doo::loadModel('htReportePlanTrabajo');
        $token = $this->params['token'];
        $usuario = $this->params['usuario'];
        $idreporte = $this->params['idhtreporte'];
        $result = array();
        if (validaLogin::validaToken($token, $usuario)) {
            $result = array('acceso' => 'correcto');
            $planTrabajo = new ctPlanTrabajo();
            $planTrabajo->id_plan_trabajo = $idreporte;
            $planTrabajo = $this->db()->find($planTrabajo, array('limit' => 1));
            if ($planTrabajo) {
                $reporte = new htReportePlanTrabajo();
                $reporte->id_ht_plan_trabajo = $idreporte;
                $reporte->farmacia = 1;
                $reporte->id_potencial = 'A';
                $reporte->prescriptor = 1;
                $reporte->insert();
                $result['registro'] = 'ok';
            } else {
                $result['registro'] = 'error';
            }
        } else {
            $result = array('acceso' => 'denegado');
        }
        echo json_encode($result);
    }

    public function agregarMedico() {
        Doo::loadModel('htPlanTrabajo');
        Doo::loadModel('ctCiclo');
        Doo::loadModel('ctMedico');
        Doo::loadModel('ctUsusario');
        Doo::loadModel('rlMedicoSitio');
        Doo::loadClass('diaSemanaCiclo');
        $idUsuario = $this->params['usuario'];
        $idMedico = $this->params['medico'];
        $usuario = $this->db()->find(new ctUsuario(), array('where' => 'idUsuario = ' . $idUsuario, 'limit' => 1));
        $medicoVisita = $this->db()->find(new ctMedico(), array('where' => 'idMedico = ' . $idMedico, 'limit' => 1));
        $medicoSitio = $this->db()->find(new rlMedicoSitio(), array('where' => 'idMedico = ' . $idMedico, 'limit' => 1));
        $ciclo = $this->db()->find(new ctCiclo(), array('where' => 'fecha_inicio<="' . date("Y-m-d") . '" AND fecha_termino>="' . date("Y-m-d") . '"', 'limit' => 1));
        if ($ciclo) {
            $diaSemana = diaSemanaCiclo::obtenDiaSemanaCiclo($ciclo->fecha_inicio);
            if ($usuario->id_tipo_usuario == 2) {
                $limite = 13;
            } elseif ($usuario->id_tipo_usuario == 3) {
                $limite = 40;
            } else {
                $limite = 0;
            }
            $planTrabajo = new htPlanTrabajo();
            $planTrabajo->semana = $diaSemana['NumSemana'];
            $planTrabajo->id_dia = $diaSemana['NumDia'];
            $planTrabajo->id_usuario = $planTrabajo->id_usuario = $usuario;
            $arrayPlanTrabajo = $this->db()->find($planTrabajo);
            if (sizeof($arrayPlanTrabajo) >= $limite) {
                $result = array('operacion' => 'fallo', 'error' => 'No puede agregar mas visitas.');
                echo json_encode($result);
                return false;
                exit;
            } else {
                $htPlan = new htPlanTrabajo();
                $htPlan->id_usuario = $this->params['usuario'];
                $htPlan->fecha_visita = date("Y-m-d");
                $htPlan->id_ciclo = $ciclo->id_ciclo;
                $htPlan->id_medico = $medicoVisita->id_medico;
                $htPlan->id_sitio = $medicoSitio->id_sitio;
                $htPlan->activo = 0;
                $htPlan->hora_visita = "00:00:00";
                $htPlan->insert();
                $result = array('operacion' => 'exito');
                echo json_encode($result);
                return true;
                exit;
            }
        } else {
            $result = array('operacion' => 'fallo', 'error' => 'Ciclo no encontrado para la fecha actual.');
            echo json_encode($result);
            return false;
            exit;
        }
    }

}

?>
