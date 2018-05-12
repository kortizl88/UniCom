export class Tienda {

    public pais: number;
    public canal: number;
    public sucursal: number;
    public nombreTienda: string;
    public tiendaReceptora: number;
    public centroCostos: number;

    constructor(pais: number, canal: number, sucursal: number, centroCostos: number) {
        this.pais = pais;
        this.canal = canal;
        this.sucursal = sucursal;
        this.centroCostos = centroCostos;
    }

}