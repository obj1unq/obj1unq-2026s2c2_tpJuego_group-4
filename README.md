# WALLAGA

    Wallaga es un videojuego inspirado en -Galaga- desarrollado en Wollok, utilizando la biblioteca de Wollok Game.

    El jugador controla una nave espacial que debe enfrentarse a diferentes tipos de enemigos y esquivar sus proyectiles mientras consigue puntos.

## Equipo de desarrollo

- Andrea G. Frank
- Lucas Asorey

## OBJETIVO/REGLAS

    Hay un total de 3 niveles en el juego y la nave del jugador debe ir obteniendo puntos para ir pasando a través de ellos, tratando de sobrevivir con 5 vidas durante el recorrido.

    ⚠ IMPORTANTE: al pasar por nivel, las vidas no se regeneran :( , por lo que deberás cuidar tus corazones...

    Dichos puntos se obtienen al ir disparando y matando a todas las diferentes naves que tiene cada nivel, y para pasar de nivel se requieren los siguientes puntos:
        -Nivel 1:  125pts en donde cada nave ligera te otorga 25pts  ➤  naves por matar: 5
        -Nivel 2:  500pts en donde cada nave kamikaze te otorga 100pts  ➤  naves por matar: 5
        -Nivel 3:  999pts en donde la nave jefe te otorga 999pts  ➤  naves por matar: 1
        
    Cada vez que recibe un impacto, dependiendo la nave es el total de corazones que pierde

--

    El juego cuenta con 2 finales: 
    - El jugador pierde todas sus vidas → Game Over (con posibilidad de reinicar desde el nivel 1)
    - El jugador logra  eliminar la nave Jefe → Victoria





## NAVES:
### *Ligera*
    Tiene 1 vida
    Dispara cada 5 segundos y su daño equivale a medio corazón


### *Kamikaze*
    Tiene 2 vidas
    Dispara cada 7 segundos
    En un momento aleatorio se lanza a sí mismo hacia el jugador, quitándole 1 corazón

### *Jefe*
    Tiene 3 vidas
    Dispara cada 5 segundos
    Dispara proyectiles guiados al jugador y su daño equivale al total de vidas que tenga el jugador (insta kill)


## CONTROLES

    Teclas:
    W = Mover hacia arriba
    A = Mover hacia la izquierda
    S = Mover hacia abajo
    D = Mover hacia la derecha

    ESPACIO = Disparar

    R = Reiniciar la partida después de perder

## Otros

- Comision 2, Universidad Nacional de Quilmes
- Versión de wollok: 4.2.3
- Una vez terminado, no tenemos problemas en que el repositorio sea público
