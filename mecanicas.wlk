// acá van todas las mecánicas extra, como reiniciar el juego, perder, etc
import wollok.game.*
import pantallas.*
import naveJugador.*
import navesEnemigas.*
import direcciones.*
import contador.*





object mecanicas {
    var estado = estadoEnJuego       // dejar este estado para que la mecanica trabaje según él??? 
    var tanques = []




    method iniciarPartida(tanquesIniciales) {
        tanques = tanquesIniciales
        estado = estadoEnJuego
        game.boardGround("fondo.png")
        self.configurarControles()
        game.addVisual(jugador)
        game.addVisual(vida)
        game.addVisual(contadorVida)
        game.addVisual(score)
        tanques.forEach{tanque => tanque.aparecer()}
    }

    method configurarControles() {
        keyboard.w().onPressDo({estado.mover(arriba)})
        keyboard.s().onPressDo({estado.mover(abajo)})
        keyboard.a().onPressDo({estado.mover(izquierda)})
        keyboard.d().onPressDo({estado.mover(derecha)})
        keyboard.space().onPressDo({estado.disparar()})
        keyboard.r().onPressDo({estado.reiniciar()})    // en teoría sólo puede funcionar cuando esté la pantalla de GO
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
        keyboard.r().onPressDo({estado.reiniciar()})
    }

    method reiniciarJuego() {
        estado.reiniciar()
    }

    method reiniciarPartida() {
        game.clear()
        jugador.reiniciar()
        tanques.forEach{tanque => tanque.reiniciar()}
        self.iniciarPartida(tanques)
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

    method reiniciar() = 0
}

object estadoPerdido {
    //method nombre() = "partida perdida"

    method mover(_direccion) = 0

    method disparar() = 0

    method perder() = 0

    method ganar() = 0

    method reiniciar() {
        mecanicas.reiniciarPartida()
    }
}

object estadoGanado {
    //method nombre() = "partida ganada"

    method mover(_direccion) = 0

    method disparar() = 0

    method perder() = 0

    method ganar() = 0

    method reiniciar() = 0
}



