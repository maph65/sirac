<?php

class MainController extends DooController{

    public function index(){
		header('location:'.Doo::conf()->APP_URL.'mobile/');
    }
}
?>