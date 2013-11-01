$(document).on('pageshow', '#planes', function() {
    $.mobile.loading('show', {
        text: 'Actualizando información...',
        textVisible: true,
        theme: 'a',
        html: ""
    });
    $.get(
            servidor + "sirac/API/gerente/getRepresentantes/" + getUsuario() + "/" + getToken(),
            {},
            function(data) {
                //alert(data);
                $("#listaRepresentantesGerente").html("");
                result = jQuery.parseJSON(data);
                if (result.acceso === "correcto") {
                    if (result.numRepresentantes > 0) {
                        var text = "";
                        for (var i = 0; i < result.representantes.length; i++) {
                            var representante = result.representantes[i];
                            text = text + '<li><a href="#" onclick="verPlanRepresentante(\'' + representante.idRepresentante + '\')" data-transition="slide">' + representante.nombreRepresentante + '</a></li>';
                        }
                        $("#listaRepresentantesGerente").append(text).listview('refresh');
                    }
                } else {
                    window.location = "index.html";
                }
            });
    $.mobile.loading('hide');
});

$(document).on('pageshow', '#agendaRep', function() {
    $.mobile.loading('show', {
        text: 'Actualizando información...',
        textVisible: true,
        theme: 'a',
        html: ""
    });
    $.get(
            servidor + "sirac/API/gerente/getRepresentantes/" + getUsuario() + "/" + getToken(),
            {},
            function(data) {
                $("#listaAgendaRepresentantes").html("");
                //alert(data);
                result = jQuery.parseJSON(data);
                if (result.acceso === "correcto") {
                    if (result.numRepresentantes > 0) {
                        var text = "";
                        for (var i = 0; i < result.representantes.length; i++) {
                            var representante = result.representantes[i];
                            text = text + '<li><a href="#" onclick="verInfoRep(\'' + representante.idRepresentante + '\')" data-transition="slide">' + representante.nombreRepresentante + '</a></li>';
                        }
                        $("#listaAgendaRepresentantes").append(text).listview('refresh');
                    }
                } else {
                    window.location = "index.html";
                }
            });
    $.mobile.loading('hide');
});

$(document).on('pageshow', '#agendaDoctores', function() {
    $.mobile.loading('show', {
        text: 'Actualizando información...',
        textVisible: true,
        theme: 'a',
        html: ""
    });
    $.get(
            servidor + "sirac/API/medicos/verMedicos",
            {},
            function(data) {
                result = jQuery.parseJSON(data);
                var text = "";
                for (var i = 0; i < result.medicos.length; i++) {
                    var medico = result.medicos[i];
                    text += '<li><a href="#" data-transition="slide">' + medico.NombreMedico + '</a></li>';
                }
                $("#listaAgendaDoctores").append(text).listview('refresh');//trigger('create');
                $.mobile.loading('hide');
            });
    $.mobile.loading('hide');

});




function verPlanRepresentante(idRepresentante) {
    $.mobile.loading('show', {
        text: 'Actualizando información...',
        textVisible: true,
        theme: 'a',
        html: ""
    });
    $.get(
            servidor + "sirac/API/gerente/getPlanTrabajo/" + getUsuario() + "/" + getToken() + "/" + idRepresentante,
            {},
            function(data) {
                result = jQuery.parseJSON(data);
                if (result.acceso === "correcto") {
                    if (result.planActivo) {
                        $.mobile.changePage('#detallesPlanTrabajo', {
                            transition: 'slide'
                        });
                    } else {
                        $('#planInactivo').popup();
                        $('#planInactivo').popup('open');
                    }
                } else {
                    window.location = "index.html";
                }

            });
    $.mobile.loading('hide');
}

function verInfoRep(idRepresentante) {
    $.mobile.loading('show', {
        text: 'Actualizando información...',
        textVisible: true,
        theme: 'a',
        html: ""
    });
    $.get(
            servidor + "sirac/API/gerente/verInformacionRepresentante/" + getUsuario() + "/" + getToken() + "/" + idRepresentante,
            {},
            function(data) {
                result = jQuery.parseJSON(data);
                if (result.acceso === "correcto") {
                    if (result.informacion) {
                        $("#repNombre").html(result.informacion.nombre);
                        $("#repClave").html(result.informacion.clave);
                        $("#repEmail").html(result.informacion.email);
                        $("#repUltimoAcceso").html(result.informacion.ultimoAcceso);
                        $.mobile.changePage('#InfoRepresentante', {
                            transition: 'slide'
                        });
                    } else {
                        alert(result.error);
                    }
                } else {
                    window.location = "index.html";
                }

            });
    $.mobile.loading('hide');
}