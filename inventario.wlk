import wollok.game.*
import personaje.personaje



object inventario {
    var property image = "inventario.png"     // var xq dsp va a ir cambiando mediante el pj agarre cosas y las suelte (soltar = colocar barras en puerta)
    const property position = game.at(0,7)     //calcular en donde queda justo al medio :p

    method agregarse() {
        game.addVisual(self)
        (0..4).forEach({pos => game.addVisual(new CeldaDeInventario(indiceEnMochila=pos))})
    }

}

class CeldaDeInventario {
  
  const indiceEnMochila

  method position() {
    return inventario.position().right(indiceEnMochila)
  }

  method image() {
    const elemento = personaje.elementoEnMochila(indiceEnMochila)
    return if (elemento != null) elemento.image() else "panel.png" 
  }

}
