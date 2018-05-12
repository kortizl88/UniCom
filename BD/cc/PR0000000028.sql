CREATE OR REPLACE PACKAGE                       UNIFORMES.PASRVUNIFORMESCOMERCIO
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

 FUNCTION FNCONSSOLPENDGCDACTCDNCNE(
    paNoTipoSolicitud  NUMBER)
 RETURN rcgCursor;

 PROCEDURE SPACTSOLICITUDESDETALLE(
    paSolicitudesDetalle IN UNIFORMES.TYPEARRSOLICITUDDETALLE,
    paResultado OUT NUMBER);

 PROCEDURE SPACTNOTASCARGOENTRADA(
    paNotasCargoEntrada IN UNIFORMES.TYPEARRNOTACARGOENTRADA,
    paResultado OUT NUMBER);

 PROCEDURE SPCONSULTASOLDETDESCSAP(
    curResultado OUT rcgCursor);

 PROCEDURE SPGUARDADISTRIBUCIONSAP( 
    paDistribucionesSAP IN UNIFORMES.TYPEARRDISTRIBUCIONSAP);

 PROCEDURE SPACTUALIZADESCSAPXPED(
    paDescuentosSAP IN UNIFORMES.TYPEARRDESCUENTOSSAP,
    paNoRegistrosAct OUT NUMBER);

 FUNCTION FNESTATUSCDRUTADESCXSOLICITUD(
    paNoEstatusCD           UNIFORMES.TASOLICITUDESDETALLE.FIESTATUSCD%TYPE,
    paDescripcionCD         UNIFORMES.TABITACORASOLICITUD.FCCOMENTARIOS%TYPE,
    paDescripcionBitacora   UNIFORMES.TABITACORASOLICITUD.FCCOMENTARIOS%TYPE,    
    paNoRuta                UNIFORMES.TASOLICITUDESDETALLE.FIRUTA%TYPE,
    paNoEstatusRemision     UNIFORMES.TASOLICITUDESDETALLE.FIRUTA%TYPE)
 RETURN NUMBER;

 FUNCTION FNCONSSKUXKITTALLAGENEROPRENDA(
    paNoKit         UNIFORMES.TASKUSXKIT.FIKIT%TYPE,
    paNoTalla       UNIFORMES.TAPRENDAS.FITALLA%TYPE,
    paCadenaGenero  UNIFORMES.TAEMPLEADOS.FCGENERO%TYPE,
    paTipoPrenda    UNIFORMES.TASOLICITUDESDETALLE.FIIDTIPOPRENDA%TYPE)
 RETURN NUMBER;

 FUNCTION FNREGRESANUMERO(
    paCadena UNIFORMES.TACECO.FCIDCANAL%TYPE)
 RETURN NUMBER;

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
 
 FUNCTION FNGENERACONSDISTSAP(
    paFolioSolicitud    UNIFORMES.TADISTRIBUCIONSAP.FIFOLIOSOLICITUD%TYPE,
    paIDDetalle         UNIFORMES.TADISTRIBUCIONSAP.FIIDDETALLE%TYPE,
    paPais              UNIFORMES.TADISTRIBUCIONSAP.FIPAIS%TYPE,
    paCanal             UNIFORMES.TADISTRIBUCIONSAP.FICANAL%TYPE,
    paSucursal          UNIFORMES.TADISTRIBUCIONSAP.FISUCURSAL%TYPE,
    paPedido            UNIFORMES.TADISTRIBUCIONSAP.FIPEDIDO%TYPE,
    paSKU               UNIFORMES.TADISTRIBUCIONSAP.FISKU%TYPE)
 RETURN NUMBER;
 
 FUNCTION FNCONSULTAESTATUSABASTO
 RETURN rcgCursor;
 
 FUNCTION FNCONSULTATIPOSERROR
 RETURN rcgCursor;
 
END PASRVUNIFORMESCOMERCIO;

CREATE OR REPLACE PACKAGE BODY            UNIFORMES.PASRVUNIFORMESCOMERCIO
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
 CURSOR curEquivalenciaCanales IS (SELECT FICANAL,FICANALCECO FROM UNIFORMES.TAEQUIVALENCIACANALES);
 
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
                SOLICITUDES.FIESTATUSSOL,
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
                    SD.FIESTATUSSOL,
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
                SD.FIESTATUSSOL,
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

 FUNCTION FNCONSSOLPENDGCDACTCDNCNE(
    paNoTipoSolicitud  NUMBER
 )
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
 curCursorSalida            rcgCursor;
 csgNoGrabarCD              CONSTANT NUMBER(1) := 1;
 csgNoActEstatus            CONSTANT NUMBER(1) := 2;
 csgNoActNotaCargoEntrada   CONSTANT NUMBER(1) := 3;
 BEGIN

    OPEN curCursorSalida FOR
        SELECT  SD.FIFOLIOSOLICITUD,
                E.FIEMPLEADO,
                SD.FIPAIS,
                SD.FICANAL,
                SD.FISUCURSAL,
                T.FCDIRIP,
                SD.FIIDDETALLE,
                SD.FIPEDIDO,
                P.FISKU,
                SD.FIESTATUSSOL,
                P.FITALLA,
                SD.FICANTIDAD,
                SD.FIRUTA
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
        WHERE   SD.FIESTATUSSOL IN (SELECT * FROM TABLE(    CASE paNoTipoSolicitud
                                                                WHEN csgNoGrabarCD THEN sys.odcinumberlist(csgSolicitadoTienda) 
                                                                WHEN csgNoActEstatus THEN sys.odcinumberlist(csgSolicitadoCD,csgAtendidoCD,csgCaminoTienda)
                                                                WHEN csgNoActNotaCargoEntrada THEN sys.odcinumberlist(csgSolicitadoCD,csgAtendidoCD,csgCaminoTienda,csgRecibidoTienda)
                                                            END)) AND
                SD.FIPEDIDO > csgCero AND
                SD.FIACTIVO = csgUno        
        ORDER BY    S.FIFOLIOSOLICITUD,
                    SD.FIIDDETALLE,
                    E.FIEMPLEADO;
 RETURN curCursorSalida;

 EXCEPTION
    WHEN OTHERS THEN
        vgErrCode := SQLCODE;
        vgErrMsg := SQLERRM;
        RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PASRVUNIFORMESCOMERCIO.FNCONSSOLPENDGRABARCD": ' || vgErrMsg);

 END FNCONSSOLPENDGCDACTCDNCNE;

 PROCEDURE SPACTSOLICITUDESDETALLE(
    paSolicitudesDetalle IN UNIFORMES.TYPEARRSOLICITUDDETALLE,
    paResultado OUT NUMBER)
 IS
 /*************************************************************
   Proyecto:                         Sistema de Uniformes
   Descripcion:                      Actualiza los estatus de la tabla de TASOLICITUDESDETALLE[0-5]
   Parametros de entrada:            SolicitudesDetalle     paResultado
   Parametros de salida:             No aplica
   Parametros de entrada-salida      No aplica
   Precondiciones:                   Tener creado el esquema
   Creador:                          Luis Daniel Rodriguez Garcia
   Fecha de creacion:                14 Abril del 2018
 *************************************************************/             
 cslInactivo                    CONSTANT NUMBER(1) := 1;
 vlCadenaComentariosBitacora    UNIFORMES.TABITACORASOLICITUD.FCCOMENTARIOS%TYPE;
 vlNoEstatusSolicitud           UNIFORMES.TASOLICITUDESDETALLE.FIESTATUSSOL%TYPE;
 vlNoEstatusAnterior            UNIFORMES.TABITACORASOLICITUD.FIESTATUSANT%TYPE;
 vlNoEstatusNuevo               UNIFORMES.TABITACORASOLICITUD.FIESTATUSNVO%TYPE;
 vlNoRegistros                  NUMBER;
 BEGIN	

    FOR i IN paSolicitudesDetalle.FIRST..paSolicitudesDetalle.LAST LOOP
        -- SI NO HAY ERROR EN EL WEB SERVICES
        IF paSolicitudesDetalle(i).FIERROR = csgCero THEN  
            --GENERA EL FIESTATUSCD A FIESTATUSSOL
            vlNoEstatusSolicitud := UNIFORMES.PASRVUNIFORMESCOMERCIO.FNESTATUSCDRUTADESCXSOLICITUD( paSolicitudesDetalle(i).FIESTATUSCD,
                                                                                                    paSolicitudesDetalle(i).FCMENSAJECD,
                                                                                                    paSolicitudesDetalle(i).FCDESCRIPCIONBIT,
                                                                                                    paSolicitudesDetalle(i).FIRUTA,
                                                                                                    paSolicitudesDetalle(i).FIESTATUSREMISION);
            --VALIDA EL QUE ESTATUS PARA ACTUALIZAR NO SEA EL MISMO
            IF paSolicitudesDetalle(i).FIESTATUSSOL <> vlNoEstatusSolicitud THEN 
                --DESCRIBE LA CADENA EL TIPO DE SOLICITUD DE COMENTARIOS EN BITACORA
                vlCadenaComentariosBitacora := UNIFORMES.PAWEBUNIFORMESCOMERCIO.FNCADENAESTADOESTATUS(vlNoEstatusSolicitud);
                --CONSULTA EL ESTATUS ANTERIOR
                vlNoEstatusAnterior := paSolicitudesDetalle(i).FIESTATUSSOL;
                vlNoEstatusNuevo := vlNoEstatusSolicitud;
                --SI ESTATUSSOLICITUD ES DIFERENTE DE CANCELADO
                IF vlNoEstatusSolicitud <> csgCancelado THEN    
                    vlNoRegistros := vlNoRegistros + csgUno;
                    --ACTUALIZA EL NUEVO ESTATUS DE LAS SOLICITUDESDETALLE
                    MERGE INTO UNIFORMES.TASOLICITUDESDETALLE SD
                    USING (SELECT 	paSolicitudesDetalle(i).FIFOLIOSOLICITUD    AS FIFOLIOSOLICITUD,
                                    paSolicitudesDetalle(i).FIIDDETALLE         AS FIIDDETALLE,
                                    paSolicitudesDetalle(i).FIPAIS              AS FIPAIS,
                                    paSolicitudesDetalle(i).FICANAL             AS FICANAL,
                                    paSolicitudesDetalle(i).FISUCURSAL          AS FISUCURSAL,
                                    paSolicitudesDetalle(i).FIPEDIDO            AS FIPEDIDO,
                                    paSolicitudesDetalle(i).FISKU               AS FISKU
                            FROM SYS.DUAL) TYPEARRAYSOLICITUDESDETALLE
                    ON  (   SD.FIFOLIOSOLICITUD  = TYPEARRAYSOLICITUDESDETALLE.FIFOLIOSOLICITUD AND
                            SD.FIIDDETALLE       = TYPEARRAYSOLICITUDESDETALLE.FIIDDETALLE AND
                            SD.FIPAIS            = TYPEARRAYSOLICITUDESDETALLE.FIPAIS AND
                            SD.FICANAL           = TYPEARRAYSOLICITUDESDETALLE.FICANAL AND
                            SD.FISUCURSAL        = TYPEARRAYSOLICITUDESDETALLE.FISUCURSAL AND
                            SD.FIACTIVO          = csgUno)
                    WHEN MATCHED THEN
                        UPDATE SET  SD.FIPEDIDO = paSolicitudesDetalle(i).FIPEDIDO,
                                    SD.FISKU = paSolicitudesDetalle(i).FISKU,
                                    SD.FIESTATUSSOL = vlNoEstatusNuevo,
                                    SD.FIESTATUSCD =  paSolicitudesDetalle(i).FIESTATUSCD,
                                    SD.FCMENSAJECD = paSolicitudesDetalle(i).FCMENSAJECD,
                                    SD.FIRUTA =  paSolicitudesDetalle(i).FIRUTA,
                                    SD.FDFECHAACT = SYSDATE;
                -- SOLICITUDES DETALLE (CANCELADAS DEFINITIVAS)                    
                ELSE 
                    vlNoEstatusAnterior := paSolicitudesDetalle(i).FIESTATUSSOL;
                    vlNoEstatusNuevo := csgCancelado;
                    UPDATE  UNIFORMES.TASOLICITUDESDETALLE
                        SET FIACTIVO = cslInactivo,
                            FIESTATUSSOL = csgCancelado,
                            FIESTATUSCD = paSolicitudesDetalle(i).FIESTATUSCD,
                            FCMENSAJECD = paSolicitudesDetalle(i).FCMENSAJECD,
                            FIRUTA =  paSolicitudesDetalle(i).FIRUTA,
                            FDFECHAACT = SYSDATE
                    WHERE   FIFOLIOSOLICITUD  = paSolicitudesDetalle(i).FIFOLIOSOLICITUD AND
                            FIIDDETALLE       = paSolicitudesDetalle(i).FIIDDETALLE AND
                            FIPAIS            = paSolicitudesDetalle(i).FIPAIS AND
                            FICANAL           = paSolicitudesDetalle(i).FICANAL AND
                            FISUCURSAL        = paSolicitudesDetalle(i).FISUCURSAL AND
                            FIPEDIDO          = paSolicitudesDetalle(i).FIPEDIDO AND
                            FISKU             = paSolicitudesDetalle(i).FISKU;       
                END IF;
                -- GUARDA EN LA BITACORA EL ULTIMO ESTATUS
                UNIFORMES.PAWEBUNIFORMESCOMERCIO.SPGUARDABITACORA(   
                    paSolicitudesDetalle(i).FIFOLIOSOLICITUD,
                    paSolicitudesDetalle(i).FIIDDETALLE,
                    paSolicitudesDetalle(i).FIPEDIDO,
                    paSolicitudesDetalle(i).FCXMLRESPONSE, 
                    vlNoEstatusAnterior,
                    vlNoEstatusNuevo,
                    'TRACKING:' || vlCadenaComentariosBitacora || 
                    ',MSJ WSUC:' || paSolicitudesDetalle(i).FCMSJERROR  ||
                    ',ESTATUSCD:' || TO_CHAR(paSolicitudesDetalle(i).FIESTATUSCD) || 
                    ',MENSAJECD:' || paSolicitudesDetalle(i).FCMENSAJECD,
                    paSolicitudesDetalle(i).FIERROR);  
                END IF;
            ELSE
                vlNoEstatusAnterior := paSolicitudesDetalle(i).FIESTATUSSOL;
                vlNoEstatusNuevo := paSolicitudesDetalle(i).FIESTATUSSOL;
                UNIFORMES.PAWEBUNIFORMESCOMERCIO.SPGUARDABITACORA(   
                    paSolicitudesDetalle(i).FIFOLIOSOLICITUD,
                    paSolicitudesDetalle(i).FIIDDETALLE,
                    paSolicitudesDetalle(i).FIPEDIDO,
                    paSolicitudesDetalle(i).FCXMLRESPONSE, 
                    vlNoEstatusAnterior,
                    vlNoEstatusNuevo,
                    paSolicitudesDetalle(i).FCMSJERROR,
                    paSolicitudesDetalle(i).FIERROR); 
            END IF;                                           
        END LOOP;
 COMMIT;
 
 paResultado := vlNoRegistros;--NO REGISTROS EXITOSOS

 EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        vgErrCode := SQLCODE;
        vgErrMsg := SQLERRM;
        RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PASRVUNIFORMESCOMERCIO.SPACTSOLICITUDESDETALLE": ' || vgErrMsg);

  END SPACTSOLICITUDESDETALLE;
  
 PROCEDURE SPACTNOTASCARGOENTRADA(
    paNotasCargoEntrada IN UNIFORMES.TYPEARRNOTACARGOENTRADA,
    paResultado OUT NUMBER)
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
 BEGIN
    --BUSCA ERRORES PARA BITACORA
    FOR i IN paNotasCargoEntrada.FIRST..paNotasCargoEntrada.LAST LOOP             
        IF paNotasCargoEntrada(i).FIERROR = 1 THEN
            UNIFORMES.PAWEBUNIFORMESCOMERCIO.SPGUARDABITACORA(  paNotasCargoEntrada(i).FIFOLIOSOLICITUD,
                                                                paNotasCargoEntrada(i).FIIDDETALLE,
                                                                paNotasCargoEntrada(i).FIPEDIDO,
                                                                paNotasCargoEntrada(i).FCXMLRESPONSE, 
                                                                paNotasCargoEntrada(i).FIESTATUSSOL,
                                                                paNotasCargoEntrada(i).FIESTATUSSOL,
                                                                paNotasCargoEntrada(i).FCMSJERROR,
                                                                paNotasCargoEntrada(i).FIERROR);                 
        END IF;
    END LOOP;
    
    MERGE INTO UNIFORMES.TANOTASCARGOENTRADA NCE
    USING (SELECT 	NCE.FIFOLIOSOLICITUD,
                    NCE.FIIDDETALLE,
                    NCE.FIPAIS,
                    NCE.FICANAL,                
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
            ON
                SD.FIFOLIOSOLICITUD = NCE.FIFOLIOSOLICITUD AND
                SD.FIIDDETALLE = NCE.FIIDDETALLE AND
                SD.FIPAIS = NCE.FIPAIS AND 
                SD.FICANAL = NCE.FICANAL AND
                SD.FISUCURSAL = NCE.FISUCURSAL AND
                SD.FIPEDIDO = NCE.FIPEDIDO AND
                SD.FISKU = NCE.FISKU
            WHERE NCE.FIERROR = csgCero AND SD.FIACTIVO = csgUno) TYPEARRNOTACARGOENTRADA
    ON  (   NCE.FIPEDIDO    = TYPEARRNOTACARGOENTRADA.FIPEDIDO AND
            NCE.FISUCURSAL  = TYPEARRNOTACARGOENTRADA.FISUCURSAL AND
            NCE.FISKU       = TYPEARRNOTACARGOENTRADA.FISKU)
    WHEN MATCHED THEN
        UPDATE SET  NCE.FIFOLIOREMISION     = TYPEARRNOTACARGOENTRADA.FIFOLIOREMISION,
                    NCE.FDFECHAREMISION     = TYPEARRNOTACARGOENTRADA.FDFECHAREMISION,
                    NCE.FIRUTA              = TYPEARRNOTACARGOENTRADA.FIRUTA,
                    NCE.FINOTACARGO         = TYPEARRNOTACARGOENTRADA.FINOTACARGO,
                    NCE.FINOTAENTRADA       = TYPEARRNOTACARGOENTRADA.FINOTAENTRADA,
                    NCE.FCESTREMISION       = TYPEARRNOTACARGOENTRADA.FCESTREMISION,
                    NCE.FCOBSERVACIONNC     = TYPEARRNOTACARGOENTRADA.FCOBSERVACIONNC,
                    NCE.FCOBSERVACIONNE     = TYPEARRNOTACARGOENTRADA.FCOBSERVACIONNE,
                    NCE.FDFECHAACT          = SYSDATE,
                    NCE.FCFECHAACTCD        = TYPEARRNOTACARGOENTRADA.FCFECHAACTCD,
                    NCE.FICANTIDADSURT      = TYPEARRNOTACARGOENTRADA.FICANTIDADSURT
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
        VALUES(     TYPEARRNOTACARGOENTRADA.FIFOLIOSOLICITUD,
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
    paResultado := SQL%ROWCOUNT;
 EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
            vgErrCode := SQLCODE;
            vgErrMsg := SQLERRM;
            RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' "PASRVUNIFORMESCOMERCIO.SPACTNOTASCARGOENTRADA": ' || vgErrMsg );	
	
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
            AND S.FIIDTIPOSOLICITUD = cslDos -- TIPO SOLICITUD VOLUNTARIA
            AND E.FCSITUACION = cslEmpleadoActivo -- SI EL EMPLEADO ESTA ACTIVO
            AND SD.FIACTIVO = csgUno;
 EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
            vgErrCode := SQLCODE;
            vgErrMsg := SQLERRM;
            RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' "PASRVUNIFORMESCOMERCIO.SPCONSULTAPEDIDOSDESCUENTOSSAP": ' || vgErrMsg );

 END SPCONSULTASOLDETDESCSAP;

 PROCEDURE SPGUARDADISTRIBUCIONSAP( 
    paDistribucionesSAP IN UNIFORMES.TYPEARRDISTRIBUCIONSAP)
 IS
 /************************************************************************************************************
    Proyecto:              SRVUniformesComercio
    Descripcion:           Aplica los descuentos SAP de los empleados a las tablas
                           TABITACORASOLICITUD Y TADISTRIBUCIONSAP
    Parametros de entrada: TYPEAARAY
    Parametros de salida:  Respuesta del Stored Procedure
    Parametros de ent-sal: No aplica
    Valor de retorno:      No aplica 
    Creador:               Luis Daniel Rodriguez Garcia
    Fecha de creacion:     21 Febrero de 2017
 *************************************************************************************************************/  
 cslRespuestaOKSap              CONSTANT NUMBER(1) := 1;
 vlSecuenciaDistribucionSap     UNIFORMES.TADISTRIBUCIONSAP.FICONSECUTIVO%TYPE;          -- SECUENCIA DE TADESCUENTOSXPEDIDOS
 vlIdBitacora 	                UNIFORMES.TABITACORASOLICITUD.FIIDBITACORA%TYPE;            -- SECUENCIA DE TABITACORASOLICITUD
 vlNoEstatusAnterior            UNIFORMES.TABITACORASOLICITUD.FIESTATUSANT%TYPE;
 vlNoEstatusNuevo               UNIFORMES.TABITACORASOLICITUD.FIESTATUSNVO%TYPE;
 BEGIN
      FOR i IN paDistribucionesSAP.FIRST..paDistribucionesSAP.LAST LOOP
            --ESTATUS ENTREGADO
            vlNoEstatusAnterior := csgEntregado;
            --ESTATUS DESCUENTO SAP
            vlNoEstatusNuevo := csgDescuentoSAP;
            --SECUENCIA DE DISTRIBUCIONSAP  
            vlSecuenciaDistribucionSap :=  UNIFORMES.PASRVUNIFORMESCOMERCIO.FNGENERACONSDISTSAP(
                                                    paDistribucionesSAP(i).FIFOLIOSOLICITUD,
                                                    paDistribucionesSAP(i).FIIDDETALLE,
                                                    paDistribucionesSAP(i).FIPAIS,
                                                    paDistribucionesSAP(i).FICANAL,
                                                    paDistribucionesSAP(i).FIIDSUCURSAL,
                                                    paDistribucionesSAP(i).FIPEDIDO,
                                                    paDistribucionesSAP(i).FISKU);
            --GUARDA EN BITACORA                                        
            UNIFORMES.PAWEBUNIFORMESCOMERCIO.SPGUARDABITACORA(  paDistribucionesSAP(i).FIFOLIOSOLICITUD,
                                                                paDistribucionesSAP(i).FIIDDETALLE,
                                                                paDistribucionesSAP(i).FIPEDIDO,
                                                                paDistribucionesSAP(i).FCXMLRESPONSE, 
                                                                vlNoEstatusAnterior,
                                                                vlNoEstatusNuevo,
                                                                paDistribucionesSAP(i).FCTEXTXMLRESPONSE,
                                                                paDistribucionesSAP(i).FIIDERROR);      
                                                                
            -- SI EL ESTATUS SAP ES 1 ENTONCES SE INSERTA EN TADISTRIBUCIONSAP                                                                                            
            IF( paDistribucionesSAP(i).FIESTATUSSAP = cslRespuestaOKSap ) THEN 
                INSERT INTO UNIFORMES.TADISTRIBUCIONSAP(
                    FIFOLIOSOLICITUD,      
                    FIIDDETALLE,
                    FIPAIS,
                    FICANAL,
                    FISUCURSAL,
                    FIPEDIDO,
                    FISKU,
                    FICONSECUTIVO,
                    FCREFERENCIA,
                    FIESTATUS,
                    FCXMLREQUEST,
                    FCXMLRESPONSE)   
                VALUES(                                        
                    paDistribucionesSAP(i).FIFOLIOSOLICITUD,
                    paDistribucionesSAP(i).FIIDDETALLE,
                    paDistribucionesSAP(i).FIPAIS,
                    paDistribucionesSAP(i).FICANAL,
                    paDistribucionesSAP(i).FIIDSUCURSAL,
                    paDistribucionesSAP(i).FIPEDIDO,
                    paDistribucionesSAP(i).FISKU,
                    vlSecuenciaDistribucionSap,
                    paDistribucionesSAP(i).FCREFERENCIASAP,
                    paDistribucionesSAP(i).FIESTATUSSAP,
                    paDistribucionesSAP(i).FCXMLREQUEST,
                    paDistribucionesSAP(i).FCXMLRESPONSE);
                    
                UPDATE UNIFORMES.TASOLICITUDESDETALLE 
                    SET FIESTATUSSOL = csgDescuentoSAP 
                WHERE   FIFOLIOSOLICITUD = paDistribucionesSAP(i).FIFOLIOSOLICITUD
                    AND FIIDDETALLE = paDistribucionesSAP(i).FIIDDETALLE
                    AND FIPAIS = paDistribucionesSAP(i).FIPAIS
                    AND FICANAL = paDistribucionesSAP(i).FICANAL
                    AND FISUCURSAL = paDistribucionesSAP(i).FIIDSUCURSAL
                    AND FIPEDIDO = paDistribucionesSAP(i).FIPEDIDO
                    AND FISKU = paDistribucionesSAP(i).FISKU;               
            END IF;

    END LOOP;
	COMMIT;
    EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
            vgErrCode := SQLCODE;
            vgErrMsg := SQLERRM;
            RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' "PASRVUNIFORMESCOMERCIO.SPGUARDADISTRIBUCIONSAP": ' || vgErrMsg );
 END SPGUARDADISTRIBUCIONSAP;

 PROCEDURE SPACTUALIZADESCSAPXPED(
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
    
    MERGE INTO UNIFORMES.TADESCUENTOSSAPXPEDIDO DSAP
        USING (SELECT   DESCSAP.FIFOLIOSOLICITUD,
                        DESCSAP.FIPEDIDO,
                        DESCSAP.FCREFERENCIA,
                        DESCSAP.FCSOCIEDAD,
                        DESCSAP.FCCNOMINA,
                        DESCSAP.FNTOTAL,
                        DESCSAP.FDFECHAPAGO,
                        DESCSAP.FISEMACTUAL,
                        DESCSAP.FNSALDO,
                        DESCSAP.FNPAGO,
                        SD.FIIDDETALLE,
                        SD.FIPAIS,
                        SD.FICANAL,
                        SD.FISUCURSAL,
                        SD.FISKU
                FROM TABLE(paDescuentosSAP) DESCSAP
                INNER JOIN  UNIFORMES.TASOLICITUDESDETALLE SD
                ON  SD.FIFOLIOSOLICITUD = DESCSAP.FIFOLIOSOLICITUD AND
                    SD.FIPEDIDO = DESCSAP.FIPEDIDO) TGENERAL
        ON (DSAP.FIFOLIOSOLICITUD = TGENERAL.FIFOLIOSOLICITUD AND
            DSAP.FIIDDETALLE = TGENERAL.FIIDDETALLE AND
            DSAP.FIPEDIDO = TGENERAL.FIPEDIDO AND
            DSAP.FIPAIS = TGENERAL.FIPAIS AND
            DSAP.FICANAL = TGENERAL.FICANAL AND
            DSAP.FISUCURSAL = TGENERAL.FISUCURSAL AND
            DSAP.FISKU = TGENERAL.FISKU AND
            DSAP.FISEMANADESCUENTO = TGENERAL.FISEMACTUAL)
    WHEN NOT MATCHED THEN
        INSERT (FIFOLIOSOLICITUD,
                FIIDDETALLE,
                FIPEDIDO,     
                FIPAIS,  
                FICANAL,
                FISUCURSAL,
                FISKU,
                FCSOCIEDAD,
                FDPAGO,
                FCREFERENCIA,
                FCCCNOMINA,
                FNTOTALDESCUENTO,
                FISEMANADESCUENTO,
                FNSALDO,
                FNPAGO)
        VALUES( TGENERAL.FIFOLIOSOLICITUD,
                TGENERAL.FIIDDETALLE,
                TGENERAL.FIPEDIDO,
                TGENERAL.FIPAIS,
                TGENERAL.FICANAL,
                TGENERAL.FISUCURSAL,
                TGENERAL.FISKU,
                TGENERAL.FCSOCIEDAD,
                TGENERAL.FDFECHAPAGO,
                TGENERAL.FCREFERENCIA,
                TGENERAL.FCCNOMINA,
                TGENERAL.FNTOTAL,
                TGENERAL.FISEMACTUAL,
                TGENERAL.FNSALDO,
                TGENERAL.FNPAGO);

 paNoRegistrosAct := SQL%ROWCOUNT;

 EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
            vgErrCode := SQLCODE;
            vgErrMsg := SQLERRM;
            RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' "PASRVUNIFORMESCOMERCIO.SPACTUALIZADESCSAPXPED": ' || vgErrMsg );

 END SPACTUALIZADESCSAPXPED;

 FUNCTION FNESTATUSCDRUTADESCXSOLICITUD(
    paNoEstatusCD           UNIFORMES.TASOLICITUDESDETALLE.FIESTATUSCD%TYPE,
    paDescripcionCD         UNIFORMES.TABITACORASOLICITUD.FCCOMENTARIOS%TYPE,
    paDescripcionBitacora   UNIFORMES.TABITACORASOLICITUD.FCCOMENTARIOS%TYPE,    
    paNoRuta                UNIFORMES.TASOLICITUDESDETALLE.FIRUTA%TYPE,
    paNoEstatusRemision     UNIFORMES.TASOLICITUDESDETALLE.FIRUTA%TYPE)
 RETURN NUMBER
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
 vlNoEstatusSolicitud           UNIFORMES.TASOLICITUDESDETALLE.FIESTATUSSOL%TYPE;
 csgCadenaGrabadoEnTienda       CONSTANT VARCHAR2(50) := 'SOLICITUD DETALLE GRABADA EN TIENDA';
 csgCadenaGrabadoEnCD           CONSTANT VARCHAR2(50) := 'SOLICITUD DETALLE GRABADA EN CD';
 csgCadenaCancelado             CONSTANT VARCHAR2(50) := 'CANCELED';
 csgCadenaFailed                CONSTANT VARCHAR2(50) := '%Failed%';
 cslCero                        CONSTANT NUMBER(1) := 0;
 cslDos                         CONSTANT NUMBER(1) := 2;
 cslTres                        CONSTANT NUMBER(1) := 3;
 cslVeinte                      CONSTANT NUMBER(2) := 20;
 cslDoscientos                  CONSTANT NUMBER(3) := 200;
 cslCuatrocientos               CONSTANT NUMBER(3) := 400;
 cslCuatrocientosCincuenta      CONSTANT NUMBER(3) := 450;
 cslCuatrocientosNoventa        CONSTANT NUMBER(3) := 490;
 cslCuatrocientosNoveintaDos    CONSTANT NUMBER(3) := 492;
 cslCuatrocientosNoveintaSeis   CONSTANT NUMBER(3) := 496;
 cslQuinientos                  CONSTANT NUMBER(3) := 500;
 cslSeiscientos                 CONSTANT NUMBER(3) := 600;
 cslSeiscientosCincuenta        CONSTANT NUMBER(3) := 650;
 cslOchocientosCincuenta        CONSTANT NUMBER(3) := 850;
 cslNovecientosCuarenta         CONSTANT NUMBER(3) := 940;
 BEGIN
    IF paNoEstatusCD = cslCero AND UPPER(trim(paDescripcionBitacora)) = csgCadenaGrabadoEnTienda THEN -- (SIN ESTATUS WSABASTO) SOLICITUD EN TIENDA
        vlNoEstatusSolicitud := csgSolicitadoTienda; --SOLICITADO EN TIENDA
    ELSIF paNoEstatusCD = cslCero AND UPPER(trim(paDescripcionBitacora)) = csgCadenaGrabadoEnCD THEN --PEDIDO CREADO (CD)                      
        vlNoEstatusSolicitud := csgSolicitadoCD; --SOLICITADO EN CD
    ELSIF paNoEstatusCD IN (cslVeinte,cslDoscientos) AND UPPER(trim(paDescripcionBitacora)) != csgCadenaGrabadoEnTienda THEN --PEDIDO CREADO (CD)                      
        vlNoEstatusSolicitud := csgSolicitadoCD; --SOLICITADO EN CD
    ELSIF paNoEstatusCD IN (cslCuatrocientos,cslCuatrocientosCincuenta,cslCuatrocientosNoveintaDos,cslCuatrocientosNoveintaSeis,cslQuinientos,cslSeiscientos,cslSeiscientosCincuenta) AND paDescripcionCD NOT LIKE csgCadenaFailed THEN --ASIGNADO EN ALMACEN (CD)          
        vlNoEstatusSolicitud := csgAtendidoCD; --ATENDIDO EN CD
    ELSIF paNoEstatusCD IN (cslCuatrocientos,cslCuatrocientosCincuenta,cslCuatrocientosNoveintaDos,cslCuatrocientosNoveintaSeis,cslQuinientos,cslSeiscientos,cslSeiscientosCincuenta) AND paDescripcionCD LIKE csgCadenaFailed THEN --ASIGNADO EN ALMACEN (CD)                
        vlNoEstatusSolicitud := csgAtendidoCD; --ATENDIDO EN CD            
    ELSIF paNoEstatusCD = cslCuatrocientosNoventa THEN --ATENDIENDO SOLICITUD                
        vlNoEstatusSolicitud := csgAtendidoCD; --ATENDIDO EN CD   
    ELSIF paNoEstatusCD = cslOchocientosCincuenta AND paNoRuta = cslCero THEN --REMISIONADO SIN RUTA (CD)              
        vlNoEstatusSolicitud := csgAtendidoCD; --ATENDIDO EN CD           
    ELSIF paNoEstatusCD = cslOchocientosCincuenta AND paNoEstatusRemision > cslCero THEN --ENVIADO A TIENDA              
        vlNoEstatusSolicitud := csgCaminoTienda; --EN CAMINO A TIENDA
    ELSIF paNoEstatusCD = cslNovecientosCuarenta OR UPPER(trim(paDescripcionCD)) = csgCadenaCancelado THEN --CANCELADO
        vlNoEstatusSolicitud := csgCancelado;          
    END IF;    
 RETURN vlNoEstatusSolicitud;
 
 END FNESTATUSCDRUTADESCXSOLICITUD; 

 FUNCTION FNCONSSKUXKITTALLAGENEROPRENDA(
    paNoKit         UNIFORMES.TASKUSXKIT.FIKIT%TYPE,
    paNoTalla       UNIFORMES.TAPRENDAS.FITALLA%TYPE,
    paCadenaGenero  UNIFORMES.TAEMPLEADOS.FCGENERO%TYPE,
    paTipoPrenda    UNIFORMES.TASOLICITUDESDETALLE.FIIDTIPOPRENDA%TYPE
 )
 RETURN NUMBER
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
 cslNoGeneroHombre      UNIFORMES.TAGENERO.FIIDGENERO%TYPE := 1; 
 cslNoGeneroMujer       UNIFORMES.TAGENERO.FIIDGENERO%TYPE := 2;
 cslNoGeneroUnisex      UNIFORMES.TAGENERO.FIIDGENERO%TYPE := 3;
 cslCadenaGeneroHombre  CONSTANT VARCHAR2(1) := 'H';
 cslCadenaGeneroMujer   CONSTANT VARCHAR2(1) := 'M';
 vlNoSKU UNIFORMES.TAPRENDAS.FISKU%TYPE := 0;
 BEGIN
	    SELECT P.FISKU 
	      INTO vlNoSKU 
	      FROM UNIFORMES.TASKUSXKIT SKIT
    INNER JOIN UNIFORMES.TAPRENDAS P
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

		UPDATE UNIFORMES.TASOLICITUDESDETALLE
		   SET FIESTATUSSOL = vlEstRecibido ,
		       FDFECHAACT = SYSDATE
		 WHERE FIFOLIOSOLICITUD = vlSol
		   AND FIIDDETALLE =  vlDet;

		 UNIFORMES.PAWEBUNIFORMESCOMERCIO.SPGUARDABITACORA(vlSol, vlDet, paPedido, ' ',vlEstEnCamino, vlEstRecibido, 'Remision : '||paRemision, 0);


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

		UNIFORMES.PAWEBUNIFORMESCOMERCIO.SPGUARDABITACORA(vlSol, vlDet, paPedido, ' ',vlEstPed, vlEstCancelado, 'Cancelado por diferencia de remision : '||paRemision, 1);	   


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

		 UNIFORMES.PAWEBUNIFORMESCOMERCIO.SPGUARDABITACORA(vlSol,vlIdDetalleSol, csgCero, 'SOLICITUD GENERADA POR RE INYECCION DIFERENCIA DE REMISION :'||paRemision , vlEstPed, csgUno, 'SOLICITUD GENERADA', csgCero);

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
		           ,LPAD (SP.FCCLAVESOCIEDAD , csgCuatro ,csgCero) FCCLAVESOCIEDAD
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

     UNIFORMES.PAWEBUNIFORMESCOMERCIO.SPGUARDABITACORA(paCargasSPPI(indC).FIFOLIOSOLICITUD, 
     												   paCargasSPPI(indC).FIIDDETALLE,
     												   paCargasSPPI(indC).FIPEDIDO, 
     												   paCargasSPPI(indC).FCDATOSPROC,
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
 vlActivo   NUMBER(1);
 BEGIN
    SELECT (CASE FCSITUACION
                WHEN 'A' THEN csgUno
                ELSE csgCero
            END) INTO vlActivo
    FROM UNIFORMES.TAEMPLEADOS 
    WHERE FIEMPLEADO = paNoEmpleado;
 RETURN vlActivo;
 END FNEMPLEADOACTIVO;
 
 FUNCTION FNGENERACONSDISTSAP(
    paFolioSolicitud    UNIFORMES.TADISTRIBUCIONSAP.FIFOLIOSOLICITUD%TYPE,
    paIDDetalle         UNIFORMES.TADISTRIBUCIONSAP.FIIDDETALLE%TYPE,
    paPais              UNIFORMES.TADISTRIBUCIONSAP.FIPAIS%TYPE,
    paCanal             UNIFORMES.TADISTRIBUCIONSAP.FICANAL%TYPE,
    paSucursal          UNIFORMES.TADISTRIBUCIONSAP.FISUCURSAL%TYPE,
    paPedido            UNIFORMES.TADISTRIBUCIONSAP.FIPEDIDO%TYPE,
    paSKU               UNIFORMES.TADISTRIBUCIONSAP.FISKU%TYPE)
 RETURN NUMBER
 IS
 /*************************************************************
   Proyecto:                         SRVUniformesComercio
   Descripcion:                      Consulta distrinucion sap. 
                                     Filtra: SolicitudGenerada
   Parametros de entrada:            No aplica
   Parametros de salida:             No aplica
   Parametros de entrada-salida      No aplica
   Precondiciones:                   Tener creado el esquema
   Creador:                          
   Fecha de creacion:                
  *************************************************************/
 vlConsecutivo  UNIFORMES.TADISTRIBUCIONSAP.FICONSECUTIVO%TYPE;
 BEGIN
     SELECT (NVL(MAX(FICONSECUTIVO), csgCero) + csgUno)
        INTO vlConsecutivo
    FROM UNIFORMES.TADISTRIBUCIONSAP
    WHERE   FIFOLIOSOLICITUD = paFolioSolicitud AND
            FIIDDETALLE = paIDDetalle AND
            FIPAIS = paPais AND
            FICANAL = paCanal AND
            FISUCURSAL = paSucursal AND
            FIPEDIDO = paPedido AND
            FISKU  = paSKU;
 RETURN vlConsecutivo;
 END FNGENERACONSDISTSAP;
 
 FUNCTION FNCONSULTAESTATUSABASTO
 RETURN rcgCursor
 IS
 /*************************************************************
   Proyecto:                         SRVUniformesComercio
   Descripcion:                      Consulta estados de abasto
                                     Filtra: SolicitudGenerada
   Parametros de entrada:            No aplica
   Parametros de salida:             No aplica
   Parametros de entrada-salida      No aplica
   Precondiciones:                   Tener creado el esquema
   Creador:                          
   Fecha de creacion:                
  *************************************************************/
 curCursorSalida rcgCursor;
 BEGIN
 OPEN curCursorSalida FOR 
    SELECT FIESTATUS, FCMENSAJE
        FROM UNIFORMES.TAESTATUSABASTO;
 RETURN curCursorSalida;
 END FNCONSULTAESTATUSABASTO;
 
 FUNCTION FNCONSULTATIPOSERROR
 RETURN rcgCursor
 IS
 /*************************************************************
   Proyecto:                         SRVUniformesComercio
   Descripcion:                      Consulta tipos de error 
                                     Filtra: SolicitudGenerada
   Parametros de entrada:            No aplica
   Parametros de salida:             No aplica
   Parametros de entrada-salida      No aplica
   Precondiciones:                   Tener creado el esquema
   Creador:                          
   Fecha de creacion:                
  *************************************************************/
 curCursorSalida rcgCursor;
 BEGIN
 OPEN curCursorSalida FOR 
    SELECT FIIDERROR, FCDESCRIPCION
        FROM UNIFORMES.TATIPOSERROR;
 RETURN curCursorSalida;
 END FNCONSULTATIPOSERROR;
 
END PASRVUNIFORMESCOMERCIO;