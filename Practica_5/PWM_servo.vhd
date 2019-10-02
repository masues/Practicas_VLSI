LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY pwm_servo IS
	PORT (
		reloj : IN STD_LOGIC;
		switch : IN STD_LOGIC_vector(3 DOWNTO 0);
		--Salida que irá conectada al servo
		servo : OUT STD_LOGIC);
END pwm_servo;

ARCHITECTURE Prac5 OF pwm_servo IS

	SIGNAL delay : INTEGER RANGE 0 TO 249;
	SIGNAL div : std_logic;
	SIGNAL pwm_cuenta : INTEGER RANGE 0 TO 1999;

BEGIN
	divi : PROCESS (reloj)
	BEGIN
		IF rising_edge (reloj) THEN
			IF (delay = 249) THEN --Tiempo para 100[kHz]. 100 veces en 1 milisegundo
				delay <= 0;
				div <= NOT div;
			ELSE
				delay <= delay + 1;
			END IF;
		END IF;
	END PROCESS;

	conta : PROCESS (div)
		-- la variable cuenta va a contar de de 0 a 19999 (2000 veces)
		-- por cada milisegundo contara 100 veces
		-- 20000/100=20, 20 milisegundos durará el periodo completo (periodo
		-- establecido por el fabricante).
		VARIABLE cuenta : INTEGER RANGE 0 TO 1999;
	BEGIN
		IF rising_edge(div) THEN
			cuenta := cuenta + 1;
		END IF;
		pwm_cuenta <= cuenta;
	END PROCESS;

	intensidad : PROCESS (switch, pwm_cuenta)
	BEGIN
		CASE switch IS
			--Según el fabricante, -90° del servomotor se alcanzan en una PWM con
			--1ms en alto y 19 en bajo, mientras que +90° del servomotor se alcanzan
			--en una PWM con 2ms en alto y 18 en bajo.
			--Para llegar al menor valor posible por el servomotor (-90°) usamos
			--el valor 0000 del switch, y mantenemos a la señal "servo" en alto
			--mientras el tiempo sea menor a 1ms, y para mover el ángulo vamos
			--modificando este tiempo. 
			WHEN x"0" =>
				--Mientras sea menor a 1ms
				IF pwm_cuenta <= 100 THEN
					servo <= '1';
				ELSE
					servo <= '0';
				END IF;
			WHEN x"1" =>
				--Mientras sea menor a 1.07ms
				IF pwm_cuenta <= 107 THEN
					servo <= '1';
				ELSE
					servo <= '0';
				END IF;
			WHEN x"2" =>
				--Mientras sea menor a 1.13ms
				IF pwm_cuenta <= 113 THEN
					servo <= '1';
				ELSE
					servo <= '0';
				END IF;
			WHEN x"3" =>
				--Mientras sea menor a 1.20ms
				IF pwm_cuenta <= 120 THEN
					servo <= '1';
				ELSE
					servo <= '0';
				END IF;
			WHEN x"4" =>
				--Mientras sea menor a 1.27ms
				IF pwm_cuenta <= 127 THEN
					servo <= '1';
				ELSE
					servo <= '0';
				END IF;
			WHEN x"5" =>
				--Mientras sea menor a 1.33ms
				IF pwm_cuenta <= 133 THEN
					servo <= '1';
				ELSE
					servo <= '0';
				END IF;
			WHEN x"6" =>
				--Mientras sea menor a 1.40ms
				IF pwm_cuenta <= 140 THEN
					servo <= '1';
				ELSE
					servo <= '0';
				END IF;
			WHEN x"7" =>
				--Mientras sea menor a 1.47ms
				IF pwm_cuenta <= 147 THEN
					servo <= '1';
				ELSE
					servo <= '0';
				END IF;
			WHEN x"8" =>
				--Mientras sea menor a 1.53ms
				IF pwm_cuenta <= 153 THEN
					servo <= '1';
				ELSE
					servo <= '0';
				END IF;
			WHEN x"9" =>
				--Mientras sea menor a 1.60ms
				IF pwm_cuenta <= 160 THEN
					servo <= '1';
				ELSE
					servo <= '0';
				END IF;
			WHEN x"A" =>
				--Mientras sea menor a 1.67ms
				IF pwm_cuenta <= 167 THEN
					servo <= '1';
				ELSE
					servo <= '0';
				END IF;
			WHEN x"B" =>
				--Mientras sea menor a 1.73ms
				IF pwm_cuenta <= 173 THEN
					servo <= '1';
				ELSE
					servo <= '0';
				END IF;
			WHEN x"C" =>
				--Mientras sea menor a 1.80ms
				IF pwm_cuenta <= 180 THEN
					servo <= '1';
				ELSE
					servo <= '0';
				END IF;
			WHEN x"D" =>
				--Mientras sea menor a 1.87ms
				IF pwm_cuenta <= 187 THEN
					servo <= '1';
				ELSE
					servo <= '0';
				END IF;
			WHEN x"E" =>
				--Mientras sea menor a 1.93ms
				IF pwm_cuenta <= 193 THEN
					servo <= '1';
				ELSE
					servo <= '0';
				END IF;
			WHEN OTHERS =>
				--Mientras sea menor a 2ms
				IF pwm_cuenta <= 200 THEN
					servo <= '1';
				ELSE
					servo <= '0';
				END IF;
		END CASE;
	END PROCESS;

END Prac5;