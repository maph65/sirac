function inciarSesion() {
    var result;
    $.mobile.loading('show', {
        text: 'Iniciando sesión...',
        textVisible: true,
        theme: 'a',
        html: ""
    });
    $.post(
            servidor + "sirac/API/login",
            {'email': $("#usuario").val(), 'passwd': $("#passwd").val()},
    function(data) {
        window.localStorage.clear();
        result = jQuery.parseJSON(data);
        $.mobile.loading('hide');
        if (result.error === "incorrecto") {
            alert('Nombre de usuario o contraseña incorrecto.');
        } else if (result.error === "incompleto") {
            alert('Proporcione su nombre de usuario y contraseña.');
        } else {
            if (result.usuario !== null && result.tipoUsuario !== null && result.token !== null) {
                //alert(data);
                setUsuario(result.usuario);
                setTipoUsuario(result.tipoUsuario);
                if (getTipoUsuario === 1) {
                    $.mobile.changePage('representante.html', {
                        transition: 'slide'
                    });
                } else {
                    $.mobile.changePage('gerente.html', {
                        transition: 'slide'
                    });
                }
                setToken(result.token);
            } else {
                alert('Error de conexión.');
            }
        }
    })
            .fail(function() {
        alert("No hay conexión a Internet. Verifique la conexión de su dispositivo");
        $.mobile.loading('hide');
        /*navigator.notification.alert(
         'No se puede establecer la conexión con el servidor.', // mensaje (message)
         function() {
         }, // función 'callback' (alertCallback)
         'Inicio de sesión', // titulo (title)
         'Cerrar'                // nombre del botón (buttonName)
         );*/
    });
}

function clearField(object) {
    object.value = "@cellpharma.com";
    object.setSelectionRange(0, 0);
}
