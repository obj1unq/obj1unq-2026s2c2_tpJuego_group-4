// acá van todas las mecánicas extra, como reiniciar el juego, perder, etc
import wollok.game.*
import pantallas.*
import naveJugador.*
import navesEnemigas.*
import direcciones.*
import contador.*
import niveles.*


object mecanicas {
    var estado = estadoEnJuego       // dejar este estado para que la mecanica trabaje según él??? 
    var enemigos = []
    var controlesConfigurados = false

    method iniciarMenu() {
        self.mostrarInicio()
    }

    method limpiarPantalla() {
        game.clear()
        controlesConfigurados = false
        self.configurarControles()
    }

    method mostrarInicio() {
        estado = estadoInicio
        self.limpiarPantalla()
        game.addVisual(inicio)
    }

    method mostrarInformacion() {
        estado = estadoInformacion
        self.limpiarPantalla()
        game.addVisual(informacion)
    }

    method mostrarReadyInicial() {
        estado = estadoReadyInicial
        self.limpiarPantalla()
        nivel1.cargar()
    }

    method iniciarPartida(enemigosIniciales) {
        enemigos = enemigosIniciales
        estado = estadoEnJuego
        //game.boardGround("fondoCarga.png")
        if (not game.hasVisual(fondo)) {
            game.addVisual(fondo)
        }
        self.configurarControles()
        game.addVisual(jugador)
        self.configurarContadores()     // de vida y del puntaje
        enemigos.forEach{enemigo => enemigo.aparecer()}

        //generador.iniciar()
    }

    method configurarContadores() {
        score.agregarAlJuego()
        contadorDeVidas.agregarAJuego()
    }

    method configurarControles() {
        if (not controlesConfigurados) {
            keyboard.w().onPressDo({estado.mover(new Arriba())})
            keyboard.s().onPressDo({estado.mover(new Abajo())})
            keyboard.a().onPressDo({estado.mover(new Izquierda())})
            keyboard.d().onPressDo({estado.mover(new Derecha())})
            keyboard.c().onPressDo({estado.avanzar()})
            keyboard.space().onPressDo({estado.disparar()})
            self.configurarReinicio()
            controlesConfigurados = true
        }
    }

    method configurarReinicio() {
        keyboard.r().onPressDo({ estado.reiniciar() })
    }
    
    method perder() {
        estado.perder()
    }

    method ganar() {
        estado.ganar()
    }

    method completarNivel() {
        const siguienteNivel = jugador.nivelEnElQueEsta().siguienteNivel()
        if (siguienteNivel == null) {
            self.ganar()
        } else {
            self.cambiarNivel(siguienteNivel)
        }
    }

    method cambiarNivel(nivel) {
        enemigos.forEach{ enemigo => enemigo.desaparecer() }
        estado = estadoReadyInicial
        self.limpiarPantalla()
        nivel.cargar()
    }

    method finalizarEn(pantalla, nuevoEstado) {
        estado = nuevoEstado
        self.limpiarPantalla()
        //game.boardGround(pantalla)
        game.addVisual(pantalla)
    }

    method reiniciarJuego() {
        enemigos.forEach{ enemigo => enemigo.desaparecer() }
        self.limpiarPantalla()
        jugador.reiniciar()
        estado = estadoReadyInicial
        nivel1.cargar()
    }

    method estadoActual() = estado
}

object estadoEnJuego {
    method avanzar() {}

    method mover(direccion) {
        jugador.moverseA(direccion)
    }

    method disparar() {
        jugador.disparar()
    }

    method reiniciar() {}

    method perder() {
        mecanicas.finalizarEn(gameOverWindow, estadoPerdido)
    }

    method ganar() {
        mecanicas.finalizarEn(winWindow, estadoGanado)
    }
}

class EstadoFinal {
    method avanzar() {}

    method mover(_direccion) {}

    method disparar() {}

    method perder() {}

    method ganar() {}

    method reiniciar() {}
}

object estadoInicio inherits EstadoFinal {
    override method avanzar() {
        mecanicas.mostrarInformacion()
    }
}

object estadoInformacion inherits EstadoFinal {
    override method avanzar() {
        mecanicas.mostrarReadyInicial()
    }
}

object estadoReadyInicial inherits EstadoFinal {}

object estadoPerdido inherits EstadoFinal {
    override method reiniciar() {
        mecanicas.reiniciarJuego()
    }
}

object estadoGanado inherits EstadoFinal {
    override method ganar(){
        mecanicas.ganar()
    }

}



