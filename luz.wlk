import wollok.game.*
import personaje.*




object inicio {
	const intervalo = 1000
	var estadoLuz = prendido
	const visuales = []
	var property fondo = "fondoGris.jpg"     // agregado solo para el test

/*
tema con los parpadeos y los visuales..tener una lista sirve como un registro para todas las visuales de la 'sala', esten visibles o no
y al usar game.removeVisual(self) al apagarse la luz (que era como estaba antes) en el sig tick no se le puede volver a invocar, y usando una lista/registro de
las visuales permite volver a invocar todas las visuales, tal y cómo estaban previamente, cuando se prende la luz
*/

	method configurarEscenario() {
		game.title("Escenario inicial")
		game.height(20)
		game.width(20)
		game.boardGround("fondoGris.jpg")
	}

	method registrarVisual(visual) {
		visuales.add(visual)
	}

	method iniciarParpadeo() {		// ex scheculerInicial()
		game.schedule(3000, {self.prender()})
		game.schedule(10000, {self.apagar()})
	}

	method prender() {
		game.onTick(intervalo, "Parpadear", {self.parpadear()})
											//game.allVisuals().forEach({cosa => cosa.efectoPorLuzPrendida()})})
	}

	method parpadear() {
		estadoLuz = estadoLuz.parpadeo()
		estadoLuz.activar()
	}

	method actualizarVisuales() {	// ex schedulerFinal() - delega a cada visual cuál era su comportamiento
		estadoLuz.aplicarEfectos(visuales)
		//game.removeTickEvent("Parpadeo")
		//config.configurarEscenario()    //quita el parpadeo y ya aparecería el escenario a oscuras
	}

	method moverPersonaje(direccion) {
		personaje.mover(direccion)
		self.actualizarVisuales()
	}

	method alternarLinterna() {
		if(personaje.tieneLinternaEncendida()) {
			personaje.apagarLinterna()
		} else {
			personaje.encenderLinterna()
		}
		self.actualizarVisuales()
	}

	//method interactuar(cosas, puerta) {
	//	personaje.interactuar(cosas, puerta)
	//	self.actualizarVisuales()
	//}

	method apagar() {
		game.removeTickEvent("Parpadear")
		estadoLuz = apagado
		estadoLuz.activar()
	}
}

object prendido {
	method parpadeo() = apagado

	method activar() {
		game.boardGround("fondoGris.jpg")
		//game.removeVisual(oscuridad)
		inicio.fondo("fondoGris.jpg")
		inicio.actualizarVisuales()
	}

	method aplicarEfectos(visuales) {
		visuales.forEach({visual => visual.efectoPorLuzPrendida()})
	}
}

object apagado {
	method parpadeo() = prendido

	method activar() {
		game.boardGround("fondoOscuro.jpg")
		//game.addVisual(oscuridad)
		inicio.fondo("fondoOscuro.jpg")
		inicio.actualizarVisuales()
	}

	method aplicarEfectos(visuales) {
		visuales.forEach({visual => visual.efectoPorLuzApagada()})
	}
}

//object oscuridad{
//	const property position = game.at(0,0)
//	const property image = "fondoOscuro.jpg"
//}

