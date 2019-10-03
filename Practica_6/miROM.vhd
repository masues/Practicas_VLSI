library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity miROM is
	generic(	--Se utiliza para describir el contenido de la memoria, la estructura de la ROM
	  addr_width: integer :=16;  --# localidades
	  addr_bits: integer := 4;
	  data_width: integer := 7); --Se van a almacenar 7 bits
	port(
	  addr: in std_logic_vector(addr_bits-1 downto 0);
	  data: out std_logic_vector(data_width-1 downto 0));
end miROM;

architecture Prac6_1 of miROM is
type rom_type is array(0 to addr_width-1) of std_logic_vector(data_width-1 downto 0); --Arreglo de 16 localidades, donde cada localidad tiene 7 bits 
signal sieteSeg: rom_type := (
	"1000000", --0
	"1111001", --1
	"0100100", --2
	"0110000", --3
	"0011001", --4
	"0010010", --5 
	"0000010", --6
	"1111000", --7
	"0000000", --8
	"0010000", --9
	"0001000", --A
	"0000011", --b
	"1000110", --C
	"0100001", --d
	"0000110", --E
	"0001110" --F
	);
begin
	data <= sieteSeg(to_integer(unsigned(addr))); 
end Prac6_1;
