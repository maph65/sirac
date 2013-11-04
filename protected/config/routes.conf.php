<?php

/**
 * Define your URI routes here.
 *
 * $route[Request Method][Uri] = array( Controller class, action method, other options, etc. )
 *
 * RESTful api support, *=any request method, GET PUT POST DELETE
 * POST 	Create
 * GET      Read
 * PUT      Update, Create
 * DELETE 	Delete
 *
 * Use lowercase for Request Method
 *
 */
$route['*']['/'] = array('MainController', 'index');
$route['*']['/error'] = array('ErrorController', 'index');

//Sesiones
$route['post']['/API/login'] = array('loginController', 'login');

//Plan de trabajo 
$route['*']['/API/representante/getPlanTrabajo/:usuario/:token'] = array('planTrabajoController', 'obtenerPlanTrabajo');
$route['*']['/API/representante/planActivo/:usuario/:token'] = array('planTrabajoController', 'planTrabajoActivo');
$route['*']['/API/representante/ActivaPlan/:usuario/:token'] = array('planTrabajoController', 'activaPlanTrabajo');
$route['*']['/API/representante/detallesMedicoSitio/:usuario/:token/:medico/:sitio/:idHtPlanTrabajo'] = array('planTrabajoController', 'getDetallesMedicoSitio');
$route['*']['/API/representante/fijarHoraVisita/:usuario/:token/:idHtPlanTrabajo/:horas/:minutos'] = array('planTrabajoController', 'setHoraMinutosPlanTrabajo');
$route['*']['/API/representante/quitarMedico/:usuario/:idPlan/:token'] = array('planTrabajoController', 'quitarMedico');
$route['*']['/API/gerente/verPlanTrabajo/:gerente/:token/:representante'] = array('planTrabajoController', 'verPlanTrabajo');

//medicamentos
$route['*']['/API/medicina/listarMedicamentos/:usuario/:token'] = array('medicamentosController', 'listarMedicamentos');
$route['*']['/API/medicina/listarPresentaciones/:idMedicamento/:usuario/:token'] = array('medicamentosController', 'listarPresentaciones');

//Reportes
$route['*']['/API/representante/getDoctoresReporte/:usuario/:token'] = array('reportesController', 'getDoctoresReporte');
$route['*']['/API/representante/registrarReporte/:usuario/:token/:idhtreporte'] = array('reportesController', 'guardarReporte');

//medicos
$route['*']['/API/medicos/verMedicos/:usuario/:token'] = array('medicosController', 'consultarMedicos');
$route['*']['/API/medicos/verInformacionMedico/:idMedico/:usuario/:token'] = array('medicosController', 'verInformacionMedico');

//Gerente
$route['*']['/API/gerente/getRepresentantes/:usuario/:token'] = array('gerenteController', 'getRepresentantesGerente');
$route['*']['/API/gerente/getPlanTrabajo/:usuario/:token/:representante'] = array('gerenteController', 'getPlanTrabajoActivo');
$route['*']['/API/gerente/verInformacionRepresentante/:usuario/:token/:representante'] = array('gerenteController', 'verInformacionRepresentante');

//Chat
$route['*']['/API/chat/getNumeroMensajesNuevos/:usuario/:token'] = array('chatController', 'getNumeroMensajesNuevos');
$route['*']['/API/chat/getListaUsuarios/:usuario/:token'] = array('chatController', 'getListaUsuarios');
$route['*']['/API/chat/getConversacion/:usuario/:token/:segundoUsuario'] = array('chatController', 'getConversacion');
?>