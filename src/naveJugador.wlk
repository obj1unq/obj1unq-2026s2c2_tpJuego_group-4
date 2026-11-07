import wollok.game.*
import navesEnemigas.*

object jugador {

    var property position = game.at(7, 2)
    var property vidas = 3
    var property puntos = 0

    method image() = "naveJugador.png"

    method moverArriba() {
        if (position.y() < 5) {
            position = position.up(1)
        }
    }

    method moverAbajo() {
        if (position.y() > 0) {
            position = position.down(1)
        }
    }

    method moverIzquierda() {
        if (position.x() > 0) {
            position = position.left(1)
        }
    }

    method moverDerecha() {
        if (position.x() < game.width() - 1) {
            position = position.right(1)
        }
    }

    method disparar() {
        const proyectil = new ProyectilJugador(position = self.position().up(1))
        game.addVisual(proyectil)
        proyectil.iniciarMovimiento()
    }

    method recibirDaño(){
        vidas = vidas - 1
        if (vidas <= 0) {
            self.morir()
        }
    }

    method morir() {
        game.removeVisual(self)
    }

}



class ProyectilJugador {

    var property position
    
    method image() = "proyectilAzul.png"

    method iniciarMovimiento() {
        game.onTick(100, "moverProyectil" + self.identity(), { self.mover() })
    }

    method mover() {
        if (position.y() >= game.height() - 1) {
            self.desaparecer()
        } else {
            position = position.up(1)
        }
    }

    method desaparecer() {
        game.removeTickEvent("moverProyectil" + self.identity())

        if (game.hasVisual(self)) {
            game.removeVisual(self)
        }
    }

    method chocarConEnemigo (enemigo) {
        enemigo.recibirDaño()
        self.desaparecer()
    }

}

