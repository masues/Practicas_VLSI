library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity uav is
    Port ( reloj : in  STD_LOGIC;
			  reset: in  STD_LOGIC;
			  Si,Sd: in STD_LOGIC;
			  movi: out STD_LOGIC_VECTOR(3 downto 0);
			  display: out STD_LOGIC_VECTOR(7 downto 0);
end uav;

architecture Prac4 of uav is

signal L1,L2,L3,L : STD_LOGIC_VECTOR(15 downto 0);
signal delay: integer range 0 to 24999999;
signal div: std_logic :='0';


--Biblioteca de estados
type Estados is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11);
signal qt: Estados;

begin
	divi: process(reloj)
	variable cuenta: std_logic_vector(27 downto 0):=X"0000000";		--Declaracion de una varible interna de proceso
	begin
		if rising_edge (reloj) then
			if (delay = 24999999) then		--Tiempo para 1s
				delay <= 0;
				div <= not div;
			else
				delay <= delay + 1;
			end if;
		end if;
	end process;

	
ASM: process(div,reset,Si,Sd)
begin
	if(reset='0') then
			if rising_edge(div) then
				case qt is 
					when S0 =>
							movi <=X"0";
							display <="1000000";
							if Si='0' then 
								if Sd='0' then
									movi<='1000';
									qt <= S0;
								else
									qt <= S1;
								end if;
							else
								if Sd='0' then
									qt<=S3;
								else
									qt<=S5;
								end if;
							end if;
					when S1 =>
							movi <=X"4";
							display <= "1111001";
							qt<=S2;
			end if;
					
	end if;				2  0100100
							3  0110000
							4  0011001
							5  0010010
							6  0000011
							7  1111000
							
	
	
end Behavioral;