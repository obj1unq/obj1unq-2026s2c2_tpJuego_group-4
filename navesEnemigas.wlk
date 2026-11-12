import wollok.game.*
import naveJugador.*
import generador.*
import proyectil.*
import direcciones.*


class Enemigo {

    var property position
    var property vida = self.vidaInicial()
    var property direccion = 1
    const property posicionInicial = game.at(5, 5)

    method image()

    method vidaInicial() 

    method puntosQueOtorga()

    method intervaloDisparo() 

    method intervaloMovimiento() = 300

    method trayectoriaDeDisparo() = abajo

    method posicionDeDisparo() = position.down(1)

    method bando() = bandoEnemigo

    method vida() = vida

    method esBlancoDe(bando) = bando.puedeHerirAEnemigos()
    
    method recibirDaño() {
        vida = vida - 1

        if (vida <= 0) {
            self.morir()
        }
    }

    method aparecer() {
        game.addVisual(self)
        self.iniciarMovimiento()
        self.iniciarDisparos()
    }

    method reiniciar() {
        position = posicionInicial
        vida = self.vidaInicial()
        direccion = 1
    }

    method morir() {
        jugador.sumarPuntos(self.puntosQueOtorga())
        self.retirarse()
    }

    method retirarse() {
        self.desaparecer()
        generador.liberar(self)
    }

    method desaparecer() {
        game.removeTickEvent("moverEnemigo" + self.identity())
        game.removeTickEvent("dispararEnemigo" + self.identity())

        if (game.hasVisual(self)) {
            game.removeVisual(self)
        }
        
    }


    method iniciarMovimiento() {
        game.onTick( self.intervaloMovimiento(), "moverEnemigo" + self.identity(), { self.mover() })    
    }

    method mover() {
        const siguienteX = position.x() + direccion

        if (siguienteX < 0 || siguienteX >= game.width()) {
            direccion = direccion * -1
        }

        position = game.at(
            position.x() + direccion,
            position.y()
        )
    }

    method iniciarDisparos(){
        game.onTick(self.intervaloDisparo(), "dispararEnemigo" + self.identity(), { self.disparar() }) 
    }

    method disparar() {
        const proyectil = new ProyectilEnemigo(
            position = self.posicionDeDisparo(),
            trayectoria = self.trayectoriaDeDisparo()
        )

        proyectil.lanzar()
    }

    //method x(self) = 1

}


class Tanque inherits Enemigo {

    override method image() = "enemigoTanque.png"

    override method vidaInicial() = 3

    override method puntosQueOtorga() = 100

    override method intervaloDisparo() = 10000

}

class Ligero inherits Enemigo {

    override method image() = "enemigoLigero.png"

    override method vidaInicial() = 1

    override method puntosQueOtorga() = 500

    override method intervaloDisparo() = 5000



}


class Jefe inherits Enemigo {

    override method image() = "enemigoJefe.png"

    override method vidaInicial() = 3

    override method puntosQueOtorga() = 1000   

    override method intervaloDisparo() = 5000

    override method trayectoriaDeDisparo() =
        new Trayectoria(
            origen = self.posicionDeDisparo(), destino = jugador.position()
            )

}


class Kamikaze inherits Enemigo {

    var lanzado = false
    var trayectoriaDePicada = null // mmm

    override method image() = "enemigoKamikaze.png"

    override method vidaInicial() = 2

    override method puntosQueOtorga() = 200

    override method intervaloDisparo() = 7000 

    override method intervaloMovimiento() = if (lanzado) 100 else 300

    method tiempoHastaLanzarse() = 3000.randomUpTo(6000).truncate(0)

    override method reiniciar() {
        super()
        lanzado = false
        trayectoriaDePicada = null
    }

    override method aparecer() {
        super()
        game.onCollideDo(self, { objeto => self.chocarCon(objeto) })
        game.schedule(self.tiempoHastaLanzarse(), { self.lanzarse() })
    }

    method lanzarse() {
        if (game.hasVisual(self) and not lanzado) {
            lanzado = true
            trayectoriaDePicada = new Trayectoria(origen = position, destino = jugador.position())
            game.removeTickEvent("moverEnemigo" + self.identity())
            self.iniciarMovimiento()
        }
    }

    override method mover() {
        if (lanzado) {
            self.avanzarEnPicada()
        } else {
            super()
        }
    }

    method avanzarEnPicada() {
        const siguiente = trayectoriaDePicada.siguiente(position)

        if (tablero.dentro(siguiente)) {
            position = siguiente
        } else {
            self.retirarse()
        }
    }

    method chocarCon(objeto) {
        if (game.hasVisual(self) and objeto.esBlancoDe(self.bando())) {
            objeto.recibirDaño()
            self.retirarse()
        }
    }

}

