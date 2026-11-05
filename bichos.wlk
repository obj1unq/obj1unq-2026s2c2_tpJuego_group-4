import personaje.*
import wollok.game.*
import direcciones.*
import pantallas.*

class Bicho {

    var property position = game.center()

    method image(){
        return "araña.png"
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

class Robot inherits Bicho {

    override method image(){
        return "robot.png"
    }

    method dispararAlPersonaje(){
        const proyectil = new Proyectil(
            position = position,
            destino = game.at(personaje.position().x(), personaje.position().y())
        )
        game.addVisual(proyectil)
        proyectil.iniciar()
    }

}

class Proyectil {

    var property position
    const destino

    method image(){
        return "proyectil.png"
    }

    method iniciar(){
        game.onTick(100, "proyectil" + self.identity(), { self.avanzar() })
    }

    method avanzar(){
        const x = self.calcularNuevaX(destino.x(), position.x())
        const y = self.calcularNuevaY(destino.y(), position.y())

        position = game.at(x, y)

        if (position == destino) {
            self.impactar()
        }
    }

    method impactar(){
        
        self.desaparecer()
        if (personaje.position() == destino) {
            gameOver.activar()
        }
    }

    method desaparecer(){
        game.removeTickEvent("proyectil" + self.identity())
        game.removeVisual(self)
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

}