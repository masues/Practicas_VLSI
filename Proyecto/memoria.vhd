----------------------------------------------------------------------------------
-- Universidad Nacional Autónoma de México 
-- Engineers: Cabrera Beltrán Héctor Eduardo
--				  Castillo López Humberto Serafín
--				  García Racilla Sandra
--				  Suárez Espinoza Mario Alberto
-- 
-- Create Date:    25/11/2019 
-- Module Name:    codificador - Behavioral 
-- Project Name:   Traductor Código Morse
-- Additional Comments: 
--		Codificación de entrada del símbolo, punto o línea
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

Entity memoria is
Port (	clk : in STD_LOGIC;
			rw : in STD_LOGIC;
			--cs : in STD_LOGIC;
			direccion : in STD_LOGIC_VECTOR (4 downto 0);
			datain : in STD_LOGIC_VECTOR (7 downto 0);
			dataout : out STD_LOGIC_VECTOR (7 downto 0));
end memoria;

architecture Behavioral of memoria is

type ram is array(0 to 20) of std_logic_vector(7 downto 0);
signal mens: ram;
signal cs: std_logic := '1';

begin

	process(cs,rw,clk,mens,datain)
	begin
		dataout <= (others => '0');
		if cs='1' then
			--Modo de escritura
			if rw='0' then
				if rising_edge(clk) then
					mens(conv_integer(direccion)) <= datain;
				end if;
			End if;
			--Modo de lectura
			else
				dataout <= mens(conv_integer(direccion));
		End if;
	End process;

End Behavioral;