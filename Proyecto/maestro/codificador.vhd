----------------------------------------------------------------------------------
-- Universidad Nacional Aut�noma de M�xico 
-- Engineers: Cabrera Beltr�n H�ctor Eduardo
--				  Castillo L�pez Humberto Seraf�n
--				  Garc�a Racilla Sandra
--				  Su�rez Espinoza Mario Alberto
-- 
-- Create Date:    25/11/2019 
-- Module Name:    codificador - Behavioral 
-- Project Name:   Traductor C�digo Morse
-- Additional Comments: 
--		Codificaci�n de entrada del s�mbolo, punto o l�nea
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity codificador is
	port(
		reloj: in std_logic;
		btn_morse: in std_logic;
		simbolo: out std_logic_vector(1 downto 0);
		led_segundo: out std_logic); --Enciende cada segundo
end codificador;

architecture Behavioral of codificador is

signal delay: integer range 0 to 499999;
signal div: std_logic :='0';
signal cont_btn: integer range 0 to 99; --Indica el tiempo que el bot�n estuvo presionado
signal cont_segundo: integer range 0 to 99; --Determina si ya transcurri� un segundo
signal aux: integer range 0 to 99; --Guarda el valor de cont_btn

begin

divi: process(reloj)
	begin
		if rising_edge (reloj) then
			if (delay = 499999) then		--Tiempo para 0.02s
				delay <= 0;
				div <= not div;
			else
				delay <= delay + 1;
			end if;
		end if;
	end process;
	
process(div)
	begin
		if rising_edge(div) then
			if (cont_segundo = 99) then
				aux <= cont_btn;
				cont_segundo <= 0;
				cont_btn <= 0;
				led_segundo <= '0';
			else
				if (btn_morse = '1') then
					cont_btn <= cont_btn + 1;
				end if;
				cont_segundo <= cont_segundo + 1;
				led_segundo <= '1';
			end if;
		end if;
	end process;
	
process(aux)
	begin
		--Si es puntito
		if (aux > 0 and aux < 10) then
			simbolo <= "01";
		--Si es rayita
		elsif (aux > 10) then
			simbolo <= "10";
		--Si es espacio
		elsif (aux = 0) then
			simbolo <= "00";
		else
			simbolo <= "11";
		end if;
	end process;

end Behavioral;