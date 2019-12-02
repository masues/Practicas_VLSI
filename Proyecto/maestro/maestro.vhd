----------------------------------------------------------------------------------
-- Universidad Nacional Autónoma de México 
-- Engineers: Cabrera Beltrán Héctor Eduardo
--				  Castillo López Humberto Serafín
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

entity maestro is
port(
	CLK : IN std_logic; --Reloj de FPGA
	RX : IN std_logic; --Pin de recepci?n de RS232
	btn_morse, btn_save, reset, reset_palabra : IN std_logic;
	TX : OUT std_logic; --Pin de transmisi?n de RS232
	led_segundo, buzzer: OUT std_logic;
	leds : OUT std_logic_vector(7 DOWNTO 0)
);
end maestro;

architecture Behavioral of maestro is

signal seg: std_logic := '0';
signal delay: integer range 0 to 49999999;
signal L, L1, L2, L3, L4: std_logic_vector(1 downto 0);
signal reg, aux, led: std_logic_vector(7 downto 0);

begin

	codi: entity work.codificador --Se crea una "instancia" del otro módulo
	port map(
		reloj => CLK, 
		btn_morse => btn_morse,
		buzzer => buzzer,
		simbolo => L,
		led_segundo => led_segundo
	);
	
	transmisor: entity work.UART	--Se crea una "instancia" del otro módulo
	port map(
		CLK => CLK,
		RX => RX,
		TX => TX,
		leds => led,
		switch => aux
	);
	
	--Divisor de frecuencia
	divi: process(CLK)
	begin
		if rising_edge (CLK) then
			if (delay = 49999999) then		--Tiempo para 2s
				delay <= 0;
				seg <= not seg;
			else
				delay <= delay + 1;
			end if;
		end if;
	end process;
	
	--Registros de corrimiento
	reg0: process(seg,reset)
	begin
		if (reset = '0') then
			if rising_edge (seg) then
				L1<=L;
			end if;
		else
			L1 <= "00";
		end if;
	end process;

	reg1: process(seg,reset)
	begin
		if (reset = '0') then
			if rising_edge (seg) then
				L2<=L1;
			end if;
		else
			L2 <= "00";
		end if;
	end process;

	reg2: process(seg,reset)
	begin
		if (reset = '0') then
			if rising_edge (seg) then
				L3<=L2;
			end if;
		else
			L3 <= "00";
		end if;
	end process;
	
	reg3: process(seg,reset)
	begin
		if (reset = '0') then
			if rising_edge (seg) then
				L4<=L3;
			end if;
		else
			L4 <= "00";
		end if;
	end process;

	registro: process(seg,btn_save,reset_palabra)
	begin
		reg(7) <= L4(1);
		reg(6) <= L4(0);
		reg(5) <= L3(1);
		reg(4) <= L3(0);
		reg(3) <= L2(1);
		reg(2) <= L2(0);
		reg(1) <= L1(1);
		reg(0) <= L1(0);
		
		if (reset_palabra = '0') then
			--Guarda letra y envia letra guardada
			if (btn_save = '1') then
				aux <= reg;
			end if;
		--Envia señal para borrar letra
		else
			reg <= "00000000";
			aux <= reg;
		end if;
		
		leds <= reg;
	end process;
	
end Behavioral;

