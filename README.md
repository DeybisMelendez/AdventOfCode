# Advent of Code - Soluciones 

Este repositorio contiene mis soluciones a los retos de [Advent of Code](https://adventofcode.com), una serie de desafíos de programación diarios que se publican cada diciembre. Es un ejemplo de mi habilidad para resolver problemas algorítmicos y trabajar con lenguajes de programación como **Lua** y **LuaJIT**.

## Descripción del Proyecto

El proyecto está diseñado principalmente para ejecutarse con **LuaJIT**, pero en algunos casos se utiliza **Lua 5.4** debido a la necesidad de soporte para operadores binarios que no están disponibles en LuaJIT. Cada solución está estructurada para ser clara, eficiente y fácil de entender, destacando mi capacidad para implementar soluciones en diferentes entornos de desarrollo.

### Motivación

Este repositorio no solo refleja mi pasión por la programación y la resolución de problemas, sino que también demuestra mi habilidad para aprender y aplicar nuevas técnicas mientras trabajo en proyectos desafiantes. Es un componente clave que utilizo para destacar mi experiencia en desarrollo y algoritmos.

## Cómo Ejecutar

Para ejecutar una solución, utiliza **LuaJIT** o **Lua** y proporciona como argumento el año (`YYYY`) y el día (`DD`) del reto que deseas resolver. Actualmente, esta funcionalidad está implementada únicamente para los retos del año 2015. Los demás años se pueden ejecutar individualmente.

Es necesario colocar el puzzle input del ejercicio en un `input.txt` ubicado en la raíz del proyecto.

### Ejecución con LuaJIT

```shell
luajit main.lua [[YYYY.DD]]
```

### Ejecución con Lua

```shell
lua main.lua [[YYYY.DD]]
```

## Organización del Repositorio

El repositorio está estructurado de la siguiente manera:

- **`main.lua`**: Script principal que coordina la ejecución de los retos.
- **`/YYYY/DD`**: Carpeta que contiene las soluciones para los retos de cada año, organizadas por día.
- **`/lib`**: Librerías de soporte y utilidades comunes para resolver los retos.

## Tecnologías Utilizadas

- **Lua** (5.4)
- **LuaJIT**

## Próximos Pasos

Planeo expandir este proyecto agregando soluciones de más años y optimizando las soluciones existentes para mejorar su rendimiento y legibilidad.

---

Si tienes alguna sugerencia o quieres colaborar, no dudes en crear un issue o un pull request. ¡Me encantaría recibir tu retroalimentación!