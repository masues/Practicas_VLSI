library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tanqueMe is
Port(RELOJ, H: in std_logic;
		A,B: out std_logic);
end tanqueMe;

architecture Prac3 of tanqueMe is
type estado is (E0,E1,E2,E3);
signal qt: estado;

begin
process(RELOJ) 
begin
	if rising_edge(RELOJ) then
		case qt is 
			when E0 =>
				if H = '0' then
					A <= '1';
					B <= '0';
					qt <= E1;
				else
					A <= '0';
					B <= '0';
					qt <= E0;
				end if;
			when E1 =>
				if H = '0' then
					A <= '1';
					B <= '0';
					qt <= E1;
				else
					A <= '0';
					B <= '0';
					qt <= E2;
				end if;
			when E2 =>
				if H = '0' then
					A <= '0';
					B <= '1';
					qt <= E3;
				else
					A <= '0';
					B <= '0';
					qt <= E2;
				end if;
			when E3 =>
				if H = '0' then
					A <= '0';
					B <= '1';
					qt <= E3;
				else
					A <= '0';
					B <= '0';
					qt <= E0;
				end if;
		end case;
	end if;
end process; 
end Prac3;
