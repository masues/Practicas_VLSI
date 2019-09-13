library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity examen is
Port(RELOJ, C: in std_logic;
		P, kokoro: out std_logic);
end examen;

architecture marcapasos of examen is
type estado is (E2, E0, E1, E3);
signal qt: estado;

signal del: integer range 0 to 6249999;
signal div: std_logic := '0';

signal delay: integer range 0 to 24999999;  
signal t: std_logic := '0';

signal latido: integer range 0 to 12499999;  
signal S: std_logic := '0';
	
begin

divi: process(RELOJ)
begin
	if (rising_edge(RELOJ)) then
		if (del = 6249999) then
			del <= 0;
			div <= not (div);
		else
         del <= del + 1;
		end if;
	end if;
end process;


divisor: process(RELOJ)
begin
	if (rising_edge(RELOJ)) then
		if (delay = 24999999) then
			delay <= 0;
			t <= not (t);
		else
         delay <= delay + 1;
		end if;
	end if;
end process;


corazon: process(RELOJ)
begin
	if (C = '1') then
		if (rising_edge(RELOJ)) then
			if (latido = 12499999) then
				latido <= 0;
				S <= not (S);
			else
				latido <= latido + 1;
			end if;
		end if;
	else
		S <= '0';
	end if;
	kokoro <= S;
end process;


process(div)
begin
	if rising_edge(div) then
		case qt is
			when E2 =>
				P <= '0';
				qt <= E0;
			when E0 =>
				P <= '0';
				qt <= E1;
			when E1 =>
				if (S = '0' and t = '0') then
					P <= '0';
					qt <= E1;
				elsif (S = '0' and t = '1') then
					P <= '1';
					qt <= E3;
				elsif(S = '1') then
					P <= '0';
					qt <= E0;
				end if;
			when E3 =>
				P <= '0';
				qt <= E0;
		end case;
	end if;
end process;

end marcapasos;
