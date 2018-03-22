export class Menu {
    idMenu: number;
    titulo: string;
    descMenu: string;
    ruta: string;

    constructor(idMenu: number, titulo: string, descMenu: string, ruta: string) {
        this.idMenu = idMenu;
        this.titulo = titulo;
        this.descMenu = descMenu;
        this.ruta = ruta;
    }
}

