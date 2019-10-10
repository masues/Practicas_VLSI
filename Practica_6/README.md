# Práctica 6. Memorias ROM. Diseño Digital VLSI
## Integrantes del equipo:
- Cabrera Beltrán Héctor Eduardo
- Castillo López Humberto Serafín
- García Racilla Sandra
- Suárez Espinoza Mario Alberto
---
### Descripción de el problema
> Diseñar la descripción de una memoria ROM
> 1. Memoria ROM 16x7 dónde se guarden la codificación de los números del 0 a 15
> en hexadecimal para su visualización en un display de 7 segmentos y que pueda
> accesarese a cualquier dirección utilizando un dip switch.
> 2. Memoria ROM 16x7 dónde se almacene la codificación 7 segmentos del mensaje
> "VLSI-2020_1-HSSA", dónde HSSA son las iniciales de los nombres de los
> integrantes de nuestro equipo, es decir: Héctor, Serafín, Sandra, Alberto.
> El acceso a estas localidades de memoria deberá ser automático.
---
### Solución
> Para ambos casos, se separó al sistema en dos archivos, la descripción de la
> memoria (archivos miROM), y la conexión física (archivos access_miROM).
> En específico, para la memoria ROM con el mensaje, se implementó un contador
> que va a permitir el recorrido de la memoria.
> [Clic aquí para ver video en YouTube](https://www.youtube.com)
---
