import wollok.game.*
import personaje.*


class CosaUObstaculo{
    var property position = game.center()
    const imagenOriginal = "coso.jpg"
    var recolectada = false

    // Devuelve la imagen del objeto si es visible; de lo contrario, muestra el fondo gris.
    method image() {
        if (personaje.tieneLinternaEncendida() and personaje.estaCerca(position)) {
            return imagenOriginal
        }
        return "fondoGris1.jpg"
    }

    // Indica si el objeto ya fue recogido.
    method estaRecolectada() = recolectada

    // Marca el objeto como recogido y lo quita del mapa.
    method recolectar() {
        recolectada = true
        game.removeVisual(self)
    }
}