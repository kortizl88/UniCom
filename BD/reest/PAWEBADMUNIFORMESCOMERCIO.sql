CREATE OR REPLACE PACKAGE           PAWEBADMUNIFORMESCOMERCIO
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

  FUNCTION FNCONSULTANEGOCIOS
  RETURN rcgCursor;
  
  FUNCTION FNCONSTIENDAS
  RETURN rcgCursor;
  
  FUNCTION FNCONSESTATUSSOLICITUD
  RETURN rcgCursor;
  
  FUNCTION FNCONSCARGASEMESTRAL
  RETURN rcgCursor;
  
  FUNCTION FNCONSREPORTE(
  	paIndFecha NUMBER,
  	paFi VARCHAR2,
  	paFf VARCHAR2,
  	paIndCarga NUMBER,
  	paCargas VARCHAR2,
  	paIndEst NUMBER,
  	paEst VARCHAR2,
  	paIndTda NUMBER,
  	paTienda NUMBER,
  	paIndEmp NUMBER,
  	paEmp NUMBER)
  RETURN rcgCursor;
  
  PROCEDURE SPACTUALIZACARGA(
  	paCarga IN  UNIFORMES.TYPCARGA,
  	paRes OUT NUMBER
  );
  
END PAWEBADMUNIFORMESCOMERCIO;

CREATE OR REPLACE PACKAGE BODY            PAWEBADMUNIFORMESCOMERCIO
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
    csgDos      NUMBER(1)           :=2;
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
             N.FIIDNEGOCIO,
             N.FCDESCRIPCION FCNEGOCIO
        FROM UNIFORMES.TACARGAS C
   LEFT JOIN UNIFORMES.TASOLICITUDESXCARGA S
          ON S.FIIDCARGA = C.FIIDCARGA
  INNER JOIN UNIFORMES.TACARGASXNEGOCIO NC
          ON NC.FIIDCARGA = C.FIIDCARGA
  INNER JOIN UNIFORMES.TANEGOCIOS N
          ON N.FIIDNEGOCIO = NC.FIIDNEGOCIO
    GROUP BY C.FIIDCARGA,
      		 C.FCDESCRIPCION,
      		 C.FDFECHAINICIAL,
             C.FDFECHAFINAL,
             C.FIESTATUS,
             C.FIGENERARPEDIDO,
             N.FIIDNEGOCIO,
             N.FCDESCRIPCION
    ORDER BY C.FIIDCARGA;
       RETURN curCursorSalida;
       	EXCEPTION
          WHEN OTHERS THEN
              vgErrCode := SQLCODE;
              vgErrMsg := SQLERRM;
              RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PAWEBADMUNIFORMESCOMERCIO.FNCONSCARGASEMESTRAL": ' || vgErrMsg);
              
  END FNCONSCARGASEMESTRAL;
    
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
  vlIdCarga UNIFORMES.TACARGAS.FIIDCARGA%TYPE;
  BEGIN
  paRes := 0;
  	
  	SELECT NVL(MAX(FIIDCARGA), csgCero) + 1 
    	  INTO vlIdCarga
    	  FROM UNIFORMES.TACARGAS;
  	
  	IF paCarga.FIIDCARGA != csgCero THEN
  	   vlIdCarga:= paCarga.FIIDCARGA;	
  	END IF;
  	
  	MERGE INTO UNIFORMES.TACARGAS C
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
  
  FUNCTION FNCONSREPORTE(
  	paIndFecha NUMBER,
  	paFi VARCHAR2,
  	paFf VARCHAR2,
  	paIndCarga NUMBER,
  	paCargas VARCHAR2,
  	paIndEst NUMBER,
  	paEst VARCHAR2,
  	paIndTda NUMBER,
  	paTienda NUMBER,
  	paIndEmp NUMBER,
  	paEmp NUMBER)
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
      SELECT S.FIIDEMPLEADO,
      		 E.FCNOMBRE,
      		 S.FIFOLIOSOLICITUD,
      		 EP.FCDESCRIPCION FCESTATUS,
      		 F.FCDESCFUNCION FCFUNCION,
      		 TO_CHAR(S.FDFECHACAPTURA,'DD/MM/YYYY') FDFECHACAPTURA,
      		 NVL (R.FIREMISION, 0) FIREMISION,
      		 D.FIPEDIDO,
      		 D.FISKU,
      		 TP.FCDESCRIPCION FCPRENDA,
      		 D.FICANTIDAD
        FROM UNIFORMES.TASOLICITUDES S
  INNER JOIN UNIFORMES.TAEMPLEADOS E
  		  ON S.FIIDEMPLEADO = E.FIEMPLEADO
  INNER JOIN UNIFORMES.TASOLICITUDESDETALLE D
          ON D.FIFOLIOSOLICITUD = S.FIFOLIOSOLICITUD
  INNER JOIN UNIFORMES.TAESTATUSPEDIDOS EP
          ON EP.FIIDESTATUSPEDIDO = D.FIESTATUSSOL
  INNER JOIN UNIFORMES.TAFUNCIONESXNEGOCIO F
          ON F.FIFUNCIONSAP = S.FIFUNCIONSAP
   LEFT JOIN UNIFORMES.TAREMISIONESXPEDIDO R
          ON R.FIPAIS = D.FIPAIS
         AND R.FICANAL = D.FICANAL
         AND R.FISUCURSAL = D.FISUCURSAL
         AND R.FIPEDIDO = D.FIPEDIDO
   LEFT JOIN UNIFORMES.TATIPOSPRENDA TP
          ON TP.FIIDTIPOPRENDA = D.FIIDTIPOPRENDA
    GROUP BY S.FIIDEMPLEADO,
      		 E.FCNOMBRE,
      		 S.FIFOLIOSOLICITUD,
      		 EP.FCDESCRIPCION,
      		 F.FCDESCFUNCION,
      		 S.FDFECHACAPTURA,
      		 R.FIREMISION,
      		 D.FIPEDIDO,
      		 D.FISKU,
      		 TP.FCDESCRIPCION,
      		 D.FICANTIDAD
    ORDER BY S.FIFOLIOSOLICITUD,
    	     D.FIPEDIDO;
       RETURN curCursorSalida;
       	EXCEPTION
          WHEN OTHERS THEN
              vgErrCode := SQLCODE;
              vgErrMsg := SQLERRM;
              RAISE_APPLICATION_ERROR (-20002,'ERROR ' || vgErrCode  || ' EN "PAWEBADMUNIFORMESCOMERCIO.FNCONSCARGASEMESTRAL": ' || vgErrMsg);
              
  END FNCONSREPORTE;
  
END PAWEBADMUNIFORMESCOMERCIO;

