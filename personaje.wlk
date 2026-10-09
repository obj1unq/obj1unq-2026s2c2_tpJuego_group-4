import wollok.game.*
import direcciones.*
import puerta.*
import barra.*
import monticulo.*



object personaje {
  var property position = game.at(0, 3)
  var property image = "PJnormal.png"    // después va a cambiar por otro que tenga la linterna encima
  const mochila = []
  var elementoEnColision = null


  // Mueve al personaje en la dirección indicada y reinicia la última colisión.
  method mover(dir) {
    const nuevaPosicion = dir.siguiente(position)
    self.validarMovimientoHacia(nuevaPosicion)
    elementoEnColision = null
    position = nuevaPosicion
  }

  method validarMovimientoHacia(dir){
    if(self.sePuedeMoverHacia(dir)){
      self.error("No es posible moverme hacia el "+dir+".")
    }
  }

  method sePuedeMoverHacia(direccion) = !self.hayObstaculoHacia(direccion)

  method hayObstaculoHacia(dir) = game.getObjectsIn(dir).isEmpty()

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
  method buscarBarra() {
    self.validarBusquedaYRecoleccion()
    mochila.add(Barra)
    //cosa.recolectar()
}

  method validarBusquedaYRecoleccion(){
    if (self.hayBarraCercana()) {
      self.error("No hay nada para agarrar acá.")
    }
  }

  method hayBarraCercana() = self.hayMonticuloCerca() && Monticulo.tieneBarra()

  method hayMonticuloCerca() = monticulosEnSala.todos().any({ monticulo =>
    monticulo.position() != position and
    self.estaCerca(monticulo.position())
  })

  method puedeAgarrar(cosa) = not cosa.estaRecolectada() and self.tieneLinternaEncendida() and self.estaCerca(cosa.position())

  method abrirPuerta() {
    self.validarAbrirPuerta()
    puerta.efectoAlSerAbierta()
    // juego.cambiarEscenario()   // el que eliminará todo de la sala 1 y empezará la sala 2
    // -----  "juego", por ahora esa referencia porque no sé en dónde ubicar la lógica de cambiar de sala..hablarlo
  }

  method validarAbrirPuerta() {    // 2 validaciones porque los mensajes que dice el pj son diferentes
    self.validarPosicionDeLaPuerta()
    self.validarBarrasSuficientesParaAbrirPuerta()
  }

  method validarPosicionDeLaPuerta() {
    if(self.hayPuertaCerca()){
      self.error("No hay puerta cercana para abrir.")
    }
  }

  method hayPuertaCerca() = self.estaFrenteAlPanel()

  method estaFrenteAlPanel() = self.position() == game.at(18,5)   //exactamente delante del panel

  method validarBarrasSuficientesParaAbrirPuerta() {
    if(self.haySuficientesBarrasParaAbrirLaPuerta()){
      self.error("No puedo abrir la puerta, no cuento con suficientes barras.")
    }
  }

  method haySuficientesBarrasParaAbrirLaPuerta() = mochila.ocurrencesOf(Barra) == 3  // solo hay 3 barras en toda la sala, por lo que buscar un resultado diferente que 3 sería ilógico..

  // Recoge una cosa visible cercana o informa si no hay ninguna disponible.
//  method agarrarCosasVisibles(cosas) {
//    var yaAgarroUna = false
//    cosas.forEach({ cosa =>
//      if (not yaAgarroUna and not cosa.estaRecolectada() and self.tieneLinternaEncendida() and self.estaCerca(cosa.position())) {
//        self.agarrarCosa(cosa)
//        yaAgarroUna = true
//      }
//    })
//    if (not yaAgarroUna) {
//      self.error("No se puede agarrar la cosa: "+cosas+" ya que no está cerca para agarrarla.")
//    }
//  }

  // Abre la puerta o recoge el objeto con el que colisionó; si no hubo colisión, busca algo cercano.
//  method interactuar(cosas, puerta) {
//    if (elementoEnColision == puerta) {
//      puerta.abrir(mochila, cosas)
//      elementoEnColision = null
//    } else if (cosas.contains(elementoEnColision)) {
//      self.agarrarCosa(elementoEnColision)
//      elementoEnColision = null
//    } else {
//      self.agarrarCosasVisibles(cosas)
//    }
//  }

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