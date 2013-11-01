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






function verPlanRepresentante(idRepresentante) {
    $.mobile.loading('show', {
        text: 'Guardando información...',
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