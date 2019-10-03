library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity access_miROM is
	port(
		sw: in std_logic_vector(3 downto 0);
		disp: out std_logic_vector(6 downto 0));
		
end access_miROM;

architecture Prac6_2 of access_miROM is
	signal data: std_logic_vector(6 downto 0); --Debe tener el mismo nombre que la señal del módulo anterior
begin
	sieteSegROM: entity work.miROM --Se crea una "instancia" del otro módulo
	port map(addr => SW, data => data);
	disp <= data;
end Prac6_2;
