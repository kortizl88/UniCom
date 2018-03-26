export class Menu {
    idMenu: number;
    titulo: string;
    descMenu: string;
    ruta: string;
    sel: boolean;

    constructor(idMenu: number, titulo: string, descMenu: string, ruta: string) {
        this.idMenu = idMenu;
        this.titulo = titulo;
        this.descMenu = descMenu;
        this.ruta = ruta;
        this.sel = false;
    }
}

