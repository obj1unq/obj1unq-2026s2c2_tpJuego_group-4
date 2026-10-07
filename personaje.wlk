import wollok.game.*
import direcciones.*



object personaje {
  var property position = game.at(0, 3)
  var property image = "PJnormal.png"    // después va a cambiar por otro que tenga la linterna encima
  var property inventario = []

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

  method validarBuscar() {
  
  }

  method buscar () {
    self.validarBuscar()
  }

  method buscarBarritaDentroDe(cosa){
    if (cosa.tieneBarrita()){inventario.add(barrita) cosa.removeVisual(image)} else { self.error("No encontre nada") cosa.removeVisual(image)}
  }
}

object barrita {
  var property image = "barrita.png"
}