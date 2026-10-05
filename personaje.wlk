import wollok.game.*
import direcciones.*



object personaje {
  var property position = game.at(0, 3)
  var property image = "PJnormal.png"    // después va a cambiar por otro que tenga la linterna encima
  const mochila = []
  var elementoEnColision = null

  method mover(dir) {
    const nuevaPosicion = dir.siguiente(position)
    elementoEnColision = null
    position = nuevaPosicion
  }

  method registrarColision(elemento) {
    elementoEnColision = elemento
  }

  method encenderLinterna() {
    image = "PJconLinterna.png"
  }

  method apagarLinterna() {
    image = "PJnormal.png"
  }

  method tieneLinternaEncendida() {
    return image == "PJconLinterna.png"
  }

  method estaCerca(otraPosicion) {
    const estaEnRangoHorizontal = otraPosicion.x().between(position.x() - 1, position.x() + 1)
    const estaEnRangoVertical = otraPosicion.y().between(position.y() - 1, position.y() + 1)
    return estaEnRangoHorizontal and estaEnRangoVertical
  }

  method agarrarCosa(cosa) {
    if (not cosa.estaRecolectada() and self.tieneLinternaEncendida() and self.estaCerca(cosa.position())) {
      mochila.add(cosa)
      cosa.recolectar()
    } else {
      self.error("No se puede agarrar la cosa: debe estar cerca, visible y todavía en el mapa.")
    }
  }

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
}