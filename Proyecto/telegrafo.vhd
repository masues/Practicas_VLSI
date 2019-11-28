----------------------------------------------------------------------------------
-- Universidad Nacional Autónoma de México 
-- Engineers: Cabrera Beltrán Héctor Eduardo
--	n_morse, btn_save: in std_logic;
		rw: in std_logic;
		sw: in std_logic_vector(4 downto 0);
		reg: out std_logic_vector(7 downto 0);
		sel: in std_logic_vector(1 downto 0);
		led_segundo: out std_logic --Enciende cada segundo
		);
end telegr			  Castillo López Humberto Serafín
--				  García Racilla Sandra
--				  Suárez Espinoza Mario Alberto
-- 
-- Create Date:    25/11/2019 
-- Module Name:    codificador - Behavioral 
-- Project Name:   Traductor Código Morse
-- Additional Comments: 
--		Codificación de entrada del símbolo, punto o línea
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity telegrafo is
	port(
		reloj: in std_logic;
		btafo;

architecture Behavioral of telegrafo is

signal L1,L2,L3,L4,L : STD_LOGIC_VECTOR(1 downto 0):="00";
signal reg_char, dt_out, aux: STD_LOGIC_VECTOR(7 downto 0);
signal delay: integer range 0 to 49999999;
signal seg: std_logic :='0';


begin
	--dt_out <= reg_char;
	codi: entity work.codificador --Se crea una "instancia" del otro módulo
	port map(reloj => reloj, 
				btn_morse => btn_morse,
				simbolo => L,
				led_segundo => led_segundo);
	
	memo: entity work.memoria --Se crea una "instancia" del otro módulo
	port map(
		clk => reloj,
		rw => rw,
		direccion => sw,
		datain => dt_out,
		dataout => aux
		);

	divi: process(reloj)
	begin
		if rising_edge (reloj) then
			if (delay = 49999999) then		--Tiempo para 2s
				delay <= 0;
				seg <= not seg;
			else
				delay <= delay + 1;
			end if;
		end if;
	end process;
	
	reg0: process(seg)
	begin
		if rising_edge (seg) then
			L1<=L;
		end if;
	end process;

	reg1: process(seg)
	begin
		if rising_edge (seg) then
			L2<=L1;
		end if;
	end process;

	reg2: process(seg)
	begin
		if rising_edge (seg) then
			L3<=L2;
		end if;
	end process;
	
	reg3: process(seg)
	begin
		if rising_edge (seg) then
			L4<=L3;
		end if;
	end process;

	registro: process(seg,L4,L3,L2,L1)
	begin
		reg_char(7) <= L4(1);
		reg_char(6) <= L4(0);
		reg_char(5) <= L3(1);
		reg_char(4) <= L3(0);
		reg_char(3) <= L2(1);
		reg_char(2) <= L2(0);
		reg_char(1) <= L1(1);
		reg_char(0) <= L1(0);
		
		
		--dt_out <= reg_char;
	end process;
		
	modo: process(sel,reg_char,aux)
	begin
		case sel is
			when "00" => reg <= reg_char;
			when "01" => reg <= dt_out;
			when others => reg <= aux;
		--muestra registro del mensaje
		
		--muestra el registro de la memoria
		
		end case;
	end process;
	
	save: process(btn_save)
	begin
		if (btn_save = '1') then
			dt_out <= reg_char;
		end if;
	end process;
--	
end Behavioral;