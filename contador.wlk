import wollok.game.*
import naveJugador.*



// se ve demasiado chico, por lo que habría que considerar usar imágenes que van cambiando al sumar el puntaje :/
//   (agregar pngs del 0 al 9)
object vida {
    const property puntosParaGanar = 5000


    method image() = "heart.png"

    method position() = game.at(0, 9)
}

object contadorVida {
    method position() = game.at(1, 9)

    method text() = "x" + jugador.vidas().max(0)  // Ex.: x3 +o x0 (el jugador murió)

    method textColor() = "FFDE21"
}

object score {
    method text() = "PUNTAJE: " + jugador.puntos()+"/5000"          // cambiar acá si se modifica la meta para ganar

    method position() = game.at(6, 9)

    method textColor() = "FFDE21"
}

object restartHint {
    method text() = "R: REINICIAR"

    method position() = game.at(5, 2)

    method textColor() = "FFDE21"
}
