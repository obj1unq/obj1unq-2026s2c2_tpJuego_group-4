import wollok.game.*
import personaje.*
import barra.*



object monticulosEnSala {
    const registrados = []

    method registrar(monticulo) {
        registrados.add(monticulo)
    }

    method quitar(monticulo) {
        registrados.remove(monticulo)
    }

    method todos() = registrados
}

class Monticulo{    // ex CosaUObstaculo
    var property position = game.center()
    var property image = "coso.jpg"
    var property tieneBarra = false
    var property fueBuscado = false

    // Marca si el montículo ya se revisó y evita volver a recoger su barra.
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

    // Revisa el montículo una vez; devuelve true si entrega una barra y false si está vacío.
    method buscar() {
        self.validarNoFueBuscado()
        fueBuscado = true
        self.cambiarImagenDespuesDeBusqueda()
        if (tieneBarra) {
            tieneBarra = false
            return true
        }
        return false
    }

    method validarNoFueBuscado() {
        if (fueBuscado) {
            self.error("Este montículo ya fue revisado.")
        }
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

    method esMonticuloConBarraDentro() = tieneBarra
}


// variantes para heredar el comportamiento de la clase de arriba (lo único que cambia es la imagen)
