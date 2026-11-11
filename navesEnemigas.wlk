import wollok.game.*
import naveJugador.*
import generador.*



/*
    cambiar:
-metodos en las clases padre (generalizar +) en las naves enemigas y generador.wlk
-imagenes para el score y la vida
-diferentes tipos de comportamientos para las naves (nave kamikaze)
-cambiar de puntaje--->niveles, por ejemplo:
    -lvl1: naves simples/ligeras
    -lvl2: naves tanque/kamikaze/etc...
    -lvl3: nave jefe (imagen mas grande, no tanto xq el hitbox puede perjudicar)
-no duplicar código
*/




class Enemigo {

    var property position
    var property vida = 3
    var property direccion = 1
    const property posicionInicial = game.at(5, 5)

    method image()

    method aparecer() {
        game.addVisual(self)
        self.iniciarMovimiento()
    }

    method reiniciar() {
        position = posicionInicial
        vida = 3
        direccion = 1
    }

    method recibirDaño() {
        vida = vida - 1

        if (vida <= 0) {
            self.morir()
        }
    }

    method puntosQueOtorga()

    method morir() {
        jugador.sumarPuntos(self.puntosQueOtorga())
        self.desaparecer()
        self.liberarCupo()
    }

    method liberarCupo()

    method desaparecer() {
        game.removeTickEvent("moverEnemigo" + self.identity())
        game.removeTickEvent("dispararEnemigo" + self.identity())

        if (game.hasVisual(self)) {
            game.removeVisual(self)
        }
    }



    method iniciarMovimiento() {
        game.onTick( 300, "moverEnemigo" + self.identity(), { self.mover() })

        self.iniciarDisparos()
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
        game.onTick(self.valor(), "dispararEnemigo" + self.identity(), { self.disparar() })   //idem los otros
    }

    method disparar() {
        const proyectil = new ProyectilEnemigo(position = self.position().down(1))

        game.addVisual(proyectil)
        proyectil.iniciarMovimiento()
    }

    //method x(self) = 1

    method valor() = 0   // cambiar nombre

}


class Tanque inherits Enemigo {

    override method image() = "enemigoTanque.png"

    override method puntosQueOtorga() = 2000

    override method valor() = 10000

    override method x() {
        
    }

    override method liberarCupo() {
        generador.liberarTanque(self)
    }

}



class Ligero inherits Tanque {

    override method image() = "enemigoLigero.png"

    override method puntosQueOtorga() = 1000

    override method reiniciar() {
        position = posicionInicial
        vida = 1
        direccion = 1
    }

    override method iniciarDisparos() {
        game.onTick(5000, "dispararEnemigo" + self.identity(), { self.disparar() }
        )
    }

    override method liberarCupo() {
        generador.liberarLigero(self)
    }

}


class Jefe inherits Enemigo {

    override method image() = "enemigoJefe.png"

    override method puntosQueOtorga() = 5000

    override method iniciarDisparos() {
        game.onTick(10000, "dispararEnemigo" + self.identity(), { self.disparar() } )
    }

    method disparar() {
        const proyectil = new ProyectilEnemigo(
            position = self.position().down(1)
        )

        game.addVisual(proyectil)
        proyectil.iniciarMovimiento()
    }

    override method liberarCupo() {
        generador.liberarJefe(self)
    }

}


