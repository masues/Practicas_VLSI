LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY miROM IS
  GENERIC (--Se utiliza para describir el contenido de la memoria, la estructura de la ROM
    addr_width : INTEGER := 17; --# localidades
    addr_bits : INTEGER := 5;
    data_width : INTEGER := 7); --Se van a almacenar 7 bits
  PORT (
    RELOJ : IN std_logic;
    data1 : OUT std_logic_vector(data_width - 1 DOWNTO 0);
    data2 : OUT std_logic_vector(data_width - 1 DOWNTO 0);
    data3 : OUT std_logic_vector(data_width - 1 DOWNTO 0);
    data4 : OUT std_logic_vector(data_width - 1 DOWNTO 0));
END miROM;

ARCHITECTURE Prac6_3 OF miROM IS
  TYPE rom_type IS ARRAY(0 TO addr_width - 1)
  --Arreglo de 32 localidades, donde cada localidad tiene 7 bits 
  OF std_logic_vector(data_width - 1 DOWNTO 0);
  SIGNAL sieteSeg : rom_type := (
  --Display Ánodo Común
  "1000001", --V
  "1000111", --L
  "0010010", --S
  "1001111", --I
  "0111111", -- - (guión)
  "0100100", --2
  "1000000", --0
  "0100100", --2
  "1000000", --0
  "1110111", -- _ (guión bajo)
  "1111001", --1
  "0111111", -- - (guión)
  "0001001", --H
  "0010010", --S
  "0010010", --S
  "0001000", --A
  "1111111" -- Espacio en blanco
  );
  SIGNAL delay : INTEGER RANGE 0 TO 24999999;
  SIGNAL div : std_logic;
  SIGNAL cuenta :INTEGER range 0 to 16;
BEGIN
  divisor : PROCESS (RELOJ)
  BEGIN
    IF (rising_edge(RELOJ)) THEN
      IF (delay = 24999999) THEN --1Hz
        delay <= 0;
        div <= NOT (div);
      ELSE
        delay <= delay + 1;
      END IF;
    END IF;
  END PROCESS divisor;

  contador : PROCESS (div)
  BEGIN
    IF (rising_edge(div)) THEN
      if cuenta = 13 then
			cuenta <= 0;
		else
			cuenta <= cuenta + 1;
		end if;		
    END IF;
  END PROCESS contador;
  data4 <= sieteSeg(cuenta);
  data3 <= sieteSeg(cuenta+1);
  data2 <= sieteSeg(cuenta+2);
  data1 <= sieteSeg(cuenta+3);
END Prac6_3;