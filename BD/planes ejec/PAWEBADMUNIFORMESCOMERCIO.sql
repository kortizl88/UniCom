CREATE OR REPLACE PACKAGE                     UNIFORMES.PAWEBADMUNIFORMESCOMERCIO
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

  FUNCTION FNCONSCARGASEMESTRAL
  RETURN rcgCursor;

  FUNCTION FNCONSTIENDAS
  RETURN rcgCursor;

  FUNCTION FNCONSESTATUSSOLICITUD
  RETURN rcgCursor;

  FUNCTION FNCONSULTANEGOCIOS
  RETURN rcgCursor;

  FUNCTION FNCONSREPORTE(
  	paIndFecha NUMBER,
  	paFechaInicio VARCHAR2,
  	paFechaFin VARCHAR2,
  	paIndCarga NUMBER,
  	paCarga VARCHAR2,
  	paIndEstatus NUMBER,
  	paEstatus VARCHAR2,
  	paIndTienda NUMBER,
  	paTienda NUMBER,
  	paIndEmpleado NUMBER,
  	paEmpleado NUMBER,
  	paIndSol NUMBER,
  	paSolicitud NUMBER,
  	paIndRem NUMBER,
  	paRemision NUMBER
  )
  RETURN rcgCursor;

  PROCEDURE SPACTUALIZACARGA(
  	paCarga IN  UNIFORMES.TYPCARGA,
  	paRes OUT NUMBER
  );

  FUNCTION FNCONSSEGUIMIENTOSOL(
  	paSolicitud UNIFORMES.TASOLICITUDES.FIFOLIOSOLICITUD%TYPE,
  	paDatosProceso NUMBER
  )
  RETURN rcgCursor;

END PAWEBADMUNIFORMESCOMERCIO;

CREATE OR REPLACE PACKAGE BODY                      UNIFORMES.PAWEBADMUNIFORMESCOMERCIO
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
  	UPDATE UNIFORMES.TAEMPLEADOSADMINISTRADOR
         SET FDULTIMOLOGIN = SYSDATE
       WHERE FINUMEMPLEADO = paNumEmpleado; 

    OPEN curCursorSalida FOR
      SELECT FINUMEMPLEADO
            ,FCNOMBRE
            ,FCAREA
            ,TO_CHAR(FDULTIMOLOGIN, 'DD/MM/YYYY')
        FROM UNIFORMES.TAEMPLEADOSADMINISTRADOR
       WHERE FINUMEMPLEADO = paNumEmpleado;
       RETURN curCursorSalida;
       	EXCEPTION
          WHEN OTHERS THEN
              vgErrCode := SQLCODE;
              vgErrMsg := SQLERRM;
              RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PAWEBADMUNIFORMESCOMERCIO.FNCONSULTAINFOEMPLEADO": ' || vgErrMsg);

  END FNCONSULTAINFOEMPLEADO;

  FUNCTION FNCONSCARGASEMESTRAL
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
      SELECT C.FIIDCARGA,
      		 C.FCDESCRIPCION,
      		 TO_CHAR(C.FDFECHAINICIAL,'DD/MM/YYYY') FDFECHAINICIAL,
      		 TO_CHAR(C.FDFECHAFINAL,'DD/MM/YYYY') FDFECHAFINAL,
      		 C.FIESTATUS,
      		 C.FIGENERARPEDIDO,
      		 COUNT(S.FIFOLIOSOLICITUD) FITOTALSOLICITUDES,
      		 CN.FIIDNEGOCIO,
      		 N.FCDESCRIPCION FCNEGOCIO
        FROM UNIFORMES.TACARGASSEMESTRALES C
   LEFT JOIN UNIFORMES.TACARGASXNEGOCIO CN
          ON  C.FIIDCARGA = CN.FIIDCARGA
   LEFT JOIN UNIFORMES.TANEGOCIOS N
          ON CN.FIIDNEGOCIO = N.FIIDNEGOCIO
   LEFT JOIN UNIFORMES.TASOLICITUDESXCARGA S
          ON S.FIIDCARGA = C.FIIDCARGA
    GROUP BY C.FIIDCARGA,
      		 C.FCDESCRIPCION,
      		 C.FDFECHAINICIAL,
      		 C.FDFECHAFINAL,
      		 C.FIESTATUS,
      		 C.FIGENERARPEDIDO,
      		 CN.FIIDNEGOCIO,
      		 N.FCDESCRIPCION
      ORDER BY C.FIIDCARGA;
       RETURN curCursorSalida;
       	EXCEPTION
          WHEN OTHERS THEN
              vgErrCode := SQLCODE;
              vgErrMsg := SQLERRM;
              RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PAWEBADMUNIFORMESCOMERCIO.FNCONSCARGASEMESTRAL": ' || vgErrMsg);

  END FNCONSCARGASEMESTRAL;

  FUNCTION FNCONSTIENDAS
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
      SELECT FISUCURSAL,
             FCNOMBRE
        FROM UNIFORMES.TATIENDAS;
       RETURN curCursorSalida;
       	EXCEPTION
          WHEN OTHERS THEN
              vgErrCode := SQLCODE;
              vgErrMsg := SQLERRM;
              RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PAWEBADMUNIFORMESCOMERCIO.FNCONSTIENDAS": ' || vgErrMsg);

  END FNCONSTIENDAS;

  FUNCTION FNCONSESTATUSSOLICITUD
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
      SELECT FIIDESTATUSPEDIDO FIESTATUSPEDIDOS,
             FCDESCRIPCION
        FROM UNIFORMES.TAESTATUSPEDIDOS;
       RETURN curCursorSalida;
       	EXCEPTION
          WHEN OTHERS THEN
              vgErrCode := SQLCODE;
              vgErrMsg := SQLERRM;
              RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PAWEBADMUNIFORMESCOMERCIO.FNCONSESTATUSSOLICITUD": ' || vgErrMsg);

  END FNCONSESTATUSSOLICITUD;

  FUNCTION FNCONSULTANEGOCIOS
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
      SELECT FIIDNEGOCIO,
             FCDESCRIPCION FCNEGOCIO
        FROM UNIFORMES.TANEGOCIOS;

       RETURN curCursorSalida;
       	EXCEPTION
          WHEN OTHERS THEN
              vgErrCode := SQLCODE;
              vgErrMsg := SQLERRM;
              RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PAWEBADMUNIFORMESCOMERCIO.FNCONSULTANEGOCIOS": ' || vgErrMsg);

  END FNCONSULTANEGOCIOS;

   FUNCTION FNCONSREPORTE(
  	paIndFecha NUMBER,
  	paFechaInicio VARCHAR2,
  	paFechaFin VARCHAR2,
  	paIndCarga NUMBER,
  	paCarga VARCHAR2,
  	paIndEstatus NUMBER,
  	paEstatus VARCHAR2,
  	paIndTienda NUMBER,
  	paTienda NUMBER,
  	paIndEmpleado NUMBER,
  	paEmpleado NUMBER,
  	paIndSol NUMBER,
  	paSolicitud NUMBER,
  	paIndRem NUMBER,
  	paRemision NUMBER
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
  vlfIni DATE;
  vlfFin DATE;
  vlListaCarga UNIFORMES.TIPO_CARGAS;
  vlListaEstatus UNIFORMES.TIPO_CARGAS;
  vlTiendas UNIFORMES.TIPO_CARGAS;
  vlEmpleados UNIFORMES.TIPO_CARGAS;
  vlSolicitud UNIFORMES.TIPO_CARGAS;
  vlRemision UNIFORMES.TIPO_CARGAS;
  vlRangoFecha NUMBER(1):= 2;
  vlGenMasc NUMBER(1):=1;
  vlGenFem NUMBER(1):=2;
  vlGenUnisex NUMBER(1):=3;
  vlGenMascStr VARCHAR2(1 CHAR) := 'H';
  
  BEGIN

  	-- fecha
  	IF paIndFecha = csgUno THEN
  	   vlfIni := TO_DATE(paFechaInicio,'DD/MM/YYYY');
  	   vlfFin := TO_DATE(paFechaFin,'DD/MM/YYYY');
  	ELSE
  	   vlfIni := TO_DATE('01/01/2013','DD/MM/YYYY');
  	   vlfFin := SYSDATE + vlRangoFecha;
  	END IF;

  	-- carga
  	IF paIndCarga = csgUno THEN
  	   SELECT FIIDCARGA
  	    BULK COLLECT INTO vlListaCarga
  	     FROM UNIFORMES.TACARGASSEMESTRALES
  	    WHERE FIIDCARGA IN ( SELECT TO_NUMBER(column_value) FROM XMLTABLE(SUBSTR(paCarga, csgCero,LENGTH(paCarga) - csgUno)));
  	END IF;

  	-- estatus
  	IF paIndEstatus = csgUno THEN
  	   SELECT FIIDESTATUSPEDIDO
  	    BULK COLLECT INTO vlListaEstatus
  	     FROM UNIFORMES.TAESTATUSPEDIDOS
  	    WHERE FIIDESTATUSPEDIDO IN ( SELECT TO_NUMBER(column_value) FROM XMLTABLE(SUBSTR(paEstatus, csgCero,LENGTH(paEstatus) - csgUno)));
  	ELSE
  	   SELECT FIIDESTATUSPEDIDO
  	    BULK COLLECT INTO vlListaEstatus
  	     FROM UNIFORMES.TAESTATUSPEDIDOS;
  	END IF;

  	--tiendas
  	IF paIndTienda = csgUno THEN
  	   SELECT FISUCURSAL
  	    BULK COLLECT INTO vlTiendas
  	     FROM UNIFORMES.TATIENDAS
  	    WHERE FISUCURSAL = paTienda;
  	ELSE
  	   SELECT FISUCURSAL
  	    BULK COLLECT INTO vlTiendas
  	     FROM UNIFORMES.TATIENDAS;
  	END IF;

  	-- empleados
  	IF paIndEmpleado = csgUno THEN
  	   SELECT paEmpleado FIEMPLEADO
  	    BULK COLLECT INTO vlEmpleados
  	     FROM DUAL;
  	ELSE
  	   SELECT FIEMPLEADO
  	    BULK COLLECT INTO vlEmpleados
  	     FROM UNIFORMES.TAEMPLEADOS E
  	 INNER JOIN UNIFORMES.TAFUNCIONESXNEGOCIO F
  	    ON F.FIFUNCIONSAP = E.FIFUNCION
  	 INNER JOIN UNIFORMES.TASOLICITUDES S
  	    ON S.FIIDEMPLEADO = E.FIEMPLEADO
  	    GROUP BY FIEMPLEADO;
  	END IF; 

  	-- solicitud
  	IF paIndSol = csgUno THEN
  	   SELECT paSolicitud FIFOLIOSOLICITUD
  	    BULK COLLECT INTO vlSolicitud
  	     FROM DUAL;
  	ELSE
  	   SELECT FIFOLIOSOLICITUD
  	    BULK COLLECT INTO vlSolicitud
  	     FROM UNIFORMES.TASOLICITUDES;
  	END IF;

    OPEN curCursorSalida FOR
      SELECT S.FIIDEMPLEADO,
      		 E.FCNOMBRE,
      		 S.FIFOLIOSOLICITUD,
      		 D.FIPAIS,
      		 D.FICANAL,
      		 D.FISUCURSAL,
      		 T.FCNOMBRE FCTIENDA,
      		 EP.FCDESCRIPCION FCESTATUS,
      		 F.FCDESCFUNCION FCFUNCION,
      		 TO_CHAR(S.FDFECHACAPTURA,'DD/MM/YYYY') FDFECHACAPTURA,
      		 NVL (R.FIREMISION, csgCero) FIREMISION,
      		 D.FIPEDIDO,
      		 D.FISKU,
      		 TP.FCDESCRIPCION FCPRENDA,
      		 TL.FITALLA,
      		 TL.FCDESCRIPCION FCTALLA,
      		 D.FICANTIDAD,
      		 TO_CHAR(D.FDFECHAACT,'DD/MM/YYYY HH24:MI:SS' ) FDFECHAACT
        FROM UNIFORMES.TASOLICITUDES S
  INNER JOIN UNIFORMES.TAEMPLEADOS E
  		  ON S.FIIDEMPLEADO = E.FIEMPLEADO
  INNER JOIN UNIFORMES.TASOLICITUDESDETALLE D
          ON D.FIFOLIOSOLICITUD = S.FIFOLIOSOLICITUD
  INNER JOIN UNIFORMES.TAESTATUSPEDIDOS EP
          ON EP.FIIDESTATUSPEDIDO = D.FIESTATUSSOL
  INNER JOIN UNIFORMES.TAFUNCIONESXNEGOCIO F
    	  ON E.FIFUNCION = F.FIFUNCIONSAP
    	 AND F.FICANAL = D.FICANAL
  INNER JOIN UNIFORMES.TASKUSXKIT SK
          ON SK.FIKIT = F.FIKIT
  INNER JOIN UNIFORMES.TAPRENDAS TP
          ON TP.FIIDTIPOPRENDA = D.FIIDTIPOPRENDA
         AND TP.FITALLA = D.FITALLA
         AND TP.FIIDGENERO IN ( ( CASE WHEN TRIM(E.FCGENERO) = vlGenMascStr THEN vlGenMasc ELSE vlGenFem END ), vlGenUnisex) 
         AND TP.FISKU = SK.FISKU
  INNER JOIN UNIFORMES.TATALLAS TL
          ON TP.FITALLA = TL.FITALLA
   LEFT JOIN UNIFORMES.TAREMISIONESXPEDIDO R
          ON R.FIPAIS = D.FIPAIS
         AND R.FICANAL = D.FICANAL
         AND R.FISUCURSAL = D.FISUCURSAL
         AND R.FIPEDIDO = D.FIPEDIDO
   LEFT JOIN ( SELECT SC.FIFOLIOSOLICITUD 
                 FROM UNIFORMES.TASOLICITUDESXCARGA SC
   		   INNER JOIN UNIFORMES.TACARGASSEMESTRALES C
          		   ON C.FIIDCARGA = SC.FIIDCARGA
                  AND C.FIIDCARGA IN (SELECT TO_NUMBER(column_value) FROM TABLE (vlListaCarga))
         	 )SXC
          ON SXC.FIFOLIOSOLICITUD = S.FIFOLIOSOLICITUD 
  INNER JOIN UNIFORMES.TATIENDAS T
          ON T.FIPAIS = D.FIPAIS
         AND T.FICANAL = D.FICANAL
         AND T.FISUCURSAL = D.FISUCURSAL
        WHERE TRUNC(S.FDFECHACAPTURA) BETWEEN vlfIni AND vlfFin
          AND S.FIFOLIOSOLICITUD IN ( CASE WHEN paIndCarga = csgUno THEN SXC.FIFOLIOSOLICITUD ELSE S.FIFOLIOSOLICITUD END)
          AND S.FIFOLIOSOLICITUD IN ( CASE WHEN paIndSol = csgUno THEN paSolicitud ELSE S.FIFOLIOSOLICITUD END)
          AND D.FIESTATUSSOL IN ( SELECT TO_NUMBER(column_value) FROM TABLE (vlListaEstatus) )
          AND D.FISUCURSAL IN ( SELECT TO_NUMBER(column_value) FROM TABLE (vlTiendas) )
          AND S.FIIDEMPLEADO IN ( SELECT TO_NUMBER(column_value) FROM TABLE (vlEmpleados) )
    GROUP BY S.FIIDEMPLEADO,
      		 E.FCNOMBRE,
      		 S.FIFOLIOSOLICITUD,
      		 D.FIPAIS,
      		 D.FICANAL,
      		 D.FISUCURSAL,
      		 T.FCNOMBRE,
      		 EP.FCDESCRIPCION,
      		 F.FCDESCFUNCION,
      		 S.FDFECHACAPTURA,
      		 R.FIREMISION,
      		 D.FIPEDIDO,
      		 D.FISKU,
      		 TP.FCDESCRIPCION,
      		 TL.FITALLA,
      		 TL.FCDESCRIPCION,
      		 D.FICANTIDAD,
      		 D.FDFECHAACT
    ORDER BY S.FIFOLIOSOLICITUD,
    	     D.FIPEDIDO;
       RETURN curCursorSalida;
       	EXCEPTION
          WHEN OTHERS THEN
              vgErrCode := SQLCODE;
              vgErrMsg := SQLERRM;
              RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PAWEBADMUNIFORMESCOMERCIO.FNCONSREPORTE": ' || vgErrMsg);

  END FNCONSREPORTE;

  PROCEDURE SPACTUALIZACARGA(
  	paCarga IN UNIFORMES.TYPCARGA,
  	paRes OUT NUMBER
  )
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
  vlIdCarga UNIFORMES.TACARGASSEMESTRALES.FIIDCARGA%TYPE;
  
  BEGIN
  paRes := 0;

  	SELECT NVL(MAX(FIIDCARGA), csgCero) + csgUno 
    	  INTO vlIdCarga
    	  FROM UNIFORMES.TACARGASSEMESTRALES;

  	IF paCarga.FIIDCARGA != csgCero THEN
  	   vlIdCarga:= paCarga.FIIDCARGA;	
  	END IF;

  	MERGE INTO UNIFORMES.TACARGASSEMESTRALES C
  	     USING ( SELECT vlIdCarga FIIDCARGA,
  	     				paCarga.FCDESCRIPCION FCDESCRIPCION,
  	     				TO_DATE(paCarga.FDFECHAINICIAL,'DD/MM/YYYY') FDFECHAINICIAL,
  	     				TO_DATE(paCarga.FDFECHAFINAL,'DD/MM/YYYY') FDFECHAFINAL,
  	     				paCarga.FIESTATUS FIESTATUS,
  	     				paCarga.FIGENERARPEDIDO FIGENERARPEDIDO
  	     		   FROM DUAL 
  	       	   ) DC
  			ON (C.FIIDCARGA = DC.FIIDCARGA)
  	WHEN MATCHED THEN 
  		   UPDATE SET C.FCDESCRIPCION = DC.FCDESCRIPCION,
  		   			  C.FDFECHAINICIAL = DC.FDFECHAINICIAL,
  		   			  C.FDFECHAFINAL = DC.FDFECHAFINAL,
  		   			  C.FIESTATUS = DC.FIESTATUS,
  		   			  C.FIGENERARPEDIDO = DC.FIGENERARPEDIDO
  WHEN NOT MATCHED THEN	
                INSERT (FIIDCARGA,
                		FCDESCRIPCION,
  		   			    FDFECHAINICIAL,
  		   			    FDFECHAFINAL,
  		   			    FIESTATUS,
  		   			    FIGENERARPEDIDO)    
  		        VALUES (DC.FIIDCARGA,
                		DC.FCDESCRIPCION,
  		   			    DC.FDFECHAINICIAL,
  		   			    DC.FDFECHAFINAL,
  		   			    DC.FIESTATUS,
  		   			    DC.FIGENERARPEDIDO);

  	DELETE FROM UNIFORMES.TACARGASXNEGOCIO
  	      WHERE FIIDCARGA = paCarga.FIIDCARGA;

  	FOR indNeg IN 1..paCarga.NEGOCIOS.count
    LOOP
    	INSERT INTO UNIFORMES.TACARGASXNEGOCIO (FIIDCARGA, FIIDNEGOCIO)
    	     VALUES (vlIdCarga, paCarga.NEGOCIOS(indNeg).FINEGOCIO); 
    END LOOP;

    COMMIT;

  EXCEPTION
  WHEN OTHERS THEN
          	  ROLLBACK;
              vgErrCode := SQLCODE;
              vgErrMsg := SQLERRM;
              RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PAWEBADMUNIFORMESCOMERCIO.SPACTUALIZACARGA": ' || vgErrMsg);

  END SPACTUALIZACARGA;

  FUNCTION FNCONSSEGUIMIENTOSOL(
  	paSolicitud UNIFORMES.TASOLICITUDES.FIFOLIOSOLICITUD%TYPE,
  	paDatosProceso NUMBER
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

  BEGIN
    OPEN curCursorSalida FOR
      SELECT 	B.FIFOLIOSOLICITUD,
				B.FIIDDETALLE,
				D.FIPAIS,
				D.FICANAL,
				D.FISUCURSAL,
				D.FIPEDIDO,
				CASE WHEN paDatosProceso = csgUno THEN TO_CHAR(B.FCDATOSPROCESO) ELSE ' ' END FCDATOSPROCESO,
				B.FCCOMENTARIOS,
				EA.FCDESCRIPCION EST_ANT,
				EN.FCDESCRIPCION EST_NUEVO,
				TO_CHAR(B.FDFECHA, 'DD/MM/YYYY HH24:MI:SS') FDFECHA
        FROM UNIFORMES.TABITACORASOLICITUD B
  INNER JOIN UNIFORMES.TASOLICITUDESDETALLE D
  		  ON D.FIFOLIOSOLICITUD = B.FIFOLIOSOLICITUD
  		 AND D.FIIDDETALLE = B.FIIDDETALLE
  INNER JOIN UNIFORMES.TAESTATUSPEDIDOS EA
          ON EA.FIIDESTATUSPEDIDO = B.FIESTATUSANT 
  INNER JOIN UNIFORMES.TAESTATUSPEDIDOS EN
          ON EN.FIIDESTATUSPEDIDO = B.FIESTATUSNVO
       WHERE B.FIFOLIOSOLICITUD = paSolicitud
       ORDER BY B.FDFECHA DESC, B.FIIDBITACORA,B.FIFOLIOSOLICITUD,B.FIIDDETALLE;
       RETURN curCursorSalida;
       	EXCEPTION
          WHEN OTHERS THEN
              vgErrCode := SQLCODE;
              vgErrMsg := SQLERRM;
              RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PAWEBADMUNIFORMESCOMERCIO.FNCONSESTATUSSOLICITUD": ' || vgErrMsg);

  END FNCONSSEGUIMIENTOSOL;

END PAWEBADMUNIFORMESCOMERCIO;

