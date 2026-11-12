import game.*


object tablero {
    method validarDentro(position) {
        if (not self.dentro(position)) {
            self.error(position.toString() + " no está dentro del tablero ")
        }
    }

    method dentro(position) {
        return position.x().between(0, game.width() -1) and position.y().between(0, game.height() -1 )
    }
}

object arriba {
    method puedeMoverDesde(position, limiteY, _limiteX) = position.y() < limiteY

    method siguiente(position) {
        const nueva = position.up(1) 
        tablero.validarDentro(nueva)
        return nueva
    }
}


object abajo {
    method puedeMoverDesde(position, _limiteY, _limiteX) = position.y() > 0

    method siguiente(position) {
        const nueva = position.down(1) 
        tablero.validarDentro(nueva)
        return nueva
    }
}

object derecha {
    method puedeMoverDesde(position, _limiteY, limiteX) = position.x() < limiteX

    method siguiente(position) {
        const nueva = position.right(1) 
        tablero.validarDentro(nueva)
        return nueva
    }
}

object izquierda{
    method puedeMoverDesde(position, _limiteY, _limiteX) = position.x() > 0

    method siguiente(position) {
        const nueva = position.left(1) 
        tablero.validarDentro(nueva)
        return nueva
    }
}

class Trayectoria {

    const origen
    const destino

    method longitud() =
        (destino.x() - origen.x()).abs().max((destino.y() - origen.y()).abs())

    method siguiente(position) {
        const pasoActual = (position.x() - origen.x()).abs().max((position.y() - origen.y()).abs()) + 1
        const avance = pasoActual / self.longitud()

        return game.at(
            origen.x() + ((destino.x() - origen.x()) * avance).round(),
            origen.y() + ((destino.y() - origen.y()) * avance).round()
        )
    }

}