webpackJsonp([0],{

/***/ "../../../../../src/assets/js/huella.js":
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "validaHuellaEmpleado", function() { return validaHuellaEmpleado; });
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
{
    console.log(RespuestaPopUp);
    /*QUITAR*/
    RespuestaPopUp.PluginResponse.authenticated = 1;
    entrega.huella.validacion(RespuestaPopUp);
}



/***/ })

});
//# sourceMappingURL=0.chunk.js.map