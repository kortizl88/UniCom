/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.elektra.uniformes.comercio.Modelo;

public class TotalesPedidosDescuentos {
    
    private String cadenaTotalPagado;   
    private String cadenaTotalSaldoPorPagar;        
    private String cadenaTotalCostoPrenda;
    private String cadenaTotalPagoSemanal;

    public String getCadenaTotalCostoPrenda() {
        return cadenaTotalCostoPrenda;
    }

    public void setCadenaTotalCostoPrenda(double totalCostoPrenda) {       
        this.cadenaTotalCostoPrenda = "$" + String.format("%.2f", totalCostoPrenda);
    }

    public String getCadenaTotalPagado() {
        return cadenaTotalPagado;
    }

    public void setCadenaTotalPagado(double totalPagado) {
        this.cadenaTotalPagado = "$" + String.format("%.2f", totalPagado);
    }

    public String getCadenaTotalSaldoPorPagar() {
        return cadenaTotalSaldoPorPagar;
    }

    public void setCadenaTotalSaldoPorPagar(double totalSaldoPorPagar) {
        this.cadenaTotalSaldoPorPagar = "$" + String.format("%.2f", totalSaldoPorPagar);
    }

    public String getCadenaTotalPagoSemanal() {
        return cadenaTotalPagoSemanal;
    }

    public void setCadenaTotalPagoSemanal(double cadenaTotalPagoSemanal) {
        this.cadenaTotalPagoSemanal = "$" + String.format("%.2f", cadenaTotalPagoSemanal);
    }


    

}
