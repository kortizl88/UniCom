DROP PACKAGE UNIFORMES.PAWEBUNIFORMESCOMERCIO2;

CREATE OR REPLACE PACKAGE PAWEBUNIFORMESCOMERCIO2 AS 

  /* TODO enter package declarations (types, exceptions, methods etc) here */ 
  TYPE rcgCursor IS REF CURSOR;
  
 FUNCTION FNCONSULTASOLICITUDES(
      paNumeroEmpleado UNIFORMES.TASOLICITUDES.FIIDEMPLEADO%TYPE, 
      paNumeroSolicitudes NUMBER)
 RETURN rcgCursor;

 FUNCTION FNCONSULTASOLICITUD(
      paNoFolioSolicitud UNIFORMES.TASOLICITUDES.FIFOLIOSOLICITUD%TYPE)  
  RETURN rcgCursor;

 FUNCTION FNDEFINEDESCRIPCIONPRENDA(
    paSKU UNIFORMES.TABITACORASOLICITUD.FISKU%TYPE,
    paIDTipoPrenda UNIFORMES.TASOLICITUDESDETALLE.FIIDTIPOPRENDA%TYPE
 )
 RETURN VARCHAR2;
 
 FUNCTION FNCADENAESTADOESTATUS(
    paNoEstadoNuevo UNIFORMES.TABITACORASOLICITUD.FIIDESTATUSNVO%TYPE
 )
 RETURN VARCHAR2;
 
 FUNCTION FNNOREMISION(
    paNoPedido UNIFORMES.TABITACORASOLICITUD.FINUMPEDIDO%TYPE,
    paNoSKU UNIFORMES.TABITACORASOLICITUD.FISKU%TYPE
 )
 RETURN NUMBER;

 FUNCTION FNCONSULTASOLICITUDAVANCE(
    paNoFolioSolicitud UNIFORMES.TASOLICITUDES.FIFOLIOSOLICITUD%TYPE
 )
 RETURN rcgCursor;

 FUNCTION FNCALCULOPORCENTAJE(
    paNoFolioSolicitud UNIFORMES.TASOLICITUDESDETALLE.FIFOLIOSOLICITUD%TYPE
 )
 RETURN NUMBER;

 FUNCTION FNCONSULTASOLICITUDESV(
  paNumeroEmpleado UNIFORMES.TASOLICITUDES.FIIDEMPLEADO%TYPE,
  paNumeroSolicitudes NUMBER
 )
 RETURN rcgCursor;

 FUNCTION FNPEDIDOSPORPRECIO(
  paFolioSolicitud UNIFORMES.TAPEDIDOSCD.FIFOLIOSOLICITUD%TYPE
 )
 RETURN rcgCursor;

 FUNCTION FNINFORMACIONDESCUENTO(
  paFolioSolicitud UNIFORMES.TAPEDIDOSCD.FIFOLIOSOLICITUD%TYPE,
  paNumeroPedido UNIFORMES.TAPEDIDOSCD.FIPEDIDO%TYPE
 )
 RETURN rcgCursor;
 
 FUNCTION FNCADENAPORCENTAJE(
  paNoPorcentaje NUMBER
 )  
 RETURN VARCHAR2;
 
 PROCEDURE SPGUARDACONFIRMACIONENTREGA(
    paConfirmacionesEntrega IN UNIFORMES.TYPEARRCONFIRMACIONENTREGA,
    paNoConfirmaciones OUT NUMBER
 );
  
END PAWEBUNIFORMESCOMERCIO2;

CREATE OR REPLACE PACKAGE BODY PAWEBUNIFORMESCOMERCIO2
AS
  /*************************************************************
   Proyecto:                           Uniformes Comercio V2
   Descripcion:                        Paquete para sistema de uniformes Div. Comercial
   Parametros de entrada:              No aplica
   Parametros de salida:               No aplica
   Parametros de entrada-salida        No aplica
   Precondiciones:                     Tener creado el esquema
   Creador:                            
   Fecha de creacion:                  
   *************************************************************/
  	vgErrCode               NUMBER(6):= 0;          -- Variable para el manejo de errores codigo
    vgErrMsg                VARCHAR2(500 CHAR):= '';-- Variable para el manejo de errores mensaje
    csgCero                 CONSTANT NUMBER(1):=0;
    csgUno                  CONSTANT NUMBER(1):=1;
    csgDos                  CONSTANT NUMBER(1):=2;
    csgTres                 CONSTANT NUMBER(1):=3;    
    csgCuatro               CONSTANT NUMBER(1):=4; 
    csgDieceNueve           CONSTANT NUMBER(2):=19;
    csgCien                 CONSTANT NUMBER(3):=100;
    csgFalso                CONSTANT NUMBER(1):=0;    
    csgCierto               CONSTANT NUMBER(1):=1;
    csgCancelado            CONSTANT NUMBER(1):=0;  -- Cancelado
    csgPendiente            CONSTANT NUMBER(1):=1;  -- Pendiente de solicitar a CD
    csgSolicitado           CONSTANT NUMBER(1):=2;  -- Solicitado a CD
    csgAtendido             CONSTANT NUMBER(1):=3;  -- Atendido en CD
    csgEnCamino             CONSTANT NUMBER(1):=4;  -- En camino a tienda
    csgRecibido             CONSTANT NUMBER(1):=5;  -- Recibido en tienda
    csgEntregado            CONSTANT NUMBER(1):=6;  -- Entregado    
    csgCadenaCancelado      CONSTANT VARCHAR2(50 CHAR):='CANCELADO';                     -- Cancelado
    csgCadenaPendiente      CONSTANT VARCHAR2(50 CHAR):='PENDIENTE DE SOLICITAR A CD';   -- Pendiente de solicitar a CD
    csgCadenaSolicitado     CONSTANT VARCHAR2(50 CHAR):='SOLICITADO A CD';               -- Solicitado a CD
    csgCadenaAtendido       CONSTANT VARCHAR2(50 CHAR):='ATENDIDO EN CD';                -- Atendido en CD
    csgCadenaEnCamino       CONSTANT VARCHAR2(50 CHAR):='EN CAMINO A TIENDA';            -- En camino a tienda
    csgCadenaRecibido       CONSTANT VARCHAR2(50 CHAR):='RECIBIDO EN TIENDA';            -- Recibido en tienda
    csgCadenaEntregado      CONSTANT VARCHAR2(50 CHAR):='ENTREGADO';                     -- Entregado

 FUNCTION FNCONSULTASOLICITUDES(
    paNumeroEmpleado UNIFORMES.TASOLICITUDES.FIIDEMPLEADO%TYPE, 
    paNumeroSolicitudes NUMBER)
 RETURN rcgCursor
 IS
 curDatos rcgCursor;
 /*************************************************************
   Proyecto:                         Uniformes Comercio V2
   Descripcion:                      Consulta de solicitudes del empleado
   Parametros de entrada:            Numero del empleado, Numero de solicitudes
   Parametros de salida:             Retorna las solicitudes del empleado
   Parametros de entrada-salida      No aplica
   Precondiciones:                   Tener creado el esquema
   Creador:                          Luis Daniel Rodriguez Garcia
   Fecha de creacion:                16 de Septiembre del 2017
  *************************************************************/
 BEGIN  
 OPEN curDatos FOR
    SELECT  S.FIFOLIOSOLICITUD, 
            TO_CHAR(S.FDFECHACAPTURA,'dd/mm/yyyy') AS FCFECHACAPTURA,
            T.FISUCURSAL,
            T.FCNOMBRE                
    FROM UNIFORMES.TASOLICITUDES S
    INNER JOIN UNIFORMES.TAEMPLEADOS E
        ON S.FIIDEMPLEADO = E.FIEMPLEADO
    INNER JOIN (SELECT FIFOLIOSOLICITUD, FIPAIS, FICANAL, FISUCURSAL FROM UNIFORMES.TASOLICITUDESDETALLE GROUP BY FIFOLIOSOLICITUD, FIPAIS, FICANAL, FISUCURSAL) SD
        ON SD.FIFOLIOSOLICITUD = S.FIFOLIOSOLICITUD
    INNER JOIN UNIFORMES.TATIENDAS T
        ON T.FIPAIS = SD.FIPAIS
        AND T.FICANAL = SD.FICANAL
        AND T.FISUCURSAL = SD.FISUCURSAL
    WHERE S.FIIDEMPLEADO = paNumeroEmpleado AND ROWNUM <= paNumeroSolicitudes
    ORDER BY S.FDFECHACAPTURA DESC;   

       
 RETURN curDatos;
 EXCEPTION
    WHEN OTHERS THEN
        vgErrCode := SQLCODE;
        vgErrMsg := SQLERRM;
        RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PAWEBUNIFORMESCOMERCIO2.FNCONSULTASOLICITUDES": ' || vgErrMsg);
        
 END FNCONSULTASOLICITUDES;

 FUNCTION FNCONSULTASOLICITUD(
    paNoFolioSolicitud UNIFORMES.TASOLICITUDES.FIFOLIOSOLICITUD%TYPE)  
 RETURN rcgCursor
 IS
 curDatos rcgCursor;
    /*************************************************************
    Proyecto:                         Uniformes Comercio V2
    Descripcion:                      Consulta la solicitud
    Parametros de entrada:            Folio de solicitud
    Parametros de salida:             Datos de la tienda (Cursor)
    Parametros de entrada-salida      No aplica
    Precondiciones:                   Tener creado el esquema
    Creador:                          Luis Rodriguez
    Fecha de creacion:                16 de Septiembre del 2017
    *************************************************************/
 BEGIN  
 OPEN curDatos FOR
/*     SELECT TBS.FINUMPEDIDO,
            TO_CHAR(TBS.FISKU) AS FCSKU, 
            FNDEFINEDESCRIPCIONPRENDA(TBS.FISKU,TSD.FIIDTIPOPRENDA) AS FCDESCRIPCION,
            FNNOREMISION(TBS.FINUMPEDIDO,TBS.FISKU) AS FIREMISION,
            TSD.FICANTIDAD,
            FNCADENAESTADOESTATUS(TBS.FIIDESTATUSNVO) AS FCIDESTATUSNVO,
            TBS.FIIDDETALLE,
            TO_CHAR(TBS.FDFECHAEVENTO, 'dd/mm/yyyy HH24:MI:SS') AS FCFECHAEVENTO
     FROM   (SELECT TBSAUX.FIFOLIOSOLICITUD, 
                    TBSAUX.FINUMPEDIDO, 
                    TBSAUX.FISKU,
                    TBSAUX.FIIDESTATUSNVO,
                    TBSAUX.FIIDDETALLE,
                    TBSAUX.FDFECHAEVENTO
            FROM    (SELECT FIIDDETALLE, 
                            MAX(FDFECHAEVENTO) AS FDFECHAEVENTO
                        FROM UNIFORMES.TABITACORASOLICITUD 
                    WHERE FIFOLIOSOLICITUD = paNoFolioSolicitud 
                    GROUP BY FIIDDETALLE) TBSORDEN
            INNER JOIN UNIFORMES.TABITACORASOLICITUD TBSAUX
                ON TBSAUX.FIIDDETALLE = TBSORDEN.FIIDDETALLE
                AND TBSAUX.FDFECHAEVENTO = TBSORDEN.FDFECHAEVENTO) TBS
     INNER JOIN UNIFORMES.TASOLICITUDESDETALLE TSD
        ON TSD.FIFOLIOSOLICITUD = TBS.FIFOLIOSOLICITUD 
        AND TSD.FIIDDETALLE = TBS.FIIDDETALLE; */
        
--   USO RANK OVER    
    SELECT  TBS.FINUMPEDIDO,
            TO_CHAR(TBS.FISKU) AS FCSKU, 
            FNDEFINEDESCRIPCIONPRENDA(TBS.FISKU,TSD.FIIDTIPOPRENDA) AS FCDESCRIPCION,
            FNNOREMISION(TBS.FINUMPEDIDO,TBS.FISKU) AS FIREMISION,
            TSD.FICANTIDAD,
            FNCADENAESTADOESTATUS(TBS.FIIDESTATUSNVO) AS FCIDESTATUSNVO,
            TBS.FIIDDETALLE,
            TO_CHAR(TBS.FDFECHAEVENTO, 'dd/mm/yyyy HH24:MI:SS') AS FCFECHAEVENTO
     FROM   (SELECT FIFOLIOSOLICITUD, 
                    FINUMPEDIDO, 
                    FISKU,
                    FIIDESTATUSNVO,
                    FIIDDETALLE,
                    FDFECHAEVENTO                
                FROM (SELECT    FIFOLIOSOLICITUD, 
                                FINUMPEDIDO, 
                                FISKU,
                                FIIDESTATUSNVO,
                                FIIDDETALLE,
                                FDFECHAEVENTO,
                                RANK() OVER (PARTITION BY FIIDDETALLE ORDER BY FDFECHAEVENTO DESC) ESCIERTO
                        FROM UNIFORMES.TABITACORASOLICITUD) 
                WHERE ESCIERTO = csgCierto AND FIFOLIOSOLICITUD = paNoFolioSolicitud) TBS
     INNER JOIN UNIFORMES.TASOLICITUDESDETALLE TSD
        ON TSD.FIFOLIOSOLICITUD = TBS.FIFOLIOSOLICITUD 
        AND TSD.FIIDDETALLE = TBS.FIIDDETALLE;        
 RETURN curDatos;
 
 EXCEPTION
    WHEN OTHERS THEN
        vgErrCode := SQLCODE;
        vgErrMsg := SQLERRM;
        RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PAWEBUNIFORMESCOMERCIO2.FNCONSULTASOLICITUD": ' || vgErrMsg);
      
 END FNCONSULTASOLICITUD;

 FUNCTION FNNOREMISION(
    paNoPedido UNIFORMES.TABITACORASOLICITUD.FINUMPEDIDO%TYPE,
    paNoSKU UNIFORMES.TABITACORASOLICITUD.FISKU%TYPE)
 RETURN NUMBER
 IS
 vlNoRemision UNIFORMES.TAREMISIONESXPEDIDO.FIREMISION%TYPE;
    /*************************************************************
    Proyecto:                         Uniformes Comercio V2
    Descripcion:                      Retorna la numero de remision
    Parametros de entrada:            Numero del pedido, Numero del SKU
    Parametros de salida:             Retorna la numero de remision
    Parametros de entrada-salida      No aplica
    Precondiciones:                   Tener creado el esquema
    Creador:                          Luis Daniel Rodriguez Garcia
    Fecha de creacion:                1 de Enero del 2017
    *************************************************************/
 BEGIN
    SELECT FIREMISION 
        INTO vlNoRemision 
    FROM UNIFORMES.TAREMISIONESXPEDIDO
        WHERE FIPEDIDO = paNoPedido
        AND FISKU = paNoSKU;
 RETURN vlNoRemision;
 
 END FNNOREMISION;
 
 FUNCTION FNCADENAESTADOESTATUS(
    paNoEstadoNuevo UNIFORMES.TABITACORASOLICITUD.FIIDESTATUSNVO%TYPE)
 RETURN VARCHAR2
 IS
 vlCadenaDescripcionEstatus UNIFORMES.TAESTATUSPEDIDOS.FCDESCRIPCION%TYPE;
    /*************************************************************
    Proyecto:                         Uniformes Comercio V2
    Descripcion:                      Retorna la numero de remision
    Parametros de entrada:            Numero del pedido, Numero del SKU
    Parametros de salida:             Retorna la numero de remision
    Parametros de entrada-salida      No aplica
    Precondiciones:                   Tener creado el esquema
    Creador:                          Luis Daniel Rodriguez Garcia
    Fecha de creacion:                1 de Enero del 2017
    *************************************************************/
 BEGIN

    vlCadenaDescripcionEstatus :=   (CASE paNoEstadoNuevo
                                        WHEN csgCancelado   THEN csgCadenaCancelado
                                        WHEN csgPendiente   THEN csgCadenaPendiente
                                        WHEN csgSolicitado  THEN csgCadenaSolicitado
                                        WHEN csgAtendido    THEN csgCadenaAtendido
                                        WHEN csgEnCamino    THEN csgCadenaEnCamino
                                        WHEN csgRecibido    THEN csgCadenaRecibido
                                        WHEN csgEntregado   THEN csgCadenaEntregado
                                     END);
 RETURN vlCadenaDescripcionEstatus;
 
 END FNCADENAESTADOESTATUS;

 

 FUNCTION FNDEFINEDESCRIPCIONPRENDA(
    paSKU UNIFORMES.TABITACORASOLICITUD.FISKU%TYPE,
    paIDTipoPrenda UNIFORMES.TASOLICITUDESDETALLE.FIIDTIPOPRENDA%TYPE)
 RETURN VARCHAR2
 IS
 vlCadenaDescripcion VARCHAR2(50);
 /*************************************************************
    Proyecto:                         Uniformes Comercio V2
    Descripcion:                      Retorna la descripcion de la prenda
    Parametros de entrada:            SKU de la tienda, Tipo de prenda
    Parametros de salida:             Retorna la descripcion en una cadena
    Parametros de entrada-salida      No aplica
    Precondiciones:                   Tener creado el esquema
    Creador:                          Luis Daniel Rodriguez Garcia
    Fecha de creacion:                16 de Septiembre del 2017
 *************************************************************/    
 BEGIN
        IF paSKU is NULL THEN
            SELECT  FCDESCRIPCION 
                    INTO vlCadenaDescripcion
            FROM UNIFORMES.TATIPOSPRENDA
                WHERE FIIDTIPOPRENDA = paIDTipoPrenda;
        ELSE
            SELECT  FCDESCRIPCION 
                    INTO vlCadenaDescripcion
            FROM UNIFORMES.TAPRENDAS 
                WHERE TAPRENDAS.FISKU = paSKU;
        END IF;
        
 RETURN vlCadenaDescripcion;   
    
 EXCEPTION
    WHEN OTHERS THEN
        vgErrCode := SQLCODE;
        vgErrMsg := SQLERRM;
        RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PAWEBUNIFORMESCOMERCIO2.FNDEFINEDESCRIPCIONPRENDA": ' || vgErrMsg); 

 END FNDEFINEDESCRIPCIONPRENDA;

 FUNCTION FNCONSULTASOLICITUDAVANCE(
    paNoFolioSolicitud UNIFORMES.TASOLICITUDES.FIFOLIOSOLICITUD%TYPE)
 RETURN rcgCursor
 IS
 /*************************************************************
    Proyecto:                         Uniformes Comercio V2
    Descripcion:                      Muestra el estatus de la solicitud
    Parametros de entrada:            Folio de la solicitud
    Parametros de salida:             Retorna los datos de la solicitud del avance
    Parametros de entrada-salida      No aplica
    Precondiciones:                   Tener creado el esquema
    Creador:                          Luis Rodriguez
    Fecha de creacion:                16 de Septiembre del 2017
 *************************************************************/   
 curDatos rcgCursor;
 vlCalculoPorcentaje NUMBER(5,2); 
 BEGIN
 vlCalculoPorcentaje := FNCALCULOPORCENTAJE(paNoFolioSolicitud);
 OPEN curDatos FOR
    SELECT    
            FNCADENAPORCENTAJE(CANCELADO * vlCalculoPorcentaje)   AS FCPORCCANCELADO,
            FNCADENAPORCENTAJE(
                    (CASE PENDIENTE
                        WHEN csgFalso THEN csgCero
                        ELSE PENDIENTE/csgDos
                    END) * vlCalculoPorcentaje)                   AS FCPORCPENDIENTE,
            FNCADENAPORCENTAJE(
                    (CASE (PENDIENTE + SOLICITADO)
                        WHEN csgFalso THEN csgCero
                        ELSE (PENDIENTE + SOLICITADO)/csgTres
                    END) * vlCalculoPorcentaje)                   AS FCPORCSOLICITADO,
            FNCADENAPORCENTAJE(ATENDIDO * vlCalculoPorcentaje)    AS FCPORCATENDIDO,
            FNCADENAPORCENTAJE(CAMINO * vlCalculoPorcentaje)      AS FCPORCCAMINO,
            FNCADENAPORCENTAJE(RECIBIDO * vlCalculoPorcentaje)    AS FCPORCRECIBIDO,        
            FNCADENAPORCENTAJE(ENTREGADO * vlCalculoPorcentaje)   AS FCPORCENTREGADO
    FROM (SELECT FIIDESTATUSNVO FROM UNIFORMES.TABITACORASOLICITUD WHERE FIFOLIOSOLICITUD = paNoFolioSolicitud) 
    PIVOT (count(FIIDESTATUSNVO) for FIIDESTATUSNVO in  
            (
                0 AS CANCELADO,
                1 AS PENDIENTE,
                2 AS SOLICITADO,
                3 AS ATENDIDO,
                4 AS CAMINO,    
                5 AS RECIBIDO,
                6 AS ENTREGADO
            )
    );
    
 RETURN curDatos;
    
 EXCEPTION
    WHEN OTHERS THEN
        vgErrCode := SQLCODE;
        vgErrMsg := SQLERRM;
        RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PAWEBUNIFORMESCOMERCIO2.FNCONSULTASOLICITUDAVANCE": ' || vgErrMsg);     

 END FNCONSULTASOLICITUDAVANCE;

 FUNCTION FNCADENAPORCENTAJE(
    paNoPorcentaje NUMBER) 
 RETURN VARCHAR2
 IS
 vlCadenaPorcentaje VARCHAR2(10 CHAR); 
 /*************************************************************
    Proyecto:                         Uniformes Comercio V2
    Descripcion:                      Transforma la cantidad numerica a cadena con porciento.
    Parametros de entrada:            Numero Porcentaje
    Parametros de salida:             Retorna una cadena por el valor del porcentaje.
    Parametros de entrada-salida      No aplica
    Precondiciones:                   Tener creado el esquema
    Creador:                          Luis Rodriguez
    Fecha de creacion:                16 de Septiembre del 2017
 *************************************************************/          
 BEGIN
 vlCadenaPorcentaje := TO_CHAR(paNoPorcentaje,'990') || '%';
 vlCadenaPorcentaje := TRIM(vlCadenaPorcentaje);   
    
 RETURN vlCadenaPorcentaje;
 EXCEPTION
    WHEN OTHERS THEN
        vgErrCode := SQLCODE;
        vgErrMsg := SQLERRM;
        RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PAWEBUNIFORMESCOMERCIO2.FNCADENAPORCENTAJE": ' || vgErrMsg);    
            
END FNCADENAPORCENTAJE;


 FUNCTION FNCALCULOPORCENTAJE(
    paNoFolioSolicitud UNIFORMES.TASOLICITUDESDETALLE.FIFOLIOSOLICITUD%TYPE)
 RETURN NUMBER
 IS
 /*************************************************************
    Proyecto:                         Uniformes Comercio V2
    Descripcion:                      Realiza la operacion del calculo del porcentaje
    Parametros de entrada:            Folio de la solicitud
    Parametros de salida:             Retorna los datos de la solicitud del avance
    Parametros de entrada-salida      No aplica
    Precondiciones:                   Tener creado el esquema
    Creador:                          Luis Rodriguez
    Fecha de creacion:                16 de Septiembre del 2017
 *************************************************************/   
 vlContador NUMBER(3);
 vlDivision NUMBER(5,2); 
 BEGIN  
 
    SELECT  COUNT(FIFOLIOSOLICITUD) 
            INTO vlContador 
    FROM UNIFORMES.TASOLICITUDESDETALLE 
    WHERE FIFOLIOSOLICITUD = paNoFolioSolicitud;
    
    vlDivision :=   (CASE vlContador
                        WHEN csgCero THEN csgCero
                        ELSE csgCien/vlContador
                    END);
 RETURN vlDivision;
 EXCEPTION
    WHEN OTHERS THEN
        vgErrCode := SQLCODE;
        vgErrMsg := SQLERRM;
        RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PAWEBUNIFORMESCOMERCIO2.FNCALCULOPORCENTAJE": ' || vgErrMsg);       

END FNCALCULOPORCENTAJE;

 FUNCTION FNCONSULTASOLICITUDESV(
    paNumeroEmpleado UNIFORMES.TASOLICITUDES.FIIDEMPLEADO%TYPE,
    paNumeroSolicitudes NUMBER)
 RETURN rcgCursor
 IS
 curDatos rcgCursor;
 /*************************************************************
    Proyecto:                         Uniformes Comercio V2
    Descripcion:                      Consulta las solicitudes voluntarias
    Parametros de entrada:            Numero de empleado, Folio de la solicitud
    Parametros de salida:             Retorna los datos de la solicitud voluntaria
    Parametros de entrada-salida      No aplica
    Precondiciones:                   Tener creado el esquema
    Creador:                          Luis Rodriguez
    Fecha de creacion:                16 de Septiembre del 2017
 *************************************************************/   
 BEGIN
 OPEN curDatos FOR
    SELECT  S.FIFOLIOSOLICITUD, 
            TO_CHAR(S.FDFECHACAPTURA,'dd/mm/yyyy') AS FCFECHACAPTURA,
            T.FISUCURSAL,
            T.FCNOMBRE                
    FROM UNIFORMES.TASOLICITUDES S
    INNER JOIN UNIFORMES.TAEMPLEADOS E
        ON S.FIIDEMPLEADO = E.FIEMPLEADO
        AND S.FIIDTIPOSOLICITUD = 2
    INNER JOIN (SELECT FIFOLIOSOLICITUD, FIPAIS, FICANAL, FISUCURSAL FROM UNIFORMES.TASOLICITUDESDETALLE GROUP BY FIFOLIOSOLICITUD, FIPAIS, FICANAL, FISUCURSAL) SD
        ON SD.FIFOLIOSOLICITUD = S.FIFOLIOSOLICITUD
    INNER JOIN UNIFORMES.TATIENDAS T
        ON T.FIPAIS = SD.FIPAIS
        AND T.FICANAL = SD.FICANAL
        AND T.FISUCURSAL = SD.FISUCURSAL
    WHERE S.FIIDEMPLEADO = paNumeroEmpleado AND ROWNUM <= paNumeroSolicitudes
    ORDER BY S.FDFECHACAPTURA DESC; 

 RETURN curDatos;
 EXCEPTION
    WHEN OTHERS THEN
        vgErrCode := SQLCODE;
        vgErrMsg := SQLERRM;
        RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PAWEBUNIFORMESCOMERCIO2.FNCONSULTASOLICITUDESV": ' || vgErrMsg);        

 END FNCONSULTASOLICITUDESV;

 FUNCTION FNPEDIDOSPORPRECIO(
    paFolioSolicitud UNIFORMES.TAPEDIDOSCD.FIFOLIOSOLICITUD%TYPE)
 RETURN rcgCursor
 IS
 curDatos rcgCursor;
 anoActual Number(4);
 /*************************************************************
    Proyecto:                         Uniformes Comercio V2
    Descripcion:                      Muestra los pedidos con su precio
    Parametros de entrada:            Folio de la solicitud
    Parametros de salida:             Retorna todos los pedidos
    Parametros de entrada-salida      No aplica
    Precondiciones:                   Tener creado el esquema
    Creador:                          Luis Rodriguez
    Fecha de creacion:                16 de Septiembre del 2017
 *************************************************************/
 BEGIN
 
 anoActual := (TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')));
 
 OPEN curDatos FOR
    SELECT  TPCD.FIPEDIDO,
            TPCD.FIFOLIOSOLICITUD,
            TO_CHAR(TPCD.FISKU) AS FCSKU,
            TP.FCDESCRIPCION,
            TO_CHAR((FNTOTDESCUENTO - FNSALDO),'FM$99990.00') AS FCPAGADO,
            TPCD.FICANTIDAD,
            TO_CHAR(TDS.FNTOTDESCUENTO,'FM$99990.00') AS FCCOSTOPRENDA,
            TDS.FISEMADESCUENTO AS FISEMANA,
            TO_CHAR((TDS.FNSALDO),'FM$99990.00') AS FCSALDOPORPAGAR,
            TO_CHAR(TDS.FNPAGO) AS FCPAGOSEMANAL,
            TO_CHAR(TDS.FDPAGO) AS FCFECHAPAGO,
            TTP.FCIMAGEN AS FCNOMBREIMAGEN
    FROM UNIFORMES.TADESCUENTOSSAP TDS
    INNER JOIN
                (SELECT FIFOLIOCENTRAL,
                        FIPEDIDO, 
                        MAX(FDPAGO) AS FDPAGO 
                    FROM UNIFORMES.TADESCUENTOSSAP 
                    WHERE FIFOLIOCENTRAL = paFolioSolicitud 
                            AND (
                            CASE 
                                WHEN (TO_NUMBER(TO_CHAR(FDPAGO, 'YYYY'))) < anoActual THEN 1   
                                WHEN (TO_NUMBER(TO_CHAR(FDPAGO, 'YYYY'))) = anoActual THEN   
                                    CASE 
                                        WHEN ((FISEMADESCUENTO) <= (SELECT (TO_NUMBER(TO_CHAR(SYSDATE, 'WW'))) FROM DUAL)) THEN 1
                                        ELSE 0
                                    END
                                ELSE 0
                            END
                            ) = 1
                    GROUP BY FIFOLIOCENTRAL,FIPEDIDO) TDSGROUPBY
        ON TDS.FIFOLIOCENTRAL = TDSGROUPBY.FIFOLIOCENTRAL 
        AND TDS.FIPEDIDO = TDSGROUPBY.FIPEDIDO 
        AND TDS.FDPAGO = TDSGROUPBY.FDPAGO
    INNER JOIN (SELECT  FIPEDIDO,
                        FIFOLIOSOLICITUD,
                        FISKU,
                        FICANTIDAD 
                FROM UNIFORMES.TAPEDIDOSCD 
                WHERE FIFOLIOSOLICITUD = paFolioSolicitud) TPCD
        ON TDSGROUPBY.FIFOLIOCENTRAL = TPCD.FIFOLIOSOLICITUD 
        AND TDSGROUPBY.FIPEDIDO = TPCD.FIPEDIDO
    INNER JOIN (SELECT  FISKU,
                        FCDESCRIPCION,
                        FIIDTIPOPRENDA 
                    FROM UNIFORMES.TAPRENDAS) TP
        ON TP.FISKU = TPCD.FISKU
    INNER JOIN (SELECT  FIIDTIPOPRENDA,
                        FCIMAGEN 
                    FROM UNIFORMES.TATIPOSPRENDA) TTP
        ON TTP.FIIDTIPOPRENDA = TP.FIIDTIPOPRENDA
    ORDER BY TPCD.FIPEDIDO;
 RETURN curDatos;   
 
 EXCEPTION
    WHEN OTHERS THEN
        vgErrCode := SQLCODE;
        vgErrMsg := SQLERRM;
        RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PAWEBUNIFORMESCOMERCIO2.FNPEDIDOSPORPRECIO": ' || vgErrMsg);     

 END FNPEDIDOSPORPRECIO;

 FUNCTION FNINFORMACIONDESCUENTO(
    paFolioSolicitud UNIFORMES.TAPEDIDOSCD.FIFOLIOSOLICITUD%TYPE,
    paNumeroPedido UNIFORMES.TAPEDIDOSCD.FIPEDIDO%TYPE)
 RETURN rcgCursor
 IS
 curDatos rcgCursor;
  /*************************************************************
    Proyecto:                         Uniformes Comercio V2
    Descripcion:                      Muestra a mayor detalle el descuento
    Parametros de entrada:            Folio de la solicitud
    Parametros de salida:             Retorna todos los pedidos
    Parametros de entrada-salida      No aplica
    Precondiciones:                   Tener creado el esquema
    Creador:                          Luis Rodriguez
    Fecha de creacion:                16 de Septiembre del 2017
  *************************************************************/   
 BEGIN
 OPEN curDatos FOR

    SELECT  TO_CHAR(TDSAP.FDPAGO, 'YYYY') AS FCANO,
            TDSAP.FISEMADESCUENTO,
            TO_CHAR(TDSAP.FDPAGO) AS FCFECHAPAGO,
            TO_CHAR(TDSAP.FNTOTDESCUENTO,'FM$99990.00') AS FCCOSTOPRENDA,
            TO_CHAR(TDSAP.FNSALDO,'FM$99990.00') AS FCSALDOPORPAGAR,
            TO_CHAR(TDSAP.FNPAGO,'FM$99990.00') AS FCPAGOSEMANAL
    FROM UNIFORMES.TAPEDIDOSCD TPCD
    INNER JOIN UNIFORMES.TADESCUENTOSSAP TDSAP
        ON TDSAP.FIFOLIOCENTRAL = TPCD.FIFOLIOSOLICITUD
        AND TDSAP.FIPEDIDO = TPCD.FIPEDIDO
    WHERE TPCD.FIFOLIOSOLICITUD = paFolioSolicitud AND TPCD.FIPEDIDO = paNumeroPedido
    ORDER BY TDSAP.FDPAGO;
    
 RETURN curDatos;        
        
 EXCEPTION
    WHEN OTHERS THEN
        vgErrCode := SQLCODE;
        vgErrMsg := SQLERRM;
        RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PAWEBUNIFORMESCOMERCIO2.FNINFORMACIONDESCUENTO": ' || vgErrMsg);          

 END FNINFORMACIONDESCUENTO;
 
 PROCEDURE SPGUARDACONFIRMACIONENTREGA(
    paConfirmacionesEntrega IN UNIFORMES.TYPEARRCONFIRMACIONENTREGA,
    paNoConfirmaciones OUT NUMBER )
 IS
 vlIdBitacora 	 UNIFORMES.TABITACORASOLICITUD.FIIDBITACORA%TYPE;
   
  /************************************************************************************************************
    Proyecto:              Uniformes Comercio V2
    Descripcion:           Agrega a la tabla TABITACORASOLICITUD y actualiza TAPEDIDOSCD
    Parametros de entrada: TYPARRAY
    Parametros de salida:  Respuesta del Stored Procedure
    Parametros de ent-sal: No aplica
    Valor de retorno:      No aplica 
    Creador:               Luis Daniel Rodriguez Garcia
    Fecha de creacion:     11 Enero de 2017
 *************************************************************************************************************/   
 BEGIN
    FOR indice IN 1..paConfirmacionesEntrega.count
        LOOP
            BEGIN
		    	SELECT NVL(MAX(FIIDBITACORA), csgCero) + 1 
		    	  INTO vlIdBitacora
		    	  FROM UNIFORMES.TABITACORASOLICITUD;
            END;
            INSERT INTO UNIFORMES.TABITACORASOLICITUD(
                FIIDBITACORA,
                FIFOLIOSOLICITUD,
                FIIDDETALLE,
                FIPAIS,
                FICANAL,
                FIIDSUCURSAL,
                FINUMPEDIDO,
                FISKU,
                FIIDTIPOEVENTO,
                FXDATOS,
                FIIDESTATUSANT,
                FIIDESTATUSNVO,
                FDFECHAEVENTO,
                FIIDERROR,
                FCCOMENTARIOS
            ) VALUES (
                    vlIdBitacora,
                    paConfirmacionesEntrega(indice).FIFOLIOSOLICITUD,
                    paConfirmacionesEntrega(indice).FIIDDETALLE,
                    paConfirmacionesEntrega(indice).FIPAIS,
                    paConfirmacionesEntrega(indice).FICANAL,
                    paConfirmacionesEntrega(indice).FIIDSUCURSAL,
                    paConfirmacionesEntrega(indice).FINUMPEDIDO,
                    paConfirmacionesEntrega(indice).FISKU,
                    paConfirmacionesEntrega(indice).FIIDTIPOEVENTO,
                    CONCAT(CONCAT('<?xml version="1.0"?><INFORMACION>',paConfirmacionesEntrega(indice).FCDATOS),'</INFORMACION>'),
                    paConfirmacionesEntrega(indice).FIIDESTATUSANT,
                    paConfirmacionesEntrega(indice).FIIDESTATUSNVO,
                    SYSDATE,
                    paConfirmacionesEntrega(indice).FIERROR,   
                    paConfirmacionesEntrega(indice).FCCOMENTARIOS                 
                );
                
            UPDATE UNIFORMES.TAPEDIDOSCD 
                SET FIIDESTATUSPEDIDO = paConfirmacionesEntrega(indice).FIIDESTATUSNVO 
            WHERE FIPAIS = paConfirmacionesEntrega(indice).FIPAIS
                AND FICANAL = paConfirmacionesEntrega(indice).FICANAL
                AND FIIDSUCURSAL = paConfirmacionesEntrega(indice).FIIDSUCURSAL
                AND FIPEDIDO = paConfirmacionesEntrega(indice).FINUMPEDIDO
                AND FISKU = paConfirmacionesEntrega(indice).FISKU;
    END LOOP;
    
    COMMIT;
    
    paNoConfirmaciones := paConfirmacionesEntrega.count;
    
    EXCEPTION
        WHEN OTHERS THEN
              ROLLBACK;
              vgErrCode := SQLCODE;
              vgErrMsg := SQLERRM;
              RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' "PAWEBUNIFORMESCOMERCIO2.SPCONFIRMAENTREGA": ' || vgErrMsg );
    
 
 END SPGUARDACONFIRMACIONENTREGA;

END PAWEBUNIFORMESCOMERCIO2;

