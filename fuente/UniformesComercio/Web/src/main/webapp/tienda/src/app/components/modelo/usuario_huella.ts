export class UsuarioHuella{
	
    private _nombre:string;
    private _numeroEmpleado:number;
	
    constructor(nombre:string,numeroEmpleado:number){
	this._nombre = nombre;
	this._numeroEmpleado = numeroEmpleado;
    }
	
    get nombre():string{
        return this._nombre;
    }
	
    get numeroEmpleado():number{
	return this._numeroEmpleado;
    }	
	
}