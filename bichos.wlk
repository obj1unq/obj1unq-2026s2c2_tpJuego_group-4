import personaje.*
import wollok.game.*
import direcciones.*
import pantallas.*

class Bicho {

    var property position = game.center()

    method image(){
        return "bicho.png"
    }

    method seguirPJ(){

        const x = self.calcularNuevaX(personaje.position().x(), position.x())
        const y = self.calcularNuevaY(personaje.position().y(), position.y())

        position = game.at(x,y)

        if (self.alcanzoAlPersonaje()) {
            gameOver.activar()
        }

    }

    method calcularNuevaX(x1, x2){ 
        return 
            if((x1 - x2) > 0) (x2 + 1)
            else if ((x1 - x2) < 0) (x2 - 1)
                 else x2 
    }

    method calcularNuevaY(y1, y2){ 
        return 
            if((y1 - y2) > 0) (y2 + 1)
            else if ((y1 - y2) < 0) (y2 - 1)
                 else y2 
    }

    method alcanzoAlPersonaje(){
        return position == personaje.position()
    }

}