LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY rom_entrada_estado IS
	GENERIC (--Se utiliza para describir el contenido de la memoria, la estructura de la ROM
		addr_width : INTEGER := 8; --# localidades
		addr_bits : INTEGER := 3;
		data_width : INTEGER := 14); --Se van a almacenar 14 bits
	PORT (
		addr : IN std_logic_vector(addr_bits - 1 DOWNTO 0);
		data : OUT std_logic_vector(data_width - 1 DOWNTO 0));
END rom_entrada_estado;

ARCHITECTURE Prac7_2 OF rom_entrada_estado IS
	TYPE rom_type IS ARRAY(0 TO addr_width - 1) OF std_logic_vector(data_width - 1 DOWNTO 0);
	SIGNAL asm : rom_type := (
	"01101110000110",
	"11010010100100",
	"10111100011000",
	"00010100001000",
	"11000000010100",
	"11001001010000",
	"11011011001000",
	"11001001000001"
	);
BEGIN
	data <= asm(to_integer(unsigned(addr)));
END Prac7_2;