var usuarioMensajeChat = "";

function enviarMensaje() {
    $.post(
            servidor + "sirac/API/chat/enviarMensaje/" + getUsuario() + "/" + getToken(),
            {'mensaje': $('#contenidoNuevoMensaje').val(), 'destinatario': usuarioMensajeChat},
    function(data) {
        alert(data);
    });
    $("#contenidoConversacion").append('<li style="text-align:right; background-color:#BBDEFF;">' + $('#contenidoNuevoMensaje').val() + '</li>');
    $('#contenidoNuevoMensaje').val("");
    $("#contenidoConversacion").listview("refresh");
}


//chat

$(document).on("pageinit", "#chat", function() {
    $("#autocompletarUsuarios").on("listviewbeforefilter", function(e, data) {
        var $ul = $(this),
                $input = $(data.input),
                value = $input.val(),
                html = "";
        $ul.html("");
        if (value && value.length > 2) {
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
                    $("#contenidoConversacion").html("<li></li>");
                    $.mobile.changePage('#verConversacion', {
                        transition: 'slide'
                    });
                    $("#contenidoConversacion").listview("refresh");
                }
                $.mobile.loading('hide');
            });
}