library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity trayectoria is
	generic(	--Se utiliza para describir el contenido de la memoria, la estructura de la ROM
	  addr_width: integer := 40;  --# localidades
	  addr_bits: integer := 6;
	  data_width: integer := 9); --Se van a almacenar 9 bits
	port(
	  addr: in std_logic_vector(addr_bits-1 downto 0);
	  data: out std_logic_vector(data_width-1 downto 0));
end trayectoria;

architecture Prac7_1 of trayectoria is
type rom_type is array(0 to addr_width-1) of std_logic_vector(data_width-1 downto 0); --Arreglo de 16 localidades, donde cada localidad tiene 7 bits 
signal contenido: rom_type := (
	"001011010",
	"001011010",
	"011011100",
	"011011100",
	"001011010",
	"001011010",
	"011011100",
	"011011100",
	"010001001",
	"010001001",
	"010001001",
	"010001001",
	"010001001",
	"010001001",
	"010001001",
	"010001001",
	"001100110",
	"100000110",
	"001100110",
	"100000110",
	"001100110",
	"100000110",
	"001100110",
	"100000110",
	"010000100",
	"010000100",
	"010000100",
	"010000100",
	"100000100",
	"100000100",
	"100000100",
	"100000100",
	"000001010",
	"000001010",
	"000001010",
	"000001010",
	"000001010",
	"000001010",
	"000001010",
	"000001010"
	);
begin
	data <= contenido(to_integer(unsigned(addr))); 
end Prac7_1;