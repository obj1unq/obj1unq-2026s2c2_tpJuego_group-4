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



    method iniciarPartida(enemigosIniciales) {
        enemigos = enemigosIniciales
        estado = estadoEnJuego
        game.boardGround("fondo.png")
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
        keyboard.w().onPressDo({estado.mover(new Arriba())})
        keyboard.s().onPressDo({estado.mover(new Abajo())})
        keyboard.a().onPressDo({estado.mover(new Izquierda())})
        keyboard.d().onPressDo({estado.mover(new Derecha())})
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
        game.clear()
        nivel.configurarNivel()
    }

    method finalizarEn(pantalla, nuevoEstado) {
        estado = nuevoEstado
        game.clear()
        game.boardGround(pantalla)
    }

    method reiniciarJuego() {
        estado.reiniciar()
    }

    method reiniciarPartida() {
        enemigos.forEach{ enemigo => enemigo.desaparecer() }
        game.clear()
        jugador.reiniciar()
        nivel1.configurarNivel()
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
    override method ganar(){
        mecanicas.ganar()
    }
}



