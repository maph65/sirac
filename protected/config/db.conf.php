<?php
//Mapeo de la base de datos al modelo ORM
//$dbmap[][][] = array('foreign_key'=>'','through'=>'');

//Tabla ctCiclo
$dbmap['ctCiclo']['has_many']['htPlanTrabajo'] = array('foreign_key'=>'id_ciclo');

//Tabla ctCorreoUsuario
$dbmap['ctCorreoUsuario']['belongs_to']['ctUsuario'] = array('foreign_key'=>'usuario');

//Tabla ctDiaSemana
$dbmap['ctDiaSemana']['has_many']['ctPlanTrabajo'] = array('foreign_key'=>'id_dia');

//Tabla ctEspecialidad
$dbmap['ctEspecialidad']['has_many']['rlMedicoEspecialidad'] = array('foreign_key'=>'id_especialidad');

//Tabla ctMedico
$dbmap['ctMedico']['has_many']['ctPlanTrabajo'] = array('foreign_key'=>'id_medico');
$dbmap['ctMedico']['has_many']['htPlanTrabajo'] = array('foreign_key'=>'id_medico');
$dbmap['ctMedico']['has_many']['rlMedicoEspecialidad'] = array('foreign_key'=>'id_medico');
$dbmap['ctMedico']['has_many']['rlMedicoSitio'] = array('foreign_key'=>'id_medico');

//Tabla ctPlanTrabajo
$dbmap['ctPlanTrabajo']['belongs_to']['ctUsuario'] = array('foreign_key'=>'usuario');
$dbmap['ctPlanTrabajo']['belongs_to']['ctMedico'] = array('foreign_key'=>'id_medico');
$dbmap['ctPlanTrabajo']['belongs_to']['ctSitio'] = array('foreign_key'=>'id_sitio');
$dbmap['ctPlanTrabajo']['belongs_to']['ctDia'] = array('foreign_key'=>'id_dia');

//Tabla ctSitio
$dbmap['ctSitio']['has_many']['ctPlanTrabajo'] = array('foreign_key'=>'id_sitio');
$dbmap['ctSitio']['has_many']['htPlanTrabajo'] = array('foreign_key'=>'id_sitio');
$dbmap['ctSitio']['has_many']['rlMedicoSitio'] = array('foreign_key'=>'id_sitio');

//Tabla ctPotencial
$dbmap['ctPotencial']['has_many']['htReportePlanTrabajo'] = array('foreign_key'=>'id_potencial');

//Tabla ctPrescriptor
$dbmap['ctPrescriptor']['has_many']['htReportePlanTrabajo'] = array('foreign_key'=>'prescriptor');

//Tabla ctTipoUsuario
$dbmap['ctTipoUsuario']['has_many']['ctUsuario'] = array('foreign_key'=>'id_tipo_usuario');

//Tabla ctUsuario
$dbmap['ctUsuario']['has_many']['ctCorreoUsuario'] = array('foreign_key'=>'usuario');
$dbmap['ctUsuario']['has_many']['ctPlanTrabajo'] = array('foreign_key'=>'usuario');
$dbmap['ctUsuario']['belongs_to']['ctTipoUsuario'] = array('foreign_key'=>'id_tipo_usuario');
$dbmap['ctUsuario']['belongs_to']['ctUsuario'] = array('foreign_key'=>'id_gerente');
$dbmap['ctUsuario']['has_many']['ctUsuario'] = array('foreign_key'=>'id_gerente');
$dbmap['ctUsuario']['has_many']['htPlanTrabajo'] = array('foreign_key'=>'usuario');
$dbmap['ctUsuario']['has_many']['presentacionHasUsuario'] = array('foreign_key'=>'representante');
$dbmap['ctUsuario']['has_many']['htMensajesUsuario'] = array('foreign_key'=>'emisor');
$dbmap['ctUsuario']['has_many']['htMensajesUsuario'] = array('foreign_key'=>'receptor');

//Tabla htPlanTrabajo
$dbmap['htPlanTrabajo']['belongs_to']['ctUsuario'] = array('foreign_key'=>'usuario');
$dbmap['htPlanTrabajo']['belongs_to']['ctMedico'] = array('foreign_key'=>'id_medico');
$dbmap['htPlanTrabajo']['belongs_to']['ctSitio'] = array('foreign_key'=>'id_sitio');
$dbmap['htPlanTrabajo']['belongs_to']['ctCiclo'] = array('foreign_key'=>'id_ciclo');
$dbmap['htPlanTrabajo']['has_one']['htReportePlanTrabajo'] = array('foreign_key'=>'id_ht_plan_trabajo');

//Tabla htReportePlanTrabajo
$dbmap['htReportePlanTrabajo']['belongs_to']['htPlanTrabajo'] = array('foreign_key'=>'id_ht_plan_trabajo');
$dbmap['htReportePlanTrabajo']['belongs_to']['ctPotencial'] = array('foreign_key'=>'id_potencial');
$dbmap['htReportePlanTrabajo']['belongs_to']['ctPrescriptor'] = array('foreign_key'=>'prescriptor');
$dbmap['htReportePlanTrabajo']['has_many']['rlReporteMedicamento'] = array('foreign_key'=>'id_ht_plan_trabajo');

//Tabla rlMedicoEspecialidad
$dbmap['rlMedicoEspecialidad']['belongs_to']['ctMedico'] = array('foreign_key'=>'id_medico');
$dbmap['rlMedicoEspecialidad']['belongs_to']['ctEspecialidad'] = array('foreign_key'=>'id_especialidad');

//Tabla rlMedicoSitio
$dbmap['rlMedicoSitio']['belongs_to']['ctMedico'] = array('foreign_key'=>'id_medico');
$dbmap['rlMedicoSitio']['belongs_to']['ctSitio'] = array('foreign_key'=>'id_sitio');

//Tabla ctMedicina
$dbmap['ctMedicina']['has_many']['ctPresentacion'] = array('foreign_key'=>'id_medicina');

//Tabla ctPresentacion
$dbmap['ctPresentacion']['belongs_to']['ctMedicina'] = array('foreign_key'=>'id_medicina');
$dbmap['ctPresentacion']['has_many']['presentacionHasUsuario'] = array('foreign_key'=>'id_presentacion');
$dbmap['ctPresentacion']['has_many']['rlReporteMedicamento'] = array('foreign_key'=>'id_presentacion');

//Tabla ct_presentacion_has_ct_usuario
$dbmap['presentacionHasUsuario']['belongs_to']['ctUsuario'] = array('foreign_key'=>'representante');
$dbmap['presentacionHasUsuario']['belongs_to']['ctPresentacion'] = array('foreign_key'=>'id_presentacion');

//Tabla htMensajesUsuario
$dbmap['htMensajesUsuario']['belongs_to']['ctUsuario'] = array('foreign_key'=>'usuario');
$dbmap['htMensajesUsuario']['belongs_to']['ctUsuario'] = array('foreign_key'=>'usuario');

//Tabla rlReporteMedicamento
$dbmap['rlReporteMedicamento']['belongs_to']['ctPresentacion'] = array('foreign_key'=>'id_presentacion');
$dbmap['rlReporteMedicamento']['belongs_to']['htReportePlanTrabajo'] = array('foreign_key'=>'id_ht_plan_trabajo');



//$dbconfig[ Environment or connection name] = array(Host, Database, User, Password, DB Driver, Make Persistent Connection?);
/**
 * Database settings are case sensitive.
 * To set collation and charset of the db connection, use the key 'collate' and 'charset'
 * array('localhost', 'database', 'root', '1234', 'mysql', true, 'collate'=>'utf8_unicode_ci', 'charset'=>'utf8'); 
 */

 $dbconfig['dev'] = array('localhost', 'sirac', 'root', 'cete8653', 'mysql', true);
 $dbconfig['prod'] = array('localhost', 'sirac', 'root', 'cete8653', 'mysql', true);

//$dbconfig['dev'] = array('localhost', 'enginetec_com_mx_sirac', 'engin_sirac', 'cete8653', 'mysql', true);
//$dbconfig['prod'] = array('localhost', 'enginetec_com_mx_sirac', 'engin_sirac', 'cete8653', 'mysql', true);
 
 

?>