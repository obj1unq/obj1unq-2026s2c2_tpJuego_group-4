import wollok.game.*



object winWindow {
    method position() = game.at(2,2)
    method image() = "fondoWin.png"
}

object gameOverWindow {
    method position() = game.at(2,2)
    method image() = "fondoPerdedor.png"
}



// si se puede poner pantallas que explican un poco el juego al inicio, las instrucciones y controles
object otrasPantallas {
    
}

object pantallaCarga {

    var nivel = null
    
    method nivel() = nivel

    method aparecer(unNivel){
        nivel = unNivel
        game.addVisual(ready)
        game.addVisual(puntosNivel)
        game.schedule(2500, {self.ocultar()})
    }

    method ocultar(){
        game.removeVisual(ready)
        game.removeVisual(puntosNivel)
        nivel.configurarNivel()
    }
}

object ready {
    method position() = game.at(2,4)
    method image() = "ready.png"
}

object puntosNivel {
    method position() = game.at(3,4)
    method text() = "Puntos Necesarios: " + pantallaCarga.nivel().puntosParaGanar()
    method textColor() = "#FFFF00FF"
}