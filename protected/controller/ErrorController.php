<?php

class ErrorController extends DooController{

    public function index(){
        header("HTTP/1.0 404 Not Found");
        echo '<h1>ERROR 404 Not Found</h1>';
    }
	

}
?>