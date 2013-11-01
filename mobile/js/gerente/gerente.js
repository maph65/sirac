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
                    text += '<li><a href="#" onclick="verDetallesMedico(' + medico.idMedico + ')">' + medico.NombreMedico + '</a></li>';
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
                        $.get(
                                servidor + "sirac/API/gerente/verPlanTrabajo/" + getUsuario() + "/" + getToken() + "/" + idRepresentante,
                                {},
                                function(data) {
                                    $("#listaDoctoresPlanTrabajo").html("");
                                    result2 = jQuery.parseJSON(data);
                                    if (result2.acceso === "correcto") {
                                        if (result2.visitas.length > 0) {
                                            for (var i = 0; i < result2.visitas.length; i++) {
                                                var medico = result2.visitas[i];
                                                //alert(medico.idMedico);
                                                var text;
                                                if (medico.reportado === "Reportado") {
                                                    text = '<li><a href="#" data-transition="slide">' + medico.nombreMedico + ' <p class="ui-li-aside">' + medico.reportado + '</p></a></li>';
                                                } else {
                                                    text = '<li><a href="#" onclick="alert(\'Este reporte médico aún no esta disponible.\')" data-transition="slide">' + medico.nombreMedico + ' <p class="ui-li-aside">' + medico.reportado + '</p></a></li>';
                                                }

                                                $("#listaDoctoresPlanTrabajo").append(text).listview('refresh');//trigger('create');
                                            }
                                        } else {
                                            //No hay medico que visitar el día de hoy
                                            var text = '<li>No hay plan de trabajo para el día de hoy</li>';
                                            $("#listaDoctoresPlanTrabajo").append(text).listview('refresh');//trigger('create');
                                        }
                                    }
                                }
                        );
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


function verDetallesMedico(idMedico) {
    $.mobile.loading('show', {
        text: 'Cargando información...',
        textVisible: true,
        theme: 'a',
        html: ""
    });
    $.get(
            servidor + "sirac/API/medicos/verInformacionMedico/" + idMedico,
            {},
            function(data) {
                result = jQuery.parseJSON(data);
                var text = "";
                if (result.encontrado) {
                    $("#datosMedicoNombre").html(result.datosMedico.nombre + "&nbsp;");
                    $("#datosMedicoFechaNac").html(result.datosMedico.fechaNac + "&nbsp;");
                    $("#datosMedicoCedula").html(result.datosMedico.cedula + "&nbsp;");
                    $("#datosMedicoUniversidad").html(result.datosMedico.universidad + "&nbsp;");
                    $("#datosMedicoCelular").html(result.datosMedico.celular + "&nbsp;");
                    $.mobile.changePage('#detallesMedico', {
                        transition: 'slide'
                    });
                }
                $.mobile.loading('hide');
            });
}