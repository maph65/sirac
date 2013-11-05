<?php
class diaSemanaCiclo{
    /**
     * ObtenDiaSemanaCiclo
     * 
     * Permite obtener el número de día de la semana (1 para lunes, 7 para domingo)
     * y el número de semana a partir de la fecha de inicio del ciclo al día actual
     * 
     * @param String $fechaInicioCiclo String con la fecha de inicio del ciclo con el formato Año-mes-dia [date("Y-m-d")]
     * @param Array $diaSemana Array con los valores NumDia (Número de día) y NumSemana (Número de semana)
     */
    public static function obtenDiaSemanaCiclo($fechaInicioCiclo){
        $hoy = strtotime(date("Y-m-d"));
        $inicioCiclo = strtotime($fechaInicioCiclo);
        $numeroSemana = floor(abs(($hoy-$inicioCiclo)/(60*60*24*7)))+1;
        $numeroDia = date("N");
        $diaSemana = array('NumDia'=>$numeroDia, 'NumSemana'=>$numeroSemana);
        return $diaSemana;
    }
}
?>
