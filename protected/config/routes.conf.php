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
$route['*']['/login'] = array('loginController', 'login');

?>