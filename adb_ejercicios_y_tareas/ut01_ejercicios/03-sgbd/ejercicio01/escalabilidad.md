# Escalabilidad Vertical y Horizontal

## Escalabilidad Vertical

La **escalabilidad vertical** se refiere a aumentar la capacidad de un solo servidor. Esto se logra mejorando el hardware, como añadir más RAM, procesadores o almacenamiento. Es como mejorar un coche al añadirle un motor más potente: el vehículo sigue siendo uno, pero tiene más potencia.

**Ventajas**:
- Sencillez en la gestión, ya que se trabaja con un solo servidor.
- Menor complejidad en la arquitectura.

**Inconvenientes**:
- Tiene un límite, ya que no se puede mejorar indefinidamente.
- Puede ser costoso.

## Escalabilidad Horizontal

La **escalabilidad horizontal** implica añadir más servidores al sistema para manejar un mayor volumen de datos o tráfico. Es como aumentar una flota de coches para transportar más personas: en lugar de mejorar un solo coche, simplemente se agregan más.

**Ventajas**:
- Permite manejar grandes volúmenes de datos de manera eficiente.
- Es más rentable a medida que se necesita más capacidad.

**Inconvenientes**:
- Puede ser más compleja de gestionar, ya que implica coordinar múltiples servidores.
- Puede requerir un diseño más cuidadoso de la aplicación para distribuir la carga.

## SGBD que Permiten un Mejor Escalado Horizontal

Los sistemas de gestión de bases de datos que permiten un mejor escalado horizontal incluyen:

- **Bases de Datos NoSQL**: Como MongoDB, Cassandra y Couchbase, que están diseñadas para trabajar en entornos distribuidos.
- **Bases de Datos Relacionales**: Como MySQL y PostgreSQL, que también ofrecen soluciones de particionamiento y replicación para escalar horizontalmente, aunque no son tan naturales en este aspecto como las NoSQL.

En resumen, la elección entre escalabilidad vertical y horizontal dependerá de las necesidades específicas de tu aplicación y de cómo esperas que crezca en el futuro.
