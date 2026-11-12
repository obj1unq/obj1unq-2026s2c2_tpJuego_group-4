import wollok.game.*
import navesEnemigas.*
import direcciones.*
import contador.*
import mecanicas.*
import proyectil.*

object jugador {

    var property position = game.at(7, 2)
    var vidas = 3
    var property puntos = 0

    method image() = "naveJugador.png"

    method vidas() = vidas

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
        const proyectil = new ProyectilJugador(position = position.up(1), trayectoria = arriba)
        
        proyectil.lanzar()
    }

    method sumarPuntos(cantidad) {
        const puntosParaGanarJuego = contador.vida.puntosParaGanar()
        puntos = puntos + cantidad
        if (puntos >= puntosParaGanarJuego) {
            mecanicas.ganar()
        }
    }

    method recibirDaño(){
        vidas = vidas - 1
        if (vidas <= 0) {
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
        vidas = 3
        puntos = 0
    }

}





