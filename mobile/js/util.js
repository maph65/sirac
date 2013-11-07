var usuarioMensajeChat = "";

function enviarMensaje() {
    $.post(
            servidor + "sirac/API/chat/enviarMensaje/" + getUsuario() + "/" + getToken(),
            {'mensaje': $('#contenidoNuevoMensaje').val(), 'destinatario': usuarioMensajeChat},
    function(data) {
        result = jQuery.parseJSON(data);
        if (result.acceso === "correcto") {
            if (result.registro === "exitoso") {
                $("#contenidoConversacion").append('<li style="text-align:right; background-color:#BBDEFF;">' + $('#contenidoNuevoMensaje').val() + '</li>');
                $('#contenidoNuevoMensaje').val("");
                $("#contenidoConversacion").listview("refresh");
            } else {
                alert('Ocurrio un error al enviar su mensaje. Verifique su conexión a Internet y vuelva a intentarlo.');
            }
        } else {
            window.location = "index.html";
        }
    });

}

$(document).on("pageshow", "#chat", function() {
    $.mobile.loading('show', {
        text: 'Cargando información...',
        textVisible: true,
        theme: 'a',
        html: ""
    });
    $.get(
            servidor + "sirac/API/chat/getUltimasConversaciones/" + getUsuario() + "/" + getToken(),
            {},
            function(data) {
                result = jQuery.parseJSON(data);
                if (result.acceso === "correcto") {
                    if (result.numeroConversaciones > 0) {
                        $('#ultimasConversaciones').html('');
                        for (var i = 0; i < result.usuarios.length; i++) {
                            $('#ultimasConversaciones').append('<li onclick="cargarConversacion(\'' + result.usuarios[i].usuario + '\')"><a href="#">' + result.usuarios[i].nombre + '<a></li>');
                        }
                        $('#ultimasConversaciones').listview("refresh");
                    }
                }
                $.mobile.loading('hide');
            });
    $("#autocompletarUsuarios").on("listviewbeforefilter", function(e, data) {
        var $ul = $(this),
                $input = $(data.input),
                value = $input.val(),
                html = "";
        $ul.html("");
        if (value && value.length > 2) {
            $.mobile.loading('show', {
                text: 'Cargando información...',
                textVisible: true,
                theme: 'a',
                html: ""
            });
            $ul.html("<li><div class='ui-loader'><span class='ui-icon ui-icon-loading'></span></div></li>");
            $ul.listview("refresh");
            $.post(
                    servidor + "sirac/API/chat/getListaUsuarios/" + getUsuario() + "/" + getToken(),
                    {'q': $input.val()},
            function(data) {
                result = jQuery.parseJSON(data);
                if (result.numUsuarios > 0) {
                    for (var i = 0; i < result.numUsuarios; i++) {
                        html += '<li onclick="cargarConversacion(\'' + result.usuarios[i].usuario + '\')"><a href="#">' + result.usuarios[i].nombre + '<a></li>';
                    }
                    $ul.html(html);
                    $ul.listview("refresh");
                    $ul.trigger("updatelayout");
                }
                $.mobile.loading('hide');
            }
            );
        }
    });
});


function cargarConversacion(usuario) {
    usuarioMensajeChat = usuario;
    $.mobile.loading('show', {
        text: 'Cargando información...',
        textVisible: true,
        theme: 'a',
        html: ""
    });
    $.get(
            servidor + "sirac/API/chat/getConversacion/" + getUsuario() + "/" + getToken() + "/" + usuario,
            {},
            function(data) {
                result = jQuery.parseJSON(data);
                var text = "";
                if (result.acceso === "correcto") {
                    //$("#contenidoConversacion").html('<li><p>La persona tal dijo a las 23:34:</p>Contenido del mensaje</li>');
                    $("#contenidoConversacion").html('');
                    if (result.tamanioConversacion > 0) {
                        for (var i = 0; i < result.mensajes.length; i++) {
                            if (result.mensajes[i].recibido) {
                                $("#contenidoConversacion").append('<li><p>' + result.segundoUsuario + ' dijo el ' + result.mensajes[i].fecha + ':</p>' + result.mensajes[i].mensaje + '</li>');
                            } else {
                                $("#contenidoConversacion").append('<li style="text-align:right; background-color:#BBDEFF;"><p>Usted dijo el ' + result.mensajes[i].fecha + ':</p>' + result.mensajes[i].mensaje + '</li>');
                            }
                        }
                    } else {
                        $("#contenidoConversacion").html('<li>No ha iniciado una conversaci&oacute;n con este usuario.</li>');
                    }
                    $.mobile.changePage('#verConversacion', {
                        transition: 'slide'
                    });
                    $("#contenidoConversacion").listview("refresh");
                }
                $.mobile.loading('hide');
            });
}


$(document).on("pageshow", "#verConversacion", function() {
    $.mobile.silentScroll($(window).height() + 400);
});

$(document).on("pageinit", "#verConversacion", function() {
    if (usuarioMensajeChat.length === 0) {
        $.mobile.changePage('#chat', {
            transition: 'slide'
        });
    }
});

function cargarMensajesNuevos(){
    
}