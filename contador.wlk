import wollok.game.*
import naveJugador.*
import niveles.*




class ContadorDePuntaje {     // sirve para el score solamente, la vida se maneja mediante imágenes
    const property position 
    var valor = 0

    method valorDelContador() = valor

    method agregarAlJuego() {
        game.addVisual(new Unidad(contador = self))
        game.addVisual(new Decena(contador = self))
        game.addVisual(new Centena(contador = self))
    }

    method agregarPuntos(cantidad) {
        valor += cantidad
    }

    method reiniciar() {
        valor = 0
    }
}

class Digito {
    const contador 

    method image() = self.valor(contador.valorDelContador()).toString()+".png"

    method valor(valorDelCont)

    method position() = contador.position().right(self.offset())

    method offset() 
}

class Unidad inherits Digito{
    override method offset() = 2

    override method valor(valorQueRecibePorUnidad) = valorQueRecibePorUnidad % 10 // resto de la unidad
}

class Decena inherits Digito {
    override method offset() = 1
    
    override method valor(valorQueRecibePorDecena) = (valorQueRecibePorDecena.div(10)) % 10

}

class Centena inherits Digito {
    override method offset() = 0

    override method valor(valorQueRecibePorCentena) = valorQueRecibePorCentena.div(100) % 10
}

class ContadorDeVidas {
    const corazones = [
        new Vida(position = game.at(0, 9)),
        new Vida(position = game.at(1, 9)),
        new Vida(position = game.at(2, 9)),
        new Vida(position = game.at(3, 9)),
        new Vida(position = game.at(4, 9))
    ]

    method agregarAJuego() {
        corazones.forEach{ corazon => game.addVisual(corazon) }
        self.actualizar(jugador.vidaEnMedios())
    }

    method actualizar(vidaEnMedios) {
        var indice = 0
        corazones.forEach{ corazon =>
            const vidaDelCorazon = vidaEnMedios - (indice * 2)
            if (vidaDelCorazon >= 2) {
                corazon.estado(corazonCompleto)
            } else if (vidaDelCorazon == 1) {
                corazon.estado(medioCorazon)
            } else {
                corazon.estado(corazonVacio)
            }
            indice += 1
        }
    }

    method imagenDelCorazon(indice) = corazones.get(indice).image()
}

class Vida {
    var property position
    var property estado = corazonCompleto

    method image() = estado.image()
}

// ESTADOS DEL CORAZON
object corazonCompleto {
    method image() = "coraCompleto.png"
}

object medioCorazon {
    method image() = "medioCora.png"
}

object corazonVacio {
    method image() = "sinCora.png"
}
//

//object contadorVida {
//    var property nivelEnElQueEsta = Nivel1



    //method position() = game.at(1, 9)

    //method text() = "x" + jugador.vidas().max(0)  // Ex.: x3 +o x0 (el jugador murió)

    //method textColor() = "FFDE21"
//}

object score {
    const contador = new ContadorDePuntaje(position = game.at(6, 9))

    method valorActual() = contador.valorDelContador()

    method agregarAlJuego() {
        contador.agregarAlJuego()
    }

    method agregarPuntos(cantidad) {
        contador.agregarPuntos(cantidad)
    }

    method reiniciar() {
        contador.reiniciar()
    }
}

object contadorDeVidas {
    const contador = new ContadorDeVidas()

    method agregarAJuego() {
        contador.agregarAJuego()
    }

    method actualizar(vidaEnMedios) {
        contador.actualizar(vidaEnMedios)
    }

    method imagenDelCorazon(indice) = contador.imagenDelCorazon(indice)
}
