import wollok.game.*
import contador.*
import mecanicas.*
import navesEnemigas.*
import naveJugador.*





class Nivel {
    method puntosParaGanar() = 0

    method siguienteNivel() = null

    method configurarNivel() {
        jugador.iniciarNivel(self)
        const enemigosIniciales = self.enemigosPorNivel()
        mecanicas.iniciarPartida(enemigosIniciales)
    }

    method enemigosPorNivel()
}



object nivel1 inherits Nivel {
    override method puntosParaGanar() = 125

    override method siguienteNivel() = nivel2

    override method enemigosPorNivel() {
        return [new Ligero(position = game.at(1, 6), posicionInicial = game.at(1, 6)),
                new Ligero(position = game.at(3, 6), posicionInicial = game.at(3, 6)),
                new Ligero(position = game.at(5, 6), posicionInicial = game.at(5, 6)),
                new Ligero(position = game.at(7, 6), posicionInicial = game.at(7, 6)),
                new Ligero(position = game.at(9, 6), posicionInicial = game.at(9, 6))]
    }
}

object nivel2 inherits Nivel {
    override method puntosParaGanar() = 500

    override method siguienteNivel() = nivel3

    override method enemigosPorNivel() {
        return [new Kamikaze(position = game.at(1, 6), posicionInicial = game.at(1, 6)),
                new Kamikaze(position = game.at(3, 6), posicionInicial = game.at(3, 6)),
                new Kamikaze(position = game.at(5, 6), posicionInicial = game.at(5, 6)),
                new Kamikaze(position = game.at(7, 6), posicionInicial = game.at(7, 6)),
                new Kamikaze(position = game.at(9, 6), posicionInicial = game.at(9, 6))]
    }
}

object nivel3 inherits Nivel {
    override method puntosParaGanar() = 999

    override method enemigosPorNivel() {
        return [new Jefe(position = game.at(5, 7), posicionInicial = game.at(5, 7))]
    }
}