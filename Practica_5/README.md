# Práctica 5. Diseño Digital VLSI
## Integrantes del equipo:
- Cabrera Beltrán Héctor Eduardo
- Castillo López Humberto Serafín
- García Racilla Sandra
- Suárez Espinoza Mario Alberto
---
### Descripción de el problema
Se requiere diseñar una forma de implemantar una señal PWM.
PWM (Pulse Width Modulation) o modulación del ancho de pulso es una forma de
variar el ciclo de trabajo de una señal. El ciclo de trabajo se refiere al 
porcentaje de la señal que permanece en alto.  
Por ejemplo, una señal de 50Hz de frecuencia, posee un periodo de 20ms. Si
 queremos un ciclo de trabajo de 10%, implica que 2ms estará en alto, mientras
 que los 18ms restantes estará en bajo.  
Las señales PWM se aplican en distintos ambitos como:
* La variación de la intensidad luminosa de un LED.
* El control de un servomotor.
* Sistemas de comunicaciones.
En esta práctica se presenta su aplicación en los dos primeros ejemplos.
---
### Solución
Se implemento la solución usando un contador, que divide al periodo
base de una señal en 100, y mantiene en alto el porcentaje que se desea.  
[Video_YouTube](https:www.youtube.com)
---
