CREATE OR REPLACE PACKAGE           PAWEBUNIFORMESCOMERCIO
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
  
  FUNCTION FNCONSULTAINFOEMPLEADO(
      paNumEmpleado  IN UNIFORMES.TAEMPLEADOS.FIEMPLEADO%TYPE)
  RETURN rcgCursor;
  
  PROCEDURE SPGUARDABITACORA(
  	paSolicitud UNIFORMES.TABITACORASOLICITUD.FIFOLIOSOLICITUD%TYPE,
  	paDetalle   UNIFORMES.TABITACORASOLICITUD.FIIDDETALLE%TYPE,
  	paPedido    UNIFORMES.TABITACORASOLICITUD.FIPEDIDO%TYPE,
  	paDatosProc UNIFORMES.TABITACORASOLICITUD.FCDATOSPROCESO%TYPE,
  	paEstAnt    UNIFORMES.TABITACORASOLICITUD.FIESTATUSANT%TYPE,
  	paEstAct    UNIFORMES.TABITACORASOLICITUD.FIESTATUSNVO%TYPE,
  	paComent    UNIFORMES.TABITACORASOLICITUD.FCCOMENTARIOS%TYPE,
  	paTipoErr   UNIFORMES.TABITACORASOLICITUD.FIIDERROR%TYPE);

  FUNCTION FNCONSULTAMENUFUNCIONXNEGOCIO(
    paNoNegocio IN UNIFORMES.TACARGASXNEGOCIO.FIIDNEGOCIO%TYPE,
    paNoFuncionSap IN UNIFORMES.TAMENUSFUNCIONESXNEGOCIO.FIIDNEGOCIO%TYPE
  )
  RETURN rcgCursor;
   
  FUNCTION FNCONSULTAMENUEMPLEADO(
  	paNumEmpleado  IN UNIFORMES.TAEMPLEADOS.FIEMPLEADO%TYPE)
  RETURN rcgCursor;
  
  FUNCTION FNCONSINFOTIENDA(
      paPais UNIFORMES.TATIENDAS.FIPAIS%TYPE,
      paCanal UNIFORMES.TATIENDAS.FICANAL%TYPE,
      paTienda UNIFORMES.TATIENDAS.FISUCURSAL%TYPE)
  RETURN rcgCursor;
  
  FUNCTION FNCONSEMPLEDOSNUEVOINGRESO(
      paCeco UNIFORMES.TAEMPLEADOS.FICECO%TYPE)
  RETURN rcgCursor;
  
  FUNCTION FNCONSTIENDASCERCANAS(
      paPais UNIFORMES.TACECO.FIPAIS%TYPE,
      paCanal UNIFORMES.TACECO.FCIDCANAL%TYPE,
      paTienda UNIFORMES.TACECO.FICC%TYPE)
  RETURN rcgCursor;
  
  FUNCTION FNCONSKITEMPLEADO(
  	paNumEmp UNIFORMES.TAEMPLEADOS.FIEMPLEADO%TYPE,
  	paTipoSol UNIFORMES.TAPRECIOS.FIIDTIPOSOLICITUD%TYPE)
  RETURN rcgCursor;
  
  FUNCTION FNCONSKITEMPLEADOSTIENDA(
  	paPais UNIFORMES.TATIENDAS.FIPAIS%TYPE,
  	paCanal UNIFORMES.TATIENDAS.FICANAL%TYPE,
  	paTienda UNIFORMES.TATIENDAS.FISUCURSAL%TYPE,
  	paTipoSol UNIFORMES.TAPRECIOS.FIIDTIPOSOLICITUD%TYPE)
  RETURN rcgCursor;
  
  PROCEDURE SPGUARDASOLICITUD(
    paSolicitudes IN UNIFORMES.TYPEARRSOLICITUDPRENDA
   ,curResultado OUT rcgCursor );
  
  FUNCTION FNCONSULTASOLICITUDES(
      paNumeroEmpleado UNIFORMES.TASOLICITUDES.FIIDEMPLEADO%TYPE, 
      paNumeroSolicitudes NUMBER)
 RETURN rcgCursor;

 FUNCTION FNCONSULTASOLICITUD(
      paNoFolioSolicitud UNIFORMES.TASOLICITUDES.FIFOLIOSOLICITUD%TYPE)  
  RETURN rcgCursor;

 FUNCTION FNDEFINEDESCRIPCIONPRENDA(
    paSKU UNIFORMES.TASOLICITUDESDETALLE.FISKU%TYPE,
    paIDTipoPrenda UNIFORMES.TASOLICITUDESDETALLE.FIIDTIPOPRENDA%TYPE
 )
 RETURN VARCHAR2;
 
 FUNCTION FNCADENAESTADOESTATUS(
    paNoEstadoNuevo UNIFORMES.TASOLICITUDESDETALLE.FIESTATUSCD%TYPE
 )
 RETURN VARCHAR2;
 
 FUNCTION FNNOREMISION(
    paNoPedido UNIFORMES.TASOLICITUDESDETALLE.FIPEDIDO%TYPE,
    paNoSKU UNIFORMES.TASOLICITUDESDETALLE.FISKU%TYPE
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
  paFolioSolicitud UNIFORMES.TASOLICITUDESDETALLE.FIFOLIOSOLICITUD%TYPE
 )
 RETURN rcgCursor;

 FUNCTION FNINFORMACIONDESCUENTO(
  paFolioSolicitud UNIFORMES.TASOLICITUDESDETALLE.FIFOLIOSOLICITUD%TYPE,
  paNumeroPedido UNIFORMES.TASOLICITUDESDETALLE.FIPEDIDO%TYPE
 )
 RETURN rcgCursor;
 
 FUNCTION FNCADENAPORCENTAJE(
  paNoPorcentaje NUMBER
 )  
 RETURN VARCHAR2;
 
  FUNCTION FNCONSPEDIDOSXENTREGAR(
   paNumEmp UNIFORMES.TAEMPLEADOS.FIEMPLEADO%TYPE
  )
  RETURN rcgCursor;
  

  
END PAWEBUNIFORMESCOMERCIO;

CREATE OR REPLACE PACKAGE BODY            PAWEBUNIFORMESCOMERCIO
AS
  /*************************************************************
   Proyecto:                           Uniformes
   Descripcion:                        Paquete para sistema de uniformes Div. Comercial
   Parametros de entrada:              No aplica
   Parametros de salida:               No aplica
   Parametros de entrada-salida        No aplica
   Precondiciones:                     Tener creado el esquema
   Creador:                            
   Fecha de creacion:                  
   *************************************************************/
  	vgErrCode                   NUMBER(6)         := 0; -- Variable para el manejo de errores codigo
    vgErrMsg                    VARCHAR2(500 CHAR):= '';-- Variable para el manejo de errores mensaje
    csgCero                     CONSTANT NUMBER(1):=0;
    csgUno                      CONSTANT NUMBER(1):=1;
    csgDos                      CONSTANT NUMBER(1):=2;
    csgTres                     CONSTANT NUMBER(1):=3;    
    csgCuatro                   CONSTANT NUMBER(1):=4; 
    csgDieceNueve               CONSTANT NUMBER(2):=19;
    csgCien                     CONSTANT NUMBER(3):=100;
    csgFalso                    CONSTANT NUMBER(1):=0;    
    csgCierto                   CONSTANT NUMBER(1):=1;
    
    csgCancelado                CONSTANT NUMBER(1):=0;  -- Cancelado
    csgSolicitudGenerada        CONSTANT NUMBER(1):=1;  -- Solicitud Generada
    csgSolicitadoTienda         CONSTANT NUMBER(1):=2;  -- Solicitado en Tienda
    csgSolicitadoCD             CONSTANT NUMBER(1):=3;  -- Solicitado en CD
    csgAtendidoCD               CONSTANT NUMBER(1):=4;  -- Atendido en CD
    csgCaminoTienda             CONSTANT NUMBER(1):=5;  -- En camino a Tienda
    csgRecibidoTienda           CONSTANT NUMBER(1):=6;  -- Recibido en Tienda
    csgEntregado                CONSTANT NUMBER(1):=7;  -- Entregado
    csgCadenaCancelado          CONSTANT VARCHAR2(50 CHAR):='CANCELADO';            -- Cancelado
    csgCadenaSolicitudGenerada  CONSTANT VARCHAR2(50 CHAR):='SOLICITUD GENERADA';   -- Solicitud Generada
    csgCadenaSolicitadoTienda   CONSTANT VARCHAR2(50 CHAR):='SOLICITADO EN TIENDA'; -- Solicitado en Tienda
    csgCadenaSolicitadoCD       CONSTANT VARCHAR2(50 CHAR):='SOLICITADO EN CD';     -- Solicitado en CD
    csgCadenaAtendidoCD         CONSTANT VARCHAR2(50 CHAR):='ATENDIDO EN CD';       -- Atendido en CD
    csgCadenaCaminoTienda       CONSTANT VARCHAR2(50 CHAR):='EN CAMINO A TIENDA';   -- En camino a tienda    
    csgCadenaRecibidoTienda     CONSTANT VARCHAR2(50 CHAR):='RECIBIDO EN TIENDA';   -- Recibido en tienda
    csgCadenaEntregado          CONSTANT VARCHAR2(50 CHAR):='ENTREGADO';            -- Entregado
    
  FUNCTION FNCONSULTAINFOEMPLEADO(
      paNumEmpleado  IN UNIFORMES.TAEMPLEADOS.FIEMPLEADO%TYPE)
  RETURN rcgCursor
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
  curCursorSalida rcgCursor;
  
  BEGIN
    OPEN curCursorSalida FOR
      SELECT E.FIEMPLEADO
            ,E.FCNOMBRE
            ,FCGENERO
            ,FIPOSICION
            ,FCPOSICION
            ,FCSITUACION
            ,FIFUNCION
            ,F.FIIDNEGOCIO
            ,F.FISOLICITUDPLANTILLA
            ,N.FISOLICITAENTIENDA
            ,T.FIPAIS
            ,T.FICANAL
            ,T.FISUCURSAL FICECO
            ,T.FCNOMBRE FCCECO
            ,FCPAIS
            ,TO_CHAR(FDINGRESO,'DD/MM/YYYY') FDINGRESO
        FROM UNIFORMES.TAEMPLEADOS E
   LEFT JOIN UNIFORMES.TATIENDAS T
          ON SUBSTR(TRIM(TO_CHAR(E.FICECO)),3,4) = T.FISUCURSAL
   LEFT JOIN UNIFORMES.TAFUNCIONESXNEGOCIO F
          ON F.FIFUNCIONSAP = E.FIFUNCION
         AND T.FICANAL = F.FICANAL
   LEFT JOIN UNIFORMES.TANEGOCIOS N
          ON F.FIIDNEGOCIO = N.FIIDNEGOCIO   
       WHERE FIEMPLEADO = paNumEmpleado
         AND E.FCSITUACION = 'A';
       RETURN curCursorSalida;
       	EXCEPTION
          WHEN OTHERS THEN
              vgErrCode := SQLCODE;
              vgErrMsg := SQLERRM;
              RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PAWEBUNIFORMESCOMERCIO.FNCONSULTAINFOEMPLEADO": ' || vgErrMsg);
              
  END FNCONSULTAINFOEMPLEADO;
  
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
			 											FIPEDIDO,
			 											FIIDDETALLE, 
			 											FCDATOSPROCESO, 
			 											FIESTATUSANT, 
			 											FIESTATUSNVO, 
			 											FDFECHA, 
			 											FCCOMENTARIOS,
			 											FIIDERROR)
			        							VALUES  (vlIdBitacora,
			        									 paSolicitud,
			        									 paPedido,
			        							         paDetalle,
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
  
  FUNCTION FNCONSULTAMENUFUNCIONXNEGOCIO(
    paNoNegocio IN UNIFORMES.TACARGASXNEGOCIO.FIIDNEGOCIO%TYPE,
    paNoFuncionSap IN UNIFORMES.TAMENUSFUNCIONESXNEGOCIO.FIIDNEGOCIO%TYPE
  )
  RETURN rcgCursor
  IS
  /*************************************************************
   Proyecto:                         Sistema de Uniformes
   Descripcion:                      Consulta el tipo de menu que necesita el empleado
   Parametros de entrada:            paNoNegocio    paNoFuncionSap
   Parametros de salida:             curDatos       Cursor de referencia
   Parametros de entrada-salida      No aplica
   Precondiciones:                   Tener creado el esquema
   Creador:                          
   Fecha de creacion:                
  *************************************************************/
  curCursorSalida rcgCursor;
  vlNoCargasSemestrales NUMBER(3);
  
  BEGIN
  		SELECT COUNT(C.FIIDCARGA)
     	  INTO vlNoCargasSemestrales 
     	  FROM UNIFORMES.TACARGASXNEGOCIO CXN
    INNER JOIN UNIFORMES.TACARGAS C 
            ON C.FIIDCARGA = CXN.FIIDCARGA 
         WHERE CXN.FIIDNEGOCIO = paNoNegocio
           AND C.FIESTATUS = csgUno
           AND SYSDATE BETWEEN C.FDFECHAINICIAL AND C.FDFECHAFINAL;
            
    OPEN curCursorSalida FOR
	    SELECT  M.FIIDMENU,
	            M.FCTITULO,
	            M.FCDESCMENU,
	            M.FCRUTAENLACE
	      FROM UNIFORMES.TAMENUSFUNCIONESXNEGOCIO MFXN
	INNER JOIN UNIFORMES.TAMENUS M ON M.FIIDMENU = MFXN.FIIDMENU 
	     WHERE MFXN.FIFUNCIONSAP = paNoFuncionSap
	            AND((   vlNoCargasSemestrales > csgCero AND M.FIAPLICACARGA = csgUno)
	            OR (    vlNoCargasSemestrales > csgCero AND M.FIBLOQUEADOCARGA = csgCero)
	            OR (    vlNoCargasSemestrales = csgCero AND M.FIBLOQUEADOCARGA = csgUno)
	            OR (    M.FIAPLICACARGA = csgCero AND M.FIBLOQUEADOCARGA = csgCero)
	             );
    RETURN curCursorSalida;
    
  END FNCONSULTAMENUFUNCIONXNEGOCIO;
  
  FUNCTION FNCONSULTAMENUEMPLEADO(
  	paNumEmpleado  IN UNIFORMES.TAEMPLEADOS.FIEMPLEADO%TYPE)
  RETURN rcgCursor
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
  curCursorSalida rcgCursor;
  vlCargaActiva NUMBER(3);
  BEGIN
  	
  	BEGIN 
  	 SELECT FIIDCARGA
  	   INTO vlCargaActiva
  	   FROM UNIFORMES.TACARGAS C
  	  WHERE SYSDATE BETWEEN FDFECHAINICIAL AND FDFECHAFINAL
  	    AND FIESTATUS = csgUno;
  	  
  	 EXCEPTION
     WHEN NO_DATA_FOUND THEN
     vlCargaActiva := csgCero;
     END;	  
  	
    OPEN curCursorSalida FOR
      SELECT M.FIIDMENU
      		,M.FCTITULO
      		,M.FCDESCMENU
      		,M.FCRUTAENLACE
        FROM UNIFORMES.TAEMPLEADOS E
  INNER JOIN UNIFORMES.TAMENUSFUNCIONESXNEGOCIO MFN
          ON MFN.FIFUNCIONSAP = E.FIFUNCION
  INNER JOIN UNIFORMES.TAMENUS M
          ON MFN.FIIDMENU = M.FIIDMENU

       WHERE FIEMPLEADO = paNumEmpleado
         AND ( ( vlCargaActiva > csgCero AND M.FIAPLICACARGA = csgUno)
            OR ( vlCargaActiva > csgCero AND M.FIBLOQUEADOCARGA = csgCero)
            OR ( vlCargaActiva = csgCero AND M.FIBLOQUEADOCARGA = csgUno)
            OR ( M.FIAPLICACARGA = csgCero AND M.FIBLOQUEADOCARGA = csgCero)
             );
          
       RETURN curCursorSalida;
       	EXCEPTION
          WHEN OTHERS THEN
              vgErrCode := SQLCODE;
              vgErrMsg := SQLERRM;
              RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PAWEBUNIFORMESCOMERCIO.FNCONSULTAMENUEMPLEADO": ' || vgErrMsg);
              
  END FNCONSULTAMENUEMPLEADO;
    
  FUNCTION FNCONSINFOTIENDA(
      paPais UNIFORMES.TATIENDAS.FIPAIS%TYPE,
      paCanal UNIFORMES.TATIENDAS.FICANAL%TYPE,
      paTienda UNIFORMES.TATIENDAS.FISUCURSAL%TYPE)
  RETURN rcgCursor
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
  curCursorSalida rcgCursor;
  
  BEGIN
    OPEN curCursorSalida FOR
    SELECT DISTINCT T.FIPAIS
            ,T.FICANAL
            ,T.FISUCURSAL
            ,T.FCNOMBRE
            ,N.FISOLICITAENTIENDA
        FROM UNIFORMES.TATIENDAS T
  INNER JOIN UNIFORMES.TAFUNCIONESXNEGOCIO F
          ON T.FICANAL = F.FICANAL
  INNER JOIN UNIFORMES.TANEGOCIOS N
          ON F.FIIDNEGOCIO = N.FIIDNEGOCIO
       WHERE T.FIPAIS = paPais
         AND T.FICANAL = paCanal
         AND T.FISUCURSAL = paTienda;
         
       RETURN curCursorSalida;
       	EXCEPTION
          WHEN OTHERS THEN
              vgErrCode := SQLCODE;
              vgErrMsg := SQLERRM;
              RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PAWEBUNIFORMESCOMERCIO.FNCONSINFOTIENDA": ' || vgErrMsg);
              
  END FNCONSINFOTIENDA;
  
  FUNCTION FNCONSEMPLEDOSNUEVOINGRESO(
      paCeco UNIFORMES.TAEMPLEADOS.FICECO%TYPE)
  RETURN rcgCursor
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
  curCursorSalida rcgCursor;
  
  BEGIN
    OPEN curCursorSalida FOR
      SELECT FIEMPLEADO
            ,FCNOMBRE
        FROM UNIFORMES.TAEMPLEADOS E
   LEFT JOIN UNIFORMES.TASOLICITUDES S
          ON S.FIIDEMPLEADO = E.FIEMPLEADO
       WHERE TO_NUMBER(SUBSTR(TRIM(TO_CHAR(FICECO)),3,4)) = paCeco
         AND FCSITUACION = 'A'
         AND FDINGRESO BETWEEN SYSDATE - 12 AND SYSDATE-4
         AND S.FIFOLIOSOLICITUD IS NULL;-- SOLO EMPLEADOS SIN SOLICITUD
         
       RETURN curCursorSalida;
       	EXCEPTION
          WHEN OTHERS THEN
              vgErrCode := SQLCODE;
              vgErrMsg := SQLERRM;
              RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PAWEBUNIFORMESCOMERCIO.FNCONSULTAINFOEMPLEADO": ' || vgErrMsg);
              
  END FNCONSEMPLEDOSNUEVOINGRESO;
  
  FUNCTION FNCONSTIENDASCERCANAS(
      paPais UNIFORMES.TACECO.FIPAIS%TYPE,
      paCanal UNIFORMES.TACECO.FCIDCANAL%TYPE,
      paTienda UNIFORMES.TACECO.FICC%TYPE)
  RETURN rcgCursor
  IS 
  /*********************************FI***************************
   Proyecto:                         Sistema de Uniformes
   Descripcion:                      Consulta datos de empleado
   Parametros de entrada:            paNumEmpleado    Numero de empleado
   Parametros de salida:             curDatos         Cursor de referencia
   Parametros de entrada-salida      No aplica
   Precondiciones:                   Tener creado el esquema
   Creador:                          
   Fecha de creacion:                
  *************************************************************/
  curCursorSalida rcgCursor;
  
  BEGIN
    OPEN curCursorSalida FOR
      SELECT C2.FIPAIS
      		,TRIM(C2.FCIDCANAL) FCCANAL
      		,C2.FICC FISUCURSAL
            ,C2.FCNOMBRE
        FROM UNIFORMES.TACECO C1
  INNER JOIN UNIFORMES.TACECO C2
          ON C1.FCIDCCPADRE = C2.FCIDCCPADRE
         AND C2.FIPAIS = C1.FIPAIS
         AND C2.FIESTATUS = csgUno
         AND TRIM(C2.FCIDCANAL) NOT IN (SELECT DISTINCT TRIM(FICANAL) 
         								  FROM UNIFORMES.TANEGOCIOS N
         							INNER JOIN UNIFORMES.TAFUNCIONESXNEGOCIO F
         							        ON F.FIIDNEGOCIO = N.FIIDNEGOCIO
         							     WHERE N.FISOLICITAENTIENDA = 0)
       WHERE C1.FIPAIS = paPais
         AND TRIM(C1.FCIDCANAL) = paCanal
         AND C1.FICC = paTienda
         AND C1.FIESTATUS = csgUno;
         
       RETURN curCursorSalida;
       	EXCEPTION
          WHEN OTHERS THEN
              vgErrCode := SQLCODE;
              vgErrMsg := SQLERRM;
              RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PAWEBUNIFORMESCOMERCIO.FNCONSTIENDASCERCANAS": ' || vgErrMsg);
              
  END FNCONSTIENDASCERCANAS;
  
  FUNCTION FNCONSKITEMPLEADO(
  	paNumEmp UNIFORMES.TAEMPLEADOS.FIEMPLEADO%TYPE,
  	paTipoSol UNIFORMES.TAPRECIOS.FIIDTIPOSOLICITUD%TYPE)
  RETURN rcgCursor
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
  curCursorSalida rcgCursor;
  vlGenUnisex NUMBER(1):=3;
  vlUltimaSolicitud DATE;
  vlDiasParaSolicitar NUMBER(2):= 28;
  
  BEGIN
   IF paTipoSol = 1 THEN -- EXCLUIR SI YA TIENE REGISTRADA SOLICITUD EN LA CARGA SEMESTRAL
   	OPEN curCursorSalida FOR
   	SELECT E.FIEMPLEADO,
			 E.FCNOMBRE,
			 E.FIFUNCION,
			 E.FCGENERO,
      		 F.FIKIT ,
			 K.FCDESCRIPCION FCKIT,
			 TP.FIIDTIPOPRENDA,
			 TP.FCDESCRIPCION FCTIPOPRENDA,
			 TP.FCIMAGEN,
			 PRP.FNVALOR,
			 TPT.FITALLA,
			 T.FCDESCRIPCION FCTALLA,
			 C.FIMINIMO,
			 C.FIMAXIMO,
			 TPT.FIIDGENERO
	    FROM UNIFORMES.TATIENDAS T
    INNER JOIN UNIFORMES.TAEMPLEADOS E
          ON T.FISUCURSAL = TO_NUMBER(SUBSTR(TRIM(TO_CHAR(E.FICECO)),3,4))
    INNER JOIN UNIFORMES.TAFUNCIONESXNEGOCIO F
    	  ON E.FIFUNCION = F.FIFUNCIONSAP
    	 AND F.FICANAL = T.FICANAL
    INNER JOIN UNIFORMES.TAKITS K
          ON F.FIKIT = K.FIKIT
    INNER JOIN UNIFORMES.TATIPOSPRENDAXKIT TPK
          ON TPK.FIKIT = K.FIKIT
    INNER JOIN UNIFORMES.TATIPOSPRENDA TP
          ON TPK.FIIDTIPOPRENDA = TP.FIIDTIPOPRENDA
    INNER JOIN UNIFORMES.TATALLASXTIPOPRENDA TPT
          ON TPT.FIIDTIPOPRENDA = TP.FIIDTIPOPRENDA
         AND TPT.FIIDGENERO IN ( ( CASE WHEN E.FCGENERO = 'H' THEN 1 ELSE 2 END ), vlGenUnisex) 
    INNER JOIN UNIFORMES.TATALLAS T
          ON TPT.FITALLA = T.FITALLA
    INNER JOIN UNIFORMES.TAPRECIOS PRP
          ON PRP.FIIDTIPOPRENDA = TP.FIIDTIPOPRENDA
         AND PRP.FIIDTIPOSOLICITUD = paTipoSol
    INNER JOIN UNIFORMES.TACANTIDADES C
          ON C.FIIDTIPOSOLICITUD = paTipoSol
         AND C.FIIDTIPOPRENDA = TP.FIIDTIPOPRENDA
       WHERE E.FIEMPLEADO = paNumEmp
         AND E.FIEMPLEADO NOT IN (SELECT DISTINCT S.FIIDEMPLEADO
       								  FROM UNIFORMES.TACARGAS C
       						    INNER JOIN UNIFORMES.TASOLICITUDESXCARGA SC
       						            ON SC.FIIDCARGA = C.FIIDCARGA
       						    INNER JOIN UNIFORMES.TASOLICITUDES S
       						    		ON S.FIFOLIOSOLICITUD = SC.FIFOLIOSOLICITUD 
       							 	 WHERE S.FIIDEMPLEADO = paNumEmp
       							 	   AND TRUNC(SYSDATE) BETWEEN C.FDFECHAINICIAL AND C.FDFECHAFINAL
       							       AND C.FIESTATUS = csgUno)
         AND E.FCSITUACION = 'A'
   ORDER BY E.FIEMPLEADO, F.FIKIT, TP.FIIDTIPOPRENDA, T.FIORDEN;	
   
   ELSE -- SOLICITUD VOLUNTARIA SIEMPRE ESTA DISPONIBLE
    OPEN curCursorSalida FOR
      SELECT E.FIEMPLEADO,
			 E.FCNOMBRE,
			 E.FIFUNCION,
			 E.FCGENERO,
      		 F.FIKIT ,
			 K.FCDESCRIPCION FCKIT,
			 TP.FIIDTIPOPRENDA,
			 TP.FCDESCRIPCION FCTIPOPRENDA,
			 TP.FCIMAGEN,
			 PRP.FNVALOR,
			 TPT.FITALLA,
			 T.FCDESCRIPCION FCTALLA,
			 C.FIMINIMO,
			 C.FIMAXIMO,
			 TPT.FIIDGENERO
	    FROM UNIFORMES.TATIENDAS T
    INNER JOIN UNIFORMES.TAEMPLEADOS E
          ON T.FISUCURSAL = TO_NUMBER(SUBSTR(TRIM(TO_CHAR(E.FICECO)),3,4))
    INNER JOIN UNIFORMES.TAFUNCIONESXNEGOCIO F
    	  ON E.FIFUNCION = F.FIFUNCIONSAP
    	 AND F.FICANAL = T.FICANAL
    INNER JOIN UNIFORMES.TAKITS K
          ON F.FIKIT = K.FIKIT
    INNER JOIN UNIFORMES.TATIPOSPRENDAXKIT TPK
          ON TPK.FIKIT = K.FIKIT
    INNER JOIN UNIFORMES.TATIPOSPRENDA TP
          ON TPK.FIIDTIPOPRENDA = TP.FIIDTIPOPRENDA
    INNER JOIN UNIFORMES.TATALLASXTIPOPRENDA TPT
          ON TPT.FIIDTIPOPRENDA = TP.FIIDTIPOPRENDA
         AND TPT.FIIDGENERO IN ( ( CASE WHEN E.FCGENERO = 'H' THEN 1 ELSE 2 END ), vlGenUnisex) 
    INNER JOIN UNIFORMES.TATALLAS T
          ON TPT.FITALLA = T.FITALLA
    INNER JOIN UNIFORMES.TAPRECIOS PRP
          ON PRP.FIIDTIPOPRENDA = TP.FIIDTIPOPRENDA
         AND PRP.FIIDTIPOSOLICITUD = paTipoSol
    INNER JOIN UNIFORMES.TACANTIDADES C
          ON C.FIIDTIPOSOLICITUD = paTipoSol
         AND C.FIIDTIPOPRENDA = TP.FIIDTIPOPRENDA
       WHERE E.FIEMPLEADO = paNumEmp
         AND E.FCSITUACION = 'A'
   ORDER BY E.FIEMPLEADO, F.FIKIT, TP.FIIDTIPOPRENDA, T.FIORDEN;
   
   END IF;
          
       RETURN curCursorSalida;
       	EXCEPTION
          WHEN OTHERS THEN
              vgErrCode := SQLCODE;
              vgErrMsg := SQLERRM;
              RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PAWEBUNIFORMESCOMERCIO.FNCONSKITEMPLEADO": ' || vgErrMsg);
              
  END FNCONSKITEMPLEADO;
  
  FUNCTION FNCONSKITEMPLEADOSTIENDA(
  	paPais UNIFORMES.TATIENDAS.FIPAIS%TYPE,
  	paCanal UNIFORMES.TATIENDAS.FICANAL%TYPE,
  	paTienda UNIFORMES.TATIENDAS.FISUCURSAL%TYPE,
  	paTipoSol UNIFORMES.TAPRECIOS.FIIDTIPOSOLICITUD%TYPE)
  RETURN rcgCursor
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
  curCursorSalida rcgCursor;
  vlGenUnisex NUMBER(1):=3;
  BEGIN
  
    OPEN curCursorSalida FOR
      SELECT E.FIEMPLEADO,
			 E.FCNOMBRE,
			 E.FIFUNCION,
			 E.FCGENERO,
			 F.FIKIT,
			 K.FCDESCRIPCION FCKIT,
			 TP.FIIDTIPOPRENDA,
			 TP.FCDESCRIPCION FCTIPOPRENDA,
			 TP.FCIMAGEN,
			 PRP.FNVALOR,
			 TPT.FITALLA,
			 T.FCDESCRIPCION FCTALLA,
			 C.FIMINIMO,
			 C.FIMAXIMO,
			 TPT.FIIDGENERO
	    FROM UNIFORMES.TATIENDAS T
    INNER JOIN UNIFORMES.TAEMPLEADOS E
          ON T.FISUCURSAL = TO_NUMBER(SUBSTR(TRIM(TO_CHAR(E.FICECO)),3,4))
    INNER JOIN UNIFORMES.TAFUNCIONESXNEGOCIO F
    	  ON E.FIFUNCION = F.FIFUNCIONSAP
    	 AND F.FICANAL = T.FICANAL
    INNER JOIN UNIFORMES.TAKITS K
          ON F.FIKIT = K.FIKIT
    INNER JOIN UNIFORMES.TATIPOSPRENDAXKIT TPK
          ON TPK.FIKIT = K.FIKIT
    INNER JOIN UNIFORMES.TATIPOSPRENDA TP
          ON TPK.FIIDTIPOPRENDA = TP.FIIDTIPOPRENDA
    INNER JOIN UNIFORMES.TATALLASXTIPOPRENDA TPT
          ON TPT.FIIDTIPOPRENDA = TP.FIIDTIPOPRENDA
         AND TPT.FIIDGENERO IN ( ( CASE WHEN E.FCGENERO = 'H' THEN 1 ELSE 2 END ), vlGenUnisex) 
    INNER JOIN UNIFORMES.TATALLAS T
          ON TPT.FITALLA = T.FITALLA
    INNER JOIN UNIFORMES.TAPRECIOS PRP
          ON PRP.FIIDTIPOPRENDA = TP.FIIDTIPOPRENDA
         AND PRP.FIIDTIPOSOLICITUD = paTipoSol
    INNER JOIN UNIFORMES.TACANTIDADES C
          ON C.FIIDTIPOSOLICITUD = paTipoSol
         AND C.FIIDTIPOPRENDA = TP.FIIDTIPOPRENDA
       WHERE T.FIPAIS = paPais
       AND T.FICANAL = paCanal
       AND T.FISUCURSAL = paTienda
       AND E.FCSITUACION = 'A'
       AND E.FIEMPLEADO NOT IN (SELECT DISTINCT S.FIIDEMPLEADO -- EXCLUYE LOS QUE YA SOLICITARON 
       								  FROM UNIFORMES.TACARGAS C
       						    INNER JOIN UNIFORMES.TASOLICITUDESXCARGA SC
       						            ON SC.FIIDCARGA = C.FIIDCARGA
       						    INNER JOIN UNIFORMES.TASOLICITUDES S
       						    		ON S.FIFOLIOSOLICITUD = SC.FIFOLIOSOLICITUD 
       							INNER JOIN UNIFORMES.TACARGASXNEGOCIO N
       							        ON C.FIIDCARGA = N.FIIDCARGA
       							INNER JOIN UNIFORMES.TAFUNCIONESXNEGOCIO F
       							        ON F.FIIDNEGOCIO = N.FIIDNEGOCIO
       							     WHERE F.FICANAL = paCanal
       							       AND TRUNC(SYSDATE) BETWEEN C.FDFECHAINICIAL AND C.FDFECHAFINAL
       							       AND C.FIESTATUS = csgUno)
  ORDER BY E.FIEMPLEADO, F.FIKIT, TP.FIIDTIPOPRENDA, T.FIORDEN;
          
       RETURN curCursorSalida;
       	EXCEPTION
          WHEN OTHERS THEN
              vgErrCode := SQLCODE;
              vgErrMsg := SQLERRM;
              RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PAWEBUNIFORMESCOMERCIO.FNCONSKITEMPLEADOSTIENDA": ' || vgErrMsg);
              
  END FNCONSKITEMPLEADOSTIENDA;
  
  PROCEDURE SPGUARDASOLICITUD(
    paSolicitudes IN UNIFORMES.TYPEARRSOLICITUDPRENDA
   ,curResultado OUT rcgCursor )
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
  vlIdSolicitud  NUMBER(18);
  vlIdDetalleSol NUMBER(18);
  vlIdBitacora 	 NUMBER(18);
  vlSolicitudSem NUMBER(1):=1;
  vlCargaActiva NUMBER(8);
  vlEvTallasCap NUMBER(2):=10;
  vlEstPendCD   NUMBER(1):=1;
  vlSolicitudes VARCHAR2(1000 CHAR);
  
  BEGIN
  
  	FOR indSol IN 1..paSolicitudes.count
    LOOP
    	BEGIN
    	
    	SELECT NVL(MAX(FIFOLIOSOLICITUD), csgCero) + 1 
    	  INTO vlIdSolicitud
    	  FROM UNIFORMES.TASOLICITUDES;
    	
    	END;	
    		INSERT INTO UNIFORMES.TASOLICITUDES(FIFOLIOSOLICITUD, 
    											FIIDEMPLEADO, 
    											FIIDTIPOSOLICITUD, 
    											FIIDNEGOCIO, 
    											FIFUNCIONSAP, 
    											FIIDEMPCAPTURA, 
    											FDFECHACAPTURA)
    									VALUES (vlIdSolicitud,
    											paSolicitudes(indSol).FIEMPLEADO,
    											paSolicitudes(indSol).FIIDTIPOSOLICITUD,
    											paSolicitudes(indSol).FIIDNEGOCIO,
    											paSolicitudes(indSol).FIFUNCIONSAP,
    											paSolicitudes(indSol).FIEMPLEADOCAPTURA,
    											SYSDATE);
    											
    		vlSolicitudes := vlSolicitudes || TO_CHAR(vlIdSolicitud)||',';
    		
        	FOR indDet IN 1..paSolicitudes(indSol).PRENDAS.count
	    	LOOP
	    		
		     BEGIN
	    	
		    	SELECT NVL(MAX(FIIDDETALLE), csgCero) + 1 
		    	  INTO vlIdDetalleSol
		    	  FROM UNIFORMES.TASOLICITUDESDETALLE;
		    	
		     END;
	    	
			 INSERT INTO UNIFORMES.TASOLICITUDESDETALLE (FIFOLIOSOLICITUD, 
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
			 											 FIESTATUSCD,
			 											 FDFECHAACT,
			 											 FIACTIVO)
			        							VALUES  (vlIdSolicitud,
			        							         vlIdDetalleSol,
			        							         csgCero ,
			 											 paSolicitudes(indSol).PRENDAS(indDet).FIPAIS, 
			 											 paSolicitudes(indSol).PRENDAS(indDet).FICANAL, 
			 											 paSolicitudes(indSol).PRENDAS(indDet).FISUCURSAL, 
			 											 paSolicitudes(indSol).PRENDAS(indDet).FIIDTIPOPRENDA, 
			 											 paSolicitudes(indSol).PRENDAS(indDet).FITALLA,
			 											 csgCero, 
			 											 paSolicitudes(indSol).PRENDAS(indDet).FICANTIDAD, 
			 											 paSolicitudes(indSol).PRENDAS(indDet).FIPRECIOUNITARIO, 
			 											 paSolicitudes(indSol).PRENDAS(indDet).FIPRECIOUNITARIO * paSolicitudes(indSol).PRENDAS(indDet).FICANTIDAD, 
			 											 csgUno,
			 											 csgCero,
			 											 SYSDATE,
			 											 csgUno);
			 											 
			UNIFORMES.PAWEBUNIFORMESCOMERCIO.SPGUARDABITACORA(vlIdSolicitud,vlIdDetalleSol,csgCero,'SOLICITUD GUARDADA', 1, 1, 'SOLICITUD GUARDADA', 0); 											 
			 
	    	END LOOP;
    	END LOOP;
       
       COMMIT;
       
       OPEN curResultado 
        FOR SELECT S.FIFOLIOSOLICITUD, E.FIEMPLEADO, E.FCNOMBRE
              FROM UNIFORMES.TASOLICITUDES S
        INNER JOIN UNIFORMES.TAEMPLEADOS E
                ON E.FIEMPLEADO = S.FIIDEMPLEADO
             WHERE FIFOLIOSOLICITUD IN ( SELECT TO_NUMBER(column_value) FROM XMLTABLE(SUBSTR(vlSolicitudes,0,LENGTH(vlSolicitudes)-1)));
       
       	EXCEPTION
          WHEN OTHERS THEN
          	  ROLLBACK;
              vgErrCode := SQLCODE;
              vgErrMsg := SQLERRM;
              RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PAWEBUNIFORMESCOMERCIO.SPGUARDASOLICITUD": ' || vgErrMsg);
              
  END SPGUARDASOLICITUD;
  
  FUNCTION FNCONSPEDIDOSXENTREGAR(
   paNumEmp UNIFORMES.TAEMPLEADOS.FIEMPLEADO%TYPE
  )
  RETURN rcgCursor
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
  curCursorSalida rcgCursor;
  vlEstEnTienda NUMBER(1):=6;
  vlEstActivo   VARCHAR2(1 CHAR) := 'A';
  BEGIN
  
    OPEN curCursorSalida FOR
	    SELECT   P.FIIDDETALLE
                ,P.FIPAIS
                ,P.FICANAL
                ,P.FISUCURSAL
                ,TRIM(T.FCDIRIP) FCDIRECCIONIP
                ,E2.FIEMPLEADO
                ,E2.FCNOMBRE
                ,E2.FCPOSICION
                ,E2.FICECO
                ,E2.FCCECO
                ,N.FCDESCRIPCION NEGOCIO
                ,S.FIFOLIOSOLICITUD
                ,P.FIPEDIDO
                ,P.FISKU
                ,R.FCDESCRIPCION PRENDA
                ,P.FICANTIDAD
                ,RM.FIREMISION
		  FROM UNIFORMES.TAEMPLEADOS E
	INNER JOIN UNIFORMES.TACECO C
			ON E.FICECO = C.FICC
	INNER JOIN UNIFORMES.TASOLICITUDESDETALLE P
			ON P.FIPAIS = C.FIPAIS
		   AND P.FICANAL = C.FCIDCANAL
		   AND P.FISUCURSAL = TO_NUMBER(SUBSTR(TRIM(TO_CHAR(C.FICC)),3,4)) 
		   AND P.FIESTATUSSOL = vlEstEnTienda
	INNER JOIN UNIFORMES.TAPRENDAS R
			ON R.FISKU = P.FISKU
	INNER JOIN UNIFORMES.TAREMISIONESXPEDIDO RM
			ON RM.FIFOLIOSOLICITUD = P.FIFOLIOSOLICITUD
		   AND RM.FIIDDETALLE = P.FIIDDETALLE
	INNER JOIN UNIFORMES.TASOLICITUDES S
		    ON P.FIFOLIOSOLICITUD = S.FIFOLIOSOLICITUD
	INNER JOIN UNIFORMES.TAEMPLEADOS E2
			ON E2.FIEMPLEADO = S.FIIDEMPLEADO
	INNER JOIN UNIFORMES.TANEGOCIOS N
			ON S.FIIDNEGOCIO = N.FIIDNEGOCIO
    INNER JOIN UNIFORMES.TATIENDAS T
            ON P.FIPAIS = T.FIPAIS
           AND P.FICANAL = T.FICANAL
           AND P.FISUCURSAL = T.FISUCURSAL
		 WHERE E.FIEMPLEADO =  paNumEmp
		   AND E.FCSITUACION = vlEstActivo
		   AND E2.FCSITUACION = vlEstActivo
	  ORDER BY E2.FIEMPLEADO
	          ,S.FIFOLIOSOLICITUD
	          ,P.FIPEDIDO;
          
       RETURN curCursorSalida;
       	EXCEPTION
          WHEN OTHERS THEN
              vgErrCode := SQLCODE;
              vgErrMsg := SQLERRM;
              RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PAWEBUNIFORMESCOMERCIO.FNCONSPENDIENTESENTREGA": ' || vgErrMsg);
              
  END FNCONSPEDIDOSXENTREGAR;
 
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
        RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PAWEBUNIFORMESCOMERCIO.FNCONSULTASOLICITUDES": ' || vgErrMsg);
        
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
--   USO RANK OVER    
    /* ANTIGUO ESQUEMA
    SELECT  TSD.FIPEDIDO,
            TO_CHAR(TSD.FISKU) AS FCSKU, 
            FNDEFINEDESCRIPCIONPRENDA(TSD.FISKU,TSD.FIIDTIPOPRENDA) AS FCDESCRIPCION,
            FNNOREMISION(TSD.FIPEDIDO,TSD.FISKU) AS FIREMISION,
            TSD.FICANTIDAD,
            FNCADENAESTADOESTATUS(TBS.FIESTATUSNVO) AS FCIDESTATUSNVO,
            TBS.FIIDDETALLE,
            TO_CHAR(TBS.FDFECHA, 'dd/mm/yyyy HH24:MI:SS') AS FCFECHAEVENTO
     FROM   (SELECT FIFOLIOSOLICITUD, 
                    FIESTATUSNVO,
                    FIIDDETALLE,
                    FDFECHA               
                FROM (SELECT    FIFOLIOSOLICITUD, 
                                FIESTATUSNVO,
                                FIIDDETALLE,
                                FDFECHA,
                                RANK() OVER (PARTITION BY FIIDDETALLE ORDER BY FDFECHA DESC) ESCIERTO
                        FROM UNIFORMES.TABITACORASOLICITUD) 
                WHERE ESCIERTO = csgCierto AND FIFOLIOSOLICITUD = paNoFolioSolicitud) TBS
     INNER JOIN UNIFORMES.TASOLICITUDESDETALLE TSD
        ON TSD.FIFOLIOSOLICITUD = TBS.FIFOLIOSOLICITUD 
        AND TSD.FIIDDETALLE = TBS.FIIDDETALLE;*/ 
        
    SELECT  TSD.FIPEDIDO,
            TO_CHAR(TSD.FISKU) AS FCSKU, 
            FNDEFINEDESCRIPCIONPRENDA(TSD.FISKU,TSD.FIIDTIPOPRENDA) AS FCDESCRIPCION,
            FNNOREMISION(TSD.FIPEDIDO,TSD.FISKU) AS FIREMISION,
            TSD.FICANTIDAD,
            FNCADENAESTADOESTATUS(TSD.FIESTATUSSOL) AS FCIDESTATUSNVO,
            TSD.FIIDDETALLE,
            TO_CHAR(TSD.FDFECHAACT, 'dd/mm/yyyy HH24:MI:SS') AS FCFECHAEVENTO
     FROM   UNIFORMES.TASOLICITUDESDETALLE TSD
     WHERE  TSD.FIFOLIOSOLICITUD = paNoFolioSolicitud AND TSD.FIACTIVO = csgUno;        
 RETURN curDatos;
 
 EXCEPTION
    WHEN OTHERS THEN
        vgErrCode := SQLCODE;
        vgErrMsg := SQLERRM;
        RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PAWEBUNIFORMESCOMERCIO.FNCONSULTASOLICITUD": ' || vgErrMsg);
      
 END FNCONSULTASOLICITUD;

 FUNCTION FNNOREMISION(
    paNoPedido UNIFORMES.TASOLICITUDESDETALLE.FIPEDIDO%TYPE,
    paNoSKU UNIFORMES.TASOLICITUDESDETALLE.FISKU%TYPE)
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
    paNoEstadoNuevo UNIFORMES.TASOLICITUDESDETALLE.FIESTATUSCD%TYPE)
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

 

 FUNCTION FNDEFINEDESCRIPCIONPRENDA(
    paSKU UNIFORMES.TASOLICITUDESDETALLE.FISKU%TYPE,
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
        IF paSKU = 0 THEN
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
        RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PAWEBUNIFORMESCOMERCIO.FNDEFINEDESCRIPCIONPRENDA": ' || vgErrMsg); 

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
    
 /* ANTIGUO ESQUEMA
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
    FROM (SELECT FIESTATUSNVO FROM UNIFORMES.TABITACORASOLICITUD WHERE FIFOLIOSOLICITUD = paNoFolioSolicitud) 
    PIVOT (count(FIESTATUSNVO) for FIESTATUSNVO in  
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
 */
    SELECT  FNCADENAPORCENTAJE(CANCELADO * vlCalculoPorcentaje) AS FCPORCCANCELADO,
            FNCADENAPORCENTAJE((CASE (SOLICITUDGENERADA + SOLICITADOTIENDA)
                                    WHEN csgCero THEN 0
                                    ELSE (SOLICITUDGENERADA + SOLICITADOTIENDA)/2
                                END) * vlCalculoPorcentaje) AS FCPORCSOLICITUD,
            FNCADENAPORCENTAJE((CASE (SOLICITADOCD + ATENDIDOCD)  
                                    WHEN csgCero THEN 0
                                    ELSE (SOLICITADOCD + ATENDIDOCD)/2
                                END) * vlCalculoPorcentaje)  AS FCPORCATENDIDOCD,
            FNCADENAPORCENTAJE(CAMINOTIENDA * vlCalculoPorcentaje)      AS FCPORCCAMINOTIENDA,        
            FNCADENAPORCENTAJE(RECIBIDOTIENDA * vlCalculoPorcentaje)    AS FCPORCRECIBIDOTIENDA,
            FNCADENAPORCENTAJE(ENTREGADO * vlCalculoPorcentaje)         AS FCPORCENTREGADO           
    FROM (SELECT FIESTATUSNVO FROM UNIFORMES.TABITACORASOLICITUD WHERE FIFOLIOSOLICITUD = paNoFolioSolicitud) 
    PIVOT (count(FIESTATUSNVO) for FIESTATUSNVO in  
            (
                0 AS CANCELADO,
                1 AS SOLICITUDGENERADA,
                2 AS SOLICITADOTIENDA,
                3 AS SOLICITADOCD,
                4 AS ATENDIDOCD,    
                5 AS CAMINOTIENDA,
                6 AS RECIBIDOTIENDA,
                7 AS ENTREGADO                
            )
    );
 RETURN curDatos;
    
 EXCEPTION
    WHEN OTHERS THEN
        vgErrCode := SQLCODE;
        vgErrMsg := SQLERRM;
        RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PAWEBUNIFORMESCOMERCIO.FNCONSULTASOLICITUDAVANCE": ' || vgErrMsg);     

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
        RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PAWEBUNIFORMESCOMERCIO.FNCADENAPORCENTAJE": ' || vgErrMsg);    
            
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
        RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PAWEBUNIFORMESCOMERCIO.FNCALCULOPORCENTAJE": ' || vgErrMsg);       

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
 vlSolVol NUMBER(1):=2;
 vlEstDescSAP NUMBER(1):= 8;
 BEGIN
 OPEN curDatos FOR
	     SELECT S.FIFOLIOSOLICITUD, 
	            TO_CHAR(S.FDFECHACAPTURA,'dd/mm/yyyy') AS FCFECHACAPTURA,
	            T.FISUCURSAL,
	            T.FCNOMBRE                
	       FROM UNIFORMES.TASOLICITUDES S
     INNER JOIN UNIFORMES.TASOLICITUDESDETALLE D
             ON D.FIFOLIOSOLICITUD = S.FIFOLIOSOLICITUD
	 INNER JOIN UNIFORMES.TATIENDAS T
	         ON T.FIPAIS = D.FIPAIS
	        AND T.FICANAL = D.FICANAL
	        AND T.FISUCURSAL = D.FISUCURSAL
	    WHERE S.FIIDEMPLEADO = paNumeroEmpleado 
	      AND ROWNUM <= paNumeroSolicitudes
	      AND S.FIIDTIPOSOLICITUD = vlSolVol
	      AND D.FIESTATUSSOL = vlEstDescSAP
	   ORDER BY S.FDFECHACAPTURA DESC; 

 RETURN curDatos;
 
 EXCEPTION
    WHEN OTHERS THEN
        vgErrCode := SQLCODE;
        vgErrMsg := SQLERRM;
        RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PAWEBUNIFORMESCOMERCIO.FNCONSULTASOLICITUDESV": ' || vgErrMsg);        

 END FNCONSULTASOLICITUDESV;

 FUNCTION FNPEDIDOSPORPRECIO(
    paFolioSolicitud UNIFORMES.TASOLICITUDESDETALLE.FIFOLIOSOLICITUD%TYPE)
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
                FROM UNIFORMES.TASOLICITUDESDETALLE 
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
        RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PAWEBUNIFORMESCOMERCIO.FNPEDIDOSPORPRECIO": ' || vgErrMsg);     

 END FNPEDIDOSPORPRECIO;

 FUNCTION FNINFORMACIONDESCUENTO(
    paFolioSolicitud UNIFORMES.TASOLICITUDESDETALLE.FIFOLIOSOLICITUD%TYPE,
    paNumeroPedido UNIFORMES.TASOLICITUDESDETALLE.FIPEDIDO%TYPE)
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
    FROM UNIFORMES.TASOLICITUDESDETALLE TPCD
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
        RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PAWEBUNIFORMESCOMERCIO.FNINFORMACIONDESCUENTO": ' || vgErrMsg);          

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
            UPDATE UNIFORMES.TASOLICITUDESDETALLE 
               SET FIESTATUSSOL = paConfirmacionesEntrega(indice).FIIDESTATUSNVO 
             WHERE FIFOLIOSOLICITUD = paConfirmacionesEntrega(indice).FIFOLIOSOLICITUD
               AND FIIDDETALLE = paConfirmacionesEntrega(indice).FIIDDETALLE
               AND FIPEDIDO = paConfirmacionesEntrega(indice).FINUMPEDIDO;
                
           UNIFORMES.PAWEBUNIFORMESCOMERCIO.SPGUARDABITACORA(paConfirmacionesEntrega(indice).FIFOLIOSOLICITUD ,paConfirmacionesEntrega(indice).FIIDDETALLE,paConfirmacionesEntrega(indice).FINUMPEDIDO,'PEDIDO ENTREGADO A EMPLEADO', paConfirmacionesEntrega(indice).FIIDESTATUSANT, paConfirmacionesEntrega(indice).FIIDESTATUSNVO, 'PEDIDO ENTREGADO A EMPLEADO', 0);
                
    END LOOP;
    
    COMMIT;
    
    paNoConfirmaciones := paConfirmacionesEntrega.count;
    
    EXCEPTION
        WHEN OTHERS THEN
              ROLLBACK;
              vgErrCode := SQLCODE;
              vgErrMsg := SQLERRM;
              RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' "PAWEBUNIFORMESCOMERCIO.SPCONFIRMAENTREGA": ' || vgErrMsg );
    
 
 END SPGUARDACONFIRMACIONENTREGA;
 
END PAWEBUNIFORMESCOMERCIO;

