import wollok.game.*
import direcciones.*



object personaje {
  var property position = game.at(0, 3)
  var property image = "PJnormal.png"    // después va a cambiar por otro que tenga la linterna encima


  method mover(dir) {
    const nuevaPosicion = dir.siguiente(position)
    position = nuevaPosicion
  }

  method interactuarLinterna() {
   if(!self.tieneLinternaEncendida()) {image = "PJconLinterna.png"} else {image = "PJnormal.png"}
  }

  method tieneLinternaEncendida(){
    return image == "PJconLinterna.png"
  } 

  
}