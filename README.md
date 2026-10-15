# EscapAlien

## Equipo de desarrollo

- Andrea G. Frank
- Lucas Asorey
- Alejandro Barros

## Capturas

![Uploading imagen.png…](https://areajugones.sport.es/wp-content/uploads/2026/08/resonance-screenshot-4k-08.jpg.webp)


## Reglas de Juego / Instrucciones

# README SUJETO A CAMBIOS...   <---------------------(quitar esto cuando ya esté todo ok/definido)
## OBJETIVO
    Ir cruzando cada una de las salas y sus dificultades, tratando de salir de la nave usando una cápsula de escape sin morir en el intento.

## INSTRUCCIONES
### Sala 1°:
    Objetivo: Recorre la sala buscando y encontrando 3 barras de energía (cambiar a nombre si luego tendrá) para poder abrir la puerta hacia la 2° sala de la nave.
    Dificultad: Mantén la linterna prendida en todo momento recargándola con la tecla 'R', ya que en la oscuridad se encuentran bichos que podrían atacarte facilmente.

#### Estado de la recolección
- Con **B**, buscá en un montículo cercano. Cada montículo se puede revisar una sola vez.
- Hay cinco montículos: tres tienen una barra y dos están vacíos. Buscar en uno vacío no suma barras.
- El inventario cambia de imagen según la cantidad: `inventario.png` (0), `inventario1.png` (1), `inventario2.png` (2) e `inventario3.png` (3).
- La mochila queda para las pruebas; el juego usa un contador separado para las barras encontradas.

#### Pendiente en Sala 1
- Implementar la recarga de la linterna con **R** y conectar la entrega de las tres barras con la apertura de la puerta.
- Activar los bichos y definir qué ocurre cuando alcanzan al personaje.

### Sala 2°:
    Objetivo: Agarrá un papel con extraños símbolos e ilumina con la linterna hacia las piedras que hay por toda la sala, algunas pueden tener inscripciones que te ayudarán a armar un código que se usa en la puerta para salir de la sala.
    Dificultad: Tratar de armar el código para la puerta siguiendo los patrones de la hoja (agregarle símbolos difíciles o que haya un timer para apurar el trámite...)

### Sala 3°: ???
    (posbible boss fight contra un alien/depredador???)


### Cosas a agregar:
    -Sonidos para la luz parpadeando
    -Sonidos de bichos cuando se apague la luz
    -Inventario con diferentes assets cuando agarre cosas
    - que un personaje aparece en X posición viendo visualmente todo (las posiciones de las cosas, la puerta, etc) y que después de unos segundos la luz empieza a parpadear hasta apagarse. El problema es que todo tiene un comportamiento cuando la luz se apaga y se prende
    -Cambiar todos los detalles de las imagenes, es decir, inventario con/sin linterna, inv con/sin linterna + barras (diferentes cant de barras)    
    --Solucion para evitar todo el quilobo de assets? Obligar al pj (a quien juega) a que agarre la linterna, y la cant de assets con/sin linterna se reduciría :)
    -Diferentes variantes para los monticulos con y sin barras, es decir: Monticulo sin tocar -> personaje.buscar() -> Monticulo afectado por la busqueda + barra visible -> Monticulo afectado por la busqueda - barra    
    --Lo de arriba es mucho assets, Solucion: que el pj diga que encontró algo y ya esta, la cant de imagenes se reduciría a Monticulo sin tocar -> Monticulo afectado por busqueda (afectado es: cajon - cajon abierto,
                                                                                    chatarra - chatarra movida,
                                                                                    escombros - escombros movidos,
                                                                                    etc.)

## Otros

- Comision 2 , Universidad nacional de Quilmes
- Versión de wollok 4.2.3
- Una vez terminado, no tenemos problemas en que el repositorio sea público 
