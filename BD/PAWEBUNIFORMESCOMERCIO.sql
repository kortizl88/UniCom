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
  	vgErrCode   NUMBER(6)           := 0;                   -- Variable para el manejo de errores codigo
    vgErrMsg    VARCHAR2(500 CHAR)  := '';                  -- Variable para el manejo de errores mensaje
    csgCero     NUMBER(1)           :=0;
    csgUno      NUMBER(1)           :=1;
    
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
    SELECT COUNT(*) INTO vlNoCargasSemestrales FROM TACARGASXNEGOCIO CXN
    INNER JOIN TACARGAS C ON C.FIIDCARGA = CXN.FIIDCARGA 
    WHERE
            CXN.FIIDNEGOCIO = paNoNegocio
            AND C.FIESTATUS = csgUno
            AND SYSDATE BETWEEN C.FDFECHAINICIAL AND C.FDFECHAFINAL;
            
    OPEN curCursorSalida FOR
    SELECT  M.FIIDMENU,
            M.FCTITULO,
            M.FCDESCMENU,
            M.FCRUTAENLACE
    FROM TAMENUSFUNCIONESXNEGOCIO MFXN
    INNER JOIN TAMENUS M ON M.FIIDMENU = MFXN.FIIDMENU 
    WHERE 
            MFXN.FIFUNCIONSAP = paNoFuncionSap
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
  	   FROM UNIFORMES.TACARGAS
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
        FROM UNIFORMES.TAEMPLEADOS   
       WHERE FICECO = paCeco
         AND FCSITUACION = 'A'
         AND FDINGRESO BETWEEN SYSDATE - 12 AND SYSDATE-4;
         
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
  BEGIN
  
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
          ON T.FISUCURSAL = E.FICECO
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
    											
    		IF paSolicitudes(indSol).FIIDTIPOSOLICITUD = vlSolicitudSem THEN
    		   
    			BEGIN 
			  	 SELECT FIIDCARGA
			  	   INTO vlCargaActiva
			  	   FROM UNIFORMES.TACARGAS
			  	  WHERE SYSDATE BETWEEN FDFECHAINICIAL AND FDFECHAFINAL
			  	    AND FIESTATUS = csgUno;
			  	  
			  	 EXCEPTION
			     WHEN NO_DATA_FOUND THEN
			     ROLLBACK;
			     RAISE_APPLICATION_ERROR (-20001,'NO HAY CARGA SEMESTRAL ACTIVA');
			     END;
			     
			     INSERT INTO UNIFORMES.TASOLICITUDESXCARGA(FIFOLIOSOLICITUD, FIIDCARGA)
			                                        VALUES(vlIdSolicitud, vlCargaActiva);
    			
    		END IF;
    		
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
			 											 FIPAIS, 
			 											 FICANAL, 
			 											 FISUCURSAL, 
			 											 FIIDTIPOPRENDA, 
			 											 FITALLA, 
			 											 FICANTIDAD, 
			 											 FNPRECIOUNITARIO, 
			 											 FNPRECIOTOTAL, 
			 											 FIBANDERAACTIVA)
			        							VALUES  (vlIdSolicitud,
			        							         vlIdDetalleSol, 
			 											 paSolicitudes(indSol).PRENDAS(indDet).FIPAIS, 
			 											 paSolicitudes(indSol).PRENDAS(indDet).FICANAL, 
			 											 paSolicitudes(indSol).PRENDAS(indDet).FISUCURSAL, 
			 											 paSolicitudes(indSol).PRENDAS(indDet).FIIDTIPOPRENDA, 
			 											 paSolicitudes(indSol).PRENDAS(indDet).FITALLA, 
			 											 paSolicitudes(indSol).PRENDAS(indDet).FICANTIDAD, 
			 											 paSolicitudes(indSol).PRENDAS(indDet).FIPRECIOUNITARIO, 
			 											 paSolicitudes(indSol).PRENDAS(indDet).FIPRECIOUNITARIO * paSolicitudes(indSol).PRENDAS(indDet).FICANTIDAD, 
			 											 csgUno);
			 											 
			 											 
			BEGIN
	    	
		    	SELECT NVL(MAX(FIIDBITACORA), csgCero) + 1 
		    	  INTO vlIdBitacora
		    	  FROM UNIFORMES.TABITACORASOLICITUD;
		    	
		     END;
	    	
			 INSERT INTO UNIFORMES.TABITACORASOLICITUD (FIIDBITACORA, 
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
			 											FCCOMENTARIOS)
			        							VALUES  (vlIdBitacora,
			        									 vlIdSolicitud,
			        							         vlIdDetalleSol, 
			 											 paSolicitudes(indSol).PRENDAS(indDet).FIPAIS, 
			 											 paSolicitudes(indSol).PRENDAS(indDet).FICANAL, 
			 											 paSolicitudes(indSol).PRENDAS(indDet).FISUCURSAL,
			 											 NULL,
			 											 NULL,
			 											 vlEvTallasCap,
			 											 '<?xml version="1.0"?><DATOS></DATOS>',
			 											 vlEstPendCD,
			 											 vlEstPendCD,
			 											 SYSDATE,
			 											 csgCero,
			 											 ' ');
			
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
  vlEstEnTienda NUMBER(1):=5;
  vlEstActivo   VARCHAR2(1 CHAR) := 'A';
  BEGIN
  
    OPEN curCursorSalida FOR
	    SELECT  D.FIIDDETALLE
                ,P.FIPAIS
                ,P.FICANAL
                ,P.FIIDSUCURSAL
                ,TRIM(T.FCDIRECCIONIP) FCDIRECCIONIP
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
	INNER JOIN UNIFORMES.TAPEDIDOSCD P
			ON P.FIPAIS = C.FIPAIS
		   AND P.FICANAL = C.FCIDCANAL
		   AND P.FIIDSUCURSAL = C.FINUMECO
		   AND P.FIIDESTATUSPEDIDO = vlEstEnTienda
	INNER JOIN UNIFORMES.TAPRENDAS R
			ON R.FISKU = P.FISKU
	INNER JOIN UNIFORMES.TAREMISIONESXPEDIDO RM
			ON RM.FIPAIS = P.FIPAIS
		   AND RM.FICANAL = P.FICANAL
		   AND RM.FISUCURSAL = P.FIIDSUCURSAL
		   AND RM.FIPEDIDO = P.FIPEDIDO
		   AND RM.FISKU = P.FISKU
	INNER JOIN UNIFORMES.TASOLICITUDESDETALLE D
	   		ON P.FIFOLIOSOLICITUD = D.FIFOLIOSOLICITUD
		   AND P.FIIDDETALLE = D.FIIDDETALLE
	INNER JOIN UNIFORMES.TASOLICITUDES S
		    ON D.FIFOLIOSOLICITUD = S.FIFOLIOSOLICITUD
	INNER JOIN UNIFORMES.TAEMPLEADOS E2
			ON E2.FIEMPLEADO = S.FIIDEMPLEADO
	INNER JOIN UNIFORMES.TANEGOCIOS N
			ON S.FIIDNEGOCIO = N.FIIDNEGOCIO
    INNER JOIN UNIFORMES.TATIENDASDIRIP T
            ON P.FIPAIS = T.FIPAISID
           AND P.FICANAL = T.FICANAL
           AND P.FIIDSUCURSAL = T.FITIENDAID
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
              RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' "PAWEBUNIFORMESCOMERCIO.SPCONFIRMAENTREGA": ' || vgErrMsg );
    
 
 END SPGUARDACONFIRMACIONENTREGA;
 
END PAWEBUNIFORMESCOMERCIO;

