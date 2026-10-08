import wollok.game.*
import personaje.*


object puerta{   //considerar pasarlo a clase en vez de que sea un objeto
    var property position = game.at(19, 4)


    // Muestra la puerta solo cuando el personaje tiene la linterna encendida y está cerca.
    method image() {
        return "puerta.jpg"
    }

    // Abre la puerta si la mochila contiene todas las cosas del nivel.
    method abrir(mochila, cosas) {
        var tieneTodasLasCosas = true
        cosas.forEach({ cosa =>
            if (not mochila.contains(cosa)) {
                tieneTodasLasCosas = false
            }
        })
        if (tieneTodasLasCosas) {
            cosas.forEach({ cosa => game.removeVisual(cosa) })  
            game.removeVisual(self)
            personaje.position(game.at(0, 3))
        } else {
            self.error("No tenemos todas las cosas para abrir la puerta.")
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
}