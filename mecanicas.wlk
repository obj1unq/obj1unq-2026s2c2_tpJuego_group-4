// acá van todas las mecánicas extra, como reiniciar el juego, perder, etc
import wollok.game.*
import pantallas.*
import naveJugador.*
import navesEnemigas.*
import direcciones.*
import contador.*
import generador.*





object mecanicas {
    var estado = estadoEnJuego       // dejar este estado para que la mecanica trabaje según él??? 
    var enemigos = []

    method iniciarPartida(enemigosIniciales) {
        enemigos = enemigosIniciales
        estado = estadoEnJuego
        game.boardGround("fondo.png")
        self.configurarControles()
        game.addVisual(jugador)
        game.addVisual(vida)
        game.addVisual(contadorVida)
        game.addVisual(score)
        enemigos.forEach{enemigo => enemigo.aparecer()}

        generador.iniciar()
    }

    method configurarControles() {
        keyboard.w().onPressDo({estado.mover(arriba)})
        keyboard.s().onPressDo({estado.mover(abajo)})
        keyboard.a().onPressDo({estado.mover(izquierda)})
        keyboard.d().onPressDo({estado.mover(derecha)})
        keyboard.space().onPressDo({estado.disparar()})
        self.configurarReinicio()
    }

    method configurarReinicio() {
        keyboard.r().onPressDo({ self.reiniciarJuego() })
    }
    
    method perder() {
        estado.perder()
    }

    method ganar() {
        estado.ganar()
    }

    method finalizarEn(pantalla, nuevoEstado) {
        estado = nuevoEstado
        game.clear()
        game.boardGround(pantalla)
        game.addVisual(restartHint)
        self.configurarReinicio()
    }

    method reiniciarJuego() {
        estado.reiniciar()
    }

    method reiniciarPartida() {
        game.clear()
        jugador.reiniciar()
        enemigos.forEach{enemigo => enemigo.reiniciar()}
        generador.reiniciar()
        self.iniciarPartida(enemigos)
    }

    method estadoActual() = estado
}

object estadoEnJuego {
    //method nombre() = "en juego"

    method mover(direccion) {
        jugador.moverseA(direccion)
    }

    method disparar() {
        jugador.disparar()
    }

    method perder() {
        mecanicas.finalizarEn(gameOverWindow, estadoPerdido)
    }

    method ganar() {
        mecanicas.finalizarEn(winWindow, estadoGanado)
    }

    method reiniciar(){}
}

class EstadoFinal {

    method mover(_direccion) {}

    method disparar() {}

    method perder() {}

    method ganar() {}

    method reiniciar() {}

}

object estadoPerdido inherits EstadoFinal {

    override method reiniciar() {
        mecanicas.reiniciarPartida()
    }

}

object estadoGanado inherits EstadoFinal {



}



