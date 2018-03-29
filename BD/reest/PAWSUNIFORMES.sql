DROP PACKAGE UNIFORMES.PAWSUNIFORMES;

CREATE OR REPLACE PACKAGE           PAWSUNIFORMES
AS
/*************************************************************
   Proyecto:                       Uniformes 
   Descripcion:                    Paquete para Crones De uniformes
   Parametros de entrada:          Todos los campos que expone SAP
   Parametros de salida:           No aplica
   Parametros de entrada-salida    No aplica
   Precondiciones:                 Tener creado el esquema
   Creador:                        Laura Garcia Martinez
   Fecha de creacion:             17 JUNIO 2014
********************************************************************/
   
   TYPE rcgCursor IS REF CURSOR; -- Cursor por referencia


PROCEDURE SPCONSULTAEMPLEADOCARGA(
    paNumEmpleado   IN    UNIFORMES.TAEMPLEADOS.FIEMPLEADO%TYPE
   ,paCurPedidoActual OUT rcgCursor );


PROCEDURE  SPGRABAPEDIDO(
    paIdEmpleado         IN   UNIFORMES.TAPEDIDOS.FIEMPLEADO%TYPE
   ,paEstadoGral         IN   UNIFORMES.TAPEDIDOS.FIESTADOGENERAL%TYPE
   ,paTipo               IN   UNIFORMES.TAPEDIDOS.FITIPO%TYPE
   ,paEmpleadoSolicita   IN   UNIFORMES.TAPEDIDOS.FIEMPLEADOSOLICITA%TYPE
   ,paFuncion            IN   UNIFORMES.TAPEDIDOS.FIFUNCION%TYPE
   ,paFolioCentral       OUT  UNIFORMES.TAPEDIDOS.FIFOLIOCENTRAL%TYPE );


PROCEDURE SPGRABADETPEDIDO(
    paPais             IN    UNIFORMES.TADETALLEPEDIDOS.FIPAIS%TYPE
   ,paCanal            IN    UNIFORMES.TADETALLEPEDIDOS.FICANAL%TYPE
   ,paSucursal         IN    UNIFORMES.TADETALLEPEDIDOS.FISUCURSAL%TYPE 
   ,paPedido           IN    UNIFORMES.TADETALLEPEDIDOS.FIPEDIDO%TYPE
   ,paFolioCentral     IN    UNIFORMES.TADETALLEPEDIDOS.FIFOLIOCENTRAL%TYPE
   ,paSKU              IN    UNIFORMES.TADETALLEPEDIDOS.FISKU%TYPE
   ,paCantidad         IN    UNIFORMES.TADETALLEPEDIDOS.FICANTIDAD%TYPE 
   ,paEstatus          IN    UNIFORMES.TADETALLEPEDIDOS.FIESTATUS%TYPE
   ,paCosto            IN    UNIFORMES.TADETALLEPEDIDOS.FNCOSTO%TYPE
   ,paDescuento        IN    UNIFORMES.TADETALLEPEDIDOS.FNDESCUENTO%TYPE );   


PROCEDURE  SPPEDIDOSPENDIENTESABASTO(
   paCurPendientesAb     OUT    rcgCursor );   
   
   
PROCEDURE SPCONSULTAEMPLEADOSOLICITUD(
   paTienda        IN    VARCHAR2
  ,paCurSolicitud  OUT   rcgCursor);

   
PROCEDURE SPSOLICITUDFORMADOR(
   paIdEmpleado    IN    UNIFORMES.TAEMPLEADOS.FIEMPLEADO%TYPE
  ,paCurSolicitud  OUT   rcgCursor);
   
      
FUNCTION FNGRABAREMISION(
    paRemision     IN UNIFORMES.TAREMISIONES.FIREMISION%TYPE
   ,paSucursal     IN UNIFORMES.TAREMISIONES.FISUCURSAL%TYPE
   ,paPedido       IN UNIFORMES.TAREMISIONES.FIPEDIDO%TYPE
   ,paSku          IN UNIFORMES.TAREMISIONES.FISKU%TYPE
   ,paCantidad     IN UNIFORMES.TAREMISIONES.FICANTIDAD%TYPE
   ,paEmpleadoRecibe IN UNIFORMES.TAREMISIONES.FIEMPLEADORECIBE%TYPE)
RETURN PAWSUNIFORMES.rcgCursor;
 

PROCEDURE SPCONSULTAENTREGA
(   paIdEmpleado    IN    UNIFORMES.TAEMPLEADOS.FIEMPLEADO%TYPE
   ,paTienda        IN    UNIFORMES.TASUCURSALES.FISUCURSAL%TYPE
   ,paCurEntrega   OUT   rcgCursor);
   

PROCEDURE SPGRABAENTREGA
(   paFolioCentral  IN    UNIFORMES.TADETALLEPEDIDOS.FIFOLIOCENTRAL%TYPE
   ,paPais          IN    UNIFORMES.TADETALLEPEDIDOS.FIPAIS%TYPE
   ,paCanal         IN    UNIFORMES.TADETALLEPEDIDOS.FICANAL%TYPE
   ,paSucursal      IN    UNIFORMES.TADETALLEPEDIDOS.FISUCURSAL%TYPE
   ,paPedido        IN    UNIFORMES.TADETALLEPEDIDOS.FIPEDIDO%TYPE
   ,paSKU           IN    UNIFORMES.TADETALLEPEDIDOS.FISKU%TYPE
   ,paEstAnterior   IN    UNIFORMES.TADETALLEPEDIDOS.FIESTATUS%TYPE
   ,paFecAnterior   IN    VARCHAR2
   ,paGerente       IN    UNIFORMES.TADETALLEPEDIDOS.FIGERENTEENTREGA%TYPE);
   
--lau --
PROCEDURE SPACTMOVTOPEDIDOS(
   paIdPais         IN  UNIFORMES.TADETALLEPEDIDOS.FIPAIS%TYPE
  ,paIdCanal        IN  UNIFORMES.TADETALLEPEDIDOS.FICANAL%TYPE
  ,paSucursal       IN  UNIFORMES.TADETALLEPEDIDOS.FISUCURSAL%TYPE
  ,paPedido         IN  UNIFORMES.TADETALLEPEDIDOS.FIPEDIDO%TYPE
  ,paFolioCentral   IN  UNIFORMES.TADETALLEPEDIDOS.FIFOLIOCENTRAL%TYPE
  ,paSKU            IN  UNIFORMES.TADETALLEPEDIDOS.FISKU%TYPE
  ,paEstatusAnterior IN  UNIFORMES.TADETALLEPEDIDOS.FIESTATUS%TYPE
  ,paActualizacion  IN  VARCHAR2
  ,paEstatusNuevo   IN  UNIFORMES.TADETALLEPEDIDOS.FIESTATUS%TYPE);
  
PROCEDURE SPCONSULTAKIT(
   paIdEmpleado    IN    UNIFORMES.TAEMPLEADOS.FIEMPLEADO%TYPE
  ,paIdBandera     IN    NUMBER
  ,paCurSolicitud  OUT   rcgCursor);
  
PROCEDURE SPSOLICITUDINDIVIDUAL( 
        paIdEmpleado         IN UNIFORMES.TAEMPLEADOS.FIEMPLEADO%TYPE,
        paFuncionEmpleado    IN UNIFORMES.TAEMPLEADOS.FIFUNCION%TYPE,
        paGeneroEmpleado     IN UNIFORMES.TAEMPLEADOS.FCGENERO%TYPE,
        paCurSolicitud      OUT rcgCursor
     );
     
PROCEDURE SPCONSULTASUCURSALPEDIDO(
   paTienda        IN    UNIFORMES.TASUCURSALES.FISUCURSAL%TYPE,
   paFolioCentral       IN  UNIFORMES.TAPEDIDOS.FIFOLIOCENTRAL%TYPE, 
   paCurSucursal  OUT   rcgCursor,
   parCurSucursalPedido OUT   rcgCursor);
   
END PAWSUNIFORMES;

CREATE OR REPLACE PACKAGE BODY           PAWSUNIFORMES
AS
/*************************************************************
   Proyecto:                       Uniformes 
   Descripcion:                    Paquete para Crones De uniformes
   Parametros de entrada:          Todos los campos que expone SAP
   Parametros de salida:           No aplica
   Parametros de entrada-salida    No aplica
   Precondiciones:                 Tener creado el esquema
   Creador:                     Laura Garcia Martinez
   Fecha de creacion:             17 JUNIO 2014
********************************************************************/

  csgCero  NUMBER(1):= 0;

 PROCEDURE SPCONSULTAEMPLEADOCARGA(
   paNumEmpleado   IN    UNIFORMES.TAEMPLEADOS.FIEMPLEADO%TYPE
   ,paCurPedidoActual OUT rcgCursor )
IS      
/********************************************************************************
   Descripcion: procedimiento consulta empleado pedido  que regresa los datos 
   Parámetros de entrada: paNumEmpleado
   Parámetros de salida: paCurPedidoActual
   Parámetros de entrada-salida: Ninguno
   Valor de retorno: Cursor con resultado.
   Creador: Laura Garcia Martinez
   Fecha de creación: 27 JUNIO 2014
**************************************************************************************/
      
   vlSituacion          UNIFORMES.TAEMPLEADOS.FCSITUACION%TYPE:= 'A';  -- Activo
   vlTipoSemestral      UNIFORMES.TAPEDIDOS.FITIPO%TYPE := 2;   -- Carga Semestral
    
BEGIN
   OPEN paCurPedidoActual FOR 
      SELECT  EMP.FIEMPLEADO 
            , EMP.FCNOMBRE
            , EMP.FCPOSICION
            , EMP.FCGENERO
            , TPROD.FCDESCRIPCION  DESCPROD 
            , PR.FITIPO   --TIPO DE PRENDA
            , PR.FITALLA   
        FROM  UNIFORMES.TAEMPLEADOS EMP 
  INNER JOIN  UNIFORMES.TAPEDIDOS P
          ON (EMP.FIEMPLEADO =  P.FIEMPLEADO) 
  INNER JOIN UNIFORMES.TADETALLEPEDIDOS  DP 
          ON (P.FIFOLIOCENTRAL = DP.FIFOLIOCENTRAL )  
  INNER JOIN UNIFORMES.TAPRODUCTOS PR
          ON (DP.FISKU = PR.FISKU)
  INNER JOIN UNIFORMES.TATIPOSPRODUCTO TPROD
          ON (PR.FITIPO = TPROD.FITIPO)
       WHERE EMP.FCSITUACION = vlSituacion    
         AND P.FITIPO = vlTipoSemestral  
         AND P.FIEMPLEADO = paNumEmpleado;         
  
END SPCONSULTAEMPLEADOCARGA;
   
 
PROCEDURE  SPGRABAPEDIDO(
    paIdEmpleado         IN   UNIFORMES.TAPEDIDOS.FIEMPLEADO%TYPE
   ,paEstadoGral         IN   UNIFORMES.TAPEDIDOS.FIESTADOGENERAL%TYPE
   ,paTipo               IN   UNIFORMES.TAPEDIDOS.FITIPO%TYPE
   ,paEmpleadoSolicita   IN   UNIFORMES.TAPEDIDOS.FIEMPLEADOSOLICITA%TYPE
   ,paFuncion            IN   UNIFORMES.TAPEDIDOS.FIFUNCION%TYPE
   ,paFolioCentral       OUT  UNIFORMES.TAPEDIDOS.FIFOLIOCENTRAL%TYPE )
IS
/********************************************************************************
   Descripcion: Procedimiento que graba el pedido 
   Parámetros de entrada:paIdEmpleado, paEstadoGral, paTipo, paEmpleadoSolicita, pafuncion
   Parámetros de salida: paFolioCentral 
   Parámetros de entrada-salida: Ninguno
   Valor de retorno: 
   * En el flujo completo solo grabará 1 vez al empleado por la carga semestral
    en individual puede grabar tantos pedidos quiera y 1 pedido por empleado desde Tienda Escuela
   Creador: Laura Garcia Martinez
   Fecha de creación: 19 JUNIO 2014
**************************************************************************************/  
     
    vlFechaRegistro       UNIFORMES.TAPEDIDOS.FDREGISTRO%TYPE := SYSDATE;
    vlIdCarga             UNIFORMES.TACARGAS.FIIDCARGA%TYPE:= 0;
    vlTipoSemestral       UNIFORMES.TAPEDIDOS.FITIPO%TYPE := 2;   -- Carga Semestral
    vlTipoFormador        UNIFORMES.TAPEDIDOS.FITIPO%TYPE := 3;   -- Carga Semestral
    vlValida              NUMBER(3) := 0;
    vlError               NUMBER(5):= -20001;
    cslActivo             UNIFORMES.TACARGAS.FIESTATUS%TYPE:= 1;
    cslDos                NUMBER(1):= 2;
    
BEGIN
    
    IF (paTipo=cslDos) THEN   -- SEMESTRAL
      SELECT FIIDCARGA
        INTO vlIdCarga
        FROM UNIFORMES.TACARGAS
       WHERE FIESTATUS = cslActivo;
    END IF;
    
    SELECT COUNT(ROWID)
      INTO vlValida
      FROM UNIFORMES.TAPEDIDOS
     WHERE FITIPO IN(vlTipoSemestral, vlTipoFormador)  -- Tipo formador 
       AND FIIDCARGA IN (vlIdCarga, csgCero)
       AND FIEMPLEADO = paIdEmpleado
       AND TRUNC(FDREGISTRO) = TRUNC(SYSDATE);
    
    IF (vlValida = 0)
    THEN
       INSERT INTO UNIFORMES.TAPEDIDOS( FIFOLIOCENTRAL
                                      , FIEMPLEADO
                                      , FIESTADOGENERAL
                                      , FITIPO
                                      , FIIDCARGA
                                      , FIEMPLEADOSOLICITA
                                      , FIFUNCION
                                      , FDREGISTRO)
                               VALUES ( UNIFORMES.SEWSGRABAPEDIDO.nextval
                                      , paIdEmpleado
                                      , paEstadoGral
                                      , paTipo
                                      , vlIdCarga
                                      , paEmpleadoSolicita
                                      , paFuncion
                                      , vlFechaRegistro ) returning FIFOLIOCENTRAL into paFolioCentral;
    ELSE 
       Raise_Application_Error ( vlError, 'YA SOLICITO EL PEDIDO PREVIAMENTE.');
    END IF;
   

END SPGRABAPEDIDO;


PROCEDURE SPGRABADETPEDIDO(
    paPais             IN    UNIFORMES.TADETALLEPEDIDOS.FIPAIS%TYPE
   ,paCanal            IN    UNIFORMES.TADETALLEPEDIDOS.FICANAL%TYPE
   ,paSucursal         IN    UNIFORMES.TADETALLEPEDIDOS.FISUCURSAL%TYPE 
   ,paPedido           IN    UNIFORMES.TADETALLEPEDIDOS.FIPEDIDO%TYPE
   ,paFolioCentral     IN    UNIFORMES.TADETALLEPEDIDOS.FIFOLIOCENTRAL%TYPE
   ,paSKU              IN    UNIFORMES.TADETALLEPEDIDOS.FISKU%TYPE
   ,paCantidad         IN    UNIFORMES.TADETALLEPEDIDOS.FICANTIDAD%TYPE 
   ,paEstatus          IN    UNIFORMES.TADETALLEPEDIDOS.FIESTATUS%TYPE
   ,paCosto            IN    UNIFORMES.TADETALLEPEDIDOS.FNCOSTO%TYPE
   ,paDescuento        IN    UNIFORMES.TADETALLEPEDIDOS.FNDESCUENTO%TYPE )
IS
/********************************************************************************
   Descripcion: Función que regresa los datos 
   Parámetros de entrada: paPais, paCanal, paSucursal, paPedido, paFolioCentral
                        , paSKU, paCantidad, paEstatus, paCosto, paDescuento
   Parámetros de salida: No aplica
   Parámetros de entrada-salida: Ninguno
   Valor de retorno: Cursor con resultado.
   Creador: Laura Garcia Martinez
   Fecha de creación: 11 jul 2014
**************************************************************************************/  
     vlFecha              UNIFORMES.TADETALLEPEDIDOS.FDACTUALIZACION%TYPE := SYSDATE;
     vlGerenteEntrega     UNIFORMES.TADETALLEPEDIDOS.FIGERENTEENTREGA%TYPE:=0; 
   
     
BEGIN
    
    INSERT INTO UNIFORMES.TADETALLEPEDIDOS( FIFOLIOCENTRAL
                                          , FIPAIS
                                          , FICANAL
                                          , FISUCURSAL
                                          , FIPEDIDO
                                          , FISKU
                                          , FICANTIDAD
                                          , FIESTATUS
                                          , FNCOSTO
                                          , FNDESCUENTO
                                          , FIGERENTEENTREGA
                                          , FDACTUALIZACION ) 
                                   VALUES ( paFolioCentral
                                          , paPais
                                          , paCanal 
                                          , paSucursal
                                          , paPedido
                                          , paSKU
                                          , paCantidad
                                          , paEstatus
                                          , paCosto 
                                          , paDescuento
                                          , vlGerenteEntrega
                                          , vlFecha);
                                          

END SPGRABADETPEDIDO;
   

PROCEDURE  SPPEDIDOSPENDIENTESABASTO(
   paCurPendientesAb     OUT    rcgCursor )
IS
/********************************************************************************
   Descripcion: Función que regresa los datos 
   Parámetros de entrada: No aplica
   Parámetros de salida: paCurPendientesAb
   Parámetros de entrada-salida: Ninguno
   Valor de retorno: Cursor con resultado.
   Creador: Laura Garcia Martinez
   Fecha de creación: 19 JUNIO 2014
**************************************************************************************/  

   vlEstatus      UNIFORMES.TADETALLEPEDIDOS.FIESTATUS%TYPE:= 30;  -- ENVIADO A TDA
   vlTipo         UNIFORMES.TAPEDIDOS.FITIPO%TYPE:= 2;  --SEMESTRAL
   
BEGIN
   
   OPEN paCurPendientesAb FOR
    SELECT P.FIEMPLEADO
         , P.FIESTADOGENERAL
         , P.FITIPO
         , P.FIEMPLEADOSOLICITA
         , P.FDREGISTRO
         , DP.FIPAIS
         , DP.FICANAL
         , DP.FISUCURSAL
         , DP.FIPEDIDO
         , DP.FIFOLIOCENTRAL
         , DP.FISKU
         , DP.FICANTIDAD
         , DP.FIESTATUS
         , DP.FNCOSTO
         , DP.FNDESCUENTO
         , TO_CHAR(DP.FDACTUALIZACION,'DD/MM/YYYY HH24:MI:SS')  AS FDACTUALIZACION   
   FROM UNIFORMES.TAPEDIDOS P 
   INNER JOIN UNIFORMES.TADETALLEPEDIDOS  DP 
    ON ( P.FIFOLIOCENTRAL = DP.FIFOLIOCENTRAL )  
   WHERE P.FITIPO = vlTipo
    AND DP.FIESTATUS = vlEstatus;  
   
     
END SPPEDIDOSPENDIENTESABASTO;


PROCEDURE SPCONSULTAEMPLEADOSOLICITUD(
    paTienda        IN    VARCHAR2
   ,paCurSolicitud  OUT   rcgCursor)
IS
/********************************************************************************
   Descripcion: Función que regresa los uniformes de los empleados de una sucursal
                en especifico, la solicitud la realiza el Gerente de la tienda
   Parámetros de entrada: paTienda
   Parámetros de salida: paCurSolicitud
   Parámetros de entrada-salida: Ninguno
   Valor de retorno: Cursor con resultado.
   Creador: Laura Garcia Martinez
   Fecha de creación: 23 JUNIO 2014
**************************************************************************************/  
   vlTienda          VARCHAR2(10):='';
   vlTienda2         VARCHAR2(10):='';
   vlTienda3         VARCHAR2(10):='';  
   vlTienda5         VARCHAR2(10):='';
   vlTienda6         VARCHAR2(10):='';
   vlSituacion       UNIFORMES.TAEMPLEADOS.FCSITUACION%TYPE:= 'A';  -- Activo
   vlGeneroU         UNIFORMES.TAPRODUCTOS.FCGENERO%TYPE:= 'U';  -- Unisex       
   vlTipoSemestral   UNIFORMES.TAPEDIDOS.FITIPO%TYPE := 2;   -- Carga Semestral
   vlTipoFormador    UNIFORMES.TAPEDIDOS.FITIPO%TYPE := 3;   -- Carga Semestral
   vlIdCarga         UNIFORMES.TACARGAS.FIIDCARGA%TYPE:= 0;
   vlFecIni          UNIFORMES.TACARGAS.FDFECHAFINAL%TYPE;
   vlFecFin          UNIFORMES.TACARGAS.FDFECHAFINAL%TYPE;
   vlFechaActual     UNIFORMES.TACARGAS.FDFECHAFINAL%TYPE; 
   cslActivo         UNIFORMES.TACARGAS.FIESTATUS%TYPE:= 1;
   vlNoDatos         NUMBER(5):= -20001;
   vlConteo          NUMBER(10):= 0;
   vlDiasAntiguedad  NUMBER(1) := 4;
   vlDosMeses        NUMBER(1) := 2;
BEGIN
   vlTienda := '52' || paTienda;
   vlTienda2 := '80' || paTienda;
   vlTienda3 := '50' || paTienda;
   vlTienda5 := '64' || paTienda;
   vlTienda6 := '79' || paTienda;
   
   SELECT FIIDCARGA
         ,TRUNC(FDFECHAINICIAL)
         ,TRUNC(FDFECHAFINAL)
         ,TRUNC(SYSDATE)
     INTO vlIdCarga
         ,vlFecIni
         ,vlFecFin
         ,vlFechaActual
     FROM UNIFORMES.TACARGAS
    WHERE FIESTATUS = cslActivo; 
    
   IF ( vlFechaActual BETWEEN vlFecIni  AND  vlFecFin ) THEN
       SELECT COUNT(1)
         INTO vlConteo
         FROM UNIFORMES.TAEMPLEADOS EMP
        INNER JOIN UNIFORMES.TACECO CECO
                ON (EMP.FICECO = CECO.FICC)
        INNER JOIN UNIFORMES.TAFUNCIONES FUN
                ON (FUN.FIFUNCIONSAP = EMP.FIFUNCION AND TRIM(CECO.FCIDCANAL)=TRIM(FUN.FCIDCANAL))
        INNER JOIN UNIFORMES.TAKITS KIT
                ON (KIT.FIKIT = FUN.FIKIT)
        INNER JOIN UNIFORMES.TAPRODUCTOSXKIT PXKIT
                ON (KIT.FIKIT = PXKIT.FIKIT)
        INNER JOIN UNIFORMES.TAPRODUCTOS PROD
                ON (PXKIT.FISKU = PROD.FISKU)
        INNER JOIN UNIFORMES.TATIPOSPRODUCTO TPROD
                ON (PROD.FITIPO = TPROD.FITIPO)
        INNER JOIN UNIFORMES.TATALLAS TALLA
                ON (PROD.FITALLA = TALLA.FITALLA)
              WHERE EMP.FICECO IN (TO_NUMBER(vlTienda), TO_NUMBER(vlTienda2), TO_NUMBER(vlTienda3), TO_NUMBER(vlTienda5), TO_NUMBER(vlTienda6) )
               AND EMP.FCSITUACION = vlSituacion    
               AND (PROD.FCGENERO = EMP.FCGENERO OR PROD.FCGENERO = vlGeneroU )  
               AND EMP.FIEMPLEADO NOT IN (SELECT FIEMPLEADO           -- Menos los empleados que ya solicitaron su pedido
                                            FROM UNIFORMES.TAPEDIDOS
                                           WHERE FITIPO IN( vlTipoSemestral, vlTipoFormador)
                                             AND FIIDCARGA IN (vlIdCarga)
                                           UNION 
                                          SELECT FIEMPLEADO     
                                            FROM UNIFORMES.TAPEDIDOS
                                           WHERE FITIPO IN( vlTipoSemestral, vlTipoFormador) 
                                             AND FIIDCARGA IN (csgCero)
                                             AND FDREGISTRO > ADD_MONTHS(SYSDATE,-vlDosMeses)
                                         ) 
              AND EMP.FDINGRESO <= SYSDATE-vlDiasAntiguedad;
       IF (vlConteo > 0)
        THEN
              OPEN paCurSolicitud  FOR
            SELECT EMP.FIEMPLEADO 
                 , EMP.FCNOMBRE                 
                 , EMP.FCPOSICION
                 , EMP.FCGENERO
                 , TPROD.FCDESCRIPCION  DESCPROD
                 , TALLA.FCCLAVE
                 , TALLA.FITALLA
                 , PROD.FNCOSTO   
                 , PROD.FNDESCUENTO   
                 , EMP.FIFUNCION    
                 , CECO.FCIDCANAL AS FIUNIDADNEGOCIO
                 , PROD.FITIPO    
                 , PROD.FISKU 
                 , TALLA.FCDESCRIPCION
              FROM  UNIFORMES.TAEMPLEADOS EMP
        INNER JOIN UNIFORMES.TACECO CECO
                ON (EMP.FICECO = CECO.FICC)
        INNER JOIN UNIFORMES.TAFUNCIONES FUN
                ON (FUN.FIFUNCIONSAP = EMP.FIFUNCION AND TRIM(CECO.FCIDCANAL)=TRIM(FUN.FCIDCANAL))
        INNER JOIN UNIFORMES.TAKITS KIT
                ON (KIT.FIKIT = FUN.FIKIT)
        INNER JOIN UNIFORMES.TAPRODUCTOSXKIT PXKIT
                ON (KIT.FIKIT = PXKIT.FIKIT)
        INNER JOIN UNIFORMES.TAPRODUCTOS PROD
                ON (PXKIT.FISKU = PROD.FISKU)
        INNER JOIN UNIFORMES.TATIPOSPRODUCTO TPROD
                ON (PROD.FITIPO = TPROD.FITIPO)
        INNER JOIN UNIFORMES.TATALLAS TALLA
                ON (PROD.FITALLA = TALLA.FITALLA)
              WHERE EMP.FICECO IN (TO_NUMBER(vlTienda), TO_NUMBER(vlTienda2), TO_NUMBER(vlTienda3), TO_NUMBER(vlTienda5), TO_NUMBER(vlTienda6) )
               AND EMP.FCSITUACION = vlSituacion    
               AND (PROD.FCGENERO = EMP.FCGENERO OR PROD.FCGENERO = vlGeneroU )  
               AND EMP.FIEMPLEADO NOT IN (SELECT FIEMPLEADO      -- Menos los empleados que ya solicitaron su pedido
                                            FROM UNIFORMES.TAPEDIDOS
                                           WHERE FITIPO IN( vlTipoSemestral  , vlTipoFormador)
                                             AND FIIDCARGA IN (vlIdCarga)
                                           UNION 
                                          SELECT FIEMPLEADO     
                                            FROM UNIFORMES.TAPEDIDOS
                                           WHERE FITIPO IN( vlTipoSemestral, vlTipoFormador)
                                             AND FIIDCARGA IN (csgCero)
                                             AND FDREGISTRO > ADD_MONTHS(SYSDATE,-vlDosMeses)
                                          )
              AND EMP.FDINGRESO <= SYSDATE-vlDiasAntiguedad
          ORDER BY EMP.FIEMPLEADO, DESCPROD, FITALLA;
       ELSE
           Raise_Application_Error ( vlNoDatos, 'No se encontraron datos para esta solicitud o ya cuenta con pedidos solicitados.');
        END IF;
          
   ELSE
       Raise_Application_Error ( vlNoDatos, 'El sistema no esta disponible en este Periodo.');
   END IF;

   
END SPCONSULTAEMPLEADOSOLICITUD;



PROCEDURE SPSOLICITUDFORMADOR(
   paIdEmpleado     IN    UNIFORMES.TAEMPLEADOS.FIEMPLEADO%TYPE
   ,paCurSolicitud  OUT   rcgCursor)
IS
/***********************************************************************************
   Descripcion: Procedimiento que regresa los datos de uniformes para los empleados
                de nuevo ingreso, la solicitud la realiza el FORMADOR o GERENTE
   Parámetros de entrada:  paIdEmpleado
   Parámetros de salida: paCurSolicitud
   Parámetros de entrada-salida: Ninguno
   Valor de retorno: Cursor con resultado.
   Creador:  Laura Garcia Martinez
   Fecha de creación: 9 JULIO 2014
***************************************************************************************/  
 
   vlSituacion         UNIFORMES.TAEMPLEADOS.FCSITUACION%TYPE:= 'A';  -- Activo
   vlGeneroU           UNIFORMES.TAPRODUCTOS.FCGENERO%TYPE:= 'U';  -- Unisex       
   vlTipoSemestral     UNIFORMES.TAPEDIDOS.FITIPO%TYPE := 2;   -- Carga Semestral
   vlTipoFormador      UNIFORMES.TAPEDIDOS.FITIPO%TYPE := 3;   -- Carga Semestral
   vlFuncionEmpleado   UNIFORMES.TAEMPLEADOS.FIFUNCION%TYPE:=0;
   vlSucursal          VARCHAR2(6):='';
   vlFunFormador       UNIFORMES.TAEMPLEADOS.FIFUNCION%TYPE:= 8041; -- Formador
   vlFuNuevaFormador   UNIFORMES.TAEMPLEADOS.FIFUNCION%TYPE:= 8030; -- Formador
   vlFunGerente        UNIFORMES.TAEMPLEADOS.FIFUNCION%TYPE:= 8035; -- Gerente
   vlFunSubGerente     UNIFORMES.TAEMPLEADOS.FIFUNCION%TYPE:= 8034; -- Subgerente
   vlCeCo              UNIFORMES.TAEMPLEADOS.FICECO%TYPE := 0;
   vlNoDatos           NUMBER(5):= -20001;
   vlConFormador       NUMBER(5):= -20002;
   vlIdCarga           UNIFORMES.TACARGAS.FIIDCARGA%TYPE:= 0;
   cslActivo           UNIFORMES.TACARGAS.FIESTATUS%TYPE:= 1;
   vlConteo            NUMBER(10):= 0;
   vlTres              NUMBER(1):= 3;
   vlCuatro            NUMBER(1):= 4;
   vlCero              NUMBER(1):= 0;
   vlDiasAntiguedad    NUMBER(1) := 4;
   vlDosMeses          NUMBER(1) := 2;
   vlDiasLimite        NUMBER(2) := 12;
   
BEGIN

    SELECT FIIDCARGA
     INTO vlIdCarga
     FROM UNIFORMES.TACARGAS
    WHERE FIESTATUS = cslActivo; 

    SELECT FIFUNCION 
          ,SUBSTR(FICECO, vlTres, vlCuatro) AS SUCURSAL 
          ,FICECO 
      INTO vlFuncionEmpleado
          ,vlSucursal 
          ,vlCeCo
     FROM UNIFORMES.TAEMPLEADOS
    WHERE FIEMPLEADO = paIdEmpleado;  
      
    
     IF ((vlFuncionEmpleado = vlFunFormador) OR (vlFuncionEmpleado = vlFuNuevaFormador) ) THEN   -- Opcion Formador
         SELECT COUNT(1)
           INTO vlConteo 
           FROM UNIFORMES.TAEMPLEADOS EMP
          INNER JOIN UNIFORMES.TACECO CECO
                  ON (EMP.FICECO = CECO.FICC)
          INNER JOIN UNIFORMES.TAFUNCIONES FUN
                  ON (FUN.FIFUNCIONSAP = EMP.FIFUNCION AND TRIM(CECO.FCIDCANAL)=TRIM(FUN.FCIDCANAL))
          INNER JOIN UNIFORMES.TAKITS KIT
                  ON (KIT.FIKIT = FUN.FIKIT)
          INNER JOIN UNIFORMES.TAPRODUCTOSXKIT PXKIT
                  ON (KIT.FIKIT = PXKIT.FIKIT)
          INNER JOIN UNIFORMES.TAPRODUCTOS PROD
                  ON (PXKIT.FISKU = PROD.FISKU)
          INNER JOIN UNIFORMES.TATIPOSPRODUCTO TPROD
                  ON (PROD.FITIPO = TPROD.FITIPO)
          INNER JOIN UNIFORMES.TATALLAS TALLA
                  ON (PROD.FITALLA = TALLA.FITALLA)
          INNER JOIN (SELECT TO_NUMBER('52'|| LPAD (TO_CHAR(FISUCURSAL),vlCuatro ,vlCero)) AS SUC  -- Lista de Sucursales x Formador
                     FROM UNIFORMES.TASUCURSALES
                    WHERE FIIDFORMADOR = paIdEmpleado
                    UNION  ALL
                    SELECT TO_NUMBER('80'|| LPAD (TO_CHAR(FISUCURSAL),vlCuatro ,vlCero)) AS SUC  -- Lista de Sucursales x Formador
                     FROM UNIFORMES.TASUCURSALES
                    WHERE FIIDFORMADOR = paIdEmpleado
                    UNION ALL
                    SELECT TO_NUMBER('50'|| LPAD (TO_CHAR(FISUCURSAL),vlCuatro ,vlCero)) AS SUC  -- Lista de Sucursales x Formador
                     FROM UNIFORMES.TASUCURSALES
                    WHERE FIIDFORMADOR = paIdEmpleado
                    UNION ALL
                    SELECT TO_NUMBER('64'|| LPAD (TO_CHAR(FISUCURSAL),vlCuatro ,vlCero)) AS SUC  -- Lista de Sucursales x Formador
                     FROM UNIFORMES.TASUCURSALES
                    WHERE FIIDFORMADOR = paIdEmpleado
                    UNION ALL
                    SELECT TO_NUMBER('79'|| LPAD (TO_CHAR(FISUCURSAL),vlCuatro ,vlCero)) AS SUC  -- Lista de Sucursales x Formador
                     FROM UNIFORMES.TASUCURSALES
                    WHERE FIIDFORMADOR = paIdEmpleado) DATOS
                 ON (EMP.FICECO = DATOS.SUC)
                 WHERE EMP.FCSITUACION =  vlSituacion
                 AND (PROD.FCGENERO = EMP.FCGENERO OR PROD.FCGENERO = vlGeneroU )  
                 AND EMP.FIEMPLEADO NOT IN (SELECT FIEMPLEADO      -- Menos los empleados que ya solicitaron su pedido
                                              FROM UNIFORMES.TAPEDIDOS
                                             WHERE FITIPO IN( vlTipoSemestral  , vlTipoFormador)
                                               AND FIIDCARGA IN (vlIdCarga)
                                             UNION 
                                            SELECT FIEMPLEADO     
                                              FROM UNIFORMES.TAPEDIDOS
                                             WHERE FITIPO IN( vlTipoSemestral, vlTipoFormador)
                                               AND FIIDCARGA IN (csgCero)
                                               AND FDREGISTRO > ADD_MONTHS(SYSDATE,-vlDosMeses)
                                           )
                  AND TRUNC(EMP.FDINGRESO) BETWEEN TRUNC(SYSDATE-vlDiasLimite) AND TRUNC(SYSDATE-vlDiasAntiguedad);
        IF (vlConteo > vlCero)
        THEN
           OPEN paCurSolicitud FOR
              SELECT TO_NUMBER(SUBSTR(EMP.FICECO, vlTres, vlCuatro)) AS SUCURSAL
                   , EMP.FIEMPLEADO 
                   , EMP.FCNOMBRE
                   , EMP.FCPOSICION
                   , EMP.FCGENERO
                   , TPROD.FCDESCRIPCION  DESCPROD
                   , TALLA.FCCLAVE
                   , TALLA.FITALLA
                   , PROD.FNCOSTO   
                   , PROD.FNDESCUENTO   
                   , EMP.FIFUNCION    
                   , CECO.FCIDCANAL AS FIUNIDADNEGOCIO 
                   , PROD.FITIPO    
                   , PROD.FISKU 
                   , TALLA.FCDESCRIPCION
                FROM  UNIFORMES.TAEMPLEADOS EMP
          INNER JOIN UNIFORMES.TACECO CECO
                  ON (EMP.FICECO = CECO.FICC)
          INNER JOIN UNIFORMES.TAFUNCIONES FUN
                  ON (FUN.FIFUNCIONSAP = EMP.FIFUNCION AND TRIM(CECO.FCIDCANAL)=TRIM(FUN.FCIDCANAL))
          INNER JOIN UNIFORMES.TAKITS KIT
                  ON (KIT.FIKIT = FUN.FIKIT)
          INNER JOIN UNIFORMES.TAPRODUCTOSXKIT PXKIT
                  ON (KIT.FIKIT = PXKIT.FIKIT)
          INNER JOIN UNIFORMES.TAPRODUCTOS PROD
                  ON (PXKIT.FISKU = PROD.FISKU)
          INNER JOIN UNIFORMES.TATIPOSPRODUCTO TPROD
                  ON (PROD.FITIPO = TPROD.FITIPO)
          INNER JOIN UNIFORMES.TATALLAS TALLA
                  ON (PROD.FITALLA = TALLA.FITALLA)
          INNER JOIN (SELECT TO_NUMBER('52'|| LPAD (TO_CHAR(FISUCURSAL),vlCuatro , vlCero)) AS SUC  -- Lista de Sucursales x Formador
                     FROM UNIFORMES.TASUCURSALES
                    WHERE FIIDFORMADOR = paIdEmpleado
                    UNION  ALL
                    SELECT TO_NUMBER('80'|| LPAD (TO_CHAR(FISUCURSAL),vlCuatro , vlCero)) AS SUC  -- Lista de Sucursales x Formador
                     FROM UNIFORMES.TASUCURSALES
                    WHERE FIIDFORMADOR = paIdEmpleado
                    UNION ALL
                    SELECT TO_NUMBER('50'|| LPAD (TO_CHAR(FISUCURSAL),vlCuatro , vlCero)) AS SUC  -- Lista de Sucursales x Formador
                     FROM UNIFORMES.TASUCURSALES
                    WHERE FIIDFORMADOR = paIdEmpleado
                    UNION ALL
                    SELECT TO_NUMBER('64'|| LPAD (TO_CHAR(FISUCURSAL),vlCuatro , vlCero)) AS SUC  -- Lista de Sucursales x Formador
                     FROM UNIFORMES.TASUCURSALES
                    WHERE FIIDFORMADOR = paIdEmpleado
                    UNION ALL
                    SELECT TO_NUMBER('79'|| LPAD (TO_CHAR(FISUCURSAL),vlCuatro , vlCero)) AS SUC  -- Lista de Sucursales x Formador
                     FROM UNIFORMES.TASUCURSALES
                    WHERE FIIDFORMADOR = paIdEmpleado) DATOS
                 ON (EMP.FICECO = DATOS.SUC)
                 WHERE EMP.FCSITUACION =  vlSituacion
                 AND (PROD.FCGENERO = EMP.FCGENERO OR PROD.FCGENERO = vlGeneroU )  
                 AND EMP.FIEMPLEADO NOT IN (SELECT FIEMPLEADO      -- Menos los empleados que ya solicitaron su pedido
                                              FROM UNIFORMES.TAPEDIDOS
                                             WHERE FITIPO IN( vlTipoSemestral  , vlTipoFormador)
                                               AND FIIDCARGA IN (vlIdCarga)
                                             UNION 
                                            SELECT FIEMPLEADO     
                                              FROM UNIFORMES.TAPEDIDOS
                                             WHERE FITIPO IN( vlTipoSemestral, vlTipoFormador)
                                               AND FIIDCARGA IN (csgCero)
                                               AND FDREGISTRO > ADD_MONTHS(SYSDATE,-vlDosMeses)
                                           )
                 AND TRUNC(EMP.FDINGRESO) BETWEEN TRUNC(SYSDATE-vlDiasLimite) AND TRUNC(SYSDATE-vlDiasAntiguedad)
            ORDER BY EMP.FIEMPLEADO, DESCPROD, FITALLA;
        ELSE
           Raise_Application_Error ( vlNoDatos, 'No cuenta con Empleados Nuevos asignados.');
        END IF;
          
     ELSIF(vlFuncionEmpleado=vlFunGerente OR vlFuncionEmpleado=vlFunSubGerente) THEN   -- Gerente O Subgerente con Rol de Formador        
           SELECT COUNT(1)
             INTO vlConteo
             FROM UNIFORMES.TAEMPLEADOS EMP
       INNER JOIN UNIFORMES.TACECO CECO
               ON (EMP.FICECO = CECO.FICC)
       INNER JOIN UNIFORMES.TAFUNCIONES FUN
               ON (FUN.FIFUNCIONSAP = EMP.FIFUNCION AND TRIM(CECO.FCIDCANAL)=TRIM(FUN.FCIDCANAL))
       INNER JOIN UNIFORMES.TAKITS KIT
               ON (KIT.FIKIT = FUN.FIKIT)
       INNER JOIN UNIFORMES.TAPRODUCTOSXKIT PXKIT
               ON (KIT.FIKIT = PXKIT.FIKIT)
       INNER JOIN UNIFORMES.TAPRODUCTOS PROD
               ON (PXKIT.FISKU = PROD.FISKU)
       INNER JOIN UNIFORMES.TATIPOSPRODUCTO TPROD
               ON (PROD.FITIPO = TPROD.FITIPO)
       INNER JOIN UNIFORMES.TATALLAS TALLA
               ON (PROD.FITALLA = TALLA.FITALLA)
            WHERE EMP.FICECO IN ( '52'||SUBSTR(TO_CHAR(vlCeCo), vlTres, vlCuatro), '80'||SUBSTR(TO_CHAR(vlCeCo), vlTres, vlCuatro),
             '50'||SUBSTR(TO_CHAR(vlCeCo), vlTres, vlCuatro), '64'||SUBSTR(TO_CHAR(vlCeCo), vlTres, vlCuatro), '79'||SUBSTR(TO_CHAR(vlCeCo), vlTres, vlCuatro) )-- CECO del Gerente de tda
              AND EMP.FCSITUACION = vlSituacion
              AND (PROD.FCGENERO = EMP.FCGENERO OR PROD.FCGENERO = vlGeneroU )  
              AND EMP.FIEMPLEADO NOT IN (SELECT FIEMPLEADO      -- Menos los empleados que ya solicitaron su pedido
                                           FROM UNIFORMES.TAPEDIDOS
                                          WHERE FITIPO IN( vlTipoSemestral  , vlTipoFormador)
                                            AND FIIDCARGA IN (vlIdCarga)
                                          UNION 
                                         SELECT FIEMPLEADO     
                                           FROM UNIFORMES.TAPEDIDOS
                                          WHERE FITIPO IN( vlTipoSemestral, vlTipoFormador)
                                            AND FIIDCARGA IN (csgCero)
                                            AND FDREGISTRO > ADD_MONTHS(SYSDATE,-vlDosMeses)
                                        )
              AND TRUNC(EMP.FDINGRESO) BETWEEN TRUNC(SYSDATE-vlDiasLimite) AND TRUNC(SYSDATE-vlDiasAntiguedad); 
          
          IF(vlConteo > vlCero)
          THEN
              OPEN paCurSolicitud FOR
                 SELECT TO_NUMBER(SUBSTR(EMP.FICECO, vlTres, vlCuatro)) AS SUCURSAL
                      , EMP.FIEMPLEADO 
                      , EMP.FCNOMBRE
                      , EMP.FCPOSICION
                      , EMP.FCGENERO
                      , TPROD.FCDESCRIPCION  DESCPROD
                      , TALLA.FCCLAVE
                      , TALLA.FITALLA
                      , PROD.FNCOSTO   
                      , PROD.FNDESCUENTO   
                      , EMP.FIFUNCION    
                      , CECO.FCIDCANAL AS FIUNIDADNEGOCIO 
                      , PROD.FITIPO    
                      , PROD.FISKU 
                      , TALLA.FCDESCRIPCION
                   FROM UNIFORMES.TAEMPLEADOS EMP
             INNER JOIN UNIFORMES.TACECO CECO
                     ON (EMP.FICECO = CECO.FICC)
             INNER JOIN UNIFORMES.TAFUNCIONES FUN
                     ON (FUN.FIFUNCIONSAP = EMP.FIFUNCION AND TRIM(CECO.FCIDCANAL)=TRIM(FUN.FCIDCANAL))
             INNER JOIN UNIFORMES.TAKITS KIT
                     ON (KIT.FIKIT = FUN.FIKIT)
             INNER JOIN UNIFORMES.TAPRODUCTOSXKIT PXKIT
                     ON (KIT.FIKIT = PXKIT.FIKIT)
             INNER JOIN UNIFORMES.TAPRODUCTOS PROD
                     ON (PXKIT.FISKU = PROD.FISKU)
             INNER JOIN UNIFORMES.TATIPOSPRODUCTO TPROD
                     ON (PROD.FITIPO = TPROD.FITIPO)
             INNER JOIN UNIFORMES.TATALLAS TALLA
                     ON (PROD.FITALLA = TALLA.FITALLA)
                  WHERE EMP.FICECO IN ( '52'||SUBSTR(TO_CHAR(vlCeCo), vlTres, vlCuatro), '80'||SUBSTR(TO_CHAR(vlCeCo), vlTres, vlCuatro),
                   '50'||SUBSTR(TO_CHAR(vlCeCo), vlTres, vlCuatro), '64'||SUBSTR(TO_CHAR(vlCeCo), vlTres, vlCuatro), '79'||SUBSTR(TO_CHAR(vlCeCo), vlTres, vlCuatro) )-- CECO del Gerente de tda
                    AND EMP.FCSITUACION = vlSituacion
                    AND (PROD.FCGENERO = EMP.FCGENERO OR PROD.FCGENERO = vlGeneroU )  
                    AND EMP.FIEMPLEADO NOT IN (SELECT FIEMPLEADO      -- Menos los empleados que ya solicitaron su pedido
                                                 FROM UNIFORMES.TAPEDIDOS
                                                WHERE FITIPO IN( vlTipoSemestral  , vlTipoFormador)
                                                  AND FIIDCARGA IN (vlIdCarga)
                                                UNION 
                                               SELECT FIEMPLEADO     
                                                 FROM UNIFORMES.TAPEDIDOS
                                                WHERE FITIPO IN( vlTipoSemestral, vlTipoFormador)
                                                  AND FIIDCARGA IN (csgCero)
                                                  AND FDREGISTRO > ADD_MONTHS(SYSDATE,-vlDosMeses)
                                              )
                    AND TRUNC(EMP.FDINGRESO) BETWEEN TRUNC(SYSDATE-vlDiasLimite) AND TRUNC(SYSDATE-vlDiasAntiguedad)
               ORDER BY EMP.FIEMPLEADO, DESCPROD, FITALLA;
          ELSE
             Raise_Application_Error ( vlNoDatos, 'No cuenta con Empleados Nuevos asignados.');
          END IF;
     
     ELSE  --  Función del vendedor 8067     
        SELECT COUNT(1)
         INTO vlConteo
         FROM UNIFORMES.TAEMPLEADOS EMP
        INNER JOIN UNIFORMES.TACECO CECO
              ON (EMP.FICECO = CECO.FICC)
        INNER JOIN UNIFORMES.TAFUNCIONES FUN
              ON (FUN.FIFUNCIONSAP = EMP.FIFUNCION AND TRIM(CECO.FCIDCANAL)=TRIM(FUN.FCIDCANAL))
        INNER JOIN UNIFORMES.TAKITS KIT
              ON (KIT.FIKIT = FUN.FIKIT)
        INNER JOIN UNIFORMES.TAPRODUCTOSXKIT PXKIT
              ON (KIT.FIKIT = PXKIT.FIKIT)
        INNER JOIN UNIFORMES.TAPRODUCTOS PROD
              ON (PXKIT.FISKU = PROD.FISKU)
        INNER JOIN UNIFORMES.TATIPOSPRODUCTO TPROD
              ON (PROD.FITIPO = TPROD.FITIPO)
        INNER JOIN UNIFORMES.TATALLAS TALLA
              ON (PROD.FITALLA = TALLA.FITALLA)
            WHERE EMP.FIEMPLEADO = paIdEmpleado   
             AND (PROD.FCGENERO = EMP.FCGENERO OR PROD.FCGENERO = vlGeneroU )  
             AND EMP.FIEMPLEADO NOT IN (SELECT FIEMPLEADO      -- Menos los empleados que ya solicitaron su pedido
                                   FROM UNIFORMES.TAPEDIDOS
                                  WHERE FITIPO IN( vlTipoSemestral  , vlTipoFormador)
                                    AND FIIDCARGA IN (vlIdCarga)
                                  UNION 
                                 SELECT FIEMPLEADO     
                                   FROM UNIFORMES.TAPEDIDOS
                                  WHERE FITIPO IN( vlTipoSemestral, vlTipoFormador)
                                    AND FIIDCARGA IN (csgCero)
                                    AND FDREGISTRO > ADD_MONTHS(SYSDATE,-vlDosMeses)
                                 )
            AND TRUNC(EMP.FDINGRESO) BETWEEN TRUNC(SYSDATE-vlDiasLimite) AND TRUNC(SYSDATE-vlDiasAntiguedad);
            
         IF(vlConteo > vlCero)
         THEN
           OPEN paCurSolicitud FOR
              SELECT TO_NUMBER(SUBSTR(EMP.FICECO, vlTres, vlCuatro)) AS SUCURSAL
                   , EMP.FIEMPLEADO 
                   , EMP.FCNOMBRE
                   , EMP.FCPOSICION
                   , EMP.FCGENERO
                   , TPROD.FCDESCRIPCION  DESCPROD
                   , TALLA.FCCLAVE
                   , TALLA.FITALLA
                   , PROD.FNCOSTO   
                   , PROD.FNDESCUENTO   
                   , EMP.FIFUNCION    
                   , CECO.FCIDCANAL AS FIUNIDADNEGOCIO 
                   , PROD.FITIPO    
                   , PROD.FISKU 
                   , TALLA.FCDESCRIPCION
                FROM UNIFORMES.TAEMPLEADOS EMP
          INNER JOIN UNIFORMES.TACECO CECO
                  ON (EMP.FICECO = CECO.FICC)
          INNER JOIN UNIFORMES.TAFUNCIONES FUN
                  ON (FUN.FIFUNCIONSAP = EMP.FIFUNCION AND TRIM(CECO.FCIDCANAL)=TRIM(FUN.FCIDCANAL))
          INNER JOIN UNIFORMES.TAKITS KIT
                  ON (KIT.FIKIT = FUN.FIKIT)
          INNER JOIN UNIFORMES.TAPRODUCTOSXKIT PXKIT
                  ON (KIT.FIKIT = PXKIT.FIKIT)
          INNER JOIN UNIFORMES.TAPRODUCTOS PROD
                  ON (PXKIT.FISKU = PROD.FISKU)
          INNER JOIN UNIFORMES.TATIPOSPRODUCTO TPROD
                  ON (PROD.FITIPO = TPROD.FITIPO)
          INNER JOIN UNIFORMES.TATALLAS TALLA
                  ON (PROD.FITALLA = TALLA.FITALLA)
               WHERE EMP.FIEMPLEADO = paIdEmpleado   
                 AND (PROD.FCGENERO = EMP.FCGENERO OR PROD.FCGENERO = vlGeneroU )  
                 AND EMP.FIEMPLEADO NOT IN (SELECT FIEMPLEADO      -- Menos los empleados que ya solicitaron su pedido
                                              FROM UNIFORMES.TAPEDIDOS
                                             WHERE FITIPO IN( vlTipoSemestral  , vlTipoFormador)
                                               AND FIIDCARGA IN (vlIdCarga)
                                             UNION 
                                            SELECT FIEMPLEADO     
                                              FROM UNIFORMES.TAPEDIDOS
                                             WHERE FITIPO IN( vlTipoSemestral, vlTipoFormador)
                                               AND FIIDCARGA IN (csgCero)
                                               AND FDREGISTRO > ADD_MONTHS(SYSDATE,-vlDosMeses)
                                           )
                AND TRUNC(EMP.FDINGRESO) BETWEEN TRUNC(SYSDATE-vlDiasLimite) AND TRUNC(SYSDATE-vlDiasAntiguedad)
            ORDER BY EMP.FIEMPLEADO, DESCPROD, FITALLA;
         ELSE
           Raise_Application_Error ( vlNoDatos, 'No cumple con las restricciones de Nuevo Ingreso o ya cuenta con pedidos solicitados.');
         END IF;
          
     END IF;

   EXCEPTION 
   WHEN NO_DATA_FOUND THEN
      Raise_Application_Error ( vlNoDatos, 'El sistema no esta disponible para este Periodo o el empleado no existe o no esta registrado.');
     
END SPSOLICITUDFORMADOR;


FUNCTION FNGRABAREMISION(
    paRemision     IN UNIFORMES.TAREMISIONES.FIREMISION%TYPE
   ,paSucursal     IN UNIFORMES.TAREMISIONES.FISUCURSAL%TYPE
   ,paPedido       IN UNIFORMES.TAREMISIONES.FIPEDIDO%TYPE
   ,paSku          IN UNIFORMES.TAREMISIONES.FISKU%TYPE
   ,paCantidad     IN UNIFORMES.TAREMISIONES.FICANTIDAD%TYPE
   ,paEmpleadoRecibe IN UNIFORMES.TAREMISIONES.FIEMPLEADORECIBE%TYPE)
RETURN PAWSUNIFORMES.rcgCursor
IS
/********************************************************************************
   Descripcion: Función que graba una remision y regresa el registro
   Parámetros de entrada:  paRemision
                           paSucursal 
                           paPedido
                           paSku
                           paCantidad
                           paEmpleadoRecibe
   Parámetros de salida: Cursor
   Parámetros de entrada-salida: Ninguno
   Valor de retorno: Cursor con resultado.
   Creador:Laura Garcia Martinez
   Fecha de creación: 16 JUNIO 2014
**************************************************************************************/

     
      curDatos           UNIFORMES.PAWSUNIFORMES.rcgCursor; 
      
      vlPais             UNIFORMES.TADETALLEPEDIDOS.FIPAIS%TYPE:=0;
      vlCanal            UNIFORMES.TADETALLEPEDIDOS.FICANAL%TYPE:=0;
      vlFolioCentral     UNIFORMES.TADETALLEPEDIDOS.FIFOLIOCENTRAL%TYPE:=0;
      vlEstadoAnt        UNIFORMES.TADETALLEPEDIDOS.FIESTATUS%TYPE:=0;
      vlActualizacion    VARCHAR2(20);
      vlEstEnviaAbasto   UNIFORMES.TADETALLEPEDIDOS.FIESTATUS%TYPE:= 40;  --Enviado a Abasto
      vlEstAbastoCD      UNIFORMES.TADETALLEPEDIDOS.FIESTATUS%TYPE:= 60;  --Abasto Envia a CD
      vlEstAbastoTda     UNIFORMES.TADETALLEPEDIDOS.FIESTATUS%TYPE:= 70; -- Abasto Envia a Tienda
      vlEstRemision      UNIFORMES.TADETALLEPEDIDOS.FIESTATUS%TYPE:= 80; -- Recibido en tienda (REMISION)
      vlCantidadDet      UNIFORMES.TADETALLEPEDIDOS.FICANTIDAD%TYPE:=0; --Cantidad piezas pedido
      vlCantidadRem      UNIFORMES.TAREMISIONES.FICANTIDAD%TYPE:=0; 
      
BEGIN

   SELECT FIPAIS
          ,FICANAL
          ,FIFOLIOCENTRAL
          ,FIESTATUS
          ,TO_CHAR(FDACTUALIZACION,'DD/MM/YYYY HH24:MI:SS') AS FDACTUALIZACION 
          ,FICANTIDAD
     INTO vlPais
         ,vlCanal
         ,vlFolioCentral
         ,vlEstadoAnt
         ,vlActualizacion   
         ,vlCantidadDet
     FROM UNIFORMES.TADETALLEPEDIDOS
    WHERE FISUCURSAL = paSucursal
      AND FIPEDIDO = paPedido
      AND FISKU = paSku
      AND FIESTATUS IN ( vlEstEnviaAbasto, vlEstAbastoCD, vlEstAbastoTda,  vlEstRemision);  
    
        
   BEGIN
    INSERT INTO UNIFORMES.TAREMISIONES( FIFOLIOCENTRAL,
                                        FIPAIS,
                                        FICANAL,
                                        FISUCURSAL,
                                        FIPEDIDO,
                                        FISKU,
                                        FIREMISION,
                                        FICANTIDAD,
                                        FIEMPLEADORECIBE)
                               VALUES ( vlFolioCentral
                                       ,vlPais
                                       ,vlCanal
                                       ,paSucursal
                                       ,paPedido
                                       ,paSku
                                       ,paRemision
                                       ,paCantidad
                                       ,paEmpleadoRecibe );
           
   EXCEPTION 
       WHEN DUP_VAL_ON_INDEX THEN
            NULL;
   END;
   
    SELECT SUM(FICANTIDAD) 
      INTO vlCantidadRem
      FROM UNIFORMES.TAREMISIONES
     WHERE FIFOLIOCENTRAL = vlFolioCentral
       AND FIPAIS = vlPais
       AND FICANAL = vlCanal
       AND FISUCURSAL = paSucursal  
       AND FIPEDIDO = paPedido
       AND FISKU = paSku;
      
   IF ( vlCantidadDet  =  vlCantidadRem ) THEN
           UNIFORMES.PAWSUNIFORMES.SPACTMOVTOPEDIDOS(vlPais
                                                    ,vlCanal
                                                    ,paSucursal
                                                    ,paPedido
                                                    ,vlFolioCentral
                                                    ,paSKU
                                                    ,vlEstadoAnt
                                                    ,vlActualizacion
                                                    ,vlEstRemision );   
   END IF;
                                                    
   OPEN curDatos FOR
        SELECT FIPAIS,
               FICANAL,
               FISUCURSAL,
               FIPEDIDO,
               FIFOLIOCENTRAL,
               FISKU,
               FIREMISION,
               FICANTIDAD,
               FIEMPLEADORECIBE
          FROM UNIFORMES.TAREMISIONES
         WHERE FIFOLIOCENTRAL = vlFolioCentral
           AND FIPAIS = vlPais
           AND FICANAL = vlCanal
           AND FISUCURSAL = paSucursal
           AND FIPEDIDO = paPedido
           AND FISKU = paSku
           AND FIREMISION = paRemision;
           
   RETURN curDatos;
    
END FNGRABAREMISION;


PROCEDURE SPCONSULTAENTREGA
(  paIdEmpleado    IN    UNIFORMES.TAEMPLEADOS.FIEMPLEADO%TYPE
   ,paTienda       IN    UNIFORMES.TASUCURSALES.FISUCURSAL%TYPE
   ,paCurEntrega   OUT   rcgCursor)
IS
/********************************************************************************
   Descripcion: Procedimiento que regresa los datos 
   Parámetros de entrada:  paIdEmpleado, paTienda
   Parámetros de salida: paCurEntrega
   Parámetros de entrada-salida: Ninguno
   Valor de retorno: Cursor con resultado.
   Creador:  Laura Garcia Martinez
   Fecha de creación: 16 JULIO 2014
**************************************************************************************/  

    vlFormador          UNIFORMES.TASUCURSALES.FIIDFORMADOR%TYPE:=0;
    vlPais              UNIFORMES.TADETALLEPEDIDOS.FIPAIS%TYPE:=0;
    vlCanal             UNIFORMES.TADETALLEPEDIDOS.FICANAL%TYPE:=0; 
    vlEstRemision       UNIFORMES.TADETALLEPEDIDOS.FIESTATUS%TYPE:= 80; -- Recibido en tienda (REMISION) 
    vlTipoVoluntaria    UNIFORMES.TAPEDIDOS.FITIPO%TYPE:= 1;
    vlTipoSemestral     UNIFORMES.TAPEDIDOS.FITIPO%TYPE:= 2;
    vlTipoFormador      UNIFORMES.TAPEDIDOS.FITIPO%TYPE:= 3;
    vlNoDatosSuc        NUMBER(5):= -20003;
    vlCero              NUMBER(1):= 0;
    vlUno               NUMBER(1):= 1;
    cslActivo           CONSTANT VARCHAR2(1 CHAR) := 'A'; -- constante para filtrar empleados ACTIVOS
BEGIN
   IF(paIdEmpleado <> vlCero)
   THEN
      SELECT CECO.FIPAIS,
             CECO.FCIDCANAL
        INTO vlPais,
             vlCanal
        FROM UNIFORMES.TAEMPLEADOS EMP
       INNER JOIN UNIFORMES.TACECO CECO
             ON (EMP.FICECO = CECO.FICC)
       INNER JOIN UNIFORMES.TAFUNCIONES FUN
             ON (FUN.FIFUNCIONSAP = EMP.FIFUNCION 
                 AND TRIM(CECO.FCIDCANAL)=TRIM(FUN.FCIDCANAL))
       WHERE EMP.FIEMPLEADO = paIdEmpleado;

        OPEN paCurEntrega FOR
          SELECT DP.FIFOLIOCENTRAL
                ,DP.FIPAIS
                ,DP.FICANAL
                ,DP.FISUCURSAL
                ,P.FIEMPLEADO
                ,P.FITIPO
                ,DP.FIPEDIDO
                ,DP.FISKU
                ,DP.FICANTIDAD
                ,DP.FIESTATUS
                ,DP.FNCOSTO
                ,DP.FNDESCUENTO
                ,TO_CHAR(DP.FDACTUALIZACION,'DD/MM/YYYY HH24:MI:SS') AS FDACTUALIZACION    
                ,EMP.FCNOMBRE 
                ,FUN.FCDESCRIPCION   -- FUNCION DESCRIPCION
                ,EMP.FICECO  -- CENTRO DE COSTOS
                ,RC.FCCOMPANIA 
                ,TIPROD.FCDESCRIPCION 
                ,REMI.FIREMISION
           FROM UNIFORMES.TADETALLEPEDIDOS DP
          INNER JOIN UNIFORMES.TAPEDIDOS P
             ON (P.FIFOLIOCENTRAL = DP.FIFOLIOCENTRAL)
          INNER JOIN UNIFORMES.TAFUNCIONES FUN
             ON (FUN.FIFUNCIONSAP = P.FIFUNCION 
             AND FUN.FCIDCANAL = DP.FICANAL) 
          INNER JOIN UNIFORMES.TARELACIONESCANAL RC
             ON (TO_NUMBER(RC.FCIDCANAL) = DP.FICANAL 
            AND RC.FCIDCANAL = FUN.FCIDCANAL)
          INNER JOIN UNIFORMES.TAEMPLEADOS EMP
             ON (EMP.FIEMPLEADO  = P.FIEMPLEADO
            AND  EMP.FCSITUACION = cslActivo) 
          INNER JOIN UNIFORMES.TAPRODUCTOS PROD
             ON (PROD.FISKU = DP.FISKU )
          INNER JOIN UNIFORMES.TATIPOSPRODUCTO TIPROD
             ON (PROD.FITIPO = TIPROD.FITIPO)  
          INNER JOIN UNIFORMES.TAREMISIONES REMI
             ON (DP.FIFOLIOCENTRAL = REMI.FIFOLIOCENTRAL
            AND DP.FIPAIS     = REMI.FIPAIS
            AND DP.FICANAL    = REMI.FICANAL
            AND DP.FISUCURSAL = REMI.FISUCURSAL 
            AND DP.FIPEDIDO   = REMI.FIPEDIDO
            AND DP.FISKU      = REMI.FISKU)     
          WHERE DP.FIPAIS     = vlPais 
            AND DP.FICANAL    = vlCanal
            AND DP.FISUCURSAL = paTienda
            AND DP.FIESTATUS  = vlEstRemision
            AND RC.FCIDCANAL  = TO_CHAR(vlCanal)
            AND P.FITIPO IN ( vlTipoSemestral, vlTipoFormador, vlTipoVoluntaria)
             AND (DP.FIFOLIOCENTRAL, DP.FIPEDIDO,DP.FISKU,REMI.FIREMISION, DP.FICANTIDAD) IN (
                  SELECT DP.FIFOLIOCENTRAL
                         ,DP.FIPEDIDO
                         ,DP.FISKU
                         ,MAX(REMI.FIREMISION)
                         ,SUM(REMI.FICANTIDAD)
                         FROM UNIFORMES.TADETALLEPEDIDOS DP
                   INNER JOIN UNIFORMES.TAPEDIDOS P
                      ON (P.FIFOLIOCENTRAL = DP.FIFOLIOCENTRAL)
                   INNER JOIN UNIFORMES.TAFUNCIONES FUN
                      ON (FUN.FIFUNCIONSAP = P.FIFUNCION 
                     AND FUN.FCIDCANAL = DP.FICANAL) 
                   INNER JOIN UNIFORMES.TARELACIONESCANAL RC
                      ON (TO_NUMBER(RC.FCIDCANAL) = DP.FICANAL 
                     AND RC.FCIDCANAL = FUN.FCIDCANAL)
                   INNER JOIN UNIFORMES.TAEMPLEADOS EMP
                      ON (EMP.FIEMPLEADO = P.FIEMPLEADO ) 
                   INNER JOIN UNIFORMES.TAPRODUCTOS PROD
                      ON (PROD.FISKU = DP.FISKU )
                   INNER JOIN UNIFORMES.TATIPOSPRODUCTO TIPROD
                      ON (PROD.FITIPO = TIPROD.FITIPO)  
                   INNER JOIN UNIFORMES.TAREMISIONES REMI
                      ON (DP.FIFOLIOCENTRAL = REMI.FIFOLIOCENTRAL
                     AND DP.FIPAIS = REMI.FIPAIS
                     AND DP.FICANAL = REMI.FICANAL
                     AND DP.FISUCURSAL = REMI.FISUCURSAL 
                     AND DP.FIPEDIDO = REMI.FIPEDIDO
                     AND DP.FISKU = REMI.FISKU)     
                   WHERE DP.FIPAIS = vlPais 
                     AND DP.FICANAL  = vlCanal
                     AND DP.FISUCURSAL = paTienda
                     AND DP.FIESTATUS = vlEstRemision
                     AND RC.FCIDCANAL = TO_CHAR(vlCanal)
                     AND P.FITIPO IN ( vlTipoSemestral, vlTipoFormador, vlTipoVoluntaria)
                     GROUP BY DP.FIFOLIOCENTRAL
                         ,DP.FIPEDIDO
                         ,DP.FISUCURSAL
                         ,DP.FISKU)
       ORDER BY P.FIEMPLEADO
                ,DP.FIFOLIOCENTRAL
                ,DP.FIPEDIDO;
   ELSE
        vlPais := vlUno;
        OPEN paCurEntrega FOR
          SELECT DP.FIFOLIOCENTRAL
                ,DP.FIPAIS
                ,DP.FICANAL
                ,DP.FISUCURSAL
                ,P.FIEMPLEADO
                ,P.FITIPO
                ,DP.FIPEDIDO
                ,DP.FISKU
                ,DP.FICANTIDAD
                ,DP.FIESTATUS
                ,DP.FNCOSTO
                ,DP.FNDESCUENTO
                ,TO_CHAR(DP.FDACTUALIZACION,'DD/MM/YYYY HH24:MI:SS') AS FDACTUALIZACION    
                ,EMP.FCNOMBRE 
                ,FUN.FCDESCRIPCION   -- FUNCION DESCRIPCION
                ,EMP.FICECO  -- CENTRO DE COSTOS
                ,RC.FCCOMPANIA 
                ,TIPROD.FCDESCRIPCION 
                ,REMI.FIREMISION
           FROM UNIFORMES.TADETALLEPEDIDOS DP
          INNER JOIN UNIFORMES.TAPEDIDOS P
             ON (P.FIFOLIOCENTRAL = DP.FIFOLIOCENTRAL)
          INNER JOIN UNIFORMES.TAFUNCIONES FUN
             ON (FUN.FIFUNCIONSAP = P.FIFUNCION 
             AND FUN.FCIDCANAL = DP.FICANAL) 
          INNER JOIN UNIFORMES.TARELACIONESCANAL RC
             ON (TO_NUMBER(RC.FCIDCANAL) = DP.FICANAL 
            AND RC.FCIDCANAL = FUN.FCIDCANAL)
          INNER JOIN UNIFORMES.TAEMPLEADOS EMP
             ON (EMP.FIEMPLEADO  = P.FIEMPLEADO
            AND  EMP.FCSITUACION = cslActivo)  
          INNER JOIN UNIFORMES.TAPRODUCTOS PROD
             ON (PROD.FISKU = DP.FISKU )
          INNER JOIN UNIFORMES.TATIPOSPRODUCTO TIPROD
             ON (PROD.FITIPO = TIPROD.FITIPO)  
          INNER JOIN UNIFORMES.TAREMISIONES REMI
             ON (DP.FIFOLIOCENTRAL = REMI.FIFOLIOCENTRAL
            AND DP.FIPAIS     = REMI.FIPAIS
            AND DP.FICANAL    = REMI.FICANAL
            AND DP.FISUCURSAL = REMI.FISUCURSAL 
            AND DP.FIPEDIDO   = REMI.FIPEDIDO
            AND DP.FISKU      = REMI.FISKU)     
          WHERE DP.FIPAIS     = vlPais
            AND DP.FISUCURSAL = paTienda
            AND DP.FIESTATUS  = vlEstRemision
            AND P.FITIPO IN ( vlTipoSemestral, vlTipoFormador, vlTipoVoluntaria)
            AND TRANSLATE(RC.FCIDCANAL, 'T 0123456789', 'T') IS NULL
            AND (DP.FIFOLIOCENTRAL, DP.FIPEDIDO,DP.FISKU,REMI.FIREMISION,DP.FICANTIDAD) IN (
                  SELECT DP.FIFOLIOCENTRAL
                        ,DP.FIPEDIDO
                        ,DP.FISKU
                        ,MAX(REMI.FIREMISION)
                        ,SUM(REMI.FICANTIDAD)
                    FROM UNIFORMES.TADETALLEPEDIDOS DP
                   INNER JOIN UNIFORMES.TAPEDIDOS P
                      ON (P.FIFOLIOCENTRAL = DP.FIFOLIOCENTRAL)
                   INNER JOIN UNIFORMES.TAFUNCIONES FUN
                      ON (FUN.FIFUNCIONSAP = P.FIFUNCION 
                     AND FUN.FCIDCANAL = DP.FICANAL) 
                   INNER JOIN UNIFORMES.TARELACIONESCANAL RC
                      ON (TO_NUMBER(RC.FCIDCANAL) = DP.FICANAL 
                     AND RC.FCIDCANAL = FUN.FCIDCANAL)
                   INNER JOIN UNIFORMES.TAEMPLEADOS EMP
                      ON (EMP.FIEMPLEADO = P.FIEMPLEADO ) 
                   INNER JOIN UNIFORMES.TAPRODUCTOS PROD
                      ON (PROD.FISKU = DP.FISKU )
                   INNER JOIN UNIFORMES.TATIPOSPRODUCTO TIPROD
                      ON (PROD.FITIPO = TIPROD.FITIPO)  
                   INNER JOIN UNIFORMES.TAREMISIONES REMI
                      ON (DP.FIFOLIOCENTRAL = REMI.FIFOLIOCENTRAL
                     AND DP.FIPAIS     = REMI.FIPAIS
                     AND DP.FICANAL    = REMI.FICANAL
                     AND DP.FISUCURSAL = REMI.FISUCURSAL 
                     AND DP.FIPEDIDO   = REMI.FIPEDIDO
                     AND DP.FISKU      = REMI.FISKU)     
                   WHERE DP.FIPAIS     = vlPais
                     AND DP.FISUCURSAL = paTienda
                     AND DP.FIESTATUS  = vlEstRemision
                     AND P.FITIPO IN ( vlTipoSemestral, vlTipoFormador, vlTipoVoluntaria)
                     AND TRANSLATE(RC.FCIDCANAL, 'T 0123456789', 'T') IS NULL
                   GROUP BY DP.FIFOLIOCENTRAL
                        ,DP.FIPEDIDO
                        ,DP.FISUCURSAL
                        ,DP.FISKU
            )
       ORDER BY P.FIEMPLEADO
                ,DP.FIFOLIOCENTRAL
                ,DP.FIPEDIDO;
   END IF;
   

EXCEPTION 
 WHEN NO_DATA_FOUND THEN
    Raise_Application_Error ( vlNoDatosSuc, 'La Tienda no existe o no esta Registrada.');
   

END SPCONSULTAENTREGA;


PROCEDURE SPGRABAENTREGA
(   paFolioCentral  IN    UNIFORMES.TADETALLEPEDIDOS.FIFOLIOCENTRAL%TYPE
   ,paPais          IN    UNIFORMES.TADETALLEPEDIDOS.FIPAIS%TYPE
   ,paCanal         IN    UNIFORMES.TADETALLEPEDIDOS.FICANAL%TYPE
   ,paSucursal      IN    UNIFORMES.TADETALLEPEDIDOS.FISUCURSAL%TYPE
   ,paPedido        IN    UNIFORMES.TADETALLEPEDIDOS.FIPEDIDO%TYPE
   ,paSKU           IN    UNIFORMES.TADETALLEPEDIDOS.FISKU%TYPE
   ,paEstAnterior   IN    UNIFORMES.TADETALLEPEDIDOS.FIESTATUS%TYPE
   ,paFecAnterior   IN    VARCHAR2
   ,paGerente       IN    UNIFORMES.TADETALLEPEDIDOS.FIGERENTEENTREGA%TYPE)
IS
/********************************************************************************
   Descripcion: Procedimiento que regresa los datos 
   Parámetros de entrada: paFolioCentral, paPais,paCanal,paSucursal,paPedido,paSKU,
                           paEstAnterior,paFecAnterior,paGerente
   Parámetros de salida: 
   Parámetros de entrada-salida: Ninguno
   Valor de retorno: Cursor con resultado.
   Creador:  Laura Garcia Martinez
   Fecha de creación: 16 JULIO 2014
**************************************************************************************/ 
   
    
   vlEstEntregado       UNIFORMES.TADETALLEPEDIDOS.FIESTATUS%TYPE:= 90;
   vlFechaActual        UNIFORMES.TADETALLEPEDIDOS.FDACTUALIZACION%TYPE:= SYSDATE;
   vlParcialEntrega     UNIFORMES.TAPEDIDOS.FIESTADOGENERAL%TYPE := 1;
   vlEntregado          UNIFORMES.TAPEDIDOS.FIESTADOGENERAL%TYPE := 2;
   vlTotalPedido        UNIFORMES.TADETALLEPEDIDOS.FICANTIDAD%TYPE:=0;
   vlTotalEntregado     UNIFORMES.TADETALLEPEDIDOS.FICANTIDAD%TYPE:=0;
     
BEGIN
    
   MERGE INTO UNIFORMES.TAMOVTODETALLEPEDIDOS DATOS
         USING (SELECT paFolioCentral FOLIOCENTRAL,
                       paPais PAIS,
                       paCanal CANAL,
                       paSucursal SUCURSAL,
                       paPedido PEDIDO,
                       paSKU SKU,
                       paEstAnterior ESTATUS
                  FROM DUAL) VALORES
            ON (DATOS.FIFOLIOCENTRAL=VALORES.FOLIOCENTRAL AND 
                DATOS.FIPAIS=VALORES.PAIS AND 
                DATOS.FICANAL=VALORES.CANAL AND 
                DATOS.FISUCURSAL=VALORES.SUCURSAL AND 
                DATOS.FIPEDIDO=VALORES.PEDIDO AND 
                DATOS.FISKU=VALORES.SKU AND 
                DATOS.FIESTADO=VALORES.ESTATUS)
      WHEN NOT MATCHED THEN
          INSERT ( FIFOLIOCENTRAL
                 , FIPAIS
                 , FICANAL
                 , FISUCURSAL
                 , FIPEDIDO
                 , FISKU
                 , FIESTADO
                 , FDMOVIMIENTO )
          VALUES ( paFolioCentral 
                 , paPais
                 , paCanal
                 , paSucursal
                 , paPedido
                 , paSKU
                 , paEstAnterior
                 , TO_DATE(paFecAnterior, 'DD/MM/YYYY HH24:MI:SS')
                  );


   UPDATE UNIFORMES.TADETALLEPEDIDOS
      SET FIESTATUS = vlEstEntregado
         ,FIGERENTEENTREGA = paGerente
         ,FDACTUALIZACION = vlFechaActual
    WHERE FIFOLIOCENTRAL = paFolioCentral 
      AND FIPAIS = paPais
      AND FICANAL = paCanal
      AND FISUCURSAL = paSucursal
      AND FIPEDIDO = paPedido
      AND FISKU = paSKU;
   
   
       SELECT COUNT(B.ROWID)
             ,A.SUBTOTAL
         INTO vlTotalPedido
             ,vlTotalEntregado      
         FROM UNIFORMES.TADETALLEPEDIDOS B
   INNER JOIN (SELECT FIFOLIOCENTRAL, COUNT(ROWID) SUBTOTAL
                 FROM UNIFORMES.TADETALLEPEDIDOS 
                WHERE FIFOLIOCENTRAL = paFolioCentral
                  AND FIESTATUS =  vlEstEntregado
             GROUP BY FIFOLIOCENTRAL ) A
          ON ( A.FIFOLIOCENTRAL = B.FIFOLIOCENTRAL)
       WHERE B.FIFOLIOCENTRAL = paFolioCentral
    GROUP BY A.SUBTOTAL;                                                    


    IF (vlTotalPedido = vlTotalEntregado) THEN
         
       UPDATE UNIFORMES.TAPEDIDOS
          SET FIESTADOGENERAL = vlEntregado
        WHERE FIFOLIOCENTRAL = paFolioCentral;
    ELSE 
       UPDATE UNIFORMES.TAPEDIDOS
          SET FIESTADOGENERAL = vlParcialEntrega
        WHERE FIFOLIOCENTRAL = paFolioCentral;
              
    END IF;
    
    
END SPGRABAENTREGA;


PROCEDURE SPACTMOVTOPEDIDOS(
   paIdPais         IN  UNIFORMES.TADETALLEPEDIDOS.FIPAIS%TYPE
  ,paIdCanal        IN  UNIFORMES.TADETALLEPEDIDOS.FICANAL%TYPE
  ,paSucursal       IN  UNIFORMES.TADETALLEPEDIDOS.FISUCURSAL%TYPE
  ,paPedido         IN  UNIFORMES.TADETALLEPEDIDOS.FIPEDIDO%TYPE
  ,paFolioCentral   IN  UNIFORMES.TADETALLEPEDIDOS.FIFOLIOCENTRAL%TYPE
  ,paSKU            IN  UNIFORMES.TADETALLEPEDIDOS.FISKU%TYPE
  ,paEstatusAnterior IN  UNIFORMES.TADETALLEPEDIDOS.FIESTATUS%TYPE
  ,paActualizacion  IN  VARCHAR2
  ,paEstatusNuevo   IN  UNIFORMES.TADETALLEPEDIDOS.FIESTATUS%TYPE)
IS
/********************************************************************************
   Descripcion: Procedimiento que regresa los datos 
   Parámetros de entrada: 
   Parámetros de salida: 
   Parámetros de entrada-salida: Ninguno
   Valor de retorno: Cursor con resultado.
   Creador: Laura Garcia Martinez
   Fecha de creación: 9 JULIO 2014
**************************************************************************************/  

   vlFechaActual    UNIFORMES.TADETALLEPEDIDOS.FDACTUALIZACION%TYPE := SYSDATE;
 
BEGIN

   BEGIN
      INSERT INTO UNIFORMES.TAMOVTODETALLEPEDIDOS ( FIFOLIOCENTRAL
                                                  , FIPAIS
                                                  , FICANAL
                                                  , FISUCURSAL
                                                  , FIPEDIDO
                                                  , FISKU
                                                  , FIESTADO
                                                  , FDMOVIMIENTO )
                                           VALUES ( paFolioCentral
                                                  , paIdPais
                                                  , paIdCanal
                                                  , paSucursal
                                                  , paPedido
                                                  , paSKU
                                                  , paEstatusAnterior
                                                  , TO_DATE(paActualizacion, 'DD/MM/YYYY HH24:MI:SS')  
                                                   ); 
   EXCEPTION 
      WHEN DUP_VAL_ON_INDEX THEN
           NULL;
   END;                                           
                                               
   UPDATE UNIFORMES.TADETALLEPEDIDOS  
      SET FIESTATUS = paEstatusNuevo
         ,FDACTUALIZACION = vlFechaActual 
    WHERE FIFOLIOCENTRAL = paFolioCentral
      AND FIPAIS = paIdPais
      AND FICANAL = paIdCanal
      AND FISUCURSAL = paSucursal
      AND FIPEDIDO = paPedido
      AND FISKU = paSKU;                                             

END SPACTMOVTOPEDIDOS;

PROCEDURE SPCONSULTAKIT(
   paIdEmpleado    IN    UNIFORMES.TAEMPLEADOS.FIEMPLEADO%TYPE
  ,paIdBandera     IN    NUMBER 
  ,paCurSolicitud  OUT   rcgCursor)
IS
/********************************************************************************
   Descripcion: Procedimiento que regresa los datos de los uniformes a solicitar
               por el EMPLEADO
   Parámetros de entrada:  paIdEmpleado
   Parámetros de salida: paCurSolicitud
   Parámetros de entrada-salida: Ninguno
   Valor de retorno: Cursor con resultado.
   Creador:  Laura Garcia Martinez
   Fecha de creación: 9 JULIO 2014
************************************************************************************/  
 
   vlGeneroU         UNIFORMES.TAPRODUCTOS.FCGENERO%TYPE:= 'U';  -- Unisex       
   vlIdCarga         UNIFORMES.TACARGAS.FIIDCARGA%TYPE:= 0;
   cslActivo         UNIFORMES.TACARGAS.FIESTATUS%TYPE:= 1;
   vlTipoSemestral   UNIFORMES.TAPEDIDOS.FITIPO%TYPE := 2;   -- Carga Semestral
   vlTipoFormador    UNIFORMES.TAPEDIDOS.FITIPO%TYPE := 3;   -- Carga Semestral
   vlFecIni          UNIFORMES.TACARGAS.FDFECHAFINAL%TYPE;
   vlFecFin          UNIFORMES.TACARGAS.FDFECHAFINAL%TYPE;
   vlFechaActual     UNIFORMES.TACARGAS.FDFECHAFINAL%TYPE; 
   vlNoDatos         NUMBER(5):= -20001;
   vlConteo          NUMBER(10):= 0;
   vlDiasAntiguedad  NUMBER(1):= 4;
   vlTres            NUMBER(1):= 3;
   vlCuatro          NUMBER(1):= 4;
   vlCero            NUMBER(1):= 0;
   vlDosMeses        NUMBER(1):= 2;
   
BEGIN

   SELECT FIIDCARGA
         ,TRUNC(FDFECHAINICIAL)
         ,TRUNC(FDFECHAFINAL)
         ,TRUNC(SYSDATE)
     INTO vlIdCarga
         ,vlFecIni
         ,vlFecFin
         ,vlFechaActual
     FROM UNIFORMES.TACARGAS
    WHERE FIESTATUS = cslActivo; 

   
   IF (paIdBandera = vlTipoFormador ) THEN   -- Opcion Nuevo Ingreso
        SELECT COUNT(1)
          INTO vlConteo 
          FROM UNIFORMES.TAEMPLEADOS EMP
    INNER JOIN UNIFORMES.TACECO CECO
            ON (EMP.FICECO = CECO.FICC)
    INNER JOIN UNIFORMES.TAFUNCIONES FUN
            ON (FUN.FIFUNCIONSAP = EMP.FIFUNCION AND TRIM(CECO.FCIDCANAL)=TRIM(FUN.FCIDCANAL))
    INNER JOIN UNIFORMES.TAKITS KIT
            ON (KIT.FIKIT = FUN.FIKIT)
    INNER JOIN UNIFORMES.TAPRODUCTOSXKIT PXKIT
            ON (KIT.FIKIT = PXKIT.FIKIT)
    INNER JOIN UNIFORMES.TAPRODUCTOS PROD
            ON (PXKIT.FISKU = PROD.FISKU)
    INNER JOIN UNIFORMES.TATIPOSPRODUCTO TPROD
            ON (PROD.FITIPO = TPROD.FITIPO)
    INNER JOIN UNIFORMES.TATALLAS TALLA
            ON (PROD.FITALLA = TALLA.FITALLA)
          WHERE EMP.FIEMPLEADO = paIdEmpleado    
           AND (PROD.FCGENERO = EMP.FCGENERO OR PROD.FCGENERO = vlGeneroU )  
           AND EMP.FIEMPLEADO NOT IN (SELECT FIEMPLEADO      -- Menos los empleados que ya solicitaron su pedido
                                        FROM UNIFORMES.TAPEDIDOS
                                       WHERE FITIPO IN( vlTipoSemestral  , vlTipoFormador)
                                         AND FIIDCARGA IN (vlIdCarga)
                                       UNION 
                                      SELECT FIEMPLEADO     
                                        FROM UNIFORMES.TAPEDIDOS
                                       WHERE FITIPO IN( vlTipoSemestral, vlTipoFormador)
                                         AND FIIDCARGA IN (csgCero)
                                         AND FDREGISTRO > ADD_MONTHS(SYSDATE,-vlDosMeses)
                                     )
           AND TRUNC(SYSDATE)-(TRUNC(EMP.FDINGRESO)+vlDiasAntiguedad) >= vlCero; 
                       
      IF (vlConteo > vlCero)
      THEN
       OPEN paCurSolicitud FOR
           SELECT TO_NUMBER(SUBSTR(EMP.FICECO, vlTres, vlCuatro)) AS SUCURSAL
                , EMP.FIEMPLEADO 
                , EMP.FCNOMBRE
                , EMP.FCPOSICION
                , EMP.FCGENERO
                , TPROD.FCDESCRIPCION  DESCPROD
                , TALLA.FCCLAVE
                , TALLA.FITALLA
                , PROD.FNCOSTO   
                , PROD.FNDESCUENTO   
                , EMP.FIFUNCION    
                , CECO.FCIDCANAL AS FIUNIDADNEGOCIO 
                , PROD.FITIPO    
                , PROD.FISKU 
                , TALLA.FCDESCRIPCION
             FROM  UNIFORMES.TAEMPLEADOS EMP
       INNER JOIN UNIFORMES.TACECO CECO
               ON (EMP.FICECO = CECO.FICC)
       INNER JOIN UNIFORMES.TAFUNCIONES FUN
               ON (FUN.FIFUNCIONSAP = EMP.FIFUNCION AND TRIM(CECO.FCIDCANAL)=TRIM(FUN.FCIDCANAL))
       INNER JOIN UNIFORMES.TAKITS KIT
               ON (KIT.FIKIT = FUN.FIKIT)
       INNER JOIN UNIFORMES.TAPRODUCTOSXKIT PXKIT
               ON (KIT.FIKIT = PXKIT.FIKIT)
       INNER JOIN UNIFORMES.TAPRODUCTOS PROD
               ON (PXKIT.FISKU = PROD.FISKU)
       INNER JOIN UNIFORMES.TATIPOSPRODUCTO TPROD
               ON (PROD.FITIPO = TPROD.FITIPO)
       INNER JOIN UNIFORMES.TATALLAS TALLA
               ON (PROD.FITALLA = TALLA.FITALLA)
             WHERE EMP.FIEMPLEADO = paIdEmpleado    
              AND (PROD.FCGENERO = EMP.FCGENERO OR PROD.FCGENERO = vlGeneroU )  
              AND EMP.FIEMPLEADO NOT IN (SELECT FIEMPLEADO      -- Menos los empleados que ya solicitaron su pedido
                                           FROM UNIFORMES.TAPEDIDOS
                                          WHERE FITIPO IN( vlTipoSemestral  , vlTipoFormador)
                                            AND FIIDCARGA IN (vlIdCarga)
                                          UNION 
                                         SELECT FIEMPLEADO     
                                           FROM UNIFORMES.TAPEDIDOS
                                          WHERE FITIPO IN( vlTipoSemestral, vlTipoFormador)
                                            AND FIIDCARGA IN (csgCero)
                                            AND FDREGISTRO > ADD_MONTHS(SYSDATE,-vlDosMeses)
                                        )
              AND TRUNC(SYSDATE)-(TRUNC(EMP.FDINGRESO)+vlDiasAntiguedad) >= vlCero  -- Empleados con MENOS de 4 dias de antiguedad
         ORDER BY EMP.FIEMPLEADO, DESCPROD, FITALLA;
      ELSE
        Raise_Application_Error ( vlNoDatos, 'No se han cumplido los dias para la solicitud.');
      END IF;
                 
   ELSE 
       
      IF (vlFechaActual BETWEEN vlFecIni AND vlFecFin) THEN
         SELECT COUNT(1)
           INTO vlConteo
           FROM UNIFORMES.TAEMPLEADOS EMP
          INNER JOIN UNIFORMES.TACECO CECO
                  ON (EMP.FICECO = CECO.FICC)
          INNER JOIN UNIFORMES.TAFUNCIONES FUN
                  ON (FUN.FIFUNCIONSAP = EMP.FIFUNCION AND TRIM(CECO.FCIDCANAL)=TRIM(FUN.FCIDCANAL))
          INNER JOIN UNIFORMES.TAKITS KIT
                  ON (KIT.FIKIT = FUN.FIKIT)
          INNER JOIN UNIFORMES.TAPRODUCTOSXKIT PXKIT
                  ON (KIT.FIKIT = PXKIT.FIKIT)
          INNER JOIN UNIFORMES.TAPRODUCTOS PROD
                  ON (PXKIT.FISKU = PROD.FISKU)
          INNER JOIN UNIFORMES.TATIPOSPRODUCTO TPROD
                  ON (PROD.FITIPO = TPROD.FITIPO)
          INNER JOIN UNIFORMES.TATALLAS TALLA
                  ON (PROD.FITALLA = TALLA.FITALLA)
               WHERE EMP.FIEMPLEADO = paIdEmpleado   
                 AND (PROD.FCGENERO = EMP.FCGENERO OR PROD.FCGENERO = vlGeneroU )  
                 AND EMP.FIEMPLEADO NOT IN (SELECT FIEMPLEADO      -- Menos los empleados que ya solicitaron su pedido
                                              FROM UNIFORMES.TAPEDIDOS
                                             WHERE FITIPO IN( vlTipoSemestral  , vlTipoFormador)
                                               AND FIIDCARGA IN (vlIdCarga)
                                             UNION 
                                            SELECT FIEMPLEADO     
                                              FROM UNIFORMES.TAPEDIDOS
                                             WHERE FITIPO IN( vlTipoSemestral, vlTipoFormador)
                                               AND FIIDCARGA IN (csgCero)
                                               AND FDREGISTRO > ADD_MONTHS(SYSDATE,-vlDosMeses)
                                           )
                AND EMP.FDINGRESO <= SYSDATE-vlDiasAntiguedad;
                         
         IF(vlConteo > vlCero)
         THEN
           OPEN paCurSolicitud FOR
              SELECT TO_NUMBER(SUBSTR(EMP.FICECO, vlTres, vlCuatro)) AS SUCURSAL
                   , EMP.FIEMPLEADO 
                   , EMP.FCNOMBRE
                   , EMP.FCPOSICION
                   , EMP.FCGENERO
                   , TPROD.FCDESCRIPCION  DESCPROD
                   , TALLA.FCCLAVE
                   , TALLA.FITALLA
                   , PROD.FNCOSTO   
                   , PROD.FNDESCUENTO   
                   , EMP.FIFUNCION    
                   , CECO.FCIDCANAL AS FIUNIDADNEGOCIO 
                   , PROD.FITIPO    
                   , PROD.FISKU 
                   , TALLA.FCDESCRIPCION
                FROM UNIFORMES.TAEMPLEADOS EMP
          INNER JOIN UNIFORMES.TACECO CECO
                  ON (EMP.FICECO = CECO.FICC)
          INNER JOIN UNIFORMES.TAFUNCIONES FUN
                  ON (FUN.FIFUNCIONSAP = EMP.FIFUNCION AND TRIM(CECO.FCIDCANAL)=TRIM(FUN.FCIDCANAL))
          INNER JOIN UNIFORMES.TAKITS KIT
                  ON (KIT.FIKIT = FUN.FIKIT)
          INNER JOIN UNIFORMES.TAPRODUCTOSXKIT PXKIT
                  ON (KIT.FIKIT = PXKIT.FIKIT)
          INNER JOIN UNIFORMES.TAPRODUCTOS PROD
                  ON (PXKIT.FISKU = PROD.FISKU)
          INNER JOIN UNIFORMES.TATIPOSPRODUCTO TPROD
                  ON (PROD.FITIPO = TPROD.FITIPO)
          INNER JOIN UNIFORMES.TATALLAS TALLA
                  ON (PROD.FITALLA = TALLA.FITALLA)
               WHERE EMP.FIEMPLEADO = paIdEmpleado   
                 AND (PROD.FCGENERO = EMP.FCGENERO OR PROD.FCGENERO = vlGeneroU )  
                 AND EMP.FIEMPLEADO NOT IN (SELECT FIEMPLEADO      -- Menos los empleados que ya solicitaron su pedido
                                              FROM UNIFORMES.TAPEDIDOS
                                             WHERE FITIPO IN( vlTipoSemestral  , vlTipoFormador)
                                               AND FIIDCARGA IN (vlIdCarga)
                                             UNION 
                                            SELECT FIEMPLEADO     
                                              FROM UNIFORMES.TAPEDIDOS
                                             WHERE FITIPO IN( vlTipoSemestral, vlTipoFormador)
                                               AND FIIDCARGA IN (csgCero)
                                               AND FDREGISTRO > ADD_MONTHS(SYSDATE,-vlDosMeses)
                                           )
                AND EMP.FDINGRESO <= SYSDATE-vlDiasAntiguedad  -- Empleados con MENOS de 4 días de antiguedad
            ORDER BY EMP.FIEMPLEADO, DESCPROD, FITALLA;
         ELSE
           Raise_Application_Error ( vlNoDatos, 'No se encontraron datos para esta solicitud o ya cuenta con pedidos solicitados.');
         END IF;
      
      ELSE
          Raise_Application_Error ( vlNoDatos, 'El sistema no esta disponible en este Periodo.');
      END IF;
                   
   END IF;

          
END SPCONSULTAKIT;


PROCEDURE SPSOLICITUDINDIVIDUAL( 
        paIdEmpleado         IN UNIFORMES.TAEMPLEADOS.FIEMPLEADO%TYPE,
        paFuncionEmpleado    IN UNIFORMES.TAEMPLEADOS.FIFUNCION%TYPE,
        paGeneroEmpleado     IN UNIFORMES.TAEMPLEADOS.FCGENERO%TYPE,
        paCurSolicitud      OUT rcgCursor
)
IS
/********************************************************************************
   Descripcion: Procedimiento que regresa los datos de uniformes para que el 
               empleado lo solicite de forma voluntaria.
   Parámetros de entrada:  paIdEmpleado
   Parámetros de entrada:  paFuncionEmpleado
   Parámetros de entrada:  paGeneroEmpleado   
   Parámetros de salida: paCurSolicitud
   Parámetros de entrada-salida: Ninguno
   Valor de retorno: Cursor con resultado.
   Creador:  exception
   Fecha de creación: 12 AGOSTO 2014
**************************************************************************************/  
    vlSituacionEmpleado UNIFORMES.TAEMPLEADOS.FCSITUACION%TYPE := 'A';
    vlGeneroU           UNIFORMES.TAPRODUCTOS.FCGENERO%TYPE:= 'U';  -- Unisex       
    vlFechaCompara      UNIFORMES.TAPEDIDOS.FDREGISTRO%TYPE;
    vlFechaUltimaReg    UNIFORMES.TAPEDIDOS.FDREGISTRO%TYPE;
    vlNoDatos           NUMBER(5):= -20001;
    vlTres              NUMBER(1):= 3;
    vlCuatro            NUMBER(1):= 4;
    vlDias              NUMBER(2):= 56;
    
BEGIN
   SELECT TRUNC(SYSDATE - vlDias)
     INTO vlFechaCompara
     FROM DUAL;
     
   SELECT NVL(TRUNC(MAX(FDREGISTRO)), TRUNC(TO_DATE('01/01/1900','DD/MM/YYYY')))
     INTO vlFechaUltimaReg
     FROM UNIFORMES.TAEMPLEADOS EMP
    INNER JOIN UNIFORMES.TAPEDIDOS PD
       ON (EMP.FIEMPLEADO = PD.FIEMPLEADO)
    WHERE EMP.FCSITUACION =  vlSituacionEmpleado
      AND EMP.FIEMPLEADO = paIdEmpleado
      AND EMP.FIFUNCION = paFuncionEmpleado;
      
   IF(vlFechaUltimaReg <= vlFechaCompara )
   THEN
        OPEN paCurSolicitud FOR
             SELECT TO_NUMBER(SUBSTR(EMP.FICECO, vlTres, vlCuatro)) AS SUCURSAL 
                        , EMP.FIEMPLEADO 
                        , EMP.FCNOMBRE
                        , EMP.FCPOSICION
                        , EMP.FCGENERO
                        , TPROD.FCDESCRIPCION  DESCPROD
                        , TALLA.FCCLAVE
                        , TALLA.FITALLA
                        , PROD.FNCOSTO   
                        , PROD.FNCOSTO FNDESCUENTO   
                        , EMP.FIFUNCION    
                        , CECO.FCIDCANAL AS FIUNIDADNEGOCIO 
                        , PROD.FITIPO    
                        , PROD.FISKU 
                        , TALLA.FCDESCRIPCION
              FROM  UNIFORMES.TAEMPLEADOS EMP
      INNER JOIN UNIFORMES.TACECO CECO
                  ON (EMP.FICECO = CECO.FICC)
      INNER JOIN UNIFORMES.TAFUNCIONES FUN
                  ON (FUN.FIFUNCIONSAP = EMP.FIFUNCION AND TRIM(CECO.FCIDCANAL)=TRIM(FUN.FCIDCANAL))
      INNER JOIN UNIFORMES.TAKITS KIT
                  ON (KIT.FIKIT = FUN.FIKIT)
      INNER JOIN UNIFORMES.TAPRODUCTOSXKIT PXKIT
                  ON (KIT.FIKIT = PXKIT.FIKIT)
      INNER JOIN UNIFORMES.TAPRODUCTOS PROD
                  ON (PXKIT.FISKU = PROD.FISKU)
      INNER JOIN UNIFORMES.TATIPOSPRODUCTO TPROD
                  ON (PROD.FITIPO = TPROD.FITIPO)
      INNER JOIN UNIFORMES.TATALLAS TALLA
                  ON (PROD.FITALLA = TALLA.FITALLA)
            WHERE EMP.FCSITUACION =  vlSituacionEmpleado
                AND EMP.FIEMPLEADO = paIdEmpleado
                AND EMP.FIFUNCION = paFuncionEmpleado
                AND PROD.FCGENERO IN (vlGeneroU,paGeneroEmpleado )
       ORDER BY EMP.FIEMPLEADO, DESCPROD, FITALLA;
       
   ELSE
      Raise_Application_Error ( vlNoDatos, 'No puedes solicitar Pedidos hasta que se cumplan 8 semanas de tu ultima solicitud.');
   END IF;
                     
END SPSOLICITUDINDIVIDUAL;

PROCEDURE SPCONSULTASUCURSALPEDIDO(
   paTienda        IN    UNIFORMES.TASUCURSALES.FISUCURSAL%TYPE,
   paFolioCentral       IN  UNIFORMES.TAPEDIDOS.FIFOLIOCENTRAL%TYPE, 
   paCurSucursal  OUT   rcgCursor,
   parCurSucursalPedido OUT   rcgCursor)
  IS
/********************************************************************************
   Descripcion: Función que regresa los datos de la sucursal
   Parámetros de entrada: paTienda
   Parámetros de salida: paCurSolicitud
   Parámetros de entrada-salida: Ninguno
   Valor de retorno: Cursor con resultado.
   Creador: Rogelio Esteban Arvea Perez
   Fecha de creación: 24 Septiembre 2014
**************************************************************************************/  
   cslEstatusPed UNIFORMES.TADETALLEPEDIDOS.FIESTATUS%TYPE := 80;
   
BEGIN
   OPEN paCurSucursal FOR 
      SELECT  SUC.FISUCURSAL
                 , SUC.FCDESCRIPCION
                 , SUC.FCDIRIP
                 , SUC.FIIDCDISTRIBUCION
                 , SUC.FIIDFORMADOR
        FROM  UNIFORMES.TASUCURSALES SUC  
       WHERE SUC.FISUCURSAL = paTienda;

   OPEN parCurSucursalPedido FOR
        SELECT P.FIEMPLEADO
               ,RM.FISKU
               ,DEP.FICANTIDAD
               ,RM.FIPEDIDO
          FROM UNIFORMES.TAPEDIDOS P
         INNER JOIN UNIFORMES.TADETALLEPEDIDOS DEP
            ON (P.FIFOLIOCENTRAL = DEP.FIFOLIOCENTRAL)
         INNER JOIN UNIFORMES.TAREMISIONES  RM 
            ON (P.FIFOLIOCENTRAL = RM.FIFOLIOCENTRAL  AND DEP.FIPEDIDO=RM.FIPEDIDO)  
         WHERE P.FIFOLIOCENTRAL = paFolioCentral
           AND RM.FISUCURSAL = paTienda
           AND DEP.FIESTATUS = cslEstatusPed
           AND (RM.FIPEDIDO, RM.FISUCURSAL, RM.FIREMISION, DEP.FICANTIDAD) IN (
                SELECT RM.FIPEDIDO,
                       RM.FISUCURSAL,
                       MAX(RM.FIREMISION),
                       SUM(RM.FICANTIDAD)
                  FROM UNIFORMES.TAPEDIDOS P
                 INNER JOIN UNIFORMES.TADETALLEPEDIDOS DEP
                    ON (P.FIFOLIOCENTRAL = DEP.FIFOLIOCENTRAL)
                 INNER JOIN UNIFORMES.TAREMISIONES  RM 
                    ON (P.FIFOLIOCENTRAL = RM.FIFOLIOCENTRAL  AND DEP.FIPEDIDO=RM.FIPEDIDO)  
                 WHERE P.FIFOLIOCENTRAL = paFolioCentral
                   AND RM.FISUCURSAL = paTienda
                   AND DEP.FIESTATUS = cslEstatusPed
                 GROUP BY RM.FIPEDIDO,
                       RM.FISUCURSAL);

      
END SPCONSULTASUCURSALPEDIDO;

END PAWSUNIFORMES;

