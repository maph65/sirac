$(document).on('pageinit', '#home', function() {
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
                            var text = '<li><a href="#" onclick="detallesVisita(' + medico.idMedico + ','+ medico.idSitio + ',' + medico.idHtPlanTrabajo + ')" data-transition="slide">' + medico.NombreMedico + '</a></li>';
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

function detallesVisita(idMedico, idSitio ,idHtPlanTrabajo) {
    $.mobile.loading('show', {
        text: 'Actualizando información...',
        textVisible: true,
        theme: 'a',
        html: ""
    });
    //Cargamos los datos
    $.get(
            servidor + "sirac/API/representante/detallesMedicoSitio/" + getUsuario() + "/" + getToken() + "/" + idMedico + "/" + idSitio,
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
                $("#sitioCalle").html(result.sitio.calle +" " + " No. " + result.sitio.numExt + " " + result.sitio.numInt + "&nbsp;");
                $("#sitioColonia").html(result.sitio.colonia + "&nbsp;");
                $("#sitioCp").html(result.sitio.cp + "&nbsp;");
                $("#sitioDelegacion").html(result.sitio.delegacion + "&nbsp;");
                $("#sitioTelefono").html(result.sitio.telefono + "&nbsp;");
                //terminamos, hora de ir a la siguiente pagina para ver la informacion
    });
    $.mobile.changePage('#detallesPlanTrabajo', {
        transition: 'slide'
    });
    $.mobile.loading('hide');
}