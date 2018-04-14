CREATE OR REPLACE PACKAGE                       PASRVUNIFORMESCOMERCIO
AS
  /*************************************************************
  Proyecto:                       Uniformes Comercio
  Descripcion:                    Paquete para sistema de uniformes Div. Comercial
  Parametros de entrada:          No aplica
  Parametros de salida:           No aplica
  Parametros de entrada-salida    No aplica
  Precondiciones:                 Tener creado el esquema
  Creador:
  Fecha de creacion:
  *************************************************************/
 TYPE rcgCursor IS REF CURSOR;

 PROCEDURE SPCARGATIENDASDIRIP(
    paTiendas   IN OUT UNIFORMES.TYPARRTIENDASDIRIP,
    paNoTiendas OUT NUMBER);

 PROCEDURE SPACTUALIZATIENDAS(
    noTiendas out NUMBER);

 FUNCTION FNCONSSOLPENDGRABARTIENDA
 RETURN rcgCursor;

 FUNCTION FNCONSSOLPENDGRABARCD
 RETURN rcgCursor;

 FUNCTION FNCONSSOLPENDACTCD
 RETURN rcgCursor;

 FUNCTION FNCONSSOLPENDACTNENC
 RETURN rcgCursor;

 PROCEDURE SPACTSOLICITUDESDETALLE(
    paSolicitudesDetalle IN UNIFORMES.TYPEARRSOLICITUDDETALLE,
    paResultado OUT NUMBER);

 PROCEDURE SPREINYECCIONSOLICITUDDETALLE(
    paResultado OUT NUMBER);

 PROCEDURE SPACTNOTASCARGOENTRADA(
    paNotasCargoEntrada IN UNIFORMES.TYPEARRNOTACARGOENTRADA,
    paResultado OUT NUMBER);

 PROCEDURE SPCONSULTASOLDETDESCSAP(
    curResultado OUT rcgCursor);

 PROCEDURE SPSEGUIMIENTOPEDDESCSAP(
    paSeguimientoPedidosDescuentos IN UNIFORMES.TYPEARRSEGUIMIENTOPEDDESCSAP);

 PROCEDURE SPACTUALIZADESCUENTOSSAP(
    paDescuentosSAP IN UNIFORMES.TYPEARRDESCUENTOSSAP,
    paNoRegistrosAct OUT NUMBER);

 FUNCTION FNESTATUSCDRUTADESCXSOLICITUD(
    paEstatusCD             UNIFORMES.TASOLICITUDESDETALLE.FIESTATUSCD%TYPE,
    paDescripcionCD         UNIFORMES.TABITACORASOLICITUD.FCCOMENTARIOS%TYPE,
    paDescripcionBitacora   UNIFORMES.TABITACORASOLICITUD.FCCOMENTARIOS%TYPE,    
    paCadenaRuta            UNIFORMES.TASOLICITUDESDETALLE.FIRUTA%TYPE)
 RETURN NUMBER;

 FUNCTION FNESTATUSSOLICITUDESDETALLE(
    paNoPais        UNIFORMES.TASOLICITUDESDETALLE.FIPAIS%TYPE,
    paNoCanal       UNIFORMES.TASOLICITUDESDETALLE.FICANAL%TYPE,
    paNoSucursal    UNIFORMES.TASOLICITUDESDETALLE.FISUCURSAL%TYPE,
    paNoSolicitud   UNIFORMES.TASOLICITUDESDETALLE.FIFOLIOSOLICITUD%TYPE,
    paNoIDDetalle   UNIFORMES.TASOLICITUDESDETALLE.FIIDDETALLE%TYPE)
 RETURN NUMBER;

 FUNCTION FNCONSSKUXKITTALLAGENEROPRENDA(
    paNoKit         UNIFORMES.TASKUSXKIT.FIKIT%TYPE,
    paNoTalla       UNIFORMES.TAPRENDAS.FITALLA%TYPE,
    paCadenaGenero  UNIFORMES.TAEMPLEADOS.FCGENERO%TYPE,
    paTipoPrenda    UNIFORMES.TASOLICITUDESDETALLE.FIIDTIPOPRENDA%TYPE)
 RETURN NUMBER;

  --ELIMINAR*********************************************************************************************************************

 FUNCTION FNREGRESANUMERO(
    paCadena UNIFORMES.TACECO.FCIDCANAL%TYPE)
 RETURN NUMBER;

 FUNCTION FNCADENAESTADOESTATUS(
    paNoEstadoNuevo UNIFORMES.TASOLICITUDESDETALLE.FIESTATUSSOL%TYPE)
 RETURN VARCHAR2;

 PROCEDURE SPGUARDABITACORA(
  	paSolicitud UNIFORMES.TABITACORASOLICITUD.FIFOLIOSOLICITUD%TYPE,
  	paDetalle   UNIFORMES.TABITACORASOLICITUD.FIIDDETALLE%TYPE,
  	paPedido    UNIFORMES.TABITACORASOLICITUD.FIPEDIDO%TYPE,
  	paDatosProc UNIFORMES.TABITACORASOLICITUD.FCDATOSPROCESO%TYPE,
  	paEstAnt    UNIFORMES.TABITACORASOLICITUD.FIESTATUSANT%TYPE,
  	paEstAct    UNIFORMES.TABITACORASOLICITUD.FIESTATUSNVO%TYPE,
  	paComent    UNIFORMES.TABITACORASOLICITUD.FCCOMENTARIOS%TYPE,
  	paTipoErr   UNIFORMES.TABITACORASOLICITUD.FIIDERROR%TYPE);

 PROCEDURE SPACTREMISION(
    paSucursal UNIFORMES.TAREMISIONESXPEDIDO.FISUCURSAL%TYPE,
  	paPedido   UNIFORMES.TAREMISIONESXPEDIDO.FIPEDIDO%TYPE,
  	paSku 	   UNIFORMES.TAREMISIONESXPEDIDO.FISKU%TYPE,
  	paRemision UNIFORMES.TAREMISIONESXPEDIDO.FIREMISION%TYPE,
  	paCantidad UNIFORMES.TAREMISIONESXPEDIDO.FICANTIDAD%TYPE,
  	paEmpleado UNIFORMES.TAREMISIONESXPEDIDO.FIEMPLEADORECIBE%TYPE,
  	paRes  OUT NUMBER);

 PROCEDURE SPACTPEDIDODIFREMISION(
  	paSucursal UNIFORMES.TASOLICITUDESDETALLE.FISUCURSAL%TYPE,
  	paPedido   UNIFORMES.TASOLICITUDESDETALLE.FIPEDIDO%TYPE,
  	paSku 	   UNIFORMES.TASOLICITUDESDETALLE.FISKU%TYPE,
  	paRemision UNIFORMES.TAREMISIONESXPEDIDO.FIREMISION%TYPE,
  	paRes  OUT NUMBER);

 FUNCTION FNVALIDADIAENVIO
 RETURN NUMBER;

 FUNCTION FNCONSULTAPENDIENTESSPPI
 RETURN rcgCursor;

 FUNCTION FNCONSSPPIPORACTUALIZAR
 RETURN rcgCursor;

 PROCEDURE SPACTUALIZAPEDIDOSSPPI(
  	paCargasSPPI UNIFORMES.TYPEARRCARGASPPI); 
 FUNCTION FNEMPLEADOACTIVO(
    paNoEmpleado UNIFORMES.TAEMPLEADOS.FIEMPLEADO%TYPE)
 RETURN NUMBER;
 
END PASRVUNIFORMESCOMERCIO;

CREATE OR REPLACE PACKAGE BODY            PASRVUNIFORMESCOMERCIO
AS
  /*************************************************************
   Proyecto:                           SRUniformesComercio
   Descripcion:                        Paquete para Sistema de Uniformes Comercio
   Parametros de entrada:              No aplica
   Parametros de salida:               No aplica
   Parametros de entrada-salida        No aplica
   Precondiciones:                     Tener creado el esquema
   Creador:                            
   Fecha de creacion:                  23 de Marzo del 2018
   *************************************************************/
  	vgErrCode       NUMBER(6):= 0;          -- Variable para el manejo de errores codigo
    vgErrMsg        VARCHAR2(500 CHAR):=''; -- Variable para el manejo de errores mensaje
    csgCero 	    NUMBER(1):=0;
    csgUno 		    NUMBER(1):=1;
    csgTres         NUMBER(1):=3;
    csgCuatro       NUMBER(1):=4;
    csgNueve		NUMBER(1):=9;
    csgDieceNueve   NUMBER(2):=19;

    csgCancelado                CONSTANT NUMBER(1):=0;  -- Cancelado
    csgSolicitudGenerada        CONSTANT NUMBER(1):=1;  -- Solicitud Generada
    csgSolicitadoTienda         CONSTANT NUMBER(1):=2;  -- Solicitado en Tienda
    csgSolicitadoCD             CONSTANT NUMBER(1):=3;  -- Solicitado en CD
    csgAtendidoCD               CONSTANT NUMBER(1):=4;  -- Atendido en CD
    csgCaminoTienda             CONSTANT NUMBER(1):=5;  -- En camino a Tienda
    csgRecibidoTienda           CONSTANT NUMBER(1):=6;  -- Recibido en Tienda
    csgEntregado                CONSTANT NUMBER(1):=7;  -- Entregado
    csgDescuentoSAP             CONSTANT NUMBER(1):=8;  -- Descuento SAP
    csgDescuentoSPPI            CONSTANT NUMBER(1):=9;  -- Descuento SPPI

    csgCadenaCancelado          CONSTANT VARCHAR2(50 CHAR):='CANCELADO';            -- Cancelado
    csgCadenaSolicitudGenerada  CONSTANT VARCHAR2(50 CHAR):='SOLICITUD GENERADA';   -- Solicitud Generada
    csgCadenaSolicitadoTienda   CONSTANT VARCHAR2(50 CHAR):='SOLICITADO EN TIENDA'; -- Solicitado en Tienda
    csgCadenaSolicitadoCD       CONSTANT VARCHAR2(50 CHAR):='SOLICITADO EN CD';     -- Solicitado en CD
    csgCadenaAtendidoCD         CONSTANT VARCHAR2(50 CHAR):='ATENDIDO EN CD';       -- Atendido en CD
    csgCadenaCaminoTienda       CONSTANT VARCHAR2(50 CHAR):='EN CAMINO A TIENDA';   -- En camino a tienda
    csgCadenaRecibidoTienda     CONSTANT VARCHAR2(50 CHAR):='RECIBIDO EN TIENDA';   -- Recibido en tienda
    csgCadenaEntregado          CONSTANT VARCHAR2(50 CHAR):='ENTREGADO';            -- Entregado

 PROCEDURE SPCARGATIENDASDIRIP(
    paTiendas   IN OUT UNIFORMES.TYPARRTIENDASDIRIP,
    paNoTiendas OUT NUMBER) 
 IS
 CURSOR curEquivalenciaCanales IS (SELECT FICANAL,FICANALCECO FROM UNIFORMES.TAEQUIVALENCIACANALES);
 /************************************************************************************************************
    Proyecto:              SRVUniformes Comercio
    Descripcion:           Borra y realiza las nuevas inserciones a la tabla UNIFORMES.TATIENDASDIRIP
    Parametros de entrada: (paTiendas) Se agregan todas las tiendas en un TypeArray.
    Parametros de salida:  (paNoTiendas) Numero de las tiendas insertadas.
    Parametros de ent-sal: No aplica
    Valor de retorno:      No aplica 
    Creador:               Luis Rodriguez
    Fecha de creacion:     5 de Marzo del 2017
 *************************************************************************************************************/
 BEGIN

    IF paTiendas.COUNT > csgCero THEN

        EXECUTE IMMEDIATE 'TRUNCATE TABLE UNIFORMES.TATIENDASDIRIP DROP STORAGE';        

        FOR i IN paTiendas.FIRST..paTiendas.LAST LOOP
            FOR tipoCanal IN curEquivalenciaCanales LOOP

                IF ( tipoCanal.FICANAL =  paTiendas(i).FICANAL ) THEN

                    paTiendas(i).FICANALCECO := tipoCanal.FICANALCECO;

                    INSERT INTO UNIFORMES.TATIENDASDIRIP
                        (
                            FITIENDAID,
                            FIPAISID,
                            FICANAL,
                            FICANALCECO,                        
                            FCDESCRIPCION,
                            FCDIRECCIONIP
                        ) 
                    VALUES 
                        (
                            paTiendas(i).FITIENDAID,
                            paTiendas(i).FIPAISID,
                            paTiendas(i).FICANAL,
                            paTiendas(i).FICANALCECO,
                            paTiendas(i).FCDESCRIPCION,
                            paTiendas(i).FCDIRECCIONIP
                        );
                END IF;
             END LOOP;
        END LOOP;        

        COMMIT;

        SELECT COUNT(FITIENDAID) INTO paNoTiendas FROM UNIFORMES.TATIENDASDIRIP;

    END IF;

 EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        vgErrCode := SQLCODE;
        vgErrMsg := SQLERRM;
        RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' "PACARGATIENDAS.SPCARGATIENDASIP": ' || vgErrMsg );

 END SPCARGATIENDASDIRIP;

 PROCEDURE SPACTUALIZATIENDAS(
    noTiendas out NUMBER) 
 IS   
 vlNumeroRegistros NUMBER;
 /************************************************************************************************************
    Proyecto:              SRVUniformes Comercio
    Descripcion:           Actualiza e inserta inserciones a la tabla UNIFORMES.TATIENDAS
    Parametros de entrada: No aplica
    Parametros de salida:  Numero de las tiendas insertadas.
    Parametros de ent-sal: No aplica
    Valor de retorno:      No aplica 
    Creador:               Luis Daniel Rodriguez Garcia
    Fecha de creacion:     22 Noviembre de 2017
 *************************************************************************************************************/
 BEGIN 
    MERGE INTO UNIFORMES.TATIENDAS T
    USING  (
            SELECT  TDIRIP.FIPAISID AS FIPAIS, 
                    TO_NUMBER(TRIM(CC.FCIDCANAL)) AS FICANAL,
                    TDIRIP.FITIENDAID AS FISUCURSAL,             
                    TRIM(CC.FCNOMBRE) AS FCNOMBRE,
                    TRIM(TDIRIP.FCDIRECCIONIP) AS FCDIRIP
            FROM UNIFORMES.TATIENDASDIRIP TDIRIP
                    INNER JOIN  UNIFORMES.TACECO CC
                        ON      TO_NUMBER(SUBSTR(TRIM(TO_CHAR(CC.FICC)),csgTres,csgCuatro)) = TDIRIP.FITIENDAID
                        AND     CC.FIPAIS = TDIRIP.FIPAISID
                        AND     CC.FIESTATUS = csgUno
                        AND     CC.FIIDTIPOOP = csgDieceNueve
                        AND     FNREGRESANUMERO(CC.FCIDCANAL) = TDIRIP.FICANALCECO
            ) TGENERAL
    ON      (
            T.FIPAIS = TGENERAL.FIPAIS 
            AND T.FICANAL = TGENERAL.FICANAL
            AND T.FISUCURSAL = TGENERAL.FISUCURSAL
            )
    WHEN MATCHED THEN 
        UPDATE SET  T.FCNOMBRE = TGENERAL.FCNOMBRE,
                    T.FCDIRIP = TGENERAL.FCDIRIP
    WHEN NOT MATCHED THEN
            INSERT (
                    T.FIPAIS,
                    T.FICANAL,
                    T.FISUCURSAL,
                    T.FCNOMBRE,
                    T.FCDIRIP,
                    T.FIIDCDISTRIBUCION,
                    T.FIIDFORMADOR
                    ) 
            VALUES (
                    TGENERAL.FIPAIS,
                    TGENERAL.FICANAL,
                    TGENERAL.FISUCURSAL,
                    TGENERAL.FCNOMBRE,
                    TGENERAL.FCDIRIP,
                    csgCero,
                    csgCero
                    );

    noTiendas := SQL%ROWCOUNT;

 EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
            vgErrCode := SQLCODE;
            vgErrMsg := SQLERRM;
            RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' "PASRVUNIFORMESCOMERCIO.SPACTUALIZATIENDAS": ' || vgErrMsg );

 END SPACTUALIZATIENDAS;

 FUNCTION FNCONSSOLPENDGRABARTIENDA
 RETURN rcgCursor
 IS 
  /*************************************************************
   Proyecto:                         SRVUniformesComercio
   Descripcion:                      Consulta las solicitudes pendientes de grabar en Tienda. 
                                     Filtra: SolicitudGenerada
   Parametros de entrada:            No aplica
   Parametros de salida:             No aplica
   Parametros de entrada-salida      No aplica
   Precondiciones:                   Tener creado el esquema
   Creador:                          
   Fecha de creacion:                
  *************************************************************/
 curCursorSalida    rcgCursor;
 vlSolSemestral     NUMBER(1):= 1;
 vlSolVoluntaria    NUMBER(1):= 2;
 vlSolNuevoIng      NUMBER(1):= 3;
 vlGeneroH		    NUMBER(1):= 1; 
 vlGeneroM		    NUMBER(2):= 2;
 vlGeneroUni	    NUMBER(2):= 3;
 vlSolenTienda      NUMBER(1):= 1;

 BEGIN
 OPEN curCursorSalida FOR
        SELECT  SOLICITUDES.FIFOLIOSOLICITUD,
                SOLICITUDES.FIIDDETALLE,
                SOLICITUDES.FIPAIS,
                SOLICITUDES.FICANAL, 
                SOLICITUDES.FISUCURSAL,  
                SOLICITUDES.FIPEDIDO,
                SOLICITUDES.FISKU,     
                SOLICITUDES.FIRUTA,
                SOLICITUDES.FIESTATUSCD,               
                SOLICITUDES.FIIDNEGOCIO,
                SOLICITUDES.FIEMPLEADO,      
                SOLICITUDES.FCDIRIP,
                SOLICITUDES.FCDESCRIPCION,
                SOLICITUDES.FITALLA,
                SOLICITUDES.FICANTIDAD,
                SOLICITUDES.FCGENERO
          FROM ( SELECT SD.FIFOLIOSOLICITUD,
	                SD.FIIDDETALLE,
	                SD.FIPAIS,
	                SD.FICANAL, 
	                SD.FISUCURSAL,  
	                SD.FIPEDIDO,
	                P.FISKU,     
	                SD.FIRUTA,
	                SD.FIESTATUSCD,               
	                S.FIIDNEGOCIO,
	                E.FIEMPLEADO,      
	                T.FCDIRIP,
	                P.FCDESCRIPCION,
	                P.FITALLA,
	                SD.FICANTIDAD,
	                E.FCGENERO             
           FROM UNIFORMES.TASOLICITUDES S
     INNER JOIN UNIFORMES.TASOLICITUDESDETALLE SD
             ON SD.FIFOLIOSOLICITUD = S.FIFOLIOSOLICITUD
     INNER JOIN UNIFORMES.TAEMPLEADOS E
             ON E.FIEMPLEADO = S.FIIDEMPLEADO            
     INNER JOIN UNIFORMES.TAPRENDAS P
             ON P.FISKU = UNIFORMES.PASRVUNIFORMESCOMERCIO.FNCONSSKUXKITTALLAGENEROPRENDA(S.FIIDNEGOCIO,SD.FITALLA,E.FCGENERO,SD.FIIDTIPOPRENDA)
     INNER JOIN UNIFORMES.TATIENDAS T
             ON T.FIPAIS = SD.FIPAIS AND
                T.FICANAL = SD.FICANAL AND
                T.FISUCURSAL = SD.FISUCURSAL
          WHERE SD.FIESTATUSSOL = csgSolicitudGenerada 
            AND SD.FIPEDIDO = csgCero
            AND SD.FIACTIVO = csgUno
            AND S.FIIDTIPOSOLICITUD IN (vlSolVoluntaria,vlSolNuevoIng)
     UNION ALL
     	SELECT  SD.FIFOLIOSOLICITUD,
                SD.FIIDDETALLE,
                SD.FIPAIS,
                SD.FICANAL, 
                SD.FISUCURSAL,  
                SD.FIPEDIDO,
                P.FISKU,     
                SD.FIRUTA,
                SD.FIESTATUSCD,               
                S.FIIDNEGOCIO,
                E.FIEMPLEADO,      
                T.FCDIRIP,
                P.FCDESCRIPCION,
                P.FITALLA,
                SD.FICANTIDAD,
                E.FCGENERO             
           FROM UNIFORMES.TASOLICITUDES S
     INNER JOIN UNIFORMES.TASOLICITUDESDETALLE SD
             ON SD.FIFOLIOSOLICITUD = S.FIFOLIOSOLICITUD
     INNER JOIN UNIFORMES.TAEMPLEADOS E
             ON E.FIEMPLEADO = S.FIIDEMPLEADO            
     INNER JOIN UNIFORMES.TAPRENDAS P
             ON P.FISKU = UNIFORMES.PASRVUNIFORMESCOMERCIO.FNCONSSKUXKITTALLAGENEROPRENDA(S.FIIDNEGOCIO,SD.FITALLA,E.FCGENERO,SD.FIIDTIPOPRENDA)
     INNER JOIN UNIFORMES.TATIENDAS T
             ON T.FIPAIS = SD.FIPAIS AND
                T.FICANAL = SD.FICANAL AND
                T.FISUCURSAL = SD.FISUCURSAL
     INNER JOIN UNIFORMES.TASOLICITUDESXCARGA SC
             ON SC.FIFOLIOSOLICITUD = S.FIFOLIOSOLICITUD
     INNER JOIN UNIFORMES.TACARGASSEMESTRALES CS
             ON CS.FIIDCARGA = SC.FIIDCARGA       
          WHERE SD.FIESTATUSSOL = csgSolicitudGenerada
            AND CS.FIGENERARPEDIDO = csgUno
            AND SD.FIPEDIDO = csgCero
            AND SD.FIACTIVO = csgUno
            AND S.FIIDTIPOSOLICITUD = vlSolSemestral   
            ) SOLICITUDES
    ORDER BY SOLICITUDES.FIFOLIOSOLICITUD,
             SOLICITUDES.FIIDDETALLE,
             SOLICITUDES.FIEMPLEADO;      
    RETURN curCursorSalida;
    EXCEPTION
          WHEN OTHERS THEN
              vgErrCode := SQLCODE;
              vgErrMsg := SQLERRM;
              RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PASRVUNIFORMESCOMERCIO.FNCONSSOLPENDGRABARTIENDA": ' || vgErrMsg);

 END FNCONSSOLPENDGRABARTIENDA;

 FUNCTION FNCONSSOLPENDGRABARCD
 RETURN rcgCursor
 IS 
 /*************************************************************
   Proyecto:                         SRVUniformesComercio
   Descripcion:                      No aplica
   Parametros de entrada:            No aplica
   Parametros de salida:             Cursor de referencia
   Parametros de entrada-salida      No aplica
   Precondiciones:                   Tener creado el esquema
   Creador:                          
   Fecha de creacion:                
 *************************************************************/
 curCursorSalida rcgCursor;
 vlSolenTienda  NUMBER(1):= 1;
 BEGIN
    OPEN curCursorSalida FOR
        SELECT  S.FIIDNEGOCIO,
                SD.FIFOLIOSOLICITUD,
                SD.FIIDDETALLE,
                E.FIEMPLEADO,
                SD.FIPAIS,
                SD.FICANAL,
                SD.FISUCURSAL,
                T.FCDIRIP,
                P.FISKU,
                P.FCDESCRIPCION,
                P.FITALLA,
                SD.FICANTIDAD,
                E.FCGENERO,
                SD.FIPEDIDO          
        FROM UNIFORMES.TASOLICITUDES S
        INNER JOIN UNIFORMES.TASOLICITUDESDETALLE SD
            ON  SD.FIFOLIOSOLICITUD = S.FIFOLIOSOLICITUD
        INNER JOIN UNIFORMES.TAEMPLEADOS E
            ON  E.FIEMPLEADO = S.FIIDEMPLEADO            
        INNER JOIN UNIFORMES.TAPRENDAS P
            ON  P.FISKU = FNCONSSKUXKITTALLAGENEROPRENDA(S.FIIDNEGOCIO,SD.FITALLA,E.FCGENERO,SD.FIIDTIPOPRENDA)
        INNER JOIN UNIFORMES.TATIENDAS T
            ON  T.FIPAIS = SD.FIPAIS AND
                T.FICANAL = SD.FICANAL AND
                T.FISUCURSAL = SD.FISUCURSAL
        WHERE SD.FIESTATUSSOL = csgSolicitadoTienda 
          AND SD.FIPEDIDO > csgCero
          AND SD.FIACTIVO = csgUno        
        ORDER BY    S.FIFOLIOSOLICITUD,
                    SD.FIIDDETALLE,
                    E.FIEMPLEADO;
 RETURN curCursorSalida;

 EXCEPTION
    WHEN OTHERS THEN
        vgErrCode := SQLCODE;
        vgErrMsg := SQLERRM;
        RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PASRVUNIFORMESCOMERCIO.FNCONSSOLPENDGRABARCD": ' || vgErrMsg);

 END FNCONSSOLPENDGRABARCD;

 FUNCTION FNCONSSOLPENDACTCD
 RETURN rcgCursor
 IS 
 /*************************************************************
   Proyecto:                         SRVUniformesComercio
   Descripcion:                      No aplica
   Parametros de entrada:            No aplica
   Parametros de salida:             Cursor de referencia
   Parametros de entrada-salida      No aplica
   Precondiciones:                   Tener creado el esquema
   Creador:                          
   Fecha de creacion:                
 *************************************************************/
 curCursorSalida rcgCursor;
 vlSolenTienda  NUMBER(1):= 1;
 BEGIN
    OPEN curCursorSalida FOR
        SELECT  S.FIIDNEGOCIO,
                SD.FIFOLIOSOLICITUD,
                SD.FIIDDETALLE,
                E.FIEMPLEADO,
                SD.FIPAIS,
                SD.FICANAL,
                SD.FISUCURSAL,
                T.FCDIRIP,
                P.FISKU,
                P.FCDESCRIPCION,
                P.FITALLA,
                SD.FICANTIDAD,
                E.FCGENERO,
                SD.FIPEDIDO
        FROM UNIFORMES.TASOLICITUDES S
        INNER JOIN UNIFORMES.TASOLICITUDESDETALLE SD
            ON  SD.FIFOLIOSOLICITUD = S.FIFOLIOSOLICITUD
        INNER JOIN UNIFORMES.TAEMPLEADOS E
            ON  E.FIEMPLEADO = S.FIIDEMPLEADO            
        INNER JOIN UNIFORMES.TAPRENDAS P
            ON  P.FISKU = FNCONSSKUXKITTALLAGENEROPRENDA(S.FIIDNEGOCIO,SD.FITALLA,E.FCGENERO,SD.FIIDTIPOPRENDA)
        INNER JOIN UNIFORMES.TATIENDAS T
            ON  T.FIPAIS = SD.FIPAIS AND
                T.FICANAL = SD.FICANAL AND
                T.FISUCURSAL = SD.FISUCURSAL
        WHERE SD.FIESTATUSSOL IN (csgSolicitadoCD,csgAtendidoCD,csgCaminoTienda,csgRecibidoTienda,csgEntregado)
        ORDER BY    S.FIFOLIOSOLICITUD,
                    SD.FIIDDETALLE,
                    E.FIEMPLEADO;
 RETURN curCursorSalida;

 EXCEPTION
    WHEN OTHERS THEN
        vgErrCode := SQLCODE;
        vgErrMsg := SQLERRM;
        RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PASRVUNIFORMESCOMERCIO.FNCONSSOLPENDGRABARCD": ' || vgErrMsg);

 END FNCONSSOLPENDACTCD;

 FUNCTION FNCONSSOLPENDACTNENC
 RETURN rcgCursor
 IS 
 /*************************************************************
   Proyecto:                         SRVUniformesComercio
   Descripcion:                      No aplica
   Parametros de entrada:            No aplica
   Parametros de salida:             Cursor de referencia
   Parametros de entrada-salida      No aplica
   Precondiciones:                   Tener creado el esquema
   Creador:                          
   Fecha de creacion:                
 *************************************************************/
 curCursorSalida rcgCursor;
 vlSolenTienda  NUMBER(1):= 1;
 BEGIN
    OPEN curCursorSalida FOR
        SELECT  S.FIIDNEGOCIO,
                SD.FIFOLIOSOLICITUD,
                SD.FIIDDETALLE,
                E.FIEMPLEADO,
                SD.FIPAIS,
                SD.FICANAL,
                SD.FISUCURSAL,
                T.FCDIRIP,
                P.FISKU,
                P.FCDESCRIPCION,
                P.FITALLA,
                SD.FICANTIDAD,
                E.FCGENERO
        FROM UNIFORMES.TASOLICITUDES S
        INNER JOIN UNIFORMES.TASOLICITUDESDETALLE SD
            ON  SD.FIFOLIOSOLICITUD = S.FIFOLIOSOLICITUD
        INNER JOIN UNIFORMES.TAEMPLEADOS E
            ON  E.FIEMPLEADO = S.FIIDEMPLEADO            
        INNER JOIN UNIFORMES.TAPRENDAS P
            ON  P.FISKU = FNCONSSKUXKITTALLAGENEROPRENDA(S.FIIDNEGOCIO,SD.FITALLA,E.FCGENERO,SD.FIIDTIPOPRENDA)
        INNER JOIN UNIFORMES.TATIENDAS T
            ON  T.FIPAIS = SD.FIPAIS AND
                T.FICANAL = SD.FICANAL AND
                T.FISUCURSAL = SD.FISUCURSAL
        WHERE SD.FIESTATUSSOL IN (csgSolicitadoCD,csgAtendidoCD,csgCaminoTienda,csgRecibidoTienda,csgEntregado)
        ORDER BY    S.FIFOLIOSOLICITUD,
                    SD.FIIDDETALLE,
                    E.FIEMPLEADO;
 RETURN curCursorSalida;

 EXCEPTION
    WHEN OTHERS THEN
        vgErrCode := SQLCODE;
        vgErrMsg := SQLERRM;
        RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PASRVUNIFORMESCOMERCIO.FNCONSSOLPENDGRABARCD": ' || vgErrMsg);

 END FNCONSSOLPENDACTNENC;

 PROCEDURE SPACTSOLICITUDESDETALLE(
    paSolicitudesDetalle IN UNIFORMES.TYPEARRSOLICITUDDETALLE,
    paResultado OUT NUMBER)
 IS
 /*************************************************************
   Proyecto:                         Sistema de Uniformes
   Descripcion:                      Consulta datos de empleado
   Parametros de entrada:            paNumEmpleado    Numero de empleado
   Parametros de salida:             curDatos         Cursor de referencia
   Parametros de entrada-salida      No aplica
   Precondiciones:                   Tener creado el esquema
   Creador:                          
   Fecha de creacion:                
 *************************************************************/             
  --CONSTANSTES
 cslEstatusCDReasignado         CONSTANT NUMBER(1) := 4;
 cslInactivo                    CONSTANT NUMBER(1) := 1;
 --VARIABLES
 csgCancelacionCD               CONSTANT NUMBER(1) := 0;
 vlPais 	                    UNIFORMES.TASOLICITUDESDETALLE.FIPAIS%TYPE;
 vlCanal 	                    UNIFORMES.TASOLICITUDESDETALLE.FICANAL%TYPE;
 vlSucursal                     UNIFORMES.TASOLICITUDESDETALLE.FISUCURSAL%TYPE;

 vlCadenaComentariosBitacora    UNIFORMES.TABITACORASOLICITUD.FCCOMENTARIOS%TYPE;

 vlCadenaEstatusCD              UNIFORMES.TASOLICITUDESDETALLE.FIESTATUSCD%TYPE;
 vlNoEstatusSolicitud           UNIFORMES.TASOLICITUDESDETALLE.FIESTATUSSOL%TYPE;

 vlNoEstatusAnterior            UNIFORMES.TABITACORASOLICITUD.FIESTATUSANT%TYPE;
 vlNoEstatusNuevo               UNIFORMES.TABITACORASOLICITUD.FIESTATUSNVO%TYPE;
 /*
 cslNoPedidoCreado              CONSTANT NUMBER(1) := 1; --PEDIDO CREADO (CD)
 cslMsgAsignadoAlmacen          CONSTANT NUMBER(1) := 2; --ASIGNADO EN ALMACEN (CD)
 cslMsgAtendiendo               CONSTANT NUMBER(1) := 3; --ATENDIENDO SOLICITUD
 cslMsgEnviadoATienda           CONSTANT NUMBER(1) := 4; --ENVIADO A TIENDA
 cslMsgRemisionado              CONSTANT NUMBER(1) := 5; --REMISIONADO SIN RUTA (CD)
 cslMsgPedidoCanceladoAbasto    CONSTANT NUMBER(1) := 6; --PEDIDO CANCELADO ABASTO
 cslMsgPedidoCanceladoNE        CONSTANT NUMBER(1) := 7; --NOTA DE ENTRADA:  
*/
  BEGIN	

    FOR i IN paSolicitudesDetalle.FIRST..paSolicitudesDetalle.LAST LOOP

        vlCadenaEstatusCD := paSolicitudesDetalle(i).FIESTATUSCD; --ASIGNACION DE VARIABLE WSABASTO

        vlNoEstatusSolicitud := PASRVUNIFORMESCOMERCIO.FNESTATUSCDRUTADESCXSOLICITUD(   vlCadenaEstatusCD,
                                                                                        paSolicitudesDetalle(i).FCMENSAJECD,
                                                                                        paSolicitudesDetalle(i).FCDESCRIPCIONBIT,
                                                                                        paSolicitudesDetalle(i).FIRUTA); --TRANSFORMACION DE FIESTATUSCD TO FIESTATUSSOL



        IF paSolicitudesDetalle(i).FIESTATUSSOL <> vlNoEstatusSolicitud THEN --VALIDA EL QUE ESTATUS PARA ACTUALIZAR NO SEA EL MISMO

            vlCadenaComentariosBitacora := FNCADENAESTADOESTATUS(vlNoEstatusSolicitud);

            vlNoEstatusAnterior := FNESTATUSSOLICITUDESDETALLE( paSolicitudesDetalle(i).FIPAIS,
                                                                paSolicitudesDetalle(i).FICANAL,
                                                                paSolicitudesDetalle(i).FISUCURSAL,
                                                                paSolicitudesDetalle(i).FIFOLIOSOLICITUD,
                                                                paSolicitudesDetalle(i).FIIDDETALLE);    
            vlNoEstatusNuevo := vlNoEstatusSolicitud;

                IF vlNoEstatusSolicitud <> csgCancelacionCD THEN

                    IF paSolicitudesDetalle(i).FIESTATUSCD = cslEstatusCDReasignado THEN -- INSERCION DE LAS SOLICITUDES DETALLE QUE SE TIENEN QUE REINYECTAR

                        -- SI ENCUENTRA UNA IGUAL LA ACTUALIZA PARA ACTIVAR LA REINYECCION (INICIALIZACION DE VALORES)
                        MERGE INTO UNIFORMES.TASOLICITUDESDETALLE SD
                        USING (SELECT 	paSolicitudesDetalle(i).FIFOLIOSOLICITUD    AS FIFOLIOSOLICITUD,
                                        paSolicitudesDetalle(i).FIIDDETALLE         AS FIIDDETALLE,
                                        paSolicitudesDetalle(i).FIPAIS              AS FIPAIS,
                                        paSolicitudesDetalle(i).FICANAL             AS FICANAL,
                                        paSolicitudesDetalle(i).FISUCURSAL          AS FISUCURSAL,
                                        paSolicitudesDetalle(i).FIPEDIDO            AS FIPEDIDO,
                                        paSolicitudesDetalle(i).FISKU               AS FISKU
                                FROM SYS.DUAL) TYPEARRAYSOLICITUDESDETALLE
                            ON  ( 
                                    SD.FIFOLIOSOLICITUD  = TYPEARRAYSOLICITUDESDETALLE.FIFOLIOSOLICITUD AND
                                    SD.FIIDDETALLE       = TYPEARRAYSOLICITUDESDETALLE.FIIDDETALLE AND
                                    SD.FIPAIS            = TYPEARRAYSOLICITUDESDETALLE.FIPAIS AND
                                    SD.FICANAL           = TYPEARRAYSOLICITUDESDETALLE.FICANAL AND
                                    SD.FISUCURSAL        = TYPEARRAYSOLICITUDESDETALLE.FISUCURSAL AND
                                    SD.FIPEDIDO          = TYPEARRAYSOLICITUDESDETALLE.FIPEDIDO AND
                                    SD.FISKU             = TYPEARRAYSOLICITUDESDETALLE.FISKU                               
                                )
                        WHEN MATCHED THEN
                            UPDATE SET  SD.FIPEDIDO = 0,
                                        SD.FIESTATUSSOL = 1,
                                        SD.FIESTATUSCD = -1;

                        vlNoEstatusAnterior := 1;    
                        vlNoEstatusNuevo    := 1; 
                        vlCadenaComentariosBitacora := vlCadenaComentariosBitacora || ', REINYECCION[FIPEDIDO=' || TO_CHAR(paSolicitudesDetalle(i).FIPEDIDO) || ']'; 
                    ELSE
                        MERGE INTO UNIFORMES.TASOLICITUDESDETALLE SD
                        USING (SELECT 	paSolicitudesDetalle(i).FIFOLIOSOLICITUD    AS FIFOLIOSOLICITUD,
                                        paSolicitudesDetalle(i).FIIDDETALLE         AS FIIDDETALLE,
                                        paSolicitudesDetalle(i).FIPAIS              AS FIPAIS,
                                        paSolicitudesDetalle(i).FICANAL             AS FICANAL,
                                        paSolicitudesDetalle(i).FISUCURSAL          AS FISUCURSAL,
                                        paSolicitudesDetalle(i).FIPEDIDO            AS FIPEDIDO,
                                        paSolicitudesDetalle(i).FISKU               AS FISKU
                                FROM SYS.DUAL) TYPEARRAYSOLICITUDESDETALLE
                            ON  ( 
                                    SD.FIFOLIOSOLICITUD  = TYPEARRAYSOLICITUDESDETALLE.FIFOLIOSOLICITUD AND
                                    SD.FIIDDETALLE       = TYPEARRAYSOLICITUDESDETALLE.FIIDDETALLE AND
                                    SD.FIPAIS            = TYPEARRAYSOLICITUDESDETALLE.FIPAIS AND
                                    SD.FICANAL           = TYPEARRAYSOLICITUDESDETALLE.FICANAL AND
                                    SD.FISUCURSAL        = TYPEARRAYSOLICITUDESDETALLE.FISUCURSAL                   
                                )
                        WHEN MATCHED THEN
                            UPDATE SET  
                                        SD.FIPEDIDO = paSolicitudesDetalle(i).FIPEDIDO,
                                        SD.FISKU = paSolicitudesDetalle(i).FISKU,
                                        SD.FIESTATUSSOL = vlNoEstatusNuevo,
                                        SD.FIESTATUSCD =  paSolicitudesDetalle(i).FIESTATUSCD,
                                        SD.FCMENSAJECD = paSolicitudesDetalle(i).FCMENSAJECD,
                                        SD.FIRUTA =  paSolicitudesDetalle(i).FIRUTA,
                                        SD.FDFECHAACT = SYSDATE;
                    END IF;

                ELSE
                    -- SOLICITUDES DETALLE QUE NO SE YA SE NO SE VAN UTILIZAR (CANCELADAS DEFINITIVAS)
                    UPDATE  UNIFORMES.TASOLICITUDESDETALLE
                        SET FIACTIVO = cslInactivo,
                            FIESTATUSSOL = csgCancelado
                        WHERE   FIFOLIOSOLICITUD  = paSolicitudesDetalle(i).FIFOLIOSOLICITUD AND
                                FIIDDETALLE       = paSolicitudesDetalle(i).FIIDDETALLE AND
                                FIPAIS            = paSolicitudesDetalle(i).FIPAIS AND
                                FICANAL           = paSolicitudesDetalle(i).FICANAL AND
                                FISUCURSAL        = paSolicitudesDetalle(i).FISUCURSAL AND
                                FIPEDIDO          = paSolicitudesDetalle(i).FIPEDIDO AND
                                FISKU             = paSolicitudesDetalle(i).FISKU;       

                END IF;

                --GUARDADO DE TABITACORASOLICITUD
                /*
                SPGUARDABITACORA(                           paSolicitudesDetalle(i).FIFOLIOSOLICITUD,
                                                            paSolicitudesDetalle(i).FIIDDETALLE,
                                                            paSolicitudesDetalle(i).FCXMLRESPONSE, 
                                                            vlNoEstatusAnterior,
                                                            vlNoEstatusNuevo,
                                                            vlCadenaComentariosBitacora || ', ESTATUSSOL[' || TO_CHAR(vlNoEstatusSolicitud) || '], ESTATUSCD[' || vlCadenaEstatusCD || ']',
                                                            0   ); */   
            END IF;                                           
        END LOOP;

 COMMIT;

 paResultado := 0;

 EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        vgErrCode := SQLCODE;
        vgErrMsg := SQLERRM;
        RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PASRVUNIFORMESCOMERCIO.SPACTSOLICITUDESDETALLE": ' || vgErrMsg);

  END SPACTSOLICITUDESDETALLE;

 PROCEDURE SPREINYECCIONSOLICITUDDETALLE(
    paResultado OUT NUMBER
 )
 IS
 csgPedidoInicial           UNIFORMES.TASOLICITUDESDETALLE.FIPEDIDO%TYPE:=0;
 csgEstatusSolicitudInicial UNIFORMES.TASOLICITUDESDETALLE.FIESTATUSSOL%TYPE:=1;
 csgActivoInicial           UNIFORMES.TASOLICITUDESDETALLE.FIACTIVO%TYPE:=1;
 csgRutaInicial             UNIFORMES.TASOLICITUDESDETALLE.FIRUTA%TYPE:=-1; 
 csgMensajeCD               UNIFORMES.TASOLICITUDESDETALLE.FCMENSAJECD%TYPE:=''; 
 csgEstatusCD               UNIFORMES.TASOLICITUDESDETALLE.FIESTATUSCD%TYPE:=-1;  
 csgReinyecta               UNIFORMES.TASOLICITUDESDETALLE.FIREINYECTA%TYPE:=0;  

 CURSOR curNCEXSD IS            (SELECT SD.FIFOLIOSOLICITUD,
                                        SD.FIIDDETALLE,
                                        SD.FIPAIS,
                                        SD.FICANAL, 
                                        SD.FISUCURSAL,
                                        SD.FIIDTIPOPRENDA,
                                        SD.FITALLA,
                                        SD.FISKU,
                                        SD.FICANTIDAD,    
                                        SD.FNPRECIOUNITARIO,
                                        SD.FNPRECIOTOTAL,
                                        SD.FIESTATUSSOL,
                                        SD.FIPEDIDO
                                FROM UNIFORMES.TANOTASCARGOENTRADA NCE
                                INNER JOIN UNIFORMES.TASOLICITUDESDETALLE SD
                                ON  SD.FIPEDIDO = NCE.FIPEDIDO AND
                                    SD.FISUCURSAL = NCE.FISUCURSAL AND
                                    SD.FISKU = NCE.FISKU
                                WHERE NCE.FINOTAENTRADA IS NOT NULL AND SD.FIACTIVO = 1 AND SD.FIREINYECTA=0);
 BEGIN
    FOR solicitudDetalle IN curNCEXSD LOOP
        INSERT INTO UNIFORMES.TASOLICITUDESDETALLE(
            FIFOLIOSOLICITUD, 
            FIIDDETALLE,
            FIPEDIDO,
            FIPAIS,
            FICANAL,
            FISUCURSAL,
            FIIDTIPOPRENDA,
            FITALLA,
            FISKU,
            FICANTIDAD,
            FNPRECIOUNITARIO,
            FNPRECIOTOTAL,
            FIESTATUSSOL,
            FDFECHAACT,
            FIACTIVO,
            FCMENSAJECD,
            FIESTATUSCD,
            FIRUTA,
            FIREINYECTA
        ) VALUES(
            solicitudDetalle.FIFOLIOSOLICITUD,--FIFOLIOSOLICITUD
            solicitudDetalle.FIIDDETALLE,--FIIDDETALLE
            csgPedidoInicial,--FIPEDIDO
            solicitudDetalle.FIPAIS,--FIPAIS
            solicitudDetalle.FICANAL,--FICANAL
            solicitudDetalle.FISUCURSAL,--FISUCURSAL
            solicitudDetalle.FIIDTIPOPRENDA,--FIIDTIPOPRENDA
            solicitudDetalle.FITALLA,--FITALLA
            solicitudDetalle.FISKU,--FISKU
            solicitudDetalle.FICANTIDAD,--FICANTIDAD
            solicitudDetalle.FNPRECIOUNITARIO,--FNPRECIOUNITARIO
            solicitudDetalle.FNPRECIOTOTAL,--FNPRECIOTOTAL
            csgEstatusSolicitudInicial,--FIESTATUSSOL 
            SYSDATE,--FDFECHAACT 
            csgActivoInicial,--FIACTIVO
            ' ',
            -1,
            -1,
            csgReinyecta--FIREINYECTA
        );


        UPDATE UNIFORMES.TASOLICITUDESDETALLE 
            SET FIACTIVO = 0,
                FIREINYECTA = 1
        WHERE   FIFOLIOSOLICITUD = solicitudDetalle.FIFOLIOSOLICITUD AND
                FIIDDETALLE = solicitudDetalle.FIIDDETALLE AND
                FIPAIS = solicitudDetalle.FIPAIS AND
                FICANAL = solicitudDetalle.FICANAL AND
                FISUCURSAL = solicitudDetalle.FISUCURSAL AND 
                FIPEDIDO = solicitudDetalle.FIPEDIDO AND
                FISKU = solicitudDetalle.FISKU;

        SPGUARDABITACORA(   solicitudDetalle.FIFOLIOSOLICITUD,
                            solicitudDetalle.FIIDDETALLE,
                            solicitudDetalle.FIPEDIDO,
                            'REINYECCION', 
                            solicitudDetalle.FIESTATUSSOL,
                            1,
                            'REINYECCION[FIPEDIDO=' || TO_CHAR(solicitudDetalle.FIPEDIDO) || ']',
                            0   );
    END LOOP;
    COMMIT;
 END SPREINYECCIONSOLICITUDDETALLE;

 PROCEDURE SPACTNOTASCARGOENTRADA(
    paNotasCargoEntrada IN UNIFORMES.TYPEARRNOTACARGOENTRADA,
    paResultado OUT NUMBER)
 IS
 BEGIN

    MERGE INTO UNIFORMES.TANOTASCARGOENTRADA NCE
    USING (SELECT 	SD.FIFOLIOSOLICITUD,
                    SD.FIIDDETALLE,
                    SD.FIPAIS,
                    SD.FICANAL,                
                    NCE.FIPEDIDO,
                    NCE.FISUCURSAL,
                    NCE.FISKU,       
                    NCE.FICANTIDADREQ,
                    NCE.FICANTIDADSURT,
                    NCE.FIFOLIOREMISION, 
                    NCE.FDFECHAREMISION,
                    NCE.FIRUTA,          
                    NCE.FINOTACARGO,     
                    NCE.FINOTAENTRADA,  
                    NCE.FCESTREMISION,  
                    NCE.FCOBSERVACIONNC, 
                    NCE.FCOBSERVACIONNE, 
                    NCE.FCFECHAACTCD 
            FROM TABLE(paNotasCargoEntrada) NCE
            INNER JOIN UNIFORMES.TASOLICITUDESDETALLE SD
            ON  SD.FIPEDIDO = NCE.FIPEDIDO AND
                SD.FISUCURSAL = NCE.FISUCURSAL AND
                SD.FISKU = NCE.FISKU
            ) TYPEARRNOTACARGOENTRADA
    ON  ( 
            NCE.FIPEDIDO    = TYPEARRNOTACARGOENTRADA.FIPEDIDO AND
            NCE.FISUCURSAL  = TYPEARRNOTACARGOENTRADA.FISUCURSAL AND
            NCE.FISKU       = TYPEARRNOTACARGOENTRADA.FISKU
        )
        WHEN MATCHED THEN
        UPDATE SET  
                    NCE.FIFOLIOREMISION     = TYPEARRNOTACARGOENTRADA.FIFOLIOREMISION,
                    NCE.FDFECHAREMISION     = TYPEARRNOTACARGOENTRADA.FDFECHAREMISION,
                    NCE.FIRUTA              = TYPEARRNOTACARGOENTRADA.FIRUTA,
                    NCE.FINOTACARGO         = TYPEARRNOTACARGOENTRADA.FINOTACARGO,
                    NCE.FINOTAENTRADA       = TYPEARRNOTACARGOENTRADA.FINOTAENTRADA,
                    NCE.FCESTREMISION       = TYPEARRNOTACARGOENTRADA.FCESTREMISION,
                    NCE.FCOBSERVACIONNC     = TYPEARRNOTACARGOENTRADA.FCOBSERVACIONNC,
                    NCE.FCOBSERVACIONNE     = TYPEARRNOTACARGOENTRADA.FCOBSERVACIONNE,
                    NCE.FDFECHAACT          = SYSDATE,
                    NCE.FCFECHAACTCD        = TYPEARRNOTACARGOENTRADA.FCFECHAACTCD
        WHEN NOT MATCHED THEN
        INSERT (    FIFOLIOSOLICITUD,
                    FIIDDETALLE,
                    FIPEDIDO,
                    FIPAIS,
                    FICANAL,
                    FISUCURSAL,
                    FISKU,
                    FICANTIDADREQ,
                    FICANTIDADSURT,
                    FIFOLIOREMISION,
                    FDFECHAREMISION,
                    FIRUTA,
                    FINOTACARGO,
                    FINOTAENTRADA,
                    FCESTREMISION,
                    FCOBSERVACIONNC,
                    FCOBSERVACIONNE,
                    FDFECHAPROC,
                    FDFECHAACT,
                    FCFECHAACTCD)
        VALUES(     
                    TYPEARRNOTACARGOENTRADA.FIFOLIOSOLICITUD,
                    TYPEARRNOTACARGOENTRADA.FIIDDETALLE,
                    TYPEARRNOTACARGOENTRADA.FIPEDIDO,
                    TYPEARRNOTACARGOENTRADA.FIPAIS,
                    TYPEARRNOTACARGOENTRADA.FICANAL,
                    TYPEARRNOTACARGOENTRADA.FISUCURSAL,
                    TYPEARRNOTACARGOENTRADA.FISKU,
                    TYPEARRNOTACARGOENTRADA.FICANTIDADREQ,
                    TYPEARRNOTACARGOENTRADA.FICANTIDADSURT,
                    TYPEARRNOTACARGOENTRADA.FIFOLIOREMISION,
                    TYPEARRNOTACARGOENTRADA.FDFECHAREMISION,
                    TYPEARRNOTACARGOENTRADA.FIRUTA,
                    TYPEARRNOTACARGOENTRADA.FINOTACARGO,
                    TYPEARRNOTACARGOENTRADA.FINOTAENTRADA,
                    TYPEARRNOTACARGOENTRADA.FCESTREMISION,
                    TYPEARRNOTACARGOENTRADA.FCOBSERVACIONNC,
                    TYPEARRNOTACARGOENTRADA.FCOBSERVACIONNE,
                    SYSDATE,
                    SYSDATE,
                    TYPEARRNOTACARGOENTRADA.FCFECHAACTCD);
    paResultado := 1;
 END SPACTNOTASCARGOENTRADA;

 PROCEDURE SPCONSULTASOLDETDESCSAP(
    curResultado OUT rcgCursor)
 IS   
 /************************************************************************************************************
    Proyecto:              SRVUniformesComercio
    Descripcion:           Consulta la informacion de los pedidos de los empleados para el descuento SAP (Armado para envio por SOAP[WSAbasto])
    Parametros de entrada: No aplica
    Parametros de salida:  curResultado
    Parametros de ent-sal: No aplica
    Valor de retorno:      No aplica 
    Creador:               Luis Daniel Rodriguez Garcia
    Fecha de creacion:     21 Febrero de 2017
 *************************************************************************************************************/    
 cslEmpleadoActivo      CONSTANT VARCHAR2(1) := 'A';
 cslNoQuincenas         CONSTANT NUMBER(1) := 8;
 cslCero                CONSTANT NUMBER(1) := 0;   
 cslDos                 CONSTANT NUMBER(1) := 2;    
 cslOcho                CONSTANT NUMBER(1) := 8;
 vlIdBitacora           UNIFORMES.TABITACORASOLICITUD.FIIDBITACORA%TYPE;
 BEGIN
 OPEN curResultado
    FOR
        SELECT  LPAD(S.FIIDEMPLEADO, cslOcho, cslCero) AS FCIDEMPLEADOSAP,
                TO_CHAR(NEXT_DAY(SYSDATE, TO_CHAR(TO_DATE('05-06-2006', 'dd-mm-yyyy'), 'Day')), 'yyyymmdd') AS FCFECHADESCUENTO, -- DIA DEL DESCUENTO
                SD.FIPEDIDO, -- NO. PEDIDO
                TO_CHAR(SD.FNPRECIOTOTAL) AS FCPRECIOTOTAL, -- TOTAL A PAGAR
                TO_CHAR(ROUND(SD.FNPRECIOTOTAL/cslNoQuincenas, cslDos)) AS FCDESCUENTOSEMANAL, -- TOTAL A PAGAR X QUINCENA
                SD.FIFOLIOSOLICITUD, -- FOLIO SOLICITUD  
                SD.FIIDDETALLE, --IDDETALLE
                SD.FIPAIS, -- PAIS
                SD.FICANAL, -- CANAL
                SD.FISUCURSAL, -- SUCURSAL
                SD.FISKU, -- SKU
                SD.FIESTATUSSOL, -- ESTATUS DEL PEDIDO
                (SD.FIFOLIOSOLICITUD || '-' || SD.FIPEDIDO || '-' || SD.FIPAIS) AS FCREFENCIASAP -- REFERENCIA SAP
        FROM UNIFORMES.TASOLICITUDES S
        INNER JOIN UNIFORMES.TASOLICITUDESDETALLE SD
            ON (SD.FIFOLIOSOLICITUD = S.FIFOLIOSOLICITUD)
        INNER JOIN UNIFORMES.TAEMPLEADOS E
            ON (E.FIEMPLEADO = S.FIIDEMPLEADO)
        WHERE SD.FIESTATUSSOL = csgEntregado
            AND SD.FNPRECIOTOTAL <> cslCero -- SI ES DIFERENTE DE CERO PERTENECE A CARGA SEMESTRAL
            AND S.FIIDTIPOSOLICITUD = 2 -- TIPO SOLICITUD VOLUNTARIA
            AND E.FCSITUACION = cslEmpleadoActivo; -- SI EL EMPLEADO ESTA ACTIVO
 EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
            vgErrCode := SQLCODE;
            vgErrMsg := SQLERRM;
            RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' "PASRVUNIFORMESCOMERCIO.SPCONSULTAPEDIDOSDESCUENTOSSAP": ' || vgErrMsg );

 END SPCONSULTASOLDETDESCSAP;

 PROCEDURE SPSEGUIMIENTOPEDDESCSAP( 
    paSeguimientoPedidosDescuentos IN UNIFORMES.TYPEARRSEGUIMIENTOPEDDESCSAP)
 IS
 /************************************************************************************************************
    Proyecto:              SRVUniformesComercio
    Descripcion:           Aplica los descuentos SAP de los empleados a las tablas
                           TABITACORASOLICITUD,TADESCUENTOSXPEDIDOS,TAPEDIDOSCD
    Parametros de entrada: TYPEAARAY
    Parametros de salida:  Respuesta del Stored Procedure
    Parametros de ent-sal: No aplica
    Valor de retorno:      No aplica 
    Creador:               Luis Daniel Rodriguez Garcia
    Fecha de creacion:     21 Febrero de 2017
 *************************************************************************************************************/  
 cslRespuestaOKSap              CONSTANT NUMBER(1) := 1;
 vlSecuenciaDescuentosXPedidos  UNIFORMES.TADESCUENTOSXPEDIDOS.FICONSECUTIVO%TYPE;          -- SECUENCIA DE TADESCUENTOSXPEDIDOS
 vlIdBitacora 	                UNIFORMES.TABITACORASOLICITUD.FIIDBITACORA%TYPE;            -- SECUENCIA DE TABITACORASOLICITUD
 vlNoEstatusAnterior            UNIFORMES.TABITACORASOLICITUD.FIESTATUSANT%TYPE;
 vlNoEstatusNuevo               UNIFORMES.TABITACORASOLICITUD.FIESTATUSNVO%TYPE;
 BEGIN
      FOR i IN 1..paSeguimientoPedidosDescuentos.count LOOP

            SELECT COUNT(FICONSECUTIVO) + 1
                INTO vlSecuenciaDescuentosXPedidos
            FROM UNIFORMES.TADESCUENTOSXPEDIDOS
            WHERE FIFOLIOCENTRAL = paSeguimientoPedidosDescuentos(i).FIFOLIOSOLICITUD
              AND FIPAIS = paSeguimientoPedidosDescuentos(i).FIPAIS
              AND FICANAL = paSeguimientoPedidosDescuentos(i).FICANAL
              AND FISUCURSAL = paSeguimientoPedidosDescuentos(i).FIIDSUCURSAL
              AND FIPEDIDO = paSeguimientoPedidosDescuentos(i).FIPEDIDO
              AND FISKU = paSeguimientoPedidosDescuentos(i).FISKU
              AND FCREFERENCIA = paSeguimientoPedidosDescuentos(i).FCREFERENCIASAP;   

            vlNoEstatusAnterior :=  FNESTATUSSOLICITUDESDETALLE(    paSeguimientoPedidosDescuentos(i).FIPAIS,
                                                                    paSeguimientoPedidosDescuentos(i).FICANAL,
                                                                    paSeguimientoPedidosDescuentos(i).FIIDSUCURSAL,
                                                                    paSeguimientoPedidosDescuentos(i).FIFOLIOSOLICITUD,
                                                                    paSeguimientoPedidosDescuentos(i).FIIDDETALLE);
            vlNoEstatusNuevo := vlNoEstatusAnterior + csgUno;

                                   SPGUARDABITACORA(    paSeguimientoPedidosDescuentos(i).FIFOLIOSOLICITUD,
                                                        paSeguimientoPedidosDescuentos(i).FIIDDETALLE,
                                                        paSeguimientoPedidosDescuentos(i).FIPEDIDO,
                                                        paSeguimientoPedidosDescuentos(i).FCXMLRESPONSE, 
                                                        vlNoEstatusAnterior,
                                                        vlNoEstatusNuevo,
                                                        paSeguimientoPedidosDescuentos(i).FCTEXTXMLRESPONSE,
                                                        paSeguimientoPedidosDescuentos(i).FIIDERROR);                    


            IF( paSeguimientoPedidosDescuentos(i).FIESTATUSSAP = cslRespuestaOKSap ) THEN -- SI EL ESTATUS SAP ES 1 ENTONCES SE INSERTA EN TADESCUENTOSXPEDIDOS                                                                                            
                INSERT INTO UNIFORMES.TADESCUENTOSXPEDIDOS(
                                                            FICONSECUTIVO,        
                                                            FIFOLIOCENTRAL,
                                                            FIPAIS,
                                                            FICANAL,
                                                            FISUCURSAL,
                                                            FIPEDIDO,
                                                            FISKU,
                                                            FCREFERENCIA,
                                                            FIESTATUS,
                                                            FCPETICION,
                                                            FCRESPUESTA)   
                                                    VALUES(
                                                            vlSecuenciaDescuentosXPedidos,                                            
                                                            paSeguimientoPedidosDescuentos(i).FIFOLIOSOLICITUD,
                                                            paSeguimientoPedidosDescuentos(i).FIPAIS,
                                                            paSeguimientoPedidosDescuentos(i).FICANAL,
                                                            paSeguimientoPedidosDescuentos(i).FIIDSUCURSAL,
                                                            paSeguimientoPedidosDescuentos(i).FIPEDIDO,
                                                            paSeguimientoPedidosDescuentos(i).FISKU,
                                                            paSeguimientoPedidosDescuentos(i).FCREFERENCIASAP,
                                                            paSeguimientoPedidosDescuentos(i).FIESTATUSSAP,
                                                            paSeguimientoPedidosDescuentos(i).FCXMLREQUEST,
                                                            paSeguimientoPedidosDescuentos(i).FCXMLRESPONSE
                                                    );
                UPDATE UNIFORMES.TASOLICITUDESDETALLE 
                    SET FIESTATUSSOL = csgDescuentoSAP 
                WHERE FIPAIS = paSeguimientoPedidosDescuentos(i).FIPAIS
                    AND FICANAL = paSeguimientoPedidosDescuentos(i).FICANAL
                    AND FISUCURSAL = paSeguimientoPedidosDescuentos(i).FIIDSUCURSAL
                    AND FIPEDIDO = paSeguimientoPedidosDescuentos(i).FIPEDIDO
                    AND FISKU = paSeguimientoPedidosDescuentos(i).FISKU;               
            END IF;

    END LOOP;
 EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
            vgErrCode := SQLCODE;
            vgErrMsg := SQLERRM;
            RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' "PASRVUNIFORMESCOMERCIO.SPSEGUIMIENTOPEDDESCSAP": ' || vgErrMsg );        

 END SPSEGUIMIENTOPEDDESCSAP;

 PROCEDURE SPACTUALIZADESCUENTOSSAP(
    paDescuentosSAP IN UNIFORMES.TYPEARRDESCUENTOSSAP,
    paNoRegistrosAct OUT NUMBER) 
 IS   
 /************************************************************************************************************
    Proyecto:              SRVUniformes Comercio
    Descripcion:           Actualiza e inserta inserciones a la tabla UNIFORMES.TADESCUENTOSSAP
    Parametros de entrada: No aplica
    Parametros de salida:  Numero de las tiendas insertadas.
    Parametros de ent-sal: No aplica
    Valor de retorno:      No aplica 
    Creador:               Luis Daniel Rodriguez Garcia
    Fecha de creacion:     6 Marzo de 2017
 *************************************************************************************************************/
 BEGIN

    MERGE INTO UNIFORMES.TADESCUENTOSSAP DSAP
        USING (SELECT   FIFOLIOSOLICITUD,
                        FIPEDIDO,
                        FCREFERENCIA,
                        FCSOCIEDAD,
                        FCCNOMINA,
                        FNTOTAL,
                        FDFECHAPAGO,
                        FISEMACTUAL,
                        FNSALDO,
                        FNPAGO
                FROM TABLE(paDescuentosSAP)) DRHSAP
        ON (DSAP.FIFOLIOCENTRAL = DRHSAP.FIFOLIOSOLICITUD AND
            DSAP.FIPEDIDO = DRHSAP.FIPEDIDO AND
            DSAP.FCSOCIEDAD = DRHSAP.FCSOCIEDAD AND
            DSAP.FDPAGO = DRHSAP.FDFECHAPAGO)
    WHEN NOT MATCHED THEN
        INSERT (FIFOLIOCENTRAL,
                FIPEDIDO,
                FCREFERENCIA,
                FCSOCIEDAD,
                FCCCNOMINA,
                FNTOTDESCUENTO,
                FDPAGO,
                FISEMADESCUENTO,
                FNSALDO,
                FNPAGO)
        VALUES( DRHSAP.FIFOLIOSOLICITUD,
                DRHSAP.FIPEDIDO,
                DRHSAP.FCREFERENCIA,
                DRHSAP.FCSOCIEDAD,
                DRHSAP.FCCNOMINA,
                DRHSAP.FNTOTAL,
                DRHSAP.FDFECHAPAGO,
                DRHSAP.FISEMACTUAL,
                DRHSAP.FNSALDO,
                DRHSAP.FNPAGO);

 paNoRegistrosAct := SQL%ROWCOUNT;

 EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
            vgErrCode := SQLCODE;
            vgErrMsg := SQLERRM;
            RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' "PASRVUNIFORMESCOMERCIO.SPACTUALIZADESCUENTOSSAP": ' || vgErrMsg );

 END SPACTUALIZADESCUENTOSSAP;

 --FUNCIONES AUXILIARESS********************************************************************************************************

 FUNCTION FNESTATUSCDRUTADESCXSOLICITUD(
    paEstatusCD             UNIFORMES.TASOLICITUDESDETALLE.FIESTATUSCD%TYPE,
    paDescripcionCD         UNIFORMES.TABITACORASOLICITUD.FCCOMENTARIOS%TYPE,
    paDescripcionBitacora   UNIFORMES.TABITACORASOLICITUD.FCCOMENTARIOS%TYPE,    
    paCadenaRuta            UNIFORMES.TASOLICITUDESDETALLE.FIRUTA%TYPE)
 RETURN NUMBER
 IS
 vlNoEstatusSolicitud       UNIFORMES.TASOLICITUDESDETALLE.FIESTATUSSOL%TYPE;
 csgCadenaGrabadoEnTienda   CONSTANT VARCHAR2(50) := 'SOLICITUD DETALLE GRABADA EN TIENDA';
 csgCadenaGrabadoEnCD       CONSTANT VARCHAR2(50) := 'SOLICITUD DETALLE GRABADA EN CD';
 csgCadenaCancelado         CONSTANT VARCHAR2(50) := 'CANCELED';
 csgCadenaFailed            CONSTANT VARCHAR2(50) := '%Failed%';
 /* csgCadenaSolicitudGenerada  CONSTANT VARCHAR2(50 CHAR):='SOLICITUD GENERADA';   -- Solicitud Generada
    csgCadenaSolicitadoTienda   CONSTANT VARCHAR2(50 CHAR):='SOLICITADO EN TIENDA'; -- Solicitado en Tienda
    csgCadenaSolicitadoCD       CONSTANT VARCHAR2(50 CHAR):='SOLICITADO EN CD';     -- Solicitado en CD
    csgCadenaAtendidoCD         CONSTANT VARCHAR2(50 CHAR):='ATENDIDO EN CD';       -- Atendido en CD
    csgCadenaCaminoTienda       CONSTANT VARCHAR2(50 CHAR):='EN CAMINO A TIENDA';   -- En camino a tienda
    csgCadenaRecibidoTienda     CONSTANT VARCHAR2(50 CHAR):='RECIBIDO EN TIENDA';   -- Recibido en tienda
    csgCadenaEntregado          CONSTANT VARCHAR2(50 CHAR):='ENTREGADO';            -- Entregado*/
 BEGIN
    --paEstatusCD := TRIM(paEstatusCD);
    IF paEstatusCD = 0 AND UPPER(trim(paDescripcionBitacora)) = csgCadenaGrabadoEnTienda THEN -- (SIN ESTATUS WSABASTO) SOLICITUD EN TIENDA
        vlNoEstatusSolicitud := 2; --SOLICITADO EN TIENDA
    ELSIF paEstatusCD = 0 AND UPPER(trim(paDescripcionBitacora)) = csgCadenaGrabadoEnCD THEN --PEDIDO CREADO (CD)                      
        vlNoEstatusSolicitud := 3; --SOLICITADO EN CD
    ELSIF paEstatusCD IN (20,200) AND UPPER(trim(paDescripcionBitacora)) != csgCadenaGrabadoEnTienda THEN --PEDIDO CREADO (CD)                      
        vlNoEstatusSolicitud := 3; --SOLICITADO EN CD
    ELSIF paEstatusCD IN (400,450,492,496,500,600,650) AND paDescripcionCD NOT LIKE csgCadenaFailed THEN --ASIGNADO EN ALMACEN (CD)          
        vlNoEstatusSolicitud := 4; --ATENDIDO EN CD
    ELSIF paEstatusCD IN (400,450,492,496,500,600,650) AND paDescripcionCD LIKE csgCadenaFailed THEN --ASIGNADO EN ALMACEN (CD)                
        vlNoEstatusSolicitud := 4; --ATENDIDO EN CD            
    ELSIF paEstatusCD = 490 THEN --ATENDIENDO SOLICITUD                
        vlNoEstatusSolicitud := 4; 
    ELSIF paEstatusCD = 850 AND paCadenaRuta = 0 THEN --REMISIONADO SIN RUTA (CD)              
        vlNoEstatusSolicitud := 4;         
    ELSIF paEstatusCD = 850 AND paCadenaRuta > 0 THEN --ENVIADO A TIENDA              
        vlNoEstatusSolicitud := 5; --EN CAMINO A TIENDA
    ELSIF paEstatusCD = 940 OR UPPER(trim(paDescripcionCD)) = csgCadenaCancelado THEN --CANCELADO
        vlNoEstatusSolicitud := 0;          
    END IF;    
 RETURN vlNoEstatusSolicitud;
 END FNESTATUSCDRUTADESCXSOLICITUD; 

 FUNCTION FNESTATUSSOLICITUDESDETALLE(
    paNoPais        UNIFORMES.TASOLICITUDESDETALLE.FIPAIS%TYPE,
    paNoCanal       UNIFORMES.TASOLICITUDESDETALLE.FICANAL%TYPE,
    paNoSucursal    UNIFORMES.TASOLICITUDESDETALLE.FISUCURSAL%TYPE,
    paNoSolicitud   UNIFORMES.TASOLICITUDESDETALLE.FIFOLIOSOLICITUD%TYPE,
    paNoIDDetalle   UNIFORMES.TASOLICITUDESDETALLE.FIIDDETALLE%TYPE)
 RETURN NUMBER
 IS
   /*************************************************************
   Proyecto:                           SRUniformesComercio
   Descripcion:                        Devuelve el ultimo estatus de TAPEDIDOSCD
   Parametros de entrada:              Numero del Pais, Numero del Canal, Numero de Tienda, Numero de Pedido, Numero de SKU
   Parametros de salida:               Devuelve el estatus 
   Parametros de entrada-salida        No aplica
   Precondiciones:                     Tener creado el esquema
   Creador:                            Luis Daniel Rodriguez Garcia
   Fecha de creacion:                  23 de Marzo del 2018
   *************************************************************/
 vlEstatus UNIFORMES.TASOLICITUDESDETALLE.FIESTATUSSOL%TYPE := 0;
 BEGIN
    SELECT FIESTATUSSOL INTO vlEstatus FROM UNIFORMES.TASOLICITUDESDETALLE
        WHERE   FIPAIS = paNoPais
            AND FICANAL = paNoCanal
            AND FISUCURSAL = paNoSucursal
            AND FIFOLIOSOLICITUD = paNoSolicitud
            AND FIIDDETALLE = paNoIDDetalle;
    RETURN vlEstatus;
    EXCEPTION
    WHEN OTHERS THEN
        RETURN csgCero;
 END FNESTATUSSOLICITUDESDETALLE;

 FUNCTION FNCONSSKUXKITTALLAGENEROPRENDA(
    paNoKit         UNIFORMES.TASKUSXKIT.FIKIT%TYPE,
    paNoTalla       UNIFORMES.TAPRENDAS.FITALLA%TYPE,
    paCadenaGenero  UNIFORMES.TAEMPLEADOS.FCGENERO%TYPE,
    paTipoPrenda    UNIFORMES.TASOLICITUDESDETALLE.FIIDTIPOPRENDA%TYPE
 )
 RETURN NUMBER
 IS
 cslNoGeneroHombre      UNIFORMES.TAGENERO.FIIDGENERO%TYPE := 1; 
 cslNoGeneroMujer       UNIFORMES.TAGENERO.FIIDGENERO%TYPE := 2;
 cslNoGeneroUnisex      UNIFORMES.TAGENERO.FIIDGENERO%TYPE := 3;
 cslCadenaGeneroHombre  CONSTANT VARCHAR2(1) := 'H';
 cslCadenaGeneroMujer   CONSTANT VARCHAR2(1) := 'M';
 vlNoSKU UNIFORMES.TAPRENDAS.FISKU%TYPE := 0;
 BEGIN
    SELECT P.FISKU INTO vlNoSKU FROM TASKUSXKIT SKIT
        INNER JOIN TAPRENDAS P
            ON P.FISKU = SKIT.FISKU 
        WHERE SKIT.FIKIT = paNoKit 
            AND P.FITALLA = paNoTalla 
            AND P.FIIDGENERO IN (   CASE paCadenaGenero 
                                        WHEN cslCadenaGeneroHombre THEN cslNoGeneroHombre
                                        WHEN cslCadenaGeneroMujer THEN cslNoGeneroMujer
                                    END, cslNoGeneroUnisex)
            AND P.FIIDTIPOPRENDA = paTipoPrenda                        
            AND P.FIDISCONTINUO = csgCero;
    RETURN vlNoSKU;
 END FNCONSSKUXKITTALLAGENEROPRENDA;

 FUNCTION FNREGRESANUMERO(
    paCadena UNIFORMES.TACECO.FCIDCANAL%TYPE)
 RETURN NUMBER
 IS
 vlNumero UNIFORMES.TAEQUIVALENCIACANALES.FICANALCECO%TYPE;
 /************************************************************************************************************
    Proyecto:              SRVUniformes Comercio 
    Descripcion:           Transforma una cadena a un numero
    Parametros de entrada: Una cadena de numeros
    Parametros de salida:  Un numero
    Parametros de ent-sal: No aplica
    Valor de retorno:      No aplica 
    Creador:               Luis Daniel Rodriguez Garcia
    Fecha de creacion:     5 de Marzo del 2017
 *************************************************************************************************************/
 BEGIN
    vlNumero := TO_NUMBER(TRIM(paCadena));
 RETURN vlNumero;

 EXCEPTION
    WHEN VALUE_ERROR THEN
        RETURN csgCero;

 END FNREGRESANUMERO;

 --ELIMINAR*********************************************************************************************************************
 FUNCTION FNCADENAESTADOESTATUS(
    paNoEstadoNuevo UNIFORMES.TASOLICITUDESDETALLE.FIESTATUSSOL%TYPE)
 RETURN VARCHAR2
 IS
 vlCadenaDescripcionEstatus UNIFORMES.TABITACORASOLICITUD.FCCOMENTARIOS%TYPE;
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
                                        WHEN csgCancelado         THEN csgCadenaCancelado
                                        WHEN csgSolicitudGenerada THEN csgCadenaSolicitudGenerada
                                        WHEN csgSolicitadoTienda  THEN csgCadenaSolicitadoTienda
                                        WHEN csgSolicitadoCD      THEN csgCadenaSolicitadoCD
                                        WHEN csgAtendidoCD        THEN csgCadenaAtendidoCD
                                        WHEN csgCaminoTienda      THEN csgCadenaCaminoTienda
                                        WHEN csgRecibidoTienda    THEN csgCadenaRecibidoTienda
                                        WHEN csgEntregado         THEN csgCadenaEntregado
                                     END);
 RETURN vlCadenaDescripcionEstatus;
 END FNCADENAESTADOESTATUS;

 PROCEDURE SPGUARDABITACORA(
  	paSolicitud UNIFORMES.TABITACORASOLICITUD.FIFOLIOSOLICITUD%TYPE,
  	paDetalle   UNIFORMES.TABITACORASOLICITUD.FIIDDETALLE%TYPE,
  	paPedido    UNIFORMES.TABITACORASOLICITUD.FIPEDIDO%TYPE,
  	paDatosProc UNIFORMES.TABITACORASOLICITUD.FCDATOSPROCESO%TYPE,
  	paEstAnt    UNIFORMES.TABITACORASOLICITUD.FIESTATUSANT%TYPE,
  	paEstAct    UNIFORMES.TABITACORASOLICITUD.FIESTATUSNVO%TYPE,
  	paComent    UNIFORMES.TABITACORASOLICITUD.FCCOMENTARIOS%TYPE,
  	paTipoErr   UNIFORMES.TABITACORASOLICITUD.FIIDERROR%TYPE)
   IS
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
 	vlIdBitacora UNIFORMES.TABITACORASOLICITUD.FIIDBITACORA%TYPE;

 	BEGIN

    BEGIN

	SELECT NVL(MAX(FIIDBITACORA), csgCero) + 1
	 INTO vlIdBitacora
	 FROM UNIFORMES.TABITACORASOLICITUD;

	END;

			 INSERT INTO UNIFORMES.TABITACORASOLICITUD (FIIDBITACORA,
			 											FIFOLIOSOLICITUD,
			 											FIIDDETALLE,
			 											FIPEDIDO,
			 											FCDATOSPROCESO,
			 											FIESTATUSANT,
			 											FIESTATUSNVO,
			 											FDFECHA,
			 											FCCOMENTARIOS,
			 											FIIDERROR)
			        							VALUES  (vlIdBitacora,
			        									 paSolicitud,
			        							         paDetalle,
			        							         paPedido,
			        							         paDatosProc,
													  	 paEstAnt,
													  	 paEstAct,
													  	 SYSDATE,
													  	 paComent,
													  	 paTipoErr);

    EXCEPTION
        WHEN OTHERS THEN
              ROLLBACK;
              vgErrCode := SQLCODE;
              vgErrMsg := SQLERRM;
              RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' "PAWEBUNIFORMESCOMERCIO.SPGUARDABITACORA": ' || vgErrMsg );

  END SPGUARDABITACORA;

  PROCEDURE SPACTREMISION(
  	paSucursal UNIFORMES.TAREMISIONESXPEDIDO.FISUCURSAL%TYPE,
  	paPedido   UNIFORMES.TAREMISIONESXPEDIDO.FIPEDIDO%TYPE,
  	paSku 	   UNIFORMES.TAREMISIONESXPEDIDO.FISKU%TYPE,
  	paRemision UNIFORMES.TAREMISIONESXPEDIDO.FIREMISION%TYPE,
  	paCantidad UNIFORMES.TAREMISIONESXPEDIDO.FICANTIDAD%TYPE,
  	paEmpleado UNIFORMES.TAREMISIONESXPEDIDO.FIEMPLEADORECIBE%TYPE,
  	paRes  OUT NUMBER)
  IS
  /************************************************************************************************************
    Proyecto:              Uniformes Comercio
    Descripcion:           Actualización de remisiones
    Parametros de entrada: 
    Parametros de salida:  Respuesta del Stored Procedure
    Parametros de ent-sal: No aplica
    Valor de retorno:      No aplica
    Creador:               Kristian Ortiz
    Fecha de creacion:     03/04/2018
 *************************************************************************************************************/
 	vlSol  UNIFORMES.TASOLICITUDESDETALLE.FIFOLIOSOLICITUD%TYPE;
 	vlDet  UNIFORMES.TASOLICITUDESDETALLE.FIIDDETALLE%TYPE;
 	vlPais UNIFORMES.TASOLICITUDESDETALLE.FIIDDETALLE%TYPE;
 	vlCanal UNIFORMES.TASOLICITUDESDETALLE.FIIDDETALLE%TYPE;
 	vlEstRecibido NUMBER(1) := 6;
 	vlEstEnCamino NUMBER(1) := 5;

 	BEGIN
	paRes := 0;

	BEGIN 

	SELECT FIFOLIOSOLICITUD, 
		   FIIDDETALLE, 
		   FIPAIS, 
		   FICANAL
	  INTO vlSol, 
	       vlDet, 
	       vlPais, 
	       vlCanal
	  FROM UNIFORMES.TASOLICITUDESDETALLE
	 WHERE FISUCURSAL = paSucursal
	   AND FIPEDIDO = paPedido
	   AND FISKU = paSku;

	EXCEPTION WHEN NO_DATA_FOUND THEN
	   vlSol := 0;	
	END;

	IF vlSol  > csgCero THEN -- Se encontro el pedido, sku, tienda

		INSERT INTO UNIFORMES.TAREMISIONESXPEDIDO (FIFOLIOSOLICITUD, 
												   FIIDDETALLE, 
												   FIPAIS, 
												   FICANAL, 
												   FISUCURSAL, 
												   FIPEDIDO, 
												   FISKU, 
												   FIREMISION, 
												   FICANTIDAD, 
												   FIEMPLEADORECIBE)
										  VALUES (vlSol, 
											      vlDet, 
											      vlPais, 
											      vlCanal,
											      paSucursal,
											      paPedido,
											      paSku,
											      paRemision,
											      paCantidad,
											      paEmpleado); 

		paRes := SQL%ROWCOUNT;

		UPDATE TASOLICITUDESDETALLE
		   SET FIESTATUSSOL = vlEstRecibido ,
		       FDFECHAACT = SYSDATE
		 WHERE FIFOLIOSOLICITUD = vlSol
		   AND FIIDDETALLE =  vlDet;

		 UNIFORMES.PASRVUNIFORMESCOMERCIO.SPGUARDABITACORA(vlSol, vlDet, paPedido, ' ',vlEstEnCamino, vlEstRecibido, 'Remision : '||paRemision, 0);


	ELSE
		paRes := 0;
	END IF;

	COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
              ROLLBACK;
              vgErrCode := SQLCODE;
              vgErrMsg := SQLERRM;
              RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' "PASRVUNIFORMESCOMERCIO.SPACTREMISION": ' || vgErrMsg );

  END SPACTREMISION;

 PROCEDURE SPACTPEDIDODIFREMISION(
  	paSucursal UNIFORMES.TASOLICITUDESDETALLE.FISUCURSAL%TYPE,
  	paPedido   UNIFORMES.TASOLICITUDESDETALLE.FIPEDIDO%TYPE,
  	paSku 	   UNIFORMES.TASOLICITUDESDETALLE.FISKU%TYPE,
  	paRemision UNIFORMES.TAREMISIONESXPEDIDO.FIREMISION%TYPE,
  	paRes  OUT NUMBER)
  IS
  /************************************************************************************************************
    Proyecto:              Uniformes Comercio
    Descripcion:           Actualización de remisiones
    Parametros de entrada: 
    Parametros de salida:  Respuesta del Stored Procedure
    Parametros de ent-sal: No aplica
    Valor de retorno:      No aplica
    Creador:               Kristian Ortiz
    Fecha de creacion:     03/04/2018
  *************************************************************************************************************/
 	vlSol  UNIFORMES.TASOLICITUDESDETALLE.FIFOLIOSOLICITUD%TYPE;
 	vlDet  UNIFORMES.TASOLICITUDESDETALLE.FIIDDETALLE%TYPE;
 	vlPais UNIFORMES.TASOLICITUDESDETALLE.FIPAIS%TYPE;
 	vlCanal UNIFORMES.TASOLICITUDESDETALLE.FICANAL%TYPE;
 	vlTipoPrenda UNIFORMES.TASOLICITUDESDETALLE.FIIDTIPOPRENDA%TYPE;
 	vlTalla UNIFORMES.TASOLICITUDESDETALLE.FITALLA%TYPE;
 	vlCantidad UNIFORMES.TASOLICITUDESDETALLE.FICANTIDAD%TYPE;
 	vlPrecio UNIFORMES.TASOLICITUDESDETALLE.FNPRECIOUNITARIO%TYPE;
 	vlIdDetalleSol UNIFORMES.TASOLICITUDESDETALLE.FIIDDETALLE%TYPE;
 	
 	vlEstPed NUMBER(1);
 	vlEstCancelado NUMBER(1) := 0;
 	vlEstSolicitado NUMBER(1):= 1;
 	vlEstDefCD NUMBER(1):= -1;

 	BEGIN
	paRes := 0;

	BEGIN 

	SELECT S.FIFOLIOSOLICITUD, 
		   S.FIIDDETALLE, 
		   S.FIPAIS, 
		   S.FICANAL,
		   S.FIESTATUSSOL,
		   S.FIIDTIPOPRENDA,
		   S.FITALLA,
		   S.FICANTIDAD,
		   S.FNPRECIOUNITARIO
	  INTO vlSol, 
	       vlDet, 
	       vlPais, 
	       vlCanal,
	       vlEstPed,
	       vlTipoPrenda,
	       vlTalla,
	       vlCantidad,
	       vlPrecio
	  FROM UNIFORMES.TAREMISIONESXPEDIDO R
 INNER JOIN UNIFORMES.TASOLICITUDESDETALLE S
        ON R.FIFOLIOSOLICITUD = S.FIFOLIOSOLICITUD
       AND R.FIIDDETALLE = S.FIIDDETALLE
       AND R.FIPAIS = S.FIPAIS
       AND R.FICANAL = S.FICANAL
       AND R.FISUCURSAL = R.FISUCURSAL
       AND R.FISKU = R.FISKU 
	 WHERE R.FISUCURSAL = paSucursal
	   AND R.FIPEDIDO = paPedido
	   AND R.FISKU = paSku
	   AND R.FIREMISION = paRemision;

	EXCEPTION WHEN NO_DATA_FOUND THEN
	   vlSol := 0;	
	END;

	IF vlSol  > csgCero THEN -- Se encontro el pedido, sku, tienda , remision

		UPDATE UNIFORMES.TASOLICITUDESDETALLE
		   SET FIREINYECTA = csgUno,
		       FIACTIVO = csgCero
		 WHERE FIFOLIOSOLICITUD = vlSol
		   AND FIIDDETALLE = vlDet
		   AND FIPEDIDO = paPedido
		   AND FISUCURSAL = paSucursal
		   AND FISKU = paSku;
	
		UNIFORMES.PASRVUNIFORMESCOMERCIO.SPGUARDABITACORA(vlSol, vlDet, paPedido, ' ',vlEstPed, vlEstCancelado, 'Cancelado por diferencia de remision : '||paRemision, 1);	   
		      

		-- Se re inyecta el pedido
		INSERT INTO UNIFORMES.TASOLICITUDESDETALLE (FIFOLIOSOLICITUD, 
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
													FIREINYECTA)
										    VALUES (vlSol,
										    		vlDet,
										    		vlPais,
										    		vlCanal,
										    		paSucursal,
										    		csgCero,
										    		csgCero,
										    		vlTipoPrenda,
										    		vlTalla,
										    		vlCantidad,
										    		vlPrecio,
										    		vlPrecio * vlCantidad,
										    		vlEstSolicitado,
										    		vlEstDefCD,
										    		SYSDATE,
										    		csgUno,
										    		vlEstDefCD,
										    		' ',
										    		csgCero
										    		); 

		 UNIFORMES.PASRVUNIFORMESCOMERCIO.SPGUARDABITACORA(vlSol,vlIdDetalleSol, csgCero, 'SOLICITUD GENERADA POR RE INYECCION DIFERENCIA DE REMISION :'||paRemision , vlEstPed, csgUno, 'SOLICITUD GENERADA', csgCero);
	
	paRes := csgUno;-- Si se encontro la remision - pedido

	ELSE
		paRes := 0;
	END IF;

	COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
              ROLLBACK;
              vgErrCode := SQLCODE;
              vgErrMsg := SQLERRM;
              RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' "PASRVUNIFORMESCOMERCIO.SPACTPEDIDODIFREMISION": ' || vgErrMsg );

 END SPACTPEDIDODIFREMISION;

 FUNCTION FNVALIDADIAENVIO
  RETURN NUMBER
  IS
  /************************************************************************************************************
    Proyecto:              Uniformes Comercio
    Descripcion:           Consulta pedidos pendientes SPPI
    Parametros de entrada: 
    Parametros de salida:  CURSOR
    Parametros de ent-sal: No aplica
    Valor de retorno:      No aplica
    Creador:               Kristian Ortiz
    Fecha de creacion:     03/04/2018
 *************************************************************************************************************/
  	 vlValido NUMBER;
  	 vlDia NUMBER;
  	 BEGIN

	 SELECT COUNT(FIDIA)
	   INTO vlDia
	   FROM UNIFORMES.TADIASSPPI
	  WHERE FIANIO = EXTRACT(YEAR FROM SYSDATE)
	    AND FIMES  = EXTRACT(MONTH FROM SYSDATE)
	    AND FIDIA    = EXTRACT(DAY FROM SYSDATE);

	 IF vlDia > csgCero THEN
	 	vlValido := 0;
	 ELSE
	 	vlValido := 1;
	 END IF;

	 RETURN vlValido;

	 EXCEPTION
     WHEN OTHERS THEN
        vgErrCode := SQLCODE;
        vgErrMsg := SQLERRM;
        RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PASRVUNIFORMESCOMERCIO.FNVALIDADIAENVIO": ' || vgErrMsg);

 END FNVALIDADIAENVIO; 

  FUNCTION FNCONSULTAPENDIENTESSPPI
  RETURN rcgCursor
  IS
  /************************************************************************************************************
    Proyecto:              Uniformes Comercio
    Descripcion:           Consulta pedidos pendientes SPPI
    Parametros de entrada: 
    Parametros de salida:  CURSOR
    Parametros de ent-sal: No aplica
    Valor de retorno:      No aplica
    Creador:               Kristian Ortiz
    Fecha de creacion:     03/04/2018
  *************************************************************************************************************/
  	 curCursorSalida rcgCursor;
	 vlEstEntregado  NUMBER(1):= 7;
	 vlSolSem NUMBER(1):= 1;
	 vlSolNvo NUMBER(1):= 3;

	 BEGIN
	    OPEN curCursorSalida FOR
	        SELECT  SP.FCCLAVEUSUARIO 
		           ,SP.FCIDSISTEMASATELITAL
		           ,SP.FCCLAVECENTROPROVEEDOR
		           ,SP.FCCLAVESERVICIO
		           ,LPAD (SP.FCCLAVESOCIEDAD ,4 ,0) FCCLAVESOCIEDAD
		           ,D.FIFOLIOSOLICITUD
		           ,D.FIIDDETALLE
		           ,SP.FCDESCRIPCION 
		           ,SP.FCCONCEPTO 
		           ,SP.FCMONEDA
		           ,TO_CHAR(TRUNC(SYSDATE, 'MM'), 'dd/mm/yyyy') FECHA_INICIAL
		           ,TO_CHAR(TRUNC(LAST_DAY(SYSDATE)), 'dd/mm/yyyy') FECHA_FINAL
		           ,(D.FICANTIDAD * PR.FNCOSTO)  AS  IMPORTETOTAL
		           ,SP.FCORDEN
		           ,E.FICECO
		           ,E.FIEMPLEADO 
		           ,D.FIPAIS
		           ,D.FICANAL
		           ,D.FISUCURSAL
		           ,D.FISKU
		           ,D.FIPEDIDO
		           ,D.FIESTATUSSOL FIESTATUSPEDIDO
		           ,TO_CHAR(D.FDFECHAACT,'DD/MM/YYYY HH24:MI:SS') FDFECHAACT
	          FROM UNIFORMES.TASOLICITUDESDETALLE D
	    INNER JOIN UNIFORMES.TASOLICITUDES S
	            ON S.FIFOLIOSOLICITUD = D.FIFOLIOSOLICITUD
	    INNER JOIN UNIFORMES.TAEMPLEADOS E
	            ON E.FIEMPLEADO = S.FIIDEMPLEADO
	    INNER JOIN UNIFORMES.TACECO C
	            ON C.FICC = E.FICECO
	    INNER JOIN UNIFORMES.TAPARAMETROSSPPI SP
	            ON SP.FICANAL = C.FCIDCANAL
	    INNER JOIN UNIFORMES.TAPRECIOS P
	  			ON S.FIIDTIPOSOLICITUD = P.FIIDTIPOSOLICITUD
	           AND D.FIIDTIPOPRENDA = P.FIIDTIPOPRENDA
	    INNER JOIN UNIFORMES.TAPRENDAS PR
	            ON PR.FISKU = D.FISKU
	         WHERE S.FIIDTIPOSOLICITUD IN (vlSolSem,vlSolNvo)
	           AND D.FIESTATUSSOL = vlEstEntregado;
	 RETURN curCursorSalida;

	 EXCEPTION
     WHEN OTHERS THEN
        vgErrCode := SQLCODE;
        vgErrMsg := SQLERRM;
        RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PASRVUNIFORMESCOMERCIO.FNCONSULTAPENDIENTESSPPI": ' || vgErrMsg);

  END FNCONSULTAPENDIENTESSPPI;  

  FUNCTION FNCONSSPPIPORACTUALIZAR
  RETURN rcgCursor
  IS
  /************************************************************************************************************
    Proyecto:              Uniformes Comercio
    Descripcion:           Consulta pedidos pendientes SPPI
    Parametros de entrada: 
    Parametros de salida:  CURSOR
    Parametros de ent-sal: No aplica
    Valor de retorno:      No aplica
    Creador:               Kristian Ortiz
    Fecha de creacion:     03/04/2018
 *************************************************************************************************************/
  	 curCursorSalida rcgCursor;
	 vlEstAplSPPI  NUMBER(1):= 1;
	 vlEstSolSPPI NUMBER(1):= 9;
	 BEGIN
	    OPEN curCursorSalida FOR
	        SELECT D.FIFOLIOSOLICITUD,
	        	   D.FIIDDETALLE,
	        	   D.FIPEDIDO,
	        	   vlEstSolSPPI AS FIESTATUSPEDIDO,
	        	   D.FIPAIS,
	        	   D.FICANAL,
	        	   D.FISUCURSAL,
	        	   D.FISKU,
	        	   D.FIFOLIOCARGA,
	        	   P.FCCLAVEUSUARIO,
	        	   P.FCIDSISTEMASATELITAL
	          FROM UNIFORMES.TADISTRIBUCIONSPPI D
	    INNER JOIN UNIFORMES.TAPARAMETROSSPPI P
	            ON D.FICANAL = P.FICANAL
	         WHERE FIESTATUS = vlEstAplSPPI;
	 RETURN curCursorSalida;

	 EXCEPTION
     WHEN OTHERS THEN
        vgErrCode := SQLCODE;
        vgErrMsg := SQLERRM;
        RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PASRVUNIFORMESCOMERCIO.FNCONSSPPIPORACTUALIZAR": ' || vgErrMsg);

 END FNCONSSPPIPORACTUALIZAR; 

  PROCEDURE SPACTUALIZAPEDIDOSSPPI(
  	paCargasSPPI UNIFORMES.TYPEARRCARGASPPI
  )
  IS
  /************************************************************************************************************
    Proyecto:              Uniformes Comercio
    Descripcion:           Consulta pedidos pendientes SPPI
    Parametros de entrada: 
    Parametros de salida:  CURSOR
    Parametros de ent-sal: No aplica
    Valor de retorno:      No aplica
    Creador:               Kristian Ortiz
    Fecha de creacion:     03/04/2018
   *************************************************************************************************************/
  	 vlEstAnt NUMBER(1):= 0;
  	 vlEstNvo NUMBER(1):= 0;
  	 vlEstEnt NUMBER(1):= 7;
  	 vlEstSPPI NUMBER(1):= 9;
  	 BEGIN
	 FOR indC IN 1..paCargasSPPI.count
     LOOP

    	MERGE INTO UNIFORMES.TADISTRIBUCIONSPPI DSPPI
    	     USING (SELECT paCargasSPPI(indC).FIFOLIOSOLICITUD FIFOLIOSOLICITUD,
						   paCargasSPPI(indC).FIIDDETALLE FIIDDETALLE,
						   paCargasSPPI(indC).FIPEDIDO FIPEDIDO,
						   paCargasSPPI(indC).FIPAIS FIPAIS,
						   paCargasSPPI(indC).FICANAL FICANAL,
						   paCargasSPPI(indC).FISUCURSAL FISUCURSAL,
						   paCargasSPPI(indC).FISKU FISKU,
						   paCargasSPPI(indC).FIFOLIOCARGA FIFOLIOCARGA,
						   paCargasSPPI(indC).FIPORCAVANCE FIPORCAVANCE,
						   paCargasSPPI(indC).FCDOCUMENTO FCDOCUMENTO,
						   paCargasSPPI(indC).FCOBSERVACIONES FCOBSERVACIONES,
						   paCargasSPPI(indC).FIESTATUS FIESTATUS
    	              FROM DUAL) WSD
                ON (DSPPI.FIFOLIOSOLICITUD = WSD.FIFOLIOSOLICITUD
               AND  DSPPI.FIIDDETALLE = WSD.FIIDDETALLE
               AND  DSPPI.FIPEDIDO = WSD.FIPEDIDO
               AND  DSPPI.FIPAIS = WSD.FIPAIS
               AND  DSPPI.FICANAL = WSD.FICANAL
               AND  DSPPI.FISUCURSAL = WSD.FISUCURSAL
               AND  DSPPI.FISKU = WSD.FISKU
               )
       WHEN MATCHED THEN
         UPDATE 
            SET FIPORCAVANCE = WSD.FIPORCAVANCE,
                FCDOCUMENTO = WSD.FCDOCUMENTO,
                FCOBSERVACIONES = WSD.FCOBSERVACIONES,
                FIESTATUS = WSD.FIESTATUS,
                FDFECHAACT = SYSDATE
      WHEN NOT MATCHED THEN
         INSERT (FIFOLIOSOLICITUD,
                 FIIDDETALLE,
                 FIPEDIDO,
                 FIPAIS,
                 FICANAL,
                 FISUCURSAL,
                 FISKU,
                 FIFOLIOCARGA,
                 FIPORCAVANCE,
                 FCDOCUMENTO,
                 FCOBSERVACIONES,
                 FDFECHA,
                 FDFECHAACT,
                 FIESTATUS)
         VALUES (WSD.FIFOLIOSOLICITUD,
                 WSD.FIIDDETALLE,
                 WSD.FIPEDIDO,
                 WSD.FIPAIS,
                 WSD.FICANAL,
                 WSD.FISUCURSAL,
                 WSD.FISKU,
                 WSD.FIFOLIOCARGA,
                 csgCero,
                 ' ',
                 WSD.FCOBSERVACIONES,
                 SYSDATE,
                 SYSDATE,
                 paCargasSPPI(indC).FIESTATUS);        

     /*VALIDA EL NUEVO ESTADO PARA BITACORA*/
     IF paCargasSPPI(indC).FIESTATUS = csgUno AND paCargasSPPI(indC).FIESTATUSPEDIDO = vlEstEnt THEN 
	     vlEstAnt := paCargasSPPI(indC).FIESTATUSPEDIDO;
	  	 vlEstNvo := vlEstSPPI;

	 ELSE
	 	 vlEstAnt := paCargasSPPI(indC).FIESTATUSPEDIDO;
	  	 vlEstNvo := paCargasSPPI(indC).FIESTATUSPEDIDO;
     END IF;

     UPDATE UNIFORMES.TASOLICITUDESDETALLE
        SET FIESTATUSSOL = vlEstNvo,
            FDFECHAACT = SYSDATE
      WHERE FIFOLIOSOLICITUD = paCargasSPPI(indC).FIFOLIOSOLICITUD
     	AND FIIDDETALLE = paCargasSPPI(indC).FIIDDETALLE
     	AND FIPEDIDO = paCargasSPPI(indC).FIPEDIDO;

     UNIFORMES.PASRVUNIFORMESCOMERCIO.SPGUARDABITACORA(paCargasSPPI(indC).FIFOLIOSOLICITUD, 
     												   paCargasSPPI(indC).FIIDDETALLE,
     												   paCargasSPPI(indC).FIPEDIDO, 
     												   ' ',
     												   vlEstAnt,
     												   vlEstNvo, 
     												   paCargasSPPI(indC).FCOBSERVACIONES, 
     												   CASE WHEN paCargasSPPI(indC).FIESTATUS = csgCero THEN csgCero ELSE csgUno END );

     END LOOP;

	 COMMIT;
	 EXCEPTION
     WHEN OTHERS THEN
     	ROLLBACK;
        vgErrCode := SQLCODE;
        vgErrMsg := SQLERRM;
        RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PASRVUNIFORMESCOMERCIO.SPACTUALIZAPEDIDOSSPPI": ' || vgErrMsg);

 END SPACTUALIZAPEDIDOSSPPI; 

 FUNCTION FNEMPLEADOACTIVO(
    paNoEmpleado UNIFORMES.TAEMPLEADOS.FIEMPLEADO%TYPE)
 RETURN NUMBER
 IS
 vlActivo   NUMBER(1);
 BEGIN
    SELECT (CASE FCSITUACION
                WHEN 'A' THEN 1
                ELSE 0
            END) INTO vlActivo
    FROM UNIFORMES.TAEMPLEADOS 
    WHERE FIEMPLEADO = paNoEmpleado;
 RETURN vlActivo;
 END FNEMPLEADOACTIVO;

END PASRVUNIFORMESCOMERCIO;