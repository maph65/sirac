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
            $planTrabajo->fecha_visita = date("Y-m-d");
            $planTrabajo->id_usuario = $usuario;
            $arrayPlanTrabajo = $this->db()->relate($planTrabajo, 'ctMedico'); //->find($planTrabajo);
            $cantidadVisitar = sizeof($arrayPlanTrabajo);
            if ($cantidadVisitar > 0) {
                $result['numeroVisitas'] = $cantidadVisitar;
                $arrayVisitas = array();
                foreach ($arrayPlanTrabajo as $visita) {
                    $v = array(
                        'idHtPlanTrabajo' => $visita->id_ht_plan_trabajo,
                        'idMedico' => $visita->id_medico,
                        'NombreMedico' => utf8_encode($visita->ctMedico->nombre . ' ' . $visita->ctMedico->apaterno . ' ' . $visita->ctMedico->amaterno),
                        'idSitio' => $visita->id_sitio,
                        'fechaVisita' => $visita->fecha_visita,
                        'horaVisita' => $visita->hora_visita,
                        'activo' => $visita->activo
                    );
                    array_push($arrayVisitas, $v);
                    /* echo '<pre>';
                      print_r($v);
                      echo '</pre>'; */
                }
                $result['visitas'] = $arrayVisitas;
            } else {
                //No hay datos en el plan de trabajo para hoy, se trata de obtener los datos del ctPlanTrabajo
                if ($this->construirPlanTrabajoDia($usuario)) {
                    $this->obtenerPlanTrabajo();
                    exit;
                } else {
                    $result['numeroVisitas'] = 0;
                }
            }
        } else {
            $result = array('acceso' => 'denegado');
        }
        //Imprimimos la respuesta como objeto json
        echo json_encode($result);
    }

    private function construirPlanTrabajoDia($usuario) {
        Doo::loadModel('htPlanTrabajo');
        Doo::loadModel('ctPlanTrabajo');
        Doo::loadModel('ctCiclo');
        Doo::loadClass('diaSemanaCiclo');
        //$ciclo = new ctCiclo();
        $ciclo = $this->db()->find(new ctCiclo(), array('where' => 'fecha_inicio<="' . date("Y-m-d") . '" AND fecha_termino>="' . date("Y-m-d") . '"', 'limit' => 1));
        if ($ciclo) {
            $diaSemana = diaSemanaCiclo::obtenDiaSemanaCiclo($ciclo->fecha_inicio);
            $planTrabajo = new ctPlanTrabajo();
            //Hay que descomentar esto, pues se esta fijando a un día específico
            $planTrabajo->semana = $diaSemana['NumSemana'];
            $planTrabajo->id_dia = $diaSemana['NumDia'];
            $planTrabajo->id_usuario = $usuario;
            $arrayPlanTrabajo = $this->db()->find($planTrabajo);
            if (!empty($arrayPlanTrabajo)) {
                foreach ($arrayPlanTrabajo as $medicoVisita) {
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
            } else {
                //No ha registros que insertar, no insertamos nada
                return false;
            }
        } else {
            $result = array('acceso' => 'correcto', 'error' => 'Ciclo no encontrado para la fecha actual.');
            echo json_encode($result);
            return false;
            exit;
        }
        return false;
    }

    public function planTrabajoActivo() {
        Doo::loadModel('htPlanTrabajo');
        Doo::loadClass('validaLogin');
        $token = $this->params['token'];
        $usuario = $this->params['usuario'];
        $result = array();
        if (validaLogin::validaToken($token, $usuario)) {
            $result = array('acceso' => 'correcto');
            $planTrabajo = new htPlanTrabajo();
            $planTrabajo->id_usuario = $usuario;
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

    public function activaPlanTrabajo() {
        Doo::loadModel('htPlanTrabajo');
        Doo::loadClass('validaLogin');
        $token = $this->params['token'];
        $usuario = $this->params['usuario'];
        $result = array();
        if (validaLogin::validaToken($token, $usuario)) {
            $result = array('acceso' => 'correcto');
            $planTrabajo = new htPlanTrabajo();
            $planTrabajo->fecha_visita = date("Y-m-d");
            //Verificamos si hay horas sin asignar
            $planTrabajo->hora_visita = "00:00:00";
            $planTrabajo->id_usuario = $usuario;
            $arrayPlanTrabajo = $this->db()->find($planTrabajo);
            if (!empty($arrayPlanTrabajo)) {
                //Hay horas sin asignar
                $result['activado'] = FALSE;
            } else {
                //No hay horas sin asignar, volvemos a consultar que si haya elementos
                $planTrabajo = new htPlanTrabajo();
                $planTrabajo->fecha_visita = date("Y-m-d");
                $planTrabajo->id_usuario = $usuario;
                $arrayPlanTrabajo = $this->db()->find($planTrabajo);
                if ($arrayPlanTrabajo) {
                    foreach ($arrayPlanTrabajo as $pTrabajo) {
                        $pTrabajo->activo = 1;
                        $pTrabajo->update();
                    }
                    $result['activado'] = TRUE;
                } else {
                    $result['activado'] = FALSE;
                }
            }
        } else {
            $result = array('acceso' => 'denegado');
        }
        echo json_encode($result);
    }

    public function getDetallesMedicoSitio() {
        Doo::loadModel('ctMedico');
        Doo::loadModel('ctSitio');
        Doo::loadModel('htPlanTrabajo');
        Doo::loadClass('validaLogin');
        $token = $this->params['token'];
        $usuario = $this->params['usuario'];
        $idMedico = $this->params['medico'];
        $idSitio = $this->params['sitio'];
        $idHtPlanTrabajo = $this->params['idHtPlanTrabajo'];
        $result = array();
        if (validaLogin::validaToken($token, $usuario)) {
            $result = array('acceso' => 'correcto');
            $medico = new ctMedico();
            $medico->id_medico = $idMedico;
            $medico = $this->db()->find($medico, array('limit' => 1));
            if ($medico) {
                $datosMedico = array(
                    'idMedico' => $medico->id_medico,
                    'nombre' => utf8_encode($medico->nombre . ' ' . $medico->apaterno . ' ' . $medico->amaterno),
                    'cedula' => $medico->cedula,
                    'celular' => $medico->celular,
                    'fechaNac' => $medico->fecha_nac,
                    'universidad' => $medico->universidad
                );
                $result['medico'] = $datosMedico;
            } else {
                $result['error'] = "Medico no encontrado.";
            }

            $sitio = new ctSitio();
            $sitio->id_sitio = $idSitio;
            $sitio = $this->db()->find($sitio, array('limit' => 1));
            if ($sitio) {
                $datosSitio = array(
                    'idSitio' => $sitio->id_sitio,
                    'nombre' => $sitio->nombre,
                    'calle' => $sitio->calle,
                    'numExt' => $sitio->num_exterior,
                    'numInt' => $sitio->num_interior,
                    'colonia' => $sitio->colonia,
                    'delegacion' => $sitio->delegacion,
                    'cp' => $sitio->cp,
                    'telefono' => $sitio->telefono
                );
                $result['sitio'] = $datosSitio;
            } else {
                $result['error'] = "Sitio no encontrado.";
            }
            $htPlan = new htPlanTrabajo();
            $htPlan->id_ht_plan_trabajo = $idHtPlanTrabajo;
            $htPlan = $this->db()->find($htPlan, array('limit' => 1));
            if ($htPlan) {
                //echo $htPlan->hora_visita;
                $horas = preg_split('/:/', $htPlan->hora_visita);
                $datosHtPlan = array(
                    'hora' => $horas[0],
                    'minutos' => $horas[1]
                );
                $result['horaVisita'] = $datosHtPlan;
            }
        } else {
            $result = array('acceso' => 'denegado');
        }
        echo json_encode($result);
    }

    public function setHoraMinutosPlanTrabajo() {
        Doo::loadModel('htPlanTrabajo');
        Doo::loadClass('validaLogin');
        $token = $this->params['token'];
        $usuario = $this->params['usuario'];
        $idPlanTrabajo = $this->params['idHtPlanTrabajo'];
        $horas = $this->params['horas'];
        $minutos = $this->params['minutos'];
        $result = array();
        if (validaLogin::validaToken($token, $usuario)) {
            $result = array('acceso' => 'correcto');
            $htPlanTrabajo = new htPlanTrabajo();
            $htPlanTrabajo->id_ht_plan_trabajo = $idPlanTrabajo;
            $htPlanTrabajo->activo = 0;
            $htPlanTrabajo = $this->db()->find($htPlanTrabajo,array('limit'=>1));
            if($htPlanTrabajo){
                $htPlanTrabajo->hora_visita = $horas.':'.$minutos.':00';
                $htPlanTrabajo->update();
                $result['actualizado'] = 'ok';
            }else{
                $result['actualizado'] = 'No se puede actualizar la hora. Este plan de trabajo ya esta activo.';
            }
        }else{
            $result = array('acceso' => 'denegado');
        }
        echo json_encode($result);
    }
    
    public function quitarMedico() {
        Doo::loadModel('htPlanTrabajo');
        Doo::loadModel('ctUsuario');
        Doo::loadModel('ctCiclo');
        Doo::loadClass('diaSemanaCiclo');
        $idUsuario = $this->params['usuario'];
        $idPlan = $this->params['idPlan'];
        $usuario = $this->db()->find(new ctUsuario(), array('where' => 'usuario = \'' . $idUsuario.'\'', 'limit' => 1));
        $htPlan = $this->db()->find(new htPlanTrabajo(), array('where' => 'id_ht_plan_trabajo = ' . $idPlan, 'limit' => 1));
        $planTrabajo = new htPlanTrabajo();
        $ciclo = $this->db()->find(new ctCiclo(), array('where' => 'fecha_inicio<="' . date("Y-m-d") . '" AND fecha_termino>="' . date("Y-m-d") . '"', 'limit' => 1));
        if ($ciclo) {
            $diaSemana = diaSemanaCiclo::obtenDiaSemanaCiclo($ciclo->fecha_inicio);
            $planTrabajo = new htPlanTrabajo();
            $planTrabajo->semana = $diaSemana['NumSemana'];
            $planTrabajo->id_dia = $diaSemana['NumDia'];
            $planTrabajo->id_usuario = $usuario->usuario;
            $planTrabajo->activo = 0;
            $arrayPlanTrabajo = $this->db()->find($planTrabajo);
            $limite = 3;
            if (sizeof($arrayPlanTrabajo) <= $limite) {
                $result = array('operacion' => 'fallo', 'error' => 'No puede quitar mas visitas.');
                echo json_encode($result);
                //return false;
                exit;
            } else {
                $htPlan->delete();
                $result = array('operacion' => 'exito');
                echo json_encode($result);
                //return true;
                exit;
            }
        } else {
            $result = array('operacion' => 'fallo', 'error' => 'Ciclo no encontrado para la fecha actual.');
            echo json_encode($result);
            //return false;
            exit;
        }
    }
    
    
    
    public function verPlanTrabajo() {
        Doo::loadClass('validaLogin');
        Doo::loadModel('htPlanTrabajo');
        $token = $this->params['token'];
        $usuario = $this->params['representante'];
        $gerente = $this->params['gerente'];
        $result = array();
        if (validaLogin::validaToken($token, $gerente)) {
            $result = array('acceso' => 'correcto');
            $planTrabajo = new htPlanTrabajo();
            $planTrabajo->fecha_visita = date("Y-m-d");
            $planTrabajo->id_usuario = $usuario;
            //$arrayPlanTrabajo = $this->db()->relate($planTrabajo, 'ctMedico'); //->find($planTrabajo);
            $arrayPlanTrabajo = $this->db()->relateMany($planTrabajo, array('ctMedico', 'htReportePlanTrabajo'));
            $cantidadVisitar = sizeof($arrayPlanTrabajo);
            if ($cantidadVisitar > 0) {
                $result['numeroVisitas'] = $cantidadVisitar;
                $arrayVisitas = array();
                foreach ($arrayPlanTrabajo as $visita) {
                    $arrayReporteMedico = array(
                        'htPlanTrabajo' => $visita->id_ht_plan_trabajo,
                        'idSitio' => $visita->id_sitio,
                        'idMedico' => $visita->ctMedico->id_medico,
                        'nombreMedico' => utf8_encode($visita->ctMedico->nombre . ' ' . $visita->ctMedico->apaterno . ' ' . $visita->ctMedico->amaterno)
                    );
                    if (empty($visita->htReportePlanTrabajo)) {
                        $arrayReporteMedico['reportado'] = "No reportado";
                    } else {
                        $arrayReporteMedico['reportado'] = "Reportado";
                    }
                    array_push($arrayVisitas, $arrayReporteMedico);
                }
                $result['visitas'] = $arrayVisitas;
            }
        } else {
            $result = array('acceso' => 'denegado');
        }
        //Imprimimos la respuesta como objeto json
        echo json_encode($result);
    }
    

}

?>
