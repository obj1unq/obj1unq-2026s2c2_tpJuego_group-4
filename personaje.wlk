import wollok.game.*
import direcciones.*



object personaje {
  var property position = game.at(0, 3)
  var property image = "PJnormal.png"    // después va a cambiar por otro que tenga la linterna encima
  const mochila = []
  var elementoEnColision = null


  // Mueve al personaje en la dirección indicada y reinicia la última colisión.
  method mover(dir) {
    const nuevaPosicion = dir.siguiente(position)
    elementoEnColision = null
    position = nuevaPosicion
  }

  // Guarda el elemento con el que acaba de colisionar el personaje.
  method registrarColision(elemento) {
    elementoEnColision = elemento
  }

  // Enciende la linterna y actualiza la imagen del personaje.
  method encenderLinterna() {
    image = "PJconLinterna.png"
  }

  // Apaga la linterna y actualiza la imagen del personaje.
  method apagarLinterna() {
    image = "PJnormal.png"
  }

  // Indica si la linterna del personaje está encendida.
  method tieneLinternaEncendida() {
    return image == "PJconLinterna.png"
  }

  // Indica si una posición está a una casilla del personaje, incluyendo diagonales y su casilla actual.
  method estaCerca(otraPosicion) {
    const estaEnRangoHorizontal = otraPosicion.x().between(position.x() - 1, position.x() + 1)
    const estaEnRangoVertical = otraPosicion.y().between(position.y() - 1, position.y() + 1)
    return estaEnRangoHorizontal and estaEnRangoVertical
  }

  // Guarda una cosa cercana y visible en la mochila, o informa si no puede recogerla.
  method agarrarCosa(cosa) {
    if (not cosa.estaRecolectada() and self.tieneLinternaEncendida() and self.estaCerca(cosa.position())) {
      mochila.add(cosa)
      cosa.recolectar()
    } else {
      self.error("No se puede agarrar la cosa: debe estar cerca, visible y todavía en el mapa.")
    }
  }

  // Recoge una cosa visible cercana o informa si no hay ninguna disponible.
  method agarrarCosasVisibles(cosas) {
    var yaAgarroUna = false
    cosas.forEach({ cosa =>
      if (not yaAgarroUna and not cosa.estaRecolectada() and self.tieneLinternaEncendida() and self.estaCerca(cosa.position())) {
        self.agarrarCosa(cosa)
        yaAgarroUna = true
      }
    })
    if (not yaAgarroUna) {
      self.error("No se puede agarrar la cosa: no hay ninguna cosa visible cerca para agarrar.")
    }
  }

  // Abre la puerta o recoge el objeto con el que colisionó; si no hubo colisión, busca algo cercano.
  method interactuar(cosas, puerta) {
    if (elementoEnColision == puerta) {
      puerta.abrir(mochila, cosas)
      elementoEnColision = null
    } else if (cosas.contains(elementoEnColision)) {
      self.agarrarCosa(elementoEnColision)
      elementoEnColision = null
    } else {
      self.agarrarCosasVisibles(cosas)
    }
  }

  method efectoPorLuzApagada() {
    if (self.tieneLinternaEncendida()) {
      if (not game.allVisuals().contains(self)) {
        game.addVisual(self)
      }
    } else if (game.allVisuals().contains(self)) {
      game.removeVisual(self)
    }
  }

  method efectoPorLuzPrendida() {
    if (not game.allVisuals().contains(self)) {
      game.addVisual(self)
    }
  }
}