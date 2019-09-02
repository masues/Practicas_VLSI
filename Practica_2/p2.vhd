library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity corrimiento is
Port(RELOJ: IN STD_LOGIC; --50MHz
     RESET: IN STD_LOGIC;
     DIR: IN STD_LOGIC;
     LEDS: OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
end corrimiento;

architecture Prac2 of corrimiento is
signal delay: integer range 0 to 24999999;  
signal div: std_logic := '0';
signal corri: std_logic_vector (7 downto 0) := x"99";
	
begin

divisor: process(RELOJ)
begin
	if (rising_edge(RELOJ)) then
		if (delay = 24999999) then
			delay <= 0;
			div <= not (div);
		else
         delay <= delay + 1;
		end if;
	end if;
end process;
	 
registro: process(div) 
begin
	if (RESET = '0') then
		if (rising_edge(div)) then
			if (DIR = '0') then
				corri(7) <= corri(0);
				corri(6) <= corri(7);
				corri(5) <= corri(6);
				corri(4) <= corri(5);
				corri(3) <= corri(4);
				corri(2) <= corri(3);
				corri(1) <= corri(2);
				corri(0) <= corri(1);
			else
				corri(0) <= corri(7);
				corri(1) <= corri(0);
				corri(2) <= corri(1);
				corri(3) <= corri(2);
				corri(4) <= corri(3);
				corri(5) <= corri(4);
				corri(6) <= corri(5);
				corri(7) <= corri(6);
			end if;
		end if;
	else
		corri <= x"99";	
	end if;
	LEDS <= corri;
end process;

end Prac2;
