--Creación de un contador de 8 bits
LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CONT8B is
Port( RELOJ: IN STD_LOGIC;
        RESET: IN STD_LOGIC;
        --IP= inicio/paro
        IP: IN STD_LOGIC;
        LEDS: OUT STD_LOGIC_VECTOR(7 downto 0));
end CONT8B;

architecture Prac1 of CONT8B is
-- [50Mhz/(1Hz*2)]-1=24999999
signal delay: integer range 0 to 24999999;
signal div : std_logic := '0'; --no es necesario que este conmutando
signal cont8 : std_logic_vector (7 downto 0);

begin

divisor: process(RELOJ)
begin
  if(rising_edge(RELOJ)) then
    if(delay=24999999) then
      delay <= 0;
      div <= not div;
    else
      delay <= delay + 1;
    end if;
  end if;
end process;

contador: process(div)
begin
  if(rising_edge(div)) then
  --si reset está en 1 o si ya terminó de contar
    if(RESET='1') OR (cont8=x"FF") then
      cont8 <= x"00";
    else 
      if ( IP='1' ) then
        cont8 <= cont8 + '1';
      else
        cont8 <= cont8;
      end if;
    end if;
  end if;
  LEDS <= cont8;
end process;
        
end Prac1;
