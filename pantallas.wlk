import wollok.game.*



//  cambiar tamaños de las imágenes para que encajen bien (o buscar otras...)
object pantallaGE {     // Good Ending
    const property image = "pantallaWin.jpg"
    const property position = game.at(0, 0)
}

object pantallaBE {        // Bad Ending
    const property image = "pantallaLose.jpg"
    const property position = game.at(0, 0)
}

object gameOver {       
    method activar() {
        game.clear()
        game.addVisual(pantallaBE)
    }
}