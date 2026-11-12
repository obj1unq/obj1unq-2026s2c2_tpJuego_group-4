import wollok.game.*
import direcciones.*

object bandoJugador {

    method puedeHerirAlJugador() = false

    method puedeHerirAEnemigos() = true

}

object bandoEnemigo {

    method puedeHerirAlJugador() = true

    method puedeHerirAEnemigos() = false

}

class Proyectil {

    var property position
    const trayectoria
    var activo = true

    method image()

    method bando()

    method intervaloMovimiento() 

    method esBlancoDe(_bando) = false

    method lanzar() {
        game.addVisual(self)
        game.onTick(self.intervaloMovimiento(), "moverProyectil" + self.identity(), { self.mover() })
        game.onCollideDo(self, { objeto => self.chocarCon(objeto) })
    }

    method mover() {
        const siguiente = trayectoria.siguiente(position)

        if (tablero.dentro(siguiente)) {
            position = siguiente
        } else {
            self.destruir()
        }
    }

    method chocarCon(objeto) {
        if (activo and objeto.esBlancoDe(self.bando())) {
            objeto.recibirDaño()
            self.destruir()
        }
    }

    method destruir() {
        activo = false

        if (game.hasVisual(self)) {
            game.removeVisual(self)
        }
        game.removeTickEvent("moverProyectil" + self.identity())
    }

}

class ProyectilJugador inherits Proyectil {

    override method image() = "proyectilAzul.png"

    override method bando() = bandoJugador

    override method intervaloMovimiento() = 100

}

class ProyectilEnemigo inherits Proyectil {

    override method image() = "proyectilRojo.png"

    override method bando() = bandoEnemigo

    override method intervaloMovimiento() = 150

}

