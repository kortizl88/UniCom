import {Talla} from './talla';

export class PrendasHomogeneas{

    private _url:string;
    private _descripcion:string;    
    private _cantidad:number;
    private _arregloTallas:Talla[];    
    private _precioFijo:number;
    private _precio:number;    

    constructor(url:string, descripcion:string, cantidad:number, arregloTallas:Talla[], precioFijo:number, precio:number){
        this._url = url;
        this._descripcion = descripcion;
        this._cantidad = cantidad;
        this._arregloTallas = arregloTallas;
        this._precioFijo = precioFijo;
        this._precio = precio;
    }

    get url():string{
        return this._url;
    }

    get descripcion():string{
        return this._descripcion;
    }

    get cantidad():number{
        return this._cantidad;
    }

    get arregloTallas():Talla[]{
        return this._arregloTallas;
    }

    get precioFijo():number{
        return this._precioFijo;
    }

    get precio():number{
        return this._precio;
    }

}

