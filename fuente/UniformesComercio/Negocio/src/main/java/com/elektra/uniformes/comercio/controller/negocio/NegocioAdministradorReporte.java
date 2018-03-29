/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.elektra.uniformes.comercio.controller.negocio;

import com.elektra.uniformes.comercio.DAO.DAOAdministradorReporte;
import com.elektra.uniformes.comercio.Modelo.BitacoraSolicitud;
import com.elektra.uniformes.comercio.Modelo.EstatusSolicitud;
import com.elektra.uniformes.comercio.Modelo.PedidoReporteDTO;
import com.elektra.uniformes.comercio.Modelo.ReporteDTO;
import com.elektra.uniformes.comercio.Modelo.ReporteReq;
import com.elektra.uniformes.comercio.Modelo.Tienda;
import java.io.File;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

/**
 *
 * @author kortizl
 */
@Component("negocioAdministradorReporte")
public class NegocioAdministradorReporte {

    @Autowired
    @Qualifier("daoAdministradorReporte")
    private DAOAdministradorReporte daoAdministradorReporte;

    public ArrayList<EstatusSolicitud> getEstatus() throws Exception {
        return daoAdministradorReporte.getEstatus();
    }

    public ArrayList<Tienda> getTiendas() throws Exception {
        return daoAdministradorReporte.getTiendas();
    }

    public ArrayList<ReporteDTO> obtieneReporte(ReporteReq reporteReq) throws Exception {
        return daoAdministradorReporte.obtieneReporte(reporteReq);
    }

    public File generarReporteExcel(int indicaFecha, String fechaInicio, String fechaFin, int indCarga, String carga, int indEstatus, String estatus, int indTienda, int tienda, int indEmpleado, int empleado) throws Exception {
        SimpleDateFormat f  = new SimpleDateFormat("dd-MM-yyyy");
        File file = new File("reporte_uniformes_comercio_"+f.format(new Date())+".xlsx");
        ReporteReq r = new ReporteReq();
        r.setIndicaFecha(indicaFecha);
        r.setFechaInicio(fechaInicio.replaceAll("-", "/"));
        r.setFechaFin(fechaFin.replaceAll("-", "/"));
        r.setIndCarga(indCarga);
        r.setCarga(carga);
        r.setIndEstatus(indEstatus);
        r.setEstatus(estatus);
        r.setIndTienda(indTienda);
        r.setTienda(tienda);
        r.setIndEmpleado(indEmpleado);
        r.setEmpleado(empleado);
        ArrayList<ReporteDTO> reporte = daoAdministradorReporte.obtieneReporte(r);
        XSSFWorkbook workbook = new XSSFWorkbook();
        XSSFSheet sheetRep = workbook.createSheet("REPORTE");

        XSSFFont fontH = workbook.createFont();
        fontH.setFontHeightInPoints((short) 14);
        fontH.setBold(true);
        XSSFColor blancoH = new XSSFColor(new java.awt.Color(255, 255, 255));
        fontH.setColor(blancoH);

        XSSFFont fontT = workbook.createFont();
        fontT.setFontHeightInPoints((short) 12);
        fontT.setBold(true);

        XSSFCellStyle stCellHeader = workbook.createCellStyle();
        XSSFColor rojoH = new XSSFColor(new java.awt.Color(192, 0, 0));
        stCellHeader.setFillForegroundColor(rojoH);
        stCellHeader.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        stCellHeader.setFont(fontH);
        stCellHeader.setAlignment(HorizontalAlignment.CENTER);

        XSSFCellStyle stCellVAlign = workbook.createCellStyle();
        stCellVAlign.setVerticalAlignment(VerticalAlignment.CENTER);
        stCellVAlign.setAlignment(HorizontalAlignment.CENTER);

        XSSFRow rowhead = sheetRep.createRow(1);

        rowhead.createCell(0).setCellValue("Solicitud");
        rowhead.getCell(0).setCellStyle(stCellHeader);
        rowhead.createCell(1).setCellValue("Empleado");
        rowhead.getCell(1).setCellStyle(stCellHeader);
        rowhead.createCell(2).setCellValue("Nombre");
        rowhead.getCell(2).setCellStyle(stCellHeader);
        rowhead.createCell(3).setCellValue("Función");
        rowhead.getCell(3).setCellStyle(stCellHeader);
        rowhead.createCell(4).setCellValue("Pais");
        rowhead.getCell(4).setCellStyle(stCellHeader);
        rowhead.createCell(5).setCellValue("Canal");
        rowhead.getCell(5).setCellStyle(stCellHeader);
        rowhead.createCell(6).setCellValue("Num Tienda");
        rowhead.getCell(6).setCellStyle(stCellHeader);
        rowhead.createCell(7).setCellValue("Tienda");
        rowhead.getCell(7).setCellStyle(stCellHeader);
        rowhead.createCell(8).setCellValue("Estatus");
        rowhead.getCell(8).setCellStyle(stCellHeader);
        rowhead.createCell(9).setCellValue("Fecha");
        rowhead.getCell(9).setCellStyle(stCellHeader);
        rowhead.createCell(10).setCellValue("Pedido");
        rowhead.getCell(10).setCellStyle(stCellHeader);
        rowhead.createCell(11).setCellValue("SKU");
        rowhead.getCell(11).setCellStyle(stCellHeader);
        rowhead.createCell(12).setCellValue("Prenda");
        rowhead.getCell(12).setCellStyle(stCellHeader);
        rowhead.createCell(13).setCellValue("Cantidad");
        rowhead.getCell(13).setCellStyle(stCellHeader);
        int indRows = 2;
        for (ReporteDTO rep : reporte) {
            for (PedidoReporteDTO ped : rep.getPedidos()) {
                XSSFRow row = sheetRep.createRow(indRows);
                row.createCell(0).setCellValue(rep.getSolicitud());
                row.getCell(0).setCellStyle(stCellVAlign);
                row.createCell(1).setCellValue(rep.getEmpleado());
                row.getCell(1).setCellStyle(stCellVAlign);
                row.createCell(2).setCellValue(rep.getNombre());
                row.createCell(3).setCellValue(rep.getFuncion());
                row.createCell(4).setCellValue(rep.getPais());
                row.createCell(5).setCellValue(rep.getCanal());
                row.createCell(6).setCellValue(rep.getTienda());
                row.createCell(7).setCellValue(rep.getNombreTienda());
                row.createCell(8).setCellValue(rep.getEstatus());
                row.createCell(9).setCellValue(rep.getFecha());
                row.getCell(9).setCellStyle(stCellVAlign);
                row.createCell(10).setCellValue(ped.getPedido());
                row.getCell(10).setCellStyle(stCellVAlign);
                row.createCell(11).setCellValue(ped.getSku());
                row.getCell(11).setCellStyle(stCellVAlign);
                row.createCell(12).setCellValue(ped.getDescripcion());
                row.getCell(12).setCellStyle(stCellVAlign);
                row.createCell(13).setCellValue(ped.getCantidad());
                row.getCell(13).setCellStyle(stCellVAlign);
                indRows++;
            }

        }
        FileOutputStream fileOut = new FileOutputStream(file);
        workbook.write(fileOut);
        fileOut.close();
        return file;
    }
    
    
    public ArrayList<BitacoraSolicitud> getSeguimientoSolicitud(int solicitud, int datosProc) throws Exception {
        return daoAdministradorReporte.getSeguimientoSolicitud(solicitud, datosProc);
    }
}
