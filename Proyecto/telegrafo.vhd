----------------------------------------------------------------------------------
-- Universidad Nacional Autónoma de México 
-- Engineers: Cabrera Beltrán Héctor Eduardo
--				  Castillo López Humberto Serafín
--				  García Racilla Sandra
--				  Suárez Espinoza Mario Alberto
-- 
-- Create Date:    25/11/2019 
-- Module Name:    despliegue - Behavioral 
-- Project Name:   Traductor Código Morse
-- Additional Comments: 
--		Impresión mensaje en LCD 16x2
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity telegrafo is
	port(
		reloj: in std_logic;
		btn_morse: in std_logic;
		led_segundo: out std_logic;
		data: out std_logic_vector(7 downto 0);
		mode: in std_logic; --Switch modo de escritura/lectura, 1/0
		sw: in std_logic_vector(4 downto 0);
		rst: in std_logic
		);
end telegrafo;

architecture Behavioral of telegrafo is

--signal delay: integer range 0 to 24999999;
--signal div: std_logic :='0';
signal message_s: std_logic_vector(1 downto 0);
--signal addr_s: std_logic_vector(4 downto 0) := "00000";
signal rst_s: std_logic;
signal btn_morse_s:std_logic;

begin
rst_s <= not(rst);
btn_morse_s <= not(btn_morse);
	codi: entity work.codificador --Se crea una "instancia" del otro módulo
	port map(reloj => reloj, 
				btn_morse => btn_morse_s,
				simbolo => message_s,
				led_segundo => led_segundo);
				
	memo: entity work.memoria --Se crea una "instancia" del otro módulo
	port map(data => data, 
				mode => mode,
				message => message_s,
				--addr => addr_s);
				addr_r => sw,
				clk => reloj,
				rst => rst_s);
	
	--divi: process(reloj)
	--begin
		--if rising_edge (reloj) then
			--if (delay = 24999999) then		--Tiempo para 1s
				--delay <= 0;
				--div <= not div;
			--else
				--delay <= delay + 1;
			--end if;
		--end if;
	--end process;
	
	--process(div)
		--begin
			--if rising_edge(div) then
				--if (addr_s = "10011") then
					--addr_s <= "00000";
				--else
					--addr_s <= addr_s + 1;
				--end if;
			--end if;
		--end process;

end Behavioral;
