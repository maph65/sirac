var htHoraPlanVisita = 0;

$(document).on('pageshow', '#home', function() {
    //verificamos el estado del plan de trabajo del dia de hoy
    $.get(
            servidor + "sirac/API/representante/planActivo/" + getUsuario() + "/" + getToken(),
            {},
            function(data) {
                //alert(data);
                result = jQuery.parseJSON(data);
                if (result.acceso === "correcto") {
                    if (result.planActivo) {
                        $("#statusPlan").html("Activo");
                    } else {
                        $("#statusPlan").html("Inactivo");
                    }
                } else {
                    window.location = "index.html";
                }
            });
});

$(document).on('pageshow', '#plan', function() {
    //leemos el plan de trabajo del dia de hoy
    $.mobile.loading('show', {
        text: 'Actualizando información...',
        textVisible: true,
        theme: 'a',
        html: ""
    });
    $.get(
            servidor + "sirac/API/representante/getPlanTrabajo/" + getUsuario() + "/" + getToken(),
            {},
            function(data) {
                //limpiamos los tados actuales antes de poner nuevos
                $("#listaDoctoresPlanTrabajo").html("");
                //ponemos nuevos datos
                result = jQuery.parseJSON(data);
                if (result.acceso === "correcto") {
                    if (result.visitas.length > 0) {
                        for (var i = 0; i < result.visitas.length; i++) {
                            var medico = result.visitas[i];
                            //alert(medico.idMedico);
                            var text = '<li><a href="#" onclick="detallesVisita(' + medico.idMedico + ',' + medico.idSitio + ',' + medico.idHtPlanTrabajo + ')" data-transition="slide">' + medico.NombreMedico + '</a></li>';
                            $("#listaDoctoresPlanTrabajo").append(text).listview('refresh');//trigger('create');
                        }
                    } else {
                        //No hay medico que visitar el día de hoy
                        var text = '<li>No hay plan de trabajo para el día de hoy</li>';
                        $("#listaDoctoresPlanTrabajo").append(text).listview('refresh');//trigger('create');
                    }
                } else {
                    window.location = "index.html";
                }
            });
    $.mobile.loading('hide');
});

function detallesVisita(idMedico, idSitio, idHtPlanTrabajo) {
    htHoraPlanVisita = idHtPlanTrabajo;
    $.mobile.loading('show', {
        text: 'Actualizando información...',
        textVisible: true,
        theme: 'a',
        html: ""
    });
    //Cargamos los datos
    $.get(
            servidor + "sirac/API/representante/detallesMedicoSitio/" + getUsuario() + "/" + getToken() + "/" + idMedico + "/" + idSitio + "/" + idHtPlanTrabajo,
            {},
            function(data) {
                //alert(data);
                result = jQuery.parseJSON(data);
                //colocamos datos nuevos
                $("#medicoNombre").html(result.medico.nombre + "&nbsp;");
                $("#medicoFechaNac").html(result.medico.fechaNac + "&nbsp;");
                $("#medicoCedula").html(result.medico.cedula + "&nbsp;");
                $("#medicoUniversidad").html(result.medico.universidad + "&nbsp;");
                $("#medicoCelular").html(result.medico.celular + "&nbsp;");

                $("#sitioNombre").html(result.sitio.nombre + "&nbsp;");
                $("#sitioCalle").html(result.sitio.calle + " " + " No. " + result.sitio.numExt + " " + result.sitio.numInt + "&nbsp;");
                $("#sitioColonia").html(result.sitio.colonia + "&nbsp;");
                $("#sitioCp").html(result.sitio.cp + "&nbsp;");
                $("#sitioDelegacion").html(result.sitio.delegacion + "&nbsp;");
                $("#sitioTelefono").html(result.sitio.telefono + "&nbsp;");
                $("#horaVisita option[value='" + result.horaVisita.hora + "']").attr("selected", "selected")
                $("#horaVisita").selectmenu('refresh', true);
                $("#minutosVisita option[value='" + result.horaVisita.minutos + "']").attr("selected", "selected")
                $("#minutosVisita").selectmenu('refresh', true);
                //terminamos, hora de ir a la siguiente pagina para ver la informacion
            });
    $.mobile.changePage('#detallesPlanTrabajo', {
        transition: 'slide'
    });
    $.mobile.loading('hide');
}

function guardarHoraVisita(idHtPlanTrabajo) {
    var horas = $("#horaVisita").val();
    var minutos = $("#minutosVisita").val();
    $.mobile.loading('show', {
        text: 'Actualizando información...',
        textVisible: true,
        theme: 'a',
        html: ""
    });
    $.get(
            servidor + "sirac/API/representante/fijarHoraVisita/" + getUsuario() + "/" + getToken() + "/" + idHtPlanTrabajo + "/" + horas + "/" + minutos,
            {},
            function(data) {
                result = jQuery.parseJSON(data);
                if (result.actualizado === "ok") {
                    $('#horaGuardadaPopup').popup();
                    $('#horaGuardadaPopup').popup('open');
                } else {
                    alert(result.actualizado);
                }
            });
    $.mobile.loading('hide');

}

function activarPlanTrabajo() {

    $.mobile.loading('show', {
        text: 'Activando plan de trabajo...',
        textVisible: true,
        theme: 'a',
        html: ""
    });
    $.get(
            servidor + "sirac/API/representante/ActivaPlan/" + getUsuario() + "/" + getToken(),
            {},
            function(data) {
                result = jQuery.parseJSON(data);
                if (result.acceso === "correcto") {
                    if (result.activado) {
                        alert('Se ha activado correctamente el plan de trabajo.');
                    } else {
                        alert('No se ha podido activar el plan de trabajo. Asegurese de haber definido una hora para cada visita.');
                    }
                } else {
                    window.location = "index.html";
                }
            });
    $.mobile.loading('hide');
}


$(document).on('pageshow', '#reporte', function() {
    //verificamos el estado del plan de trabajo del dia de hoy
    $.get(
            servidor + "sirac/API/representante/planActivo/" + getUsuario() + "/" + getToken(),
            {},
            function(data) {
                //alert(data);
                result = jQuery.parseJSON(data);
                if (result.acceso === "correcto") {
                    if (result.planActivo) {
                        //El plan esta activo, traemos a los doctores y el estado del reporte
                        $.get(
                                servidor + "sirac/API/representante/getDoctoresReporte/" + getUsuario() + "/" + getToken(),
                                {},
                                function(data) {
                                    result2 = jQuery.parseJSON(data);
                                    if (result2.acceso === "correcto") {
                                        if (result2.medicos.length > 0) {
                                            for (var i = 0; i < result2.medicos.length; i++) {
                                                var medico = result2.medicos[i];
                                                //alert(medico.idMedico);
                                                var text = '<li><a href="#" onclick="creaReporte(' + medico.idMedico + ',' + medico.htPlanTrabajo + ')" data-transition="slide">' + medico.nombreMedico + '  <span>('+ medico.reportado +')</span>' +'</a></li>';
                                                $("#listaDoctoresReporte").append(text).listview('refresh');//trigger('create');
                                            }
                                        } else {
                                            //No hay medico que visitar el día de hoy
                                            var text = '<li>No hay plan de trabajo para el día de hoy</li>';
                                            $("#listaDoctoresReporte").append(text).listview('refresh');//trigger('create');
                                        }
                                    } 
                                }
                        );
                    } else {
                        $("#ReporteEstadoPlan").html("<h1>El plan de trabajo no se encuentra activo.<h1>");
                    }
                } else {
                    window.location = "index.html";
                }
            });
});