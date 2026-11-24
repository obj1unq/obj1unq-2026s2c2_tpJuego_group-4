import wollok.game.*

object winWindow {
    method image() = "fondoWin.png"
    method position() = game.at(0,0)
}

object gameOverWindow {
    method image() = "fondoPerdedor.png"
    method position() = game.at(0,0)
}

object fondo {
    method image() = "fondo.png"
    method position() = game.at(0,0)
    method esBlancoDe(_bando) = false
}

object informacion {
    method image() = "info.png"
    method position() = game.at(0,0)
}

object inicio {
    method image() = "inicio.png"
    method position() = game.at(0,0)
}


// si se puede poner pantallas que explican un poco el juego al inicio, las instrucciones y controles

object pantallaCarga {

    var nivel = null
    
    method nivel() = nivel

    method aparecer(unNivel){
        nivel = unNivel
        if (not game.hasVisual(fondo)) {
            game.addVisual(fondo)
        }
        game.addVisual(ready)
        game.addVisual(puntosNivel)
        game.addVisual(danioNivel)
        game.schedule(5000, {self.ocultar()})
    }

    method ocultar(){
        game.removeVisual(ready)
        game.removeVisual(puntosNivel)
        game.removeVisual(danioNivel)
        nivel.configurarNivel()
    }
}

object ready {
    method position() = game.at(0,0)
    method image() = "ready.png"
}

object puntosNivel {
    method position() = game.at(3,4)
    method text() = "Puntos a obtener: " + pantallaCarga.nivel().puntosParaGanar()
    method textColor() = "#FFFF00FF"
}

object danioNivel {
    method position() = game.at(3,3)
    method text() = "Daño que causa una nave: " + pantallaCarga.nivel().danioDeNave() + " corazones"
    method textColor() = "#FFFF00FF"
}