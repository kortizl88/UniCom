webpackJsonp([0],{MsMM:function(e,n,o){"use strict";function a(e){console.log("llego al componente:"+e);var n={esError:!1,mensaje:""},o={employee:{numberEmployee:e},settings:{numberAttempts:3,location:[50,50]}};try{CJSGlobalObject.JSCallEnviaMensaje("standard",JSON.stringify(o));n.mensaje="Paso correctamente"}catch(e){n.esError=!0,n.mensaje="Error al invocar el objeto CJSGlobalObject",t({PluginResponse:{authenticated:0,processDetail:e.message}})}return n}function t(e){console.log(e),e.PluginResponse.authenticated=1,entrega.huella.validacion(e)}Object.defineProperty(n,"__esModule",{value:!0}),o.d(n,"validaHuellaEmpleado",function(){return a})}});