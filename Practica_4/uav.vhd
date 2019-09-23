library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity uav is
    Port (reloj : in  STD_LOGIC;
			 reset: in  STD_LOGIC;
			 Si,Sd: in STD_LOGIC;
			 movi: out STD_LOGIC_VECTOR(3 downto 0);
			 display: out STD_LOGIC_VECTOR(6 downto 0));
end uav;

architecture Prac4 of uav is

signal delay: integer range 0 to 24999999;
signal div: std_logic := '0';

--Biblioteca de estados
type Estados is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11);
signal qt: Estados;

begin
	divi: process(reloj)
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
		if (reset='0') then
				if rising_edge(div) then
					case qt is 
						when S0 =>
								movi <= x"0";
								display <= "1000000"; --0
								if (Si='0') then 
									if (Sd='0') then
										movi <= x"8";
										qt <= S0;
									else
										qt <= S1;
									end if;
								else
									if (Sd='0') then
										qt <= S3;
									else
										qt <= S5;
									end if;
								end if;
						when S1 =>
								movi <= x"4";
								display <= "1111001"; --1
								qt <= S2;
						when s2 =>
								movi <= x"1";
								display <= "0100100"; --2
								qt <= s0;
						when s3 =>
								movi <= x"4";
								display <= "0110000"; --3
								qt <= s4;
						when s4 =>
								movi <= x"2";
								display <= "0011001"; --4
								qt <= s0;
						when s5 =>
								movi <= x"4";
								display <= "0010010"; --5
								qt <= s6;
						when s6 =>
								movi <= x"1";
								display <= "0000010"; --6
								qt <= s7;
						when s7 =>
								movi <= x"1";
								display <= "1111000"; --7
								qt <= s8;
						when s8 =>
								movi <= x"8";
								display <= "0000000"; --8
								qt <= s9;
						when s9 =>
								movi <= x"8";
								display <= "0010000"; --9
								qt <= s10;
						when s10 =>
								movi <= x"2";
								display <= "0001000"; --A
								qt <= s11;
						when s11 =>
								movi <= x"2";
								display <= "0000011"; --b
								qt <= s0;
					end case;
				end if;		
			else
				qt <= s0;
		end if;
	end process;

end Prac4;
