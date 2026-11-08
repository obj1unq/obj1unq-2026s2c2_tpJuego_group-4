import wollok.game.*
import navesEnemigas.*
import juego.*

object generador {

    const maxLigero = 1
    const maxTanque = 1
    const maxJefe = 1

    var ligeros = []
    var tanques = []
    var jefes = []

    method iniciar() { 
        game.onTick(2000, "generarEnemigos", {self.generarEnemigos()})
    }

    method generarEnemigos() {
        self.generarLigero()
        self.generarTanque()
        self.generarJefe()
    }

    method generarLigero() {
        if (ligeros.size() < maxLigero) {
            const enemigo = new Ligero(position = self.posicionAleatoria())

            ligeros.add(enemigo)
            enemigo.aparecer()
        }
    }

    method generarTanque() {
        if (tanques.size() < maxTanque) {
            const enemigo = new Tanque(position = self.posicionAleatoria())

            tanques.add(enemigo)
            enemigo.aparecer()
        }
    }

    method generarJefe() {
        if (jefes.size() < maxJefe) {
            const enemigo = new Jefe(position = self.posicionAleatoria())

            jefes.add(enemigo)
            enemigo.aparecer()
        }
    }

    method posicionAleatoria() {
        const x = 0.randomUpTo(game.width()).truncate(0)
        const y = 5.randomUpTo(game.height()-1).truncate(0)

        return game.at(x, y)
    }

    method liberarLigero(enemigo) {
        ligeros.remove(enemigo)
    }

    method liberarTanque(enemigo) {
        tanques.remove(enemigo)
    }

    method liberarJefe(enemigo) {
        jefes.remove(enemigo)
    }

    method reiniciar() {
        ligeros = []
        tanques = []
        jefes = []
    }

}