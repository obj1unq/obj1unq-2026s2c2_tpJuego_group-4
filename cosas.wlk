import wollok.game.*
import personaje.*


class CosaUObstaculo{
    var property position = game.center()
    const imagenOriginal = "coso.jpg"
    var recolectada = false

    method image() {
        if (personaje.tieneLinternaEncendida() and personaje.estaCerca(position)) {
            return imagenOriginal
        }
        return "fondoGris1.jpg"
    }

    method estaRecolectada() = recolectada

    method recolectar() {
        recolectada = true
        game.removeVisual(self)
    }
}