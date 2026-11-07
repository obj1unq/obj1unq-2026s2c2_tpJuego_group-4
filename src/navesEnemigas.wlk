import wollok.game.*
import naveJugador.*

class Enemigo {

    var property position 
    var property vida = 3
    var property direccion = 1
    
    method image()
    
    method aparecer() {
        game.addVisual(self)
        self.iniciarMovimiento()
    }

    method recibirDaño() {
        vida = vida - 1
        if (vida <= 0) {
            self.morir()
        }
    }

    

    method puntosQueOtorga() 

    method morir() {
        jugador.puntos(jugador.puntos() + self.puntosQueOtorga())
        self.desaparecer()
    }

    method desaparecer() {
        if (game.hasVisual(self)) {
            game.removeVisual(self)
        }
    }

    method iniciarMovimiento() {
        game.onTick(300, "moverEnemigo" + self.identity(), {self.mover()})
        self.iniciarDisparos()
    }

    method mover() {
        const siguienteX = position.x() + direccion
        
        if (siguienteX < 0 || siguienteX >= game.width()) {
            direccion = direccion * -1
        }
        
        position = game.at(position.x() + direccion, position.y())
    }

    method iniciarDisparos()

}

// TIPO 1: Tanque 
class Tanque inherits Enemigo {

    override method image() = "enemigoTanque.png"

    override method puntosQueOtorga() = 2000

    override method iniciarDisparos() {
        game.onTick(10000, "dispararTanque" + self.identity(), {self.disparar()})
    }

    method disparar() {
        const proyectil = new ProyectilEnemigo(position = self.position().down(1))
        game.addVisual(proyectil)
        proyectil.iniciarMovimiento()
    }

}

class ProyectilEnemigo {
    var property position
    
    method image() = "proyectilRojo.png"

    method iniciarMovimiento() {
        game.onTick(150, "moverProyectilEnemigo" + self.identity(), { self.mover() })
    }

    method mover() {
        if (position.y() <= 0) {
            self.destruir()
        } else {
            position = position.down(1)
        }
    }

    method destruir() {
        game.removeTickEvent("moverProyectilEnemigo" + self.identity())
        if (game.hasVisual(self)) {
            game.removeVisual(self)
        }
    }

    method chocarConJugador() {
        jugador.recibirDaño()
        self.destruir()
    }

}

