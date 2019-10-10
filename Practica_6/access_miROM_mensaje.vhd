library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity access_miROM is
	port(
		disp1: out std_logic_vector(6 downto 0);
		disp2: out std_logic_vector(6 downto 0);
		disp3: out std_logic_vector(6 downto 0);
		disp4: out std_logic_vector(6 downto 0);
		reloj: in std_logic
		);
		
end access_miROM;

architecture Prac6_2 of access_miROM is
	signal data1: std_logic_vector(6 downto 0); --Debe tener el mismo nombre que la señal del módulo anterior
	signal data2: std_logic_vector(6 downto 0);
	signal data3: std_logic_vector(6 downto 0);
	signal data4: std_logic_vector(6 downto 0);
	
begin
	sieteSegROM: entity work.miROM --Se crea una "instancia" del otro módulo
	port map(reloj => RELOJ, data1 => data1, data2 => data2, data3 => data3, data4 => data4);
	disp1 <= data1;
	disp2 <= data2;
	disp3 <= data3;
	disp4 <= data4;
end Prac6_2;