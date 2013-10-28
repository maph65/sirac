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
            $arrayPlanTrabajo = $this->db()->relateMany($planTrabajo,array('ctMedico','ctSitio','ctCiclo'));//->find($planTrabajo);
            $cantidadVisitar = sizeof($arrayPlanTrabajo);
            if($cantidadVisitar>0){
                $result['numeroVisitas'] = $cantidadVisitar;
                foreach ($arrayPlanTrabajo as $visita){
                    print_r($visita);
                }
            }else{
                //No hay datos en el plan de trabajo para hoy, se trata de obtener los datos del ctPlanTrabajo
                if($this->construirPlanTrabajoDia($usuario)){
                    obtenerPlanTrabajo();
                    exit;
                }else{
                    $result['numeroVisitas'] = 0;
                }
            }
        } else {
            $result = array('acceso' => 'denegado');
        }
        //Imprimimos la respuesta como objeto json
        echo json_encode($result);
    }
    
    private function construirPlanTrabajoDia($usuario){
        Doo::loadModel('htPlanTrabajo');
        Doo::loadModel('ctPlanTrabajo');
        Doo::loadModel('ctCiclo');
        Doo::loadClass('diaSemanaCiclo');
        //$ciclo = new ctCiclo();
        $ciclo = $this->db()->find(new ctCiclo(),array('where'=>'fecha_inicio<="'.date("Y-m-d").'" AND fecha_termino>="'.date("Y-m-d").'"', 'limit'=>1));
        if($ciclo){
            $diaSemana = diaSemanaCiclo::obtenDiaSemanaCiclo($ciclo->fecha_inicio);
            $planTrabajo = new ctPlanTrabajo();
            //Hay que descomentar esto, pues se esta fijando a un día específico
            $planTrabajo->semana = 3; //$diaSemana['NumSemana'];
            $planTrabajo->id_dia = 1; //$diaSemana['NumDia'];
            $planTrabajo->id_usuario = $usuario;
            $arrayPlanTrabajo = $this->db()->find($planTrabajo);
            if(!empty($arrayPlanTrabajo)){
                foreach ($arrayPlanTrabajo as $medicoVisita){
                    $htPlan = new htPlanTrabajo();
                    $htPlan->id_usuario = $usuario;
                    $htPlan->fecha_visita = date("Y-m-d");
                    $htPlan->id_ciclo = $ciclo->id_ciclo;
                    $htPlan->id_medico = $medicoVisita->id_medico;
                    $htPlan->id_sitio = $medicoVisita->id_sitio;
                    $htPlan->activo = 0; //No esta activo el plan del día, debe ser activado
                    $htPlan->hora_visita = "00:00:00"; //No se define la hora de visita, debe definirla el usuario
                    //Procedemos a almancenar en la tabla de htPlanTrabajo
                    $htPlan->insert();
                }
                //Se ha actualizado exitosamente, podemos volver al flujo inicial
                return true;
                exit;
            }else{
                //No ha registros que insertar, no insertamos nada
                return false;
            }
        }else{
            $result = array('acceso' => 'correcto','error'=>'Ciclo no encontrado para la fecha actual.');
            echo json_encode($result);
            return false;
            exit;
        }
        return false;
    }

}

?>
