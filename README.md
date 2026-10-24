# Sistema de reclamos de la municipalidad

Trabajo práctico de Gestión de Base de Datos. El sistema usa una base relacional (MySQL) y una base documental (MongoDB) que trabajan juntas.

## Contenido del repositorio

- `diagrama.drawio`: diagrama entidad-relación de la base relacional
- `script.sql`: script de creación de la base relacional
- `documental_estructuras_y_ejemplos.json`: ejemplos de las colecciones de la base documental

## Explicación

Pensé la solución separando la información que siempre tiene la misma forma de la que cambia.

Lo fijo va en la base relacional (MySQL): ciudadanos, empleados, equipos, categorías, reclamos e intervenciones. Ahí están los estados, las fechas y las relaciones, y por eso es la base que sirve para las estadísticas (cantidad de reclamos por categoría, por empleado y tiempos de resolución). Para el estado usé un CHECK en la tabla reclamo en vez de crear otra tabla, así hay menos tablas.

Lo que cambia según el caso va en MongoDB. Un reclamo de pérdida de agua tiene el tipo de cañería y uno de luminaria tiene el número de poste, y en una tabla eso quedaría con muchas columnas vacías. Por eso guardo en documentos los datos específicos, las fotos y las observaciones de los empleados.

Las dos bases se conectan con el id del reclamo y el id de la intervención, que se guardan también en los documentos. Para ver el historial completo de un reclamo, se buscan sus intervenciones en MySQL y después se traen los documentos de MongoDB con esos mismos ids.

## Cómo funciona todo junto

Las tablas se van completando a medida que avanza un reclamo, de principio a fin:

1. El ciudadano se registra y se crea una fila en `ciudadano`.
2. Hace un reclamo: se crea una fila en `reclamo` con su `id_ciudadano`, la `id_categoria` y el estado en "pendiente".
3. Un empleado municipal lo asigna a un equipo: se completa `id_equipo` y el estado pasa a "en proceso".
4. Los empleados de ese equipo trabajan: cada visita es una fila en `intervencion`, con el `id_reclamo` y el `id_empleado` que la hizo.
5. Cuando se arregla, el estado pasa a "resuelto" y se carga la `fecha_resolucion`.

Las estadísticas salen de unir estas tablas. Por ejemplo, los reclamos por categoría se sacan uniendo `reclamo` con `categoria`, y el tiempo de resolución sale de restar `fecha_creacion` a `fecha_resolucion`.
