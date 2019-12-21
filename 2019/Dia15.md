--- Día 15: Sistema de oxígeno ---
Aquí en el espacio profundo, muchas cosas pueden salir mal. Afortunadamente, muchas de esas cosas tienen luces indicadoras . Desafortunadamente, una de esas luces está encendida: ¡el sistema de oxígeno para parte de la nave ha fallado!

Según las lecturas, el sistema de oxígeno debe haber fallado hace días después de una ruptura en el tanque de oxígeno dos; esa sección de la nave se selló automáticamente una vez que los niveles de oxígeno disminuyeron peligrosamente. Un único droide de reparación operado de forma remota es su única opción para reparar el sistema de oxígeno.

El paquete de atención de los Elfos incluía un programa Intcode (su entrada de rompecabezas) que puede usar para controlar de forma remota el droide de reparación. Al ejecutar ese programa, puede dirigir el droide de reparación al sistema de oxígeno y solucionar el problema.

El programa de control remoto ejecuta los siguientes pasos en un bucle para siempre:

Acepte un comando de movimiento mediante una instrucción de entrada.
Envía el comando de movimiento al droide de reparación.
Espera a que el droide de reparación termine la operación de movimiento.
Informe sobre el estado del droide de reparación a través de una instrucción de salida.
Solo se comprenden cuatro comandos de movimiento : norte ( 1), sur ( 2), oeste ( 3) y este ( 4). Cualquier otro comando no es válido. Los movimientos difieren en la dirección, pero no en la distancia: en un pasillo este-oeste lo suficientemente largo, una serie de comandos como 4,4,4,4,3,3,3,3dejarían al droide de reparación donde comenzó.

El droide de reparación puede responder con cualquiera de los siguientes códigos de estado :

0: El droide de reparación golpeó una pared. Su posición no ha cambiado.
1: El droide de reparación se ha movido un paso en la dirección solicitada.
2: El droide de reparación se ha movido un paso en la dirección solicitada; Su nueva posición es la ubicación del sistema de oxígeno.
No sabes nada sobre el área alrededor del droide de reparación, pero puedes resolverlo mirando los códigos de estado.

Por ejemplo, podemos dibujar el área usando Dpara el droide, #para paredes, .para ubicaciones que el droide puede atravesar, y espacio vacío para ubicaciones no exploradas. Entonces, el estado inicial se ve así:

      
      
   D  
      
      
Para hacer que el droide vaya al norte, envíalo 1. Si responde con 0, sabes que la ubicación es un muro y que el droide no se movió:

      
   #  
   D  
      
      
Para moverse hacia el este, envíe 4; una respuesta de 1significa que el movimiento fue exitoso:

      
   #  
   .D 
      
      
Entonces, tal vez los intentos de moverse hacia el norte ( 1), sur ( 2) y este ( 4) reciban respuestas de 0:

      
   ## 
   .D#
    # 
      
Ahora, sabes que el droide de reparación está en un callejón sin salida. Retroceda con 3(que ya sabe que recibirá una respuesta 1porque ya sabe que la ubicación está abierta):

      
   ## 
   D.#
    # 
      
Entonces, quizás west ( 3) obtenga una respuesta de 0, south ( 2) obtenga una respuesta de 1, south nuevamente ( 2) obtenga una respuesta de 0, y luego west ( 3) obtenga una respuesta de 2:

      
   ## 
  #..#
  D.# 
   #  
Ahora, debido a la respuesta de 2, ¡sabes que has encontrado el sistema de oxígeno ! En este ejemplo, solo 2se alejó de la posición inicial del droide de reparación.

¿Cuál es el menor número de comandos de movimiento necesarios para mover el droide de reparación desde su posición inicial a la ubicación del sistema de oxígeno?

--- La segunda parte ---
Reparas rápidamente el sistema de oxígeno; El oxígeno llena gradualmente el área.

El oxígeno comienza en la ubicación que contiene el sistema de oxígeno reparado. El oxígeno tarda un minuto en extenderse a todas las ubicaciones abiertas adyacentes a una ubicación que ya contiene oxígeno. Las ubicaciones diagonales no son adyacentes.

En el ejemplo anterior, suponga que ha usado el droide para explorar el área por completo y tiene el siguiente mapa (donde están marcadas las ubicaciones que actualmente contienen oxígeno O):

 ##   
#..## 
#.#..#
#.O.# 
 ###  
Inicialmente, la única ubicación que contiene oxígeno es la ubicación del sistema de oxígeno reparado. Sin embargo, después de un minuto, el oxígeno se propaga a todas las .ubicaciones abiertas ( ) adyacentes a una ubicación que contiene oxígeno:

 ##   
#..## 
#.#..#
#OOO# 
 ###  
Después de un total de dos minutos, el mapa se ve así:

 ##   
#..## 
#O#O.#
#OOO# 
 ###  
Después de un total de tres minutos:

 ##   
#O.## 
#O#OO#
#OOO# 
 ###  
Y finalmente, toda la región está llena de oxígeno después de un total de cuatro minutos:

 ##   
#OO## 
#O#OO#
#OOO# 
 ###  
Entonces, en este ejemplo, todas las ubicaciones contienen oxígeno después de 4minutos.

Usa el droide de reparación para obtener un mapa completo del área. ¿Cuántos minutos tardará en llenarse de oxígeno?