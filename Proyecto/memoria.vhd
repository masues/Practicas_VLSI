----------------------------------------------------------------------------------
-- Universidad Nacional Autónoma de México 
-- Engineers: Cabrera Beltrán Héctor Eduardo
--				  Castillo López Humberto Serafín
--				  García Racilla Sandra
--				  Suárez Espinoza Mario Alberto
-- 
-- Create Date:    25/11/2019 
-- Module Name:    memoria - Behavioral 
-- Project Name:   Traductor Código Morse
-- Additional Comments: 
--		Almacenamiento del mensaje
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity memoria is
	generic(	--Se utiliza para describir el contenido de la memoria, la estructura de la ROM
	  addr_width: integer :=20;  --# localidades
	  addr_bits: integer := 5;
	  data_width: integer := 8); --Se van a almacenar 8 bits
	port(
	  addr: in std_logic_vector(addr_bits-1 downto 0);
	  data: out std_logic_vector(data_width-1 downto 0);
	  mode: in std_logic; --Indica si está en modo de escritura/lectura, 1/0
	  message: in std_logic_vector(1 downto 0)); --Fragmento de un caracter
end memoria;

architecture Behavioral of memoria is
type rom_type is array(0 to addr_width-1) of std_logic_vector(data_width-1 downto 0); --Arreglo de 20 localidades, donde cada localidad tiene 8 bits 
signal mensaje: rom_type := (
	"10101010", --0
	"10101010", --1
	"10101010", --2
	"10101010", --3
	"10101010", --4
	"10101010", --5 
	"10101010", --6
	"10101010", --7
	"10101010", --8
	"10101010", --9
	"10101010", --A
	"10101010", --b
	"10101010", --C
	"10101010", --d
	"10101010", --E
	"10101010", --F
	"10101010", --10
	"10101010", --11
	"10101010", --12
	"10101010" --13
	);
signal cont_caracter: integer range 0 to 3; --Posición símbolo dentro de la letra
signal cont_letra : integer range 0 to 19; --Posición de la letra en el mensaje

begin 
	process(mode, cont_caracter)
		begin
			if (mode = '1') then
				case cont_caracter is
					when 0 => mensaje(cont_letra)(7) <= message(1);
								 mensaje(cont_letra)(6) <= message(0);
					when 1 => mensaje(cont_letra)(5) <= message(1);
								 mensaje(cont_letra)(4) <= message(0);
					when 2 => mensaje(cont_letra)(3) <= message(1);
								 mensaje(cont_letra)(2) <= message(0);
					when others => mensaje(cont_letra)(1) <= message(1);
								 mensaje(cont_letra)(0) <= message(0);
				end case;
			else
				data <= mensaje(to_integer(unsigned(addr)));
			end if;
		end process;
		
	process(message, cont_caracter)
		begin
			if (message = "10" or cont_caracter = 3) then
				cont_letra <= cont_letra + 1;
				cont_caracter <= 0;
			else
				cont_letra <= cont_letra;
				cont_caracter <= cont_caracter + 1;
			end if;
	end process;
end Behavioral;

