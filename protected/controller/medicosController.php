<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class medicosController extends DooController {

    public function consultarMedicos() {
        Doo::loadModel('ctMedico');
        $arrayMedicos = $this->db()->find(new ctMedico());
        $arrayDespliegue = array();
        foreach ($arrayMedicos as $medico) {
            $v = array(
                'idMedico' => $medico->id_medico,
                'NombreMedico' => $medico->nombre . ' ' . $medico->apaterno . ' ' . $medico->amaterno
            );
            array_push($arrayDespliegue, $v);
        }
        $result['medicos'] = $arrayDespliegue;
        echo json_encode($result);
        return true;
    }

}

?>
