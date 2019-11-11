# Práctica 8. Diseño Digital VLSI
## Integrantes del equipo:
- Cabrera Beltrán Héctor Eduardo
- Castillo López Humberto Serafín
- García Racilla Sandra
- Suárez Espinoza Mario Alberto
---
### Descripción de el problema
> Mediante el controlador RS232 disponible en:
> [Código práctica UART](https://rgunam.github.io/docs_vlsi/UART.vhd)  
> Diseñar un sistema en el que la FPGA funga como transmisor-receptor
> conectandose con la computadora mediante un puerto serie.
> En la FPGA se debe mostrar en los LEDS el caracter enviado por la computadora
> mientras que en la computadora se debe mostrar el carcater enviado por la FPGA.
---
### Solución
> Se creo diseño un componente que usa a el controlador RS232.  
> En este componente se crearon dos procesos. Uno llamado datos_entrada, el cual
> verifica que se haya enviado un caracter por la computadora, y posteriormente,
> el dato enviado se asigna a los LEDs.  
> El otro proceso llamado datos_salida, verifica que la bandera de tx_fin esté
> en cero, lo que implica que el dato aun no se ha enviado por completo (de la 
> FPGA a la computadora), por lo que durante todo ese tiempo se asigna un 1 a 
> tx_ini (indicando que la transmisión continua), y si se termino de enviar el
> dato, entonces tx_ini se asigna 0.
> [Clic aquí para ver video en YouTube](https://youtu.be/NFASbNpNb8o)
---
