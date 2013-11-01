<?php

class medicosController extends DooController {

    public function consultarMedicos() {
        Doo::loadModel('ctMedico');
        $arrayMedicos = $this->db()->find(new ctMedico());
        $arrayDespliegue = array();
        foreach ($arrayMedicos as $medico) {
            $v = array(
                'idMedico' => $medico->id_medico,
                'NombreMedico' => utf8_encode($medico->nombre . ' ' . $medico->apaterno . ' ' . $medico->amaterno)
            );
            array_push($arrayDespliegue, $v);
        }
        $result['medicos'] = $arrayDespliegue;
        echo json_encode($result);
        return true;
    }

    public function verInformacionMedico() {
        Doo::loadModel('ctMedico');
        $idMedico = $this->params['idMedico'];
        $medico = new ctMedico();
        $medico->id_medico = $idMedico;
        $medico = $this->db()->find($medico, array('limit' => 1));
        $result = array();
        if ($medico) {
            $result['encontrado'] = TRUE;
            $result['datosMedico'] = array(
                'idMedico' => $medico->id_medico,
                'nombre' => $medico->nombre . ' ' . $medico->apaterno . ' ' . $medico->amaterno,
                'cedula' => $medico->cedula,
                'celular' => $medico->celular,
                'fechaNac' => $medico->fecha_nac,
                'universidad' => $medico->universidad
            );
        } else {
            $result['encontrado'] = FALSE;
        }
        echo json_encode($result);
    }

}

?>
