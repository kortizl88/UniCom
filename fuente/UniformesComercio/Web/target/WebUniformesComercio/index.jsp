<%@ page contentType="text/html" pageEncoding="UTF-8"%> 
<%      ServletContext sc = request.getSession().getServletContext();
        String cadenaEndpointWS="";
        cadenaEndpointWS = (sc.getAttribute("ENDPOINTWS").toString().trim().equals("NULO") || sc.getAttribute("ENDPOINTWS").toString().trim().equals("")) ? "http://"+ request.getLocalName()+":"+request.getLocalPort()+request.getContextPath()+"/" : sc.getAttribute("ENDPOINTWS").toString().trim();
%>

<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Uniformes Comercio</title>  
        <base href="./"> <!-- Produccion -->
        <meta name="viewport" content="width=device-width, initial-scale=1">    
        <link rel="icon" type="image/x-icon" href="assets/img/tienda/favicon.png">               
        <!-- Librerias CSS-->
        <link rel="stylesheet" type="text/css" href="assets/css/tienda/estilo.css">	
        <link rel="stylesheet" type="text/css" href="assets/css/tienda/index.css">         
        <link rel="stylesheet" type="text/css" href="assets/css/tienda/indigo-pink.css"> <!-- Carga el tema, se comentaba que faltaba cargar el tema -->	
    </head>
    <body>
        <div id="id_endPointWS" style="display:none;"><%=cadenaEndpointWS%></div>	
    <app-root></app-root>
    <script type="text/javascript" src="scripts/inline.js"></script>
    <script type="text/javascript" src="scripts/polyfills.js"></script>
    <script type="text/javascript" src="scripts/vendor.js"></script>
    <script type="text/javascript" src="scripts/main.js"></script>
    <script type="text/javascript">
        function JSSetUpdate(RespuestaPopUp)
        {  //corr
            var respComp = (typeof RespuestaPopUp === 'object') ? RespuestaPopUp : JSON.parse(RespuestaPopUp);
            entrega.huella.validacion(respComp);
        }

    </script>
</body>
</html>