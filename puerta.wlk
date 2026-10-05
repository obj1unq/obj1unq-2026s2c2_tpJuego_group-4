import wollok.game.*
import personaje.*


object puerta{   //considerar pasarlo a clase en vez de que sea un objeto
    var property position = game.at(9, 4)

    method image() { //solo podra ver la puerta si esta cerca y esta con la linterna prendida
        if (personaje.tieneLinternaEncendida() and personaje.estaCerca(position)) {
            return "puerta.jpg"
        }
        return "fondoGris1.jpg"
    }

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
}