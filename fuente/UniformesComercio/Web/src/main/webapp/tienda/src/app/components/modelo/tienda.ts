export class Tienda {

    public pais:number;
    public canal:string;
    public sucursal:number;
    public nombreTienda:string;
    public tiendaReceptora:number;
	
    constructor(pais:number,canal:string, sucursal:number){
        this.pais = pais;
	this.canal = canal;
	this.sucursal = sucursal;
    }

}