CREATE OR REPLACE PACKAGE        UNIFORMES.PAPLUNIFORMESCOMERCIO
AS
  /*************************************************************
  Proyecto:                       Uniformes Comercio
  Descripcion:                    Paquete para la migracion de Uniformes Comercio.
  Parametros de entrada:          No aplica
  Parametros de salida:           No aplica
  Parametros de entrada-salida    No aplica
  Precondiciones:                 Tener creado el esquema
  Creador:                        
  Fecha de creacion:              
  *************************************************************/
 TYPE rcgCursor IS REF CURSOR;

 PROCEDURE SPACTSOLGENERADAS(
    paTiendas   sys.odcinumberlist,
    paNoDiasAnteriores  NUMBER);

 PROCEDURE SPACTSOLTIENDA(
    paTiendas   sys.odcinumberlist,
    paNoDiasAnteriores  NUMBER);
    
 PROCEDURE SPACTSOLRECIBIDOTIENDA(
    paTiendas   sys.odcinumberlist,
    paNoDiasAnteriores  NUMBER);   
    
 FUNCTION FNESTATUSSOLICITUD(
    paEstatus             UNIFORMES.TADETALLEPEDIDOS.FIESTATUS%TYPE)
 RETURN NUMBER;

 FUNCTION FNTIPOSOLICITUD(
    paNoTipo    UNIFORMES.TAPEDIDOS.FITIPO%TYPE)
 RETURN NUMBER; 

 FUNCTION FNTIPONEGOCIO(
    paNoCanal   UNIFORMES.TATIENDAS.FICANAL%TYPE)
 RETURN NUMBER;

 FUNCTION FNPRECIOTOTALPRENDA(
    paNoTipo    UNIFORMES.TAPEDIDOS.FITIPO%TYPE,
    paCosto     UNIFORMES.TADETALLEPEDIDOS.FNCOSTO%TYPE)
 RETURN NUMBER;

 FUNCTION FNTIPOPRENDA(
    paNoTipoProducto    UNIFORMES.TAPRODUCTOS.FITIPO%TYPE)
 RETURN NUMBER;

 FUNCTION FNGENERAFOLIOSOLICITUD
 RETURN NUMBER; 

 FUNCTION FNGENERAIDDETALLE
 RETURN NUMBER;

END PAPLUNIFORMESCOMERCIO;

CREATE OR REPLACE PACKAGE BODY    UNIFORMES.PAPLUNIFORMESCOMERCIO
AS
  /*************************************************************
  Proyecto:                       Uniformes Comercio
  Descripcion:                    Paquete para la migracion de Uniformes Comercio.
  Parametros de entrada:          No aplica
  Parametros de salida:           No aplica
  Parametros de entrada-salida    No aplica
  Precondiciones:                 Tener creado el esquema
  Creador:                        
  Fecha de creacion:              
  *************************************************************/
    csgCero                     CONSTANT NUMBER(1):=0;  
    csgUno                      CONSTANT NUMBER(1):=1;  
    csgDos                      CONSTANT NUMBER(1):=2;  
    csgTres                     CONSTANT NUMBER(1):=3; 
    csgCuatro                   CONSTANT NUMBER(1):=4;
    csgCinco                    CONSTANT NUMBER(1):=5;
    csgSeis                     CONSTANT NUMBER(1):=6;
    csgCancelado                CONSTANT NUMBER(1):=0;  -- Cancelado
    csgSolicitudGenerada        CONSTANT NUMBER(1):=1;  -- Solicitud Generada
    csgSolicitadoTienda         CONSTANT NUMBER(1):=2;  -- Solicitado en Tienda
    csgSolicitadoCD             CONSTANT NUMBER(1):=3;  -- Solicitado en CD
    csgAtendidoCD               CONSTANT NUMBER(1):=4;  -- Atendido en CD
    csgCaminoTienda             CONSTANT NUMBER(1):=5;  -- En camino a Tienda
    csgRecibidoTiendaSol        CONSTANT NUMBER(1):=6;  -- Recibido en Tienda
    csgEntregado                CONSTANT NUMBER(1):=7;  -- Entregado
    csgDescuentoSAP             CONSTANT NUMBER(1):=8;  -- Descuento SAP
    csgDescuentoSPPI            CONSTANT NUMBER(1):=9;  -- Descuento SPPI
    csgEstMigrado               CONSTANT NUMBER(3):=999;  -- MIGRADO
    csgRutaDef				    CONSTANT NUMBER(2):=-1;  
    csgRegistrado               CONSTANT NUMBER(1):=0;
    csgAutorizadoRH             CONSTANT NUMBER(2):=10;
    csgPreAutorizadoCD          CONSTANT NUMBER(2):=15;
    csgAutorizadoCD             CONSTANT NUMBER(2):=20;
    csgEnviadoTienda            CONSTANT NUMBER(2):=30;
    csgEnviadoAbasto            CONSTANT NUMBER(2):=40;
    csgAbastoEnviaCD            CONSTANT NUMBER(2):=60;
    csgAbastoEnviaTienda        CONSTANT NUMBER(2):=70;
    csgRecibidoTienda           CONSTANT NUMBER(2):=80;
    
 PROCEDURE SPACTSOLGENERADAS(
    paTiendas   sys.odcinumberlist,
    paNoDiasAnteriores  NUMBER)
 IS
 /*************************************************************
    Proyecto:                         Uniformes Comercio
    Descripcion:                      Actualiza la tabla TASOLICITUDES Y TAPEDIDOS [0,10,15,20]
    Parametros de entrada:            Tiendas y Numero de dias de la migracion
    Parametros de salida:             No aplica
    Parametros de entrada-salida      No aplica
    Precondiciones:                   Tener creado el esquema
    Creador:                          Luis Daniel Rodriguez Garcia
    Fecha de creacion:                13 de Abril del 2017
 *************************************************************/   
 vlFolioSolicitud   UNIFORMES.TASOLICITUDES.FIFOLIOSOLICITUD%TYPE;
 vlIDDetalle        UNIFORMES.TASOLICITUDESDETALLE.FIIDDETALLE%TYPE;
 CURSOR curSolicitudes IS  (SELECT  P.FIFOLIOCENTRAL,
                                    P.FIEMPLEADO AS FIIDEMPLEADO,
                                    UNIFORMES.PAPLUNIFORMESCOMERCIO.FNTIPOSOLICITUD(P.FITIPO) AS FIIDTIPOSOLICITUD,
                                    UNIFORMES.PAPLUNIFORMESCOMERCIO.FNTIPONEGOCIO(T.FICANAL) AS FIIDNEGOCIO,
                                    P.FIFUNCION AS FIFUNCIONSAP,
                                    P.FIEMPLEADOSOLICITA AS FIIDEMPCAPTURA,
                                    P.FDREGISTRO AS FDFECHACAPTURA
                            FROM UNIFORMES.TATIENDAS T
                            INNER JOIN (    SELECT DISTINCT B.FIFOLIOCENTRAL, --CONSULTA LAS SOLICITUDES QUE NO ESTAN REMISIONADAS Y ACTUALES
                                                    B.FISUCURSAL,
                                                    B.FIESTATUS
                                            FROM UNIFORMES.TAREMISIONES A --TABLA A
                                            RIGHT JOIN UNIFORMES.TADETALLEPEDIDOS B --TABLA B
                                                ON  A.FICANAL = B.FICANAL AND
                                                    A.FIPAIS = B.FIPAIS AND
                                                    A.FISUCURSAL = B.FISUCURSAL AND
                                                    A.FISKU = B.FISKU AND
                                                    A.FIPEDIDO = B.FIPEDIDO AND
                                                    A.FIFOLIOCENTRAL = B.FIFOLIOCENTRAL
                                            WHERE   A.FIREMISION IS NULL) DP
                                ON  DP.FISUCURSAL = T.FISUCURSAL     
                            INNER JOIN UNIFORMES.TAPEDIDOS P
                                ON  P.FIFOLIOCENTRAL = DP.FIFOLIOCENTRAL
                            INNER JOIN UNIFORMES.TAEMPLEADOS E
                                ON  E.FIEMPLEADO = P.FIEMPLEADO AND 
                                    SUBSTR(TRIM(TO_CHAR(E.FICECO)), csgTres, csgCuatro) = DP.FISUCURSAL -- VALIDACION SUCURSAL ACTUAL Y ANTERIOR
                            INNER JOIN UNIFORMES.TAFUNCIONESXNEGOCIO FXN
                                ON  FXN.FIFUNCIONSAP = E.FIFUNCION AND --FUNCION ESTE EN EL RANGO DE FUNCIONES
                                    FXN.FIIDNEGOCIO = UNIFORMES.PAPLUNIFORMESCOMERCIO.FNTIPONEGOCIO(T.FICANAL) --MISMO TIPO DE NEGOCIO
                            WHERE   P.FDREGISTRO >= TRUNC(SYSDATE - paNoDiasAnteriores) AND --DIAS ANTERIORES
                                    UNIFORMES.PASRVUNIFORMESCOMERCIO.FNEMPLEADOACTIVO(P.FIEMPLEADO) = csgUno AND --EMPLEADO ACTIVO
                                    T.FISUCURSAL IN (SELECT * FROM TABLE(paTiendas))  AND --SUCURSALES
                                    P.FDREGISTRO >= E.FDANTERIOR AND --VALIDACION DE USUARIO 
                                    DP.FIESTATUS IN (csgRegistrado,csgAutorizadoRH,csgPreAutorizadoCD,csgAutorizadoCD)); --ESTATUS
                                    
 CURSOR curSolicitudesDetalle IS         (   SELECT     DP.FIFOLIOCENTRAL,
                                                        DP.FIPAIS,
                                                        DP.FICANAL,
                                                        DP.FISUCURSAL,
                                                        DP.FIPEDIDO,
                                                        csgCero AS FISKU,
                                                        UNIFORMES.PAPLUNIFORMESCOMERCIO.FNTIPOPRENDA(PROD.FITIPO) AS FIIDTIPOPRENDA,
                                                        PROD.FITALLA,
                                                        DP.FICANTIDAD,
                                                        DP.FNCOSTO AS FNPRECIOUNITARIO,
                                                        UNIFORMES.PAPLUNIFORMESCOMERCIO.FNPRECIOTOTALPRENDA(P.FITIPO,DP.FNCOSTO) AS FNPRECIOTOTAL,
                                                        UNIFORMES.PAPLUNIFORMESCOMERCIO.FNESTATUSSOLICITUD(DP.FIESTATUS) AS FIESTATUSSOL,
                                                        csgCero AS FIESTATUSCD,
                                                        DP.FIESTATUS AS FIESTATUS,
                                                        DP.FDACTUALIZACION AS FDFECHAACT,
                                                        csgUno AS FIACTIVO,
                                                        csgCero AS FIRUTA,
                                                        ' ' AS FCMENSAJECD,
                                                        csgCero AS FIREINYECTA
                                                FROM UNIFORMES.TAPEDIDOS P
                                                INNER JOIN UNIFORMES.TADETALLEPEDIDOS DP 
                                                    ON P.FIFOLIOCENTRAL = DP.FIFOLIOCENTRAL
                                                INNER JOIN UNIFORMES.TAPRODUCTOS PROD
                                                    ON PROD.FISKU = DP.FISKU
                                                WHERE   P.FDREGISTRO >= TRUNC(SYSDATE-paNoDiasAnteriores) AND --DIAS ANTERIORES
                                                        UNIFORMES.PASRVUNIFORMESCOMERCIO.FNEMPLEADOACTIVO(P.FIEMPLEADO) = csgUno AND --EMPLEADO ACTIVO
                                                        DP.FISUCURSAL IN (SELECT * FROM TABLE(paTiendas)) AND --SUCURSALES
                                                        DP.FIESTATUS IN (csgRegistrado,csgAutorizadoRH,csgPreAutorizadoCD,csgAutorizadoCD)); --ESTATUS          
 BEGIN
    FOR solicitud IN curSolicitudes LOOP
        vlFolioSolicitud := UNIFORMES.PAPLUNIFORMESCOMERCIO.FNGENERAFOLIOSOLICITUD;
        INSERT INTO UNIFORMES.TASOLICITUDES(
            FIFOLIOSOLICITUD,
            FIIDEMPLEADO,
            FIIDTIPOSOLICITUD,
            FIIDNEGOCIO,
            FIFUNCIONSAP,
            FIIDEMPCAPTURA,
            FDFECHACAPTURA
        )VALUES(
            vlFolioSolicitud,
            solicitud.FIIDEMPLEADO,
            solicitud.FIIDTIPOSOLICITUD,
            solicitud.FIIDNEGOCIO,
            solicitud.FIFUNCIONSAP,
            solicitud.FIIDEMPCAPTURA,
            solicitud.FDFECHACAPTURA
        );
        UPDATE UNIFORMES.TAPEDIDOS
            SET FIESTADOGENERAL = csgCuatro
        WHERE FIFOLIOCENTRAL = solicitud.FIFOLIOCENTRAL;
        
        FOR solicitudDetalle IN curSolicitudesDetalle LOOP
            IF solicitud.FIFOLIOCENTRAL = solicitudDetalle.FIFOLIOCENTRAL THEN
            vlIDDetalle := UNIFORMES.PAPLUNIFORMESCOMERCIO.FNGENERAIDDETALLE;
                INSERT INTO UNIFORMES.TASOLICITUDESDETALLE(
                    FIFOLIOSOLICITUD,
                    FIIDDETALLE,
                    FIPAIS,
                    FICANAL,
                    FISUCURSAL,
                    FIPEDIDO,
                    FISKU,
                    FIIDTIPOPRENDA,
                    FITALLA,
                    FICANTIDAD,
                    FNPRECIOUNITARIO,
                    FNPRECIOTOTAL,
                    FIESTATUSSOL,
                    FIESTATUSCD,
                    FDFECHAACT,
                    FIACTIVO,
                    FIRUTA,
                    FCMENSAJECD,
                    FIREINYECTA
                )VALUES(
                    vlFolioSolicitud,
                    vlIDDetalle,
                    solicitudDetalle.FIPAIS,
                    solicitudDetalle.FICANAL,
                    solicitudDetalle.FISUCURSAL,
                    solicitudDetalle.FIPEDIDO,
                    solicitudDetalle.FISKU,
                    solicitudDetalle.FIIDTIPOPRENDA,
                    solicitudDetalle.FITALLA,
                    solicitudDetalle.FICANTIDAD,
                    solicitudDetalle.FNPRECIOUNITARIO,
                    solicitudDetalle.FNPRECIOTOTAL,
                    solicitudDetalle.FIESTATUSSOL,
                    solicitudDetalle.FIESTATUSCD,
                    solicitudDetalle.FDFECHAACT,
                    solicitudDetalle.FIACTIVO,
                    solicitudDetalle.FIRUTA,
                    solicitudDetalle.FCMENSAJECD,
                    solicitudDetalle.FIREINYECTA
                );
                UPDATE UNIFORMES.TADETALLEPEDIDOS
                    SET FIESTATUS = csgEstMigrado
                WHERE FIFOLIOCENTRAL = solicitudDetalle.FIFOLIOCENTRAL;   
                UNIFORMES.PAWEBUNIFORMESCOMERCIO.SPGUARDABITACORA(
                    vlFolioSolicitud,
                    vlIDDetalle,
                    solicitudDetalle.FIPEDIDO,                  
                    ' ',
                    solicitudDetalle.FIESTATUSSOL-csgUno,
                    solicitudDetalle.FIESTATUSSOL,
                    'FOLIOCENTRAL:' || 
                    TO_CHAR(solicitudDetalle.FIFOLIOCENTRAL) || 
                    ',FOLIOSOLICITUD:' ||
                    TO_CHAR(vlFolioSolicitud) ||
                    ',ESTATUSMIGRACION:' || 
                    TO_CHAR(solicitudDetalle.FIESTATUS) ,
                    csgCero);
            END IF;
        END LOOP;
    END LOOP;
    COMMIT;
 END SPACTSOLGENERADAS;

 PROCEDURE SPACTSOLTIENDA(
    paTiendas   sys.odcinumberlist,
    paNoDiasAnteriores  NUMBER)
 IS
 /*************************************************************
    Proyecto:                         Uniformes Comercio
    Descripcion:                      Actualiza la tabla TASOLICITUDES Y TAPEDIDOS [0,10,15,20]
    Parametros de entrada:            Tiendas y Numero de dias de la migracion
    Parametros de salida:             No aplica
    Parametros de entrada-salida      No aplica
    Precondiciones:                   Tener creado el esquema
    Creador:                          Luis Daniel Rodriguez Garcia
    Fecha de creacion:                13 de Abril del 2017
 *************************************************************/   
 vlFolioSolicitud   UNIFORMES.TASOLICITUDES.FIFOLIOSOLICITUD%TYPE;
 vlIDDetalle        UNIFORMES.TASOLICITUDESDETALLE.FIIDDETALLE%TYPE;
 CURSOR curSolicitudes IS  (SELECT  P.FIFOLIOCENTRAL,
                                    P.FIEMPLEADO AS FIIDEMPLEADO,
                                    UNIFORMES.PAPLUNIFORMESCOMERCIO.FNTIPOSOLICITUD(P.FITIPO) AS FIIDTIPOSOLICITUD,
                                    UNIFORMES.PAPLUNIFORMESCOMERCIO.FNTIPONEGOCIO(T.FICANAL) AS FIIDNEGOCIO,
                                    P.FIFUNCION AS FIFUNCIONSAP,
                                    P.FIEMPLEADOSOLICITA AS FIIDEMPCAPTURA,
                                    P.FDREGISTRO AS FDFECHACAPTURA
                            FROM UNIFORMES.TATIENDAS T
                            INNER JOIN (    SELECT DISTINCT B.FIFOLIOCENTRAL, --CONSULTA LAS SOLICITUDES QUE NO ESTAN REMISIONADAS Y ACTUALES
                                                    B.FISUCURSAL,
                                                    B.FIESTATUS,
                                                    B.FIPEDIDO,
                                                    B.FISKU
                                            FROM UNIFORMES.TAREMISIONES A --TABLA A
                                            RIGHT JOIN UNIFORMES.TADETALLEPEDIDOS B --TABLA B
                                                ON  A.FICANAL = B.FICANAL AND
                                                    A.FIPAIS = B.FIPAIS AND
                                                    A.FISUCURSAL = B.FISUCURSAL AND
                                                    A.FISKU = B.FISKU AND
                                                    A.FIPEDIDO = B.FIPEDIDO AND
                                                    A.FIFOLIOCENTRAL = B.FIFOLIOCENTRAL
                                            WHERE   A.FIREMISION IS NULL) DP
                                ON  DP.FISUCURSAL = T.FISUCURSAL     
                            INNER JOIN UNIFORMES.TAPEDIDOS P
                                ON  P.FIFOLIOCENTRAL = DP.FIFOLIOCENTRAL
                            INNER JOIN UNIFORMES.TAEMPLEADOS E
                                ON  E.FIEMPLEADO = P.FIEMPLEADO AND 
                                    SUBSTR(TRIM(TO_CHAR(E.FICECO)), csgTres, csgCuatro) = DP.FISUCURSAL -- VALIDACION SUCURSAL ACTUAL Y ANTERIOR
                            INNER JOIN UNIFORMES.TAFUNCIONESXNEGOCIO FXN
                                ON  FXN.FIFUNCIONSAP = E.FIFUNCION AND --FUNCION ESTE EN EL RANGO DE FUNCIONES
                                    FXN.FIIDNEGOCIO = UNIFORMES.PAPLUNIFORMESCOMERCIO.FNTIPONEGOCIO(T.FICANAL) --MISMO TIPO DE NEGOCIO
                            WHERE   P.FDREGISTRO >= TRUNC(SYSDATE - paNoDiasAnteriores) AND --DIAS ANTERIORES
                                    UNIFORMES.PASRVUNIFORMESCOMERCIO.FNEMPLEADOACTIVO(P.FIEMPLEADO) = csgUno AND --EMPLEADO ACTIVO
                                    T.FISUCURSAL IN (SELECT * FROM TABLE(paTiendas))  AND --SUCURSALES
                                    P.FDREGISTRO >= E.FDANTERIOR AND --VALIDACION DE USUARIO
                                    DP.FISKU > csgCero AND -- CONTENGA FISKU
                                    DP.FIPEDIDO > csgCero AND -- CONTENGA PEDIDO
                                    DP.FIESTATUS IN (csgEnviadoTienda,csgEnviadoAbasto,csgAbastoEnviaCD,csgAbastoEnviaTienda)); --ESTATUS
                                    
 CURSOR curSolicitudesDetalle IS         (   SELECT     DP.FIFOLIOCENTRAL,
                                                        DP.FIPAIS,
                                                        DP.FICANAL,
                                                        DP.FISUCURSAL,
                                                        DP.FIPEDIDO,
                                                        DP.FISKU,
                                                        UNIFORMES.PAPLUNIFORMESCOMERCIO.FNTIPOPRENDA(PROD.FITIPO) AS FIIDTIPOPRENDA,
                                                        PROD.FITALLA,
                                                        DP.FICANTIDAD,
                                                        DP.FNCOSTO AS FNPRECIOUNITARIO,
                                                        UNIFORMES.PAPLUNIFORMESCOMERCIO.FNPRECIOTOTALPRENDA(P.FITIPO,DP.FNCOSTO) AS FNPRECIOTOTAL,
                                                        UNIFORMES.PAPLUNIFORMESCOMERCIO.FNESTATUSSOLICITUD(DP.FIESTATUS) AS FIESTATUSSOL,
                                                        csgCero AS FIESTATUSCD,
                                                        DP.FIESTATUS AS FIESTATUS,
                                                        DP.FDACTUALIZACION AS FDFECHAACT,
                                                        csgUno AS FIACTIVO,
                                                        csgRutaDef AS FIRUTA,
                                                        ' ' AS FCMENSAJECD,
                                                        csgCero AS FIREINYECTA
                                                FROM UNIFORMES.TAPEDIDOS P
                                                INNER JOIN UNIFORMES.TADETALLEPEDIDOS DP 
                                                    ON P.FIFOLIOCENTRAL = DP.FIFOLIOCENTRAL
                                                INNER JOIN UNIFORMES.TAPRODUCTOS PROD
                                                    ON PROD.FISKU = DP.FISKU
                                                WHERE   P.FDREGISTRO >= TRUNC(SYSDATE - paNoDiasAnteriores) AND --DIAS ANTERIORES
                                                        UNIFORMES.PASRVUNIFORMESCOMERCIO.FNEMPLEADOACTIVO(P.FIEMPLEADO) = csgUno AND --EMPLEADO ACTIVO
                                                        DP.FISUCURSAL IN (SELECT * FROM TABLE(paTiendas)) AND --SUCURSALES
                                                        DP.FISKU > csgCero AND --CONTENGA SKU
                                                        DP.FIPEDIDO > csgCero AND --CONTENGA PEDIDO
                                                        DP.FIESTATUS IN (csgEnviadoTienda,csgEnviadoAbasto,csgAbastoEnviaCD,csgAbastoEnviaTienda)); --ESTATUS          
 BEGIN
    FOR solicitud IN curSolicitudes LOOP
        vlFolioSolicitud := UNIFORMES.PAPLUNIFORMESCOMERCIO.FNGENERAFOLIOSOLICITUD;
        INSERT INTO UNIFORMES.TASOLICITUDES(
            FIFOLIOSOLICITUD,
            FIIDEMPLEADO,
            FIIDTIPOSOLICITUD,
            FIIDNEGOCIO,
            FIFUNCIONSAP,
            FIIDEMPCAPTURA,
            FDFECHACAPTURA
        )VALUES(
            vlFolioSolicitud,
            solicitud.FIIDEMPLEADO,
            solicitud.FIIDTIPOSOLICITUD,
            solicitud.FIIDNEGOCIO,
            solicitud.FIFUNCIONSAP,
            solicitud.FIIDEMPCAPTURA,
            solicitud.FDFECHACAPTURA
        );
        UPDATE UNIFORMES.TAPEDIDOS
            SET FIESTADOGENERAL = csgCuatro
        WHERE FIFOLIOCENTRAL = solicitud.FIFOLIOCENTRAL;
        
        FOR solicitudDetalle IN curSolicitudesDetalle LOOP
            IF solicitud.FIFOLIOCENTRAL = solicitudDetalle.FIFOLIOCENTRAL THEN
            vlIDDetalle := UNIFORMES.PAPLUNIFORMESCOMERCIO.FNGENERAIDDETALLE;
                INSERT INTO UNIFORMES.TASOLICITUDESDETALLE(
                    FIFOLIOSOLICITUD,
                    FIIDDETALLE,
                    FIPAIS,
                    FICANAL,
                    FISUCURSAL,
                    FIPEDIDO,
                    FISKU,
                    FIIDTIPOPRENDA,
                    FITALLA,
                    FICANTIDAD,
                    FNPRECIOUNITARIO,
                    FNPRECIOTOTAL,
                    FIESTATUSSOL,
                    FIESTATUSCD,
                    FDFECHAACT,
                    FIACTIVO,
                    FIRUTA,
                    FCMENSAJECD,
                    FIREINYECTA
                )VALUES(
                    vlFolioSolicitud,
                    vlIDDetalle,
                    solicitudDetalle.FIPAIS,
                    solicitudDetalle.FICANAL,
                    solicitudDetalle.FISUCURSAL,
                    solicitudDetalle.FIPEDIDO,
                    solicitudDetalle.FISKU,
                    solicitudDetalle.FIIDTIPOPRENDA,
                    solicitudDetalle.FITALLA,
                    solicitudDetalle.FICANTIDAD,
                    solicitudDetalle.FNPRECIOUNITARIO,
                    solicitudDetalle.FNPRECIOTOTAL,
                    solicitudDetalle.FIESTATUSSOL,
                    solicitudDetalle.FIESTATUSCD,
                    solicitudDetalle.FDFECHAACT,
                    solicitudDetalle.FIACTIVO,
                    solicitudDetalle.FIRUTA,
                    solicitudDetalle.FCMENSAJECD,
                    solicitudDetalle.FIREINYECTA
                );
                UPDATE UNIFORMES.TADETALLEPEDIDOS
                    SET FIESTATUS = csgEstMigrado
                WHERE FIFOLIOCENTRAL = solicitudDetalle.FIFOLIOCENTRAL;   
                UNIFORMES.PAWEBUNIFORMESCOMERCIO.SPGUARDABITACORA(
                    vlFolioSolicitud,
                    vlIDDetalle,
                    solicitudDetalle.FIPEDIDO,                  
                    ' ',
                    solicitudDetalle.FIESTATUSSOL - csgUno,
                    solicitudDetalle.FIESTATUSSOL,
                    'FOLIOCENTRAL:' || 
                    TO_CHAR(solicitudDetalle.FIFOLIOCENTRAL) || 
                    ',FOLIOSOLICITUD:' ||
                    TO_CHAR(vlFolioSolicitud) ||
                    ',ESTATUSMIGRACION:' || 
                    TO_CHAR(solicitudDetalle.FIESTATUS) ,
                    csgCero);
            END IF;
        END LOOP;
    END LOOP;
    COMMIT;
 END SPACTSOLTIENDA;
 
 PROCEDURE SPACTSOLRECIBIDOTIENDA(
    paTiendas   sys.odcinumberlist,
    paNoDiasAnteriores  NUMBER)
 IS
 /*************************************************************
    Proyecto:                         Uniformes Comercio
    Descripcion:                      Actualiza la tabla TASOLICITUDES Y TAPEDIDOS [0,10,15,20]
    Parametros de entrada:            Tiendas y Numero de dias de la migracion
    Parametros de salida:             No aplica
    Parametros de entrada-salida      No aplica
    Precondiciones:                   Tener creado el esquema
    Creador:                          Luis Daniel Rodriguez Garcia
    Fecha de creacion:                13 de Abril del 2017
 *************************************************************/   
 vlFolioSolicitud   UNIFORMES.TASOLICITUDES.FIFOLIOSOLICITUD%TYPE;
 vlIDDetalle        UNIFORMES.TASOLICITUDESDETALLE.FIIDDETALLE%TYPE;
 CURSOR curSolicitudes IS  (SELECT  P.FIFOLIOCENTRAL,
                                    P.FIEMPLEADO AS FIIDEMPLEADO,
                                    UNIFORMES.PAPLUNIFORMESCOMERCIO.FNTIPOSOLICITUD(P.FITIPO) AS FIIDTIPOSOLICITUD,
                                    UNIFORMES.PAPLUNIFORMESCOMERCIO.FNTIPONEGOCIO(T.FICANAL) AS FIIDNEGOCIO,
                                    P.FIFUNCION AS FIFUNCIONSAP,
                                    P.FIEMPLEADOSOLICITA AS FIIDEMPCAPTURA,
                                    P.FDREGISTRO AS FDFECHACAPTURA                                  
                            FROM UNIFORMES.TATIENDAS T
                            INNER JOIN (    SELECT DISTINCT B.FIFOLIOCENTRAL, --CONSULTA LAS SOLICITUDES QUE ESTAN REMISIONADAS Y ACTUALES
                                                    B.FISUCURSAL,
                                                    B.FIESTATUS,
                                                    B.FIPEDIDO,
                                                    B.FISKU
                                            FROM UNIFORMES.TAREMISIONES A --TABLA A
                                            INNER JOIN UNIFORMES.TADETALLEPEDIDOS B --TABLA B
                                                ON  A.FICANAL = B.FICANAL AND
                                                    A.FIPAIS = B.FIPAIS AND
                                                    A.FISUCURSAL = B.FISUCURSAL AND
                                                    A.FISKU = B.FISKU AND
                                                    A.FIPEDIDO = B.FIPEDIDO AND
                                                    A.FIFOLIOCENTRAL = B.FIFOLIOCENTRAL) DP
                                ON  DP.FISUCURSAL = T.FISUCURSAL     
                            INNER JOIN UNIFORMES.TAPEDIDOS P
                                ON  P.FIFOLIOCENTRAL = DP.FIFOLIOCENTRAL
                            INNER JOIN UNIFORMES.TAEMPLEADOS E
                                ON  E.FIEMPLEADO = P.FIEMPLEADO AND 
                                    SUBSTR(TRIM(TO_CHAR(E.FICECO)), csgTres, csgCuatro) = DP.FISUCURSAL -- VALIDACION SUCURSAL ACTUAL Y ANTERIOR
                            INNER JOIN UNIFORMES.TAFUNCIONESXNEGOCIO FXN
                                ON  FXN.FIFUNCIONSAP = E.FIFUNCION AND --FUNCION ESTE EN EL RANGO DE FUNCIONES
                                    FXN.FIIDNEGOCIO = UNIFORMES.PAPLUNIFORMESCOMERCIO.FNTIPONEGOCIO(T.FICANAL) --MISMO TIPO DE NEGOCIO
                            WHERE   P.FDREGISTRO >= TRUNC(SYSDATE - paNoDiasAnteriores) AND --DIAS ANTERIORES
                                    UNIFORMES.PASRVUNIFORMESCOMERCIO.FNEMPLEADOACTIVO(P.FIEMPLEADO) = csgUno AND --EMPLEADO ACTIVO
                                    T.FISUCURSAL IN (SELECT * FROM TABLE(paTiendas))  AND --SUCURSALES
                                    P.FDREGISTRO >= E.FDANTERIOR AND --VALIDACION DE USUARIO
                                    DP.FISKU > csgCero AND -- CONTENGA FISKU
                                    DP.FIPEDIDO > csgCero AND -- CONTENGA PEDIDO
                                    DP.FIESTATUS IN (csgRecibidoTienda)); --ESTATUS
                                    
 CURSOR curSolicitudesDetalleXRemision IS(   SELECT     DP.FIFOLIOCENTRAL,
                                                        DP.FIPAIS,
                                                        DP.FICANAL,
                                                        DP.FISUCURSAL,
                                                        DP.FIPEDIDO,
                                                        DP.FISKU,
                                                        UNIFORMES.PAPLUNIFORMESCOMERCIO.FNTIPOPRENDA(PROD.FITIPO) AS FIIDTIPOPRENDA,
                                                        PROD.FITALLA,
                                                        DP.FICANTIDAD,
                                                        DP.FNCOSTO AS FNPRECIOUNITARIO,
                                                        UNIFORMES.PAPLUNIFORMESCOMERCIO.FNPRECIOTOTALPRENDA(P.FITIPO,DP.FNCOSTO) AS FNPRECIOTOTAL,
                                                        UNIFORMES.PAPLUNIFORMESCOMERCIO.FNESTATUSSOLICITUD(DP.FIESTATUS) AS FIESTATUSSOL,
                                                        csgCero AS FIESTATUSCD,
                                                        DP.FIESTATUS AS FIESTATUS,
                                                        DP.FDACTUALIZACION AS FDFECHAACT,
                                                        csgUno AS FIACTIVO,
                                                        csgRutaDef AS FIRUTA,
                                                        ' ' AS FCMENSAJECD,
                                                        csgCero AS FIREINYECTA,
                                                        R.FIREMISION AS RFIREMISION,
                                                        R.FICANTIDAD AS RFICANTIDAD,
                                                        R.FIEMPLEADORECIBE AS RFIEMPLEADORECIBE
                                                FROM UNIFORMES.TAPEDIDOS P
                                                INNER JOIN UNIFORMES.TADETALLEPEDIDOS DP
                                                    ON P.FIFOLIOCENTRAL = DP.FIFOLIOCENTRAL                                                
                                                INNER JOIN UNIFORMES.TAREMISIONES R
                                                    ON  R.FICANAL = DP.FICANAL AND
                                                        R.FIPAIS = DP.FIPAIS AND
                                                        R.FISUCURSAL = DP.FISUCURSAL AND
                                                        R.FISKU = DP.FISKU AND
                                                        R.FIPEDIDO = DP.FIPEDIDO AND
                                                        R.FIFOLIOCENTRAL = DP.FIFOLIOCENTRAL
                                                INNER JOIN UNIFORMES.TAPRODUCTOS PROD
                                                    ON PROD.FISKU = DP.FISKU
                                                WHERE   P.FDREGISTRO >= TRUNC(SYSDATE-paNoDiasAnteriores) AND --DIAS ANTERIORES
                                                        UNIFORMES.PASRVUNIFORMESCOMERCIO.FNEMPLEADOACTIVO(P.FIEMPLEADO) = csgUno AND --EMPLEADO ACTIVO
                                                        DP.FISUCURSAL IN (SELECT * FROM TABLE(paTiendas)) AND --SUCURSALES
                                                        DP.FISKU > csgCero AND --CONTENGA SKU
                                                        DP.FIPEDIDO > csgCero AND --CONTENGA PEDIDO
                                                        DP.FIESTATUS IN (csgRecibidoTienda)); --ESTATUS          
 BEGIN
    FOR solicitud IN curSolicitudes LOOP
        vlFolioSolicitud := UNIFORMES.PAPLUNIFORMESCOMERCIO.FNGENERAFOLIOSOLICITUD;
        INSERT INTO UNIFORMES.TASOLICITUDES(
            FIFOLIOSOLICITUD,
            FIIDEMPLEADO,
            FIIDTIPOSOLICITUD,
            FIIDNEGOCIO,
            FIFUNCIONSAP,
            FIIDEMPCAPTURA,
            FDFECHACAPTURA
        )VALUES(
            vlFolioSolicitud,
            solicitud.FIIDEMPLEADO,
            solicitud.FIIDTIPOSOLICITUD,
            solicitud.FIIDNEGOCIO,
            solicitud.FIFUNCIONSAP,
            solicitud.FIIDEMPCAPTURA,
            solicitud.FDFECHACAPTURA
        );
        UPDATE UNIFORMES.TAPEDIDOS
            SET FIESTADOGENERAL = csgCuatro
        WHERE FIFOLIOCENTRAL = solicitud.FIFOLIOCENTRAL;
        
        FOR solicitudDetalleXRemision IN curSolicitudesDetalleXRemision LOOP
            IF solicitud.FIFOLIOCENTRAL = solicitudDetalleXRemision.FIFOLIOCENTRAL THEN
            vlIDDetalle := UNIFORMES.PAPLUNIFORMESCOMERCIO.FNGENERAIDDETALLE;
                INSERT INTO UNIFORMES.TASOLICITUDESDETALLE(
                    FIFOLIOSOLICITUD,
                    FIIDDETALLE,
                    FIPAIS,
                    FICANAL,
                    FISUCURSAL,
                    FIPEDIDO,
                    FISKU,
                    FIIDTIPOPRENDA,
                    FITALLA,
                    FICANTIDAD,
                    FNPRECIOUNITARIO,
                    FNPRECIOTOTAL,
                    FIESTATUSSOL,
                    FIESTATUSCD,
                    FDFECHAACT,
                    FIACTIVO,
                    FIRUTA,
                    FCMENSAJECD,
                    FIREINYECTA
                )VALUES(
                    vlFolioSolicitud,
                    vlIDDetalle,
                    solicitudDetalleXRemision.FIPAIS,
                    solicitudDetalleXRemision.FICANAL,
                    solicitudDetalleXRemision.FISUCURSAL,
                    solicitudDetalleXRemision.FIPEDIDO,
                    solicitudDetalleXRemision.FISKU,
                    solicitudDetalleXRemision.FIIDTIPOPRENDA,
                    solicitudDetalleXRemision.FITALLA,
                    solicitudDetalleXRemision.FICANTIDAD,
                    solicitudDetalleXRemision.FNPRECIOUNITARIO,
                    solicitudDetalleXRemision.FNPRECIOTOTAL,
                    solicitudDetalleXRemision.FIESTATUSSOL,
                    solicitudDetalleXRemision.FIESTATUSCD,
                    solicitudDetalleXRemision.FDFECHAACT,
                    solicitudDetalleXRemision.FIACTIVO,
                    solicitudDetalleXRemision.FIRUTA,
                    solicitudDetalleXRemision.FCMENSAJECD,
                    solicitudDetalleXRemision.FIREINYECTA
                );
                INSERT INTO UNIFORMES.TAREMISIONESXPEDIDO(
                    FIFOLIOSOLICITUD,
                    FIIDDETALLE, 
                    FIPAIS,  
                    FICANAL, 
                    FISUCURSAL, 
                    FIPEDIDO, 
                    FISKU, 
                    FIREMISION, 
                    FICANTIDAD,  
                    FIEMPLEADORECIBE)
                VALUES(
                    vlFolioSolicitud,
                    vlIDDetalle,
                    solicitudDetalleXRemision.FIPAIS,  
                    solicitudDetalleXRemision.FICANAL, 
                    solicitudDetalleXRemision.FISUCURSAL, 
                    solicitudDetalleXRemision.FIPEDIDO, 
                    solicitudDetalleXRemision.FISKU, 
                    solicitudDetalleXRemision.RFIREMISION, 
                    solicitudDetalleXRemision.RFICANTIDAD,  
                    solicitudDetalleXRemision.RFIEMPLEADORECIBE);


                UPDATE UNIFORMES.TADETALLEPEDIDOS
                    SET FIESTATUS = csgEstMigrado
                WHERE FIFOLIOCENTRAL = solicitudDetalleXRemision.FIFOLIOCENTRAL;   
                
                UNIFORMES.PAWEBUNIFORMESCOMERCIO.SPGUARDABITACORA(
                    vlFolioSolicitud,
                    vlIDDetalle,
                    solicitudDetalleXRemision.FIPEDIDO,                  
                    ' ',
                    solicitudDetalleXRemision.FIESTATUSSOL - csgUno,
                    solicitudDetalleXRemision.FIESTATUSSOL,
                    'FOLIOCENTRAL:' || 
                    TO_CHAR(solicitudDetalleXRemision.FIFOLIOCENTRAL) || 
                    ',FOLIOSOLICITUD:' ||
                    TO_CHAR(vlFolioSolicitud) ||
                    ',ESTATUSMIGRACION:' || 
                    TO_CHAR(solicitudDetalleXRemision.FIESTATUS) ,
                    csgCero);
            END IF;
        END LOOP;
    END LOOP;
    COMMIT;
 END SPACTSOLRECIBIDOTIENDA;

 FUNCTION FNESTATUSSOLICITUD(
    paEstatus             UNIFORMES.TADETALLEPEDIDOS.FIESTATUS%TYPE)
 RETURN NUMBER
 IS
  /*************************************************************
    Proyecto:                         Uniformes Comercio
    Descripcion:                      Actualiza la tabla TASOLICITUDES Y TAPEDIDOS [0,10,15,20]
    Parametros de entrada:            Tiendas y Numero de dias de la migracion
    Parametros de salida:             No aplica
    Parametros de entrada-salida      No aplica
    Precondiciones:                   Tener creado el esquema
    Creador:                          Luis Daniel Rodriguez Garcia
    Fecha de creacion:                13 de Abril del 2017
 *************************************************************/
 vlNoEstatusSolicitud       UNIFORMES.TASOLICITUDESDETALLE.FIESTATUSSOL%TYPE;
 vlCancC NUMBER(2):= 50;
 vlCanc NUMBER(3):= 500;
 BEGIN
    IF paEstatus IN (vlCancC,vlCanc) THEN
        vlNoEstatusSolicitud := csgCancelado;
    ELSIF paEstatus IN (csgCero,csgAutorizadoRH,csgPreAutorizadoCD,csgAutorizadoCD ) THEN
        vlNoEstatusSolicitud := csgSolicitudGenerada;
    ELSIF paEstatus IN (csgEnviadoTienda) THEN
        vlNoEstatusSolicitud := csgSolicitadoTienda; 
    ELSIF paEstatus IN (csgEnviadoAbasto) THEN
        vlNoEstatusSolicitud := csgSolicitadoCD; 
    ELSIF paEstatus IN (csgAbastoEnviaCD) THEN
        vlNoEstatusSolicitud := csgAtendidoCD;
    ELSIF paEstatus IN ( csgAbastoEnviaTienda ) THEN
        vlNoEstatusSolicitud := csgCaminoTienda;
    ELSIF paEstatus IN (csgRecibidoTienda ) THEN
        vlNoEstatusSolicitud := csgRecibidoTiendaSol;         
    END IF;
    RETURN vlNoEstatusSolicitud;
 END FNESTATUSSOLICITUD;

 FUNCTION FNTIPOSOLICITUD(
    paNoTipo    UNIFORMES.TAPEDIDOS.FITIPO%TYPE)
 RETURN NUMBER
 IS
  /*************************************************************
    Proyecto:                         Uniformes Comercio
    Descripcion:                      Actualiza la tabla TASOLICITUDES Y TAPEDIDOS [0,10,15,20]
    Parametros de entrada:            Tiendas y Numero de dias de la migracion
    Parametros de salida:             No aplica
    Parametros de entrada-salida      No aplica
    Precondiciones:                   Tener creado el esquema
    Creador:                          Luis Daniel Rodriguez Garcia
    Fecha de creacion:                13 de Abril del 2017
 *************************************************************/
 vlNoEstatusSolicitud       UNIFORMES.TASOLICITUDES.FIIDTIPOSOLICITUD%TYPE;
 BEGIN
 vlNoEstatusSolicitud := (CASE  paNoTipo
                                WHEN csgUno THEN csgDos
                                WHEN csgDos THEN csgUno
                                WHEN csgTres THEN csgTres
                            END);
 RETURN vlNoEstatusSolicitud;
 END FNTIPOSOLICITUD;

 FUNCTION FNTIPONEGOCIO(
    paNoCanal   UNIFORMES.TATIENDAS.FICANAL%TYPE)
 RETURN NUMBER
 IS
  /*************************************************************
    Proyecto:                         Uniformes Comercio
    Descripcion:                      Actualiza la tabla TASOLICITUDES Y TAPEDIDOS [0,10,15,20]
    Parametros de entrada:            Tiendas y Numero de dias de la migracion
    Parametros de salida:             No aplica
    Parametros de entrada-salida      No aplica
    Precondiciones:                   Tener creado el esquema
    Creador:                          Luis Daniel Rodriguez Garcia
    Fecha de creacion:                13 de Abril del 2017
 *************************************************************/
 vlTipoNegocio  UNIFORMES.TANEGOCIOS.FIIDNEGOCIO%TYPE;
 vlEKTRem NUMBER(3):= 125;
 vlDek    NUMBER(2):= 71;
 vlPP     NUMBER(2):= 90;
 
 BEGIN
 vlTipoNegocio :=   (CASE  paNoCanal
                        WHEN csgUno      THEN csgUno
                        WHEN vlEKTRem    THEN csgCuatro
                        WHEN vlDek     THEN csgCinco
                        WHEN vlPP     THEN csgSeis
                        WHEN csgDos      THEN csgTres
                        WHEN csgTres      THEN csgDos
                     END);
 RETURN vlTipoNegocio;
 END FNTIPONEGOCIO;
 
 FUNCTION FNPRECIOTOTALPRENDA(
    paNoTipo    UNIFORMES.TAPEDIDOS.FITIPO%TYPE,
    paCosto     UNIFORMES.TADETALLEPEDIDOS.FNCOSTO%TYPE)
 RETURN NUMBER
 IS
  /*************************************************************
    Proyecto:                         Uniformes Comercio
    Descripcion:                      Actualiza la tabla TASOLICITUDES Y TAPEDIDOS [0,10,15,20]
    Parametros de entrada:            Tiendas y Numero de dias de la migracion
    Parametros de salida:             No aplica
    Parametros de entrada-salida      No aplica
    Precondiciones:                   Tener creado el esquema
    Creador:                          Luis Daniel Rodriguez Garcia
    Fecha de creacion:                13 de Abril del 2017
 *************************************************************/
 vlPrecioTotal  UNIFORMES.TASOLICITUDESDETALLE.FNPRECIOTOTAL%TYPE;
 BEGIN
 vlPrecioTotal :=   (CASE paNoTipo
                            WHEN csgUno THEN paCosto
                            WHEN csgDos THEN csgCero
                            WHEN csgTres THEN csgCero
                     END);
 RETURN vlPrecioTotal;
 END FNPRECIOTOTALPRENDA;
 
 FUNCTION FNTIPOPRENDA(
    paNoTipoProducto    UNIFORMES.TAPRODUCTOS.FITIPO%TYPE)
 RETURN NUMBER
 IS
  /*************************************************************
    Proyecto:                         Uniformes Comercio
    Descripcion:                      Actualiza la tabla TASOLICITUDES Y TAPEDIDOS [0,10,15,20]
    Parametros de entrada:            Tiendas y Numero de dias de la migracion
    Parametros de salida:             No aplica
    Parametros de entrada-salida      No aplica
    Precondiciones:                   Tener creado el esquema
    Creador:                          Luis Daniel Rodriguez Garcia
    Fecha de creacion:                13 de Abril del 2017
 *************************************************************/
 vlTipoPrenda  UNIFORMES.TASOLICITUDESDETALLE.FIIDTIPOPRENDA%TYPE;
 BEGIN
 vlTipoPrenda :=   (CASE paNoTipoProducto
                            WHEN csgUno  THEN csgDos
                            WHEN csgDos  THEN csgTres
                            WHEN csgTres  THEN csgUno
                            WHEN csgCuatro  THEN csgCuatro
                            WHEN csgCinco  THEN csgDos
                            WHEN csgSeis  THEN csgTres
                     END);
 RETURN vlTipoPrenda;
 END FNTIPOPRENDA;
 
 FUNCTION FNGENERAFOLIOSOLICITUD
 RETURN NUMBER
 IS
  /*************************************************************
    Proyecto:                         Uniformes Comercio
    Descripcion:                      Actualiza la tabla TASOLICITUDES Y TAPEDIDOS [0,10,15,20]
    Parametros de entrada:            Tiendas y Numero de dias de la migracion
    Parametros de salida:             No aplica
    Parametros de entrada-salida      No aplica
    Precondiciones:                   Tener creado el esquema
    Creador:                          Luis Daniel Rodriguez Garcia
    Fecha de creacion:                13 de Abril del 2017
 *************************************************************/
 vlFolioSolicitud    UNIFORMES.TASOLICITUDES.FIFOLIOSOLICITUD%TYPE;
 BEGIN 
    SELECT (NVL(MAX(FIFOLIOSOLICITUD), csgCero) + csgUno)
        INTO vlFolioSolicitud
    FROM UNIFORMES.TASOLICITUDES;
 RETURN vlFolioSolicitud;
 END FNGENERAFOLIOSOLICITUD;
 
 FUNCTION FNGENERAIDDETALLE
 RETURN NUMBER
 IS
  /*************************************************************
    Proyecto:                         Uniformes Comercio
    Descripcion:                      Actualiza la tabla TASOLICITUDES Y TAPEDIDOS [0,10,15,20]
    Parametros de entrada:            Tiendas y Numero de dias de la migracion
    Parametros de salida:             No aplica
    Parametros de entrada-salida      No aplica
    Precondiciones:                   Tener creado el esquema
    Creador:                          Luis Daniel Rodriguez Garcia
    Fecha de creacion:                13 de Abril del 2017
 *************************************************************/
 vlIDDetalle    UNIFORMES.TASOLICITUDESDETALLE.FIIDDETALLE%TYPE;
 BEGIN 
    SELECT (NVL(MAX(FIIDDETALLE), csgCero) + csgUno)
        INTO vlIDDetalle
    FROM UNIFORMES.TASOLICITUDESDETALLE;
 RETURN vlIDDetalle;
 END FNGENERAIDDETALLE;

END PAPLUNIFORMESCOMERCIO;

