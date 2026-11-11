import wollok.game.*
import naveJugador.*
import navesEnemigas.*



// fusionar esto
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

//con esto
class ProyectilEnemigo {

    var property position

    method image() = "proyectilRojo.png"

    method iniciarMovimiento() {
        game.onTick( 150, "moverProyectilEnemigo" + self.identity(), { self.mover() })
        //self.impactar()
        game.onCollideDo(self, { objeto =>  objeto.recibirDaño()
        self.destruir()
        })
        
    }

    method mover() {
        if (position.y() <= 0) {
            self.destruir()
        } else {
            position = position.down(1)
        }
    }

    method destruir() {
        game.removeTickEvent(
            "moverProyectilEnemigo" + self.identity()
        )

        if (game.hasVisual(self)) {
            game.removeVisual(self)
        }
    }

}