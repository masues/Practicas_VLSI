# Práctica 4. Diseño Digital VLSI
## Integrantes del equipo:
- Cabrera Beltrán Héctor Eduardo
- Castillo López Humberto Serafín
- García Racilla Sandra
- Suárez Espinoza Mario Alberto
---
### Descripción de el problema
Se requiere diseñar el sistema de control de vuelo de un UAV. El vehículo 
cuenta con una unidad de  medición  inercial  equipada  con  dos  sensores, uno
para el hemisferio derecho (Sd)  y  otro  para  elizquierdo (Si), con ambos el
UAV deberá tomar la decisión sobre qué movimiento deberá efectuar, los cuales 
son: “ADELANTE”, “ATRÁS”, “GIROIZQ”, y “GIRODER”. El algoritmo de navegación es 
el siguiente:
1. El UAV se eleva encendiendo sus cuatro motores y comienza a navegar hacia el
frente, (Estado 0).
2. En todo momento después del encendido, el sistema debe consultar el estado de
los sensores dela siguiente forma:
	1. Si “Si” está en nivel bajo:  
    Consultar el estado del sensor “Sd”
    	* Si Sd=1, se pasa al Estado 1, en donde debe activarse la salida “ATRÁS”. 
		Inmediatamentepasa al Estado 2, y activa el “GIROIZQ”, después de esto,
      	regresa al estado de navegación (Estado 0).
    	* Si Sd=0, se activa la salida “ADELANTE” y regresa al Estado 0.
  	2. Si “Si” está en nivel alto:  
    Consultar el estado del sensor ”Sd”
        * Si Sd=0, se pasa al Estado 3, en donde debe activarse la salida “ATRÁS”.
        Inmediatamente después pasa al Estado 4, y activa el “GIRODER”, después de
        esto, regresa al estado denavegación (Estado 0).
        * Si Sd=1, se pasa al Estado 5 en donde se activa la salida “ATRÁS”, en el
        siguiente instante de tiempo, el sistema pasa al Estado 6, en donde se
        activa “GIROIZQ”, el siguiente estado (7), activa nuevamente “GIROIZQ”,
        en los Estados 8 y 9, la salida es “ADELANTE”,  el  Estado  10  activa  la
        salida  “GIRODER”  y  el  onceavo  estado  nuevamente  activa “GIRODER”,
        finalmente el siguiente estado es el Estado 0.
---
### Solución
Se implemento la solución usando una carta ASM, añandiendo un reset asincrono
y colocando el estado actual en un display de 7 segmentos  
[Video_YouTube](https://youtu.be/oLgyyDYY5SU)
---
