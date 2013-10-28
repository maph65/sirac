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

//Representante
$route['*']['/API/representante/getPlanTrabajo/:usuario/:token'] = array('planTrabajoController', 'obtenerPlanTrabajo');
$route['*']['/API/representante/planActivo/:usuario/:token'] = array('planTrabajoController', 'planTrabajoActivo');
$route['*']['/API/representante/ActivaPlan/:usuario/:token'] = array('planTrabajoController', 'activaPlanTrabajo');
$route['*']['/API/representante/detallesMedicoSitio/:usuario/:token/:medico/:sitio/:idHtPlanTrabajo'] = array('planTrabajoController', 'getDetallesMedicoSitio');
$route['*']['/API/representante/fijarHoraVisita/:usuario/:token/:idHtPlanTrabajo/:horas/:minutos'] = array('planTrabajoController', 'setHoraMinutosPlanTrabajo');
$route['*']['/API/representante/getDoctoresReporte/:usuario/:token'] = array('reportesController', 'getDoctoresReporte');
?>