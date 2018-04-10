function validaHuellaEmpleado(numEmp) {
    console.log("llego al componente:" + numEmp)
    var mensaje = {esError: false, mensaje: ""};
    var objJson = {
        'employee': {
            'numberEmployee': numEmp
        },
        'settings': {
            'numberAttempts': 3,
            'location': [50, 50]
        }
    };
    try {
        var rest = CJSGlobalObject.JSCallEnviaMensaje('standard', JSON.stringify(objJson));

        mensaje.mensaje = "Paso correctamente";

    } catch (ex) {
        mensaje.esError = true;
        mensaje.mensaje = "Error al invocar el objeto CJSGlobalObject";
        JSSetUpdate({PluginResponse: {authenticated: 0, processDetail: ex.message }});
    }

    return mensaje;
}

function JSSetUpdate(RespuestaPopUp)
{   // corr
    var respComp = (typeof RespuestaPopUp === 'object') ? RespuestaPopUp : JSON.parse(RespuestaPopUp);
    entrega.huella.validacion(respComp);
}

export {validaHuellaEmpleado};