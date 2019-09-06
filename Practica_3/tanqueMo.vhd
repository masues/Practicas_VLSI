library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tanqueMo is
Port(RELOJ, H: in std_logic;
		A,B: out std_logic);
end tanqueMo;

architecture Prac3 of tanqueMo is
type estado is (E0,E1,E2,E3);
signal qt: estado;
signal delay: integer range 0 to 24999999;
signal div: std_logic := '0';

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

process(div) 
begin
	if rising_edge(div) then
		case qt is 
			when E0 =>
				A <= '0';
				B <= '0';
				if H = '0' then
					qt <= E1;
				else
					qt <= E0;
				end if;
			when E1 =>
				A <= '1';
				B <= '0';
				if H = '0' then
					qt <= E1;
				else
					qt <= E2;
				end if;
			when E2 =>
				A <= '0';
				B <= '0';
				if H = '0' then
					qt <= E3;
				else
					qt <= E2;
				end if;
			when E3 =>
				A <= '0';
				B <= '1';
				if H = '0' then
					qt <= E3;
				else
					qt <= E0;
				end if;
		end case;
	end if;
end process; 
end Prac3;
