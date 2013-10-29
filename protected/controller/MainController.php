<?php
/**
 * MainController
 * Feel free to delete the methods and replace them with your own code.
 *
 * @author maph65
 */
class MainController extends DooController{

    public function index(){
		header('location:'.Doo::conf()->APP_URL.'mobile/');
    }
}
?>