import wollok.game.*
import contador.*
import mecanicas.*





class Nivel {
    method puntosParaGanar() = 0

    method configurarNivel() {
        const enemigosIniciales = self.enemigosPorNivel()
        mecanicas.iniciarPartida(enemigosIniciales)
    }

    method enemigosPorNivel()
}



class Nivel1 inherits Nivel {
    override method puntosParaGanar() = 125

    override method enemigosPorNivel() {

    }
}

class Nivel2 inherits Nivel {
    override method puntosParaGanar() = 500

    override method enemigosPorNivel() {
        
    }
}

class Nivel3 inherits Nivel {
    override method puntosParaGanar() = 999

    override method enemigosPorNivel() {
        
    }
}