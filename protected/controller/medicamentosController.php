<?php

/**
 * Description of medicamentosController
 *
 * @author Miguel Pérez
 */
class medicamentosController extends DooController {

    function listarMedicamentos() {
        Doo::loadModel('ctMedicina');
        Doo::loadClass('validaLogin');
        $token = $this->params['token'];
        $usuario = $this->params['usuario'];
        if (validaLogin::validaToken($token, $usuario)) {
            $medicamentos = $this->db()->find(new ctMedicina());
            $result = array();
            $result['numeroMedicamentos'] = sizeof($medicamentos);
            if (sizeof($medicamentos) > 0) {
                $m = array();
                foreach ($medicamentos as $medicina) {
                    $temp = array(
                        'id' => $medicina->id_medicina,
                        'nombre' => utf8_encode($medicina->nombre),
                        'descripcion' => utf8_encode($medicina->descripcion)
                    );
                    array_push($m, $temp);
                }
                $result['medicamentos'] = $m;
            }
            echo json_encode($result);
        }
    }

    function listarPresentaciones() {
        Doo::loadModel('ctPresentacion');
        Doo::loadClass('validaLogin');
        $token = $this->params['token'];
        $usuario = $this->params['usuario'];
        if (validaLogin::validaToken($token, $usuario)) {
            $medicamento = $this->params['idMedicamento'];
            $presentacion = new ctPresentacion();
            $presentacion->id_medicina = $medicamento;
            $presentaciones = $this->db()->find($presentacion);
            $result = array();
            $result['numeroPresentaciones'] = sizeof($presentaciones);
            if (sizeof($presentaciones) > 0) {
                $m = array();
                foreach ($presentaciones as $presentacion) {
                    $temp = array(
                        'id' => $presentacion->id_presentacion,
                        'descripcion' => utf8_encode($presentacion->tipo_presentacion . ' ' . $presentacion->dosis)
                    );
                    array_push($m, $temp);
                }
                $result['presentaciones'] = $m;
            }
            echo json_encode($result);
        }
    }

}

?>
