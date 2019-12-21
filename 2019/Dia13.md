--- Día 13: Paquete de atención ---
A medida que reflexiona sobre la soledad del espacio y el viaje de ida y vuelta cada vez mayor de tres horas para los mensajes entre usted y la Tierra, observa que la luz indicadora del correo espacial está parpadeando. Para ayudarlo a mantenerse sano, los Elfos le han enviado un paquete de atención.

¡Es un nuevo juego para el gabinete arcade del barco ! Por desgracia, la sala de juegos es todo el camino en el otro extremo de la nave. Seguramente, no será difícil construir el suyo, el paquete de cuidado incluso viene con esquemas.

El gabinete de arcade ejecuta el software Intcode como el juego que enviaron los Elfos (su entrada de rompecabezas). Tiene una pantalla primitiva capaz de dibujar mosaicos cuadrados en una cuadrícula. El software dibuja mosaicos en la pantalla con instrucciones de salida: cada tres instrucciones de salida especifican la posición x (distancia desde la izquierda), posición y (distancia desde la parte superior) y tile id. El tile id se interpreta de la siguiente manera:

0Es un azulejo vacío . Ningún objeto del juego aparece en este mosaico.
1Es un azulejo de la pared . Los muros son barreras indestructibles.
2Es un bloque de azulejos. La pelota puede romper los bloques.
3es un azulejo de paleta horizontal . La pala es indestructible.
4Es una bola de baldosas. La pelota se mueve en diagonal y rebota en los objetos.
Por ejemplo, una secuencia de valores de salida como 1,2,3,6,5,4dibujaría un mosaico de paleta horizontal ( 1 mosaico desde la izquierda y 2 mosaicos desde la parte superior) y un mosaico de bolas ( 6 mosaicos desde la izquierda y 5 mosaicos desde la parte superior).

Empieza el juego. ¿Cuántos bloques hay en la pantalla cuando sale el juego?

--- La segunda parte ---
El juego no se ejecutó porque no invirtió en cuartos. Lamentablemente, no trajiste ningún cuarto . La dirección de memoria 0 representa el número de trimestres que se han insertado; configúralo 2 para jugar gratis.

El gabinete de arcade tiene un joystick que puede moverse hacia la izquierda y hacia la derecha. El software lee la posición del joystick con instrucciones de entrada:

Si el joystick está en la posición neutral , proporcione 0.
Si el joystick está inclinado hacia la izquierda , proporcione -1.
Si el joystick está inclinado hacia la derecha , proporcione 1.
El gabinete de arcade también tiene una pantalla de segmento capaz de mostrar un solo número que representa la puntuación actual del jugador. Cuando se especifican tres instrucciones de salida X=-1, Y=0, la tercera instrucción de salida no es un mosaico; el valor, en cambio, especifica la nueva puntuación para mostrar en la visualización del segmento. Por ejemplo, una secuencia de valores de salida como -1,0,12345aparecería 12345como la puntuación actual del jugador.

Completa el juego rompiendo todos los bloques. ¿Cuál es su puntaje después de que se rompe el último bloque?

--- La segunda parte ---
Después de recolectar ORE durante un tiempo, verifica su bodega de carga: 1 billón ( 1000000000000 ) de unidades de ORE.

Con tanto mineral , dados los ejemplos anteriores:

El 13312 ORE-por- FUELejemplo podría producir 82892753 FUEL .
El 180697, OREpor FUELejemplo, podría producir 5586022 FUEL .
El 2210736, OREpor FUELejemplo, podría producir 460664 FUEL .
Dado 1 billón ORE, ¿cuál es la cantidad máxima FUELque puede producir?