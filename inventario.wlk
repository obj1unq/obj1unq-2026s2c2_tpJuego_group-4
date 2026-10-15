import wollok.game.*
import personaje.personaje



object inventario {
    const property position = game.at(0,7)

    method agregarse() {
        game.addVisual(self)
    }

    method image() {
        const cantidad = personaje.barrasRecolectadas()
        // Cada asset resume visualmente el total de barras recolectadas.
        return if (cantidad == 0) "inventario.png"
            else if (cantidad == 1) "inventario1.png"
            else if (cantidad == 2) "inventario2.png"
            else "inventario3.png"
    }
}
