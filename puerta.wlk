import wollok.game.*
import personaje.*


object puerta{   //considerar pasarlo a clase en vez de que sea un objeto
    var property position = game.at(19, 4)


    // Muestra la puerta solo cuando el personaje tiene la linterna encendida y está cerca.
    method image() {
        return "puerta.jpg"
    }

    // Abre la puerta si la mochila contiene todas las cosas del nivel.
    //method abrir(mochila, cosas) {
        //self.validarAbrirPuerta()
        //var tieneTodasLasCosas = true
        //cosas.forEach({ cosa =>
        //    if (not mochila.contains(cosa)) {
        //        tieneTodasLasCosas = false
        //    }
        //})
        //if (tieneTodasLasCosas) {
        //    cosas.forEach({ cosa => game.removeVisual(cosa) })  
        //    game.removeVisual(self)
        //    personaje.position(game.at(0, 3))
        //} else {
        //    self.error("No tenemos todas las cosas para abrir la puerta.")
        //}
    //}

    //method validarAbrirPuerta() {
    //    if(self.puedeAbrirse()){
    //        self.error("No es posible abrir la puerta...")
    //    }
    //}

    //method puedeAbrirse() = 

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

    method efectoAlSerAbierta() {
        //game.allVisuals().forEach({o => game.removeVisual(o)})
        game.clear()     // otra forma más brusca de limpiar todo...
        //game.addVisual(positionable)     se debería crear el objeto que corresponde al final del juego
        game.boardGround("pantallaWin.jpg")
    }
}

/* 
lo siguiente es para que no se nos complique verificar la condicion de que la puerta esté cercana al pj
solucion: un "panel" al lado de la puerta en donde poner las barras
a considerar: qué hacer con la puerta??
*/

object panel {
    const property image = "panel.png"
    const property position = game.at(19, 6)


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
