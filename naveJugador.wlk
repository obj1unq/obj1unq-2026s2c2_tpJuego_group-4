import wollok.game.*
import navesEnemigas.*
import direcciones.*
import contador.*
import mecanicas.*




object jugador {
    var property position = game.at(7, 2)
    var vidas = 3
    var property puntos = 0



    method image() = "naveJugador.png"

    method mover(direccion) {
        if (direccion.puedeMoverDesde(position, 3, game.width() - 1)) {
            position = direccion.siguiente(position)
        }
    }

    method moverseA(_direcion){
		self.mover(_direcion)
    }

    method vidas() = vidas

    method sumarPuntos(cantidad) {
        const puntosParaGanarJuego = contador.vida.puntosParaGanar()
        puntos = puntos + cantidad
        if (puntos >= puntosParaGanarJuego) {
            mecanicas.ganar()
        }
    }

    method reiniciar() {
        position = game.at(7, 2)
        vidas = 3
        puntos = 0
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
        if (game.hasVisual(self)) {
            game.removeVisual(self)
        }

        mecanicas.perder()
    }

}



class ProyectilJugador {
    var property position

    method image() = "proyectilAzul.png"

    method iniciarMovimiento() {
        game.onTick(100, "moverProyectil" + self.identity(), { self.mover() })

        game.onCollideDo(self, { objeto =>  objeto.recibirDaño()
        self.desaparecer()
        })
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

