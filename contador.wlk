import wollok.game.*
import naveJugador.*
import niveles.*




class ContadorDePuntaje {     // sirve para el score solamente, la vida se maneja mediante imágenes...
    const property position 



    method valorDelContador()

    method agregarAlJuego() {
        game.addVisual(new Unidad(contador = self))
        game.addVisual(new Decena(contador = self))
        game.addVisual(new Centena(contador = self))
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
    
    override method valor(valorQueRecibePorDecena) = (valorQueRecibePorDecena .div(10)) % 10

}

class Centena inherits Digito {
    override method offset() = 0

    override method valor(valorQueRecibePorCentena) = valorQueRecibePorCentena.div(100)
}









class ContadorDeVidas {      // son 5 vidas que tiene el jugador
    var cantVidasPorAhora = jugador.vidas()



    method agregarAJuego() {
        //game.addVisual(new Vida(position = game.at(0, 9)))
        //game.addVisual(new Vida(position = game.at(1, 9)))
        //game.addVisual(new Vida(position = game.at(2, 9)))
        //game.addVisual(new Vida(position = game.at(3, 9)))
        //game.addVisual(new Vida(position = game.at(4, 9)))
        const totalVidaDelJugador = 5
        var val = 0
        totalVidaDelJugador.times({
            game.addVisual(new Vida(position = game.at(val, 9)))
            val+=1
            })
    }
}


class Vida {     // al pasar de nivel no se reinicia, pero si cuando moris y reinicias el nivel
    //var property nivelEnElQueEsta = jugador.nivelEnElQueEsta()
    //const property puntosParaGanar = nivelEnElQueEsta.puntosParaGanar()
    var position 
    var property estado = corazonCompleto


    method image() = estado.image()

    method position(pos){    // ????
        position = pos
    }
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

object score {    // al pasar de nivel y al reiniciar el juego, el puntaje vuelve a 0
    //method text() = "PUNTAJE: " + jugador.puntos()+"/5000"          // cambiar acá si se modifica la meta para ganar

    method position() = game.at(6, 9)

    //method textColor() = "FFDE21"

    method agregarPuntos(ca) {
        
    }

    method name() {
        
    }
}

//object restartHint {
//    method text() = "R: REINICIAR"
//
//    method position() = game.at(5, 2)
//
//    method textColor() = "FFDE21"
//}
