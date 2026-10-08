import wollok.game.*
import personaje.*


class Monticulo{    // ex CosaUObstaculo
    var property position = game.center()
    var image = "coso.jpg"
    //var recolectada = false

    // TO DO: cambiar todo esto de las imágenes
    // Devuelve la imagen del objeto si es visible; de lo contrario, muestra el fondo gris.
    //method image2() {
    //    if (personaje.tieneLinternaEncendida() and personaje.estaCerca(position)) {
    //        return imagenOriginal
    //    }
    //    return "fondoGris1.jpg"    // para inmersión, cambiar la imagen de original a después de buscar la cosa (cosa=montón de chatarra/basura, cajas o muebles)
    //}

    method cambiarImagenDespuesDeBusqueda() {
        image = "cosoDspDeBusqueda.jpg"    //cada tipo de 'coso' cambia su imagen dependiendo de qué es
    }

    // Indica si el objeto ya fue recogido.
    //method estaRecolectada() = recolectada

    // Marca el objeto como recogido y lo quita del mapa.
    method recolectar() {
        //recolectada = true
        //game.removeVisual(self)
        self.cambiarImagenDespuesDeBusqueda()
    }

    method efectoPorLuzPrendida() {
        if (not game.allVisuals().contains(self)) {
            game.addVisual(self)
        }
    }

    method efectoPorLuzApagada() {
        if (personaje.tieneLinternaEncendida() and personaje.estaCerca(position)) {
            if (not game.allVisuals().contains(self)) {
                game.addVisual(self)
            }
        } else if (game.allVisuals().contains(self)) {
            game.removeVisual(self)
        }
    }
}


// variantes para heredar el comportamiento de la clase de arriba (lo único que cambia es la imagen)

