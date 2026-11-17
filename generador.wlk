import wollok.game.*
import navesEnemigas.*

class Fabrica {

    const maximo
    const crear
    const vivos = []

    method generar(posicion) {
        if (vivos.size() < maximo) {
            const enemigo = crear.apply(posicion)

            vivos.add(enemigo)
            enemigo.aparecer()
        }
    }

    method liberar(enemigo) {
        vivos.remove(enemigo)
    }

    method reiniciar() {
        vivos.clear()
    }

}

object generador {

    const fabricas = [
        new Fabrica(maximo = 1, crear = { posicion => new Ligero(position = posicion) }),
        new Fabrica(maximo = 1, crear = { posicion => new Tanque(position = posicion) }),
        new Fabrica(maximo = 1, crear = { posicion => new Kamikaze(position = posicion) }),
        new Fabrica(maximo = 1, crear = { posicion => new Jefe(position = posicion) })
    ]

    method iniciar() {
        game.onTick(2000, "generarEnemigos", { self.generarEnemigos() })
    }

    method generarEnemigos() {
        fabricas.forEach({ fabrica => fabrica.generar(self.posicionAleatoria()) })
    }

    method posicionAleatoria() {
        const x = 0.randomUpTo(game.width()).truncate(0)
        const y = 5.randomUpTo(game.height() - 1).truncate(0)

        return game.at(x, y)
    }

    method liberar(enemigo) {
        fabricas.forEach({ fabrica => fabrica.liberar(enemigo) }) // recorre muchas veces?
    }

    method reiniciar() {
        fabricas.forEach({ fabrica => fabrica.reiniciar() })
    }

}
