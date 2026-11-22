import wollok.game.*
import navesEnemigas.*
import direcciones.*
import contador.*
import mecanicas.*
import proyectil.*
import niveles.*



/*
vida completa         |               vida por la mitad            (se calculará como un rango de 1..5 para una vida completa y de 6..10 para una vida incompleta)
            1                    ==>                         6
            2                    ==>                         7
            3                    ==>                         8
            4                    ==>                         9
            5                    ==>                         10
*/
object jugador {
    var property position = game.at(7, 2)
    var vidasEnMedios = 10
    var property puntosHastaAhora = 0
    var property nivelEnElQueEsta = nivel1



    method image() = "naveJugador.png"

    method vidas() = vidasEnMedios / 2

    method vidaEnMedios() = vidasEnMedios

    method esBlancoDe(bando) = bando.puedeHerirAlJugador()

    method mover(direccion) {
        if (direccion.puedeMoverDesde(position, 3, game.width() - 1)) {
            position = direccion.siguiente(position)
        }
    }

    method moverseA(_direcion){
		self.mover(_direcion)
    }

    method disparar() {
        const proyectil = new ProyectilJugador(position = position.up(1), trayectoria = new Arriba())
        
        proyectil.lanzar()
    }

    method sumarPuntos(cantidad) {
        score.agregarPuntos(cantidad)
        puntosHastaAhora += cantidad
        if (puntosHastaAhora >= nivelEnElQueEsta.puntosParaGanar()) {
            mecanicas.completarNivel()
        }
    }

    method recibirDaño(danioEnMedios) {
        vidasEnMedios = (vidasEnMedios - danioEnMedios).max(0)
        contadorDeVidas.actualizar(vidasEnMedios)
        if (vidasEnMedios == 0) {
            self.morir()
        }
    }

    method morir() {
        if (game.hasVisual(self)) {
            game.removeVisual(self)
        }

        mecanicas.perder()
    }

    method reiniciar() {
        position = game.at(7, 2)
        vidasEnMedios = 10
        puntosHastaAhora = 0
        nivelEnElQueEsta = nivel1
        score.reiniciar()
    }

    method iniciarNivel(nivel) {
        nivelEnElQueEsta = nivel
        puntosHastaAhora = 0
        score.reiniciar()
    }

}





