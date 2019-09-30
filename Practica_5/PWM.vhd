library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity pwm is
    Port (reloj : in  STD_LOGIC;
			 switch: in  STD_LOGIC_vector(3 downto 0);
			 led: out STD_LOGIC);
end pwm;

architecture Prac5 of pwm is

signal delay: integer range 0 to 2499;
signal div: std_logic := '0';
signal pwm_cuenta: integer range 1 to 100;

begin
	divi: process(reloj)
	begin
		if rising_edge (reloj) then
			if (delay = 2499) then		--Tiempo para 10000[Hz]
				delay <= 0;
				div <= not div;
			else
				delay <= delay + 1;
			end if;
		end if;
    end process;
	
	conta: process(div)
	variable cuenta: integer range 1 to 100;
	begin
		if rising_edge(div) then
			cuenta := cuenta + 1;
		end if;
		pwm_cuenta <= cuenta;
	end process;
	 
    	
	intensidad: process(switch,pwm_cuenta)
    begin
		case switch is 
			when x"0" =>
				led <= '0';
			when x"1" =>
				if pwm_cuenta <= 7 then
					led <= '1';
				else
					led <= '0';
            end if;
			when x"2" =>
				if pwm_cuenta <= 13 then
					led <= '1';
				else
					led <= '0';
            end if;
			when x"3" =>
				if pwm_cuenta <= 20 then
					led <= '1';
				else
					led <= '0';
            end if;
			when x"4" =>
				if pwm_cuenta <= 27 then
					led <= '1';
				else
					led <= '0';
            end if;
			when x"5" =>
				if pwm_cuenta <= 33 then
					led <= '1';
				else
					led <= '0';
            end if;
			when x"6" =>
				if pwm_cuenta <= 40 then
					led <= '1';
				else
					led <= '0';
            end if;
			when x"7" =>
				if pwm_cuenta <= 47 then
					led <= '1';
				else
					led <= '0';
            end if;
			when x"8" =>
				if pwm_cuenta <= 53 then
					led <= '1';
				else
					led <= '0';
            end if;
			when x"9" =>
				if pwm_cuenta <= 60 then
					led <= '1';
				else
					led <= '0';
            end if;
			when x"A" =>
				if pwm_cuenta <= 67 then
					led <= '1';
				else
					led <= '0';
            end if;
			when x"B" =>
				if pwm_cuenta <= 73 then
					led <= '1';
				else
					led <= '0';
            end if;
			when x"C" =>
				if pwm_cuenta <= 80 then
					led <= '1';
				else
					led <= '0';
            end if;
			when x"D" =>
				if pwm_cuenta <= 87 then
					led <= '1';
				else
					led <= '0';
            end if;
			when x"E" =>
				if pwm_cuenta <= 93 then
					led <= '1';
				else
					led <= '0';
            end if;
			when x"F" =>
				led <= '1';
      end case;
	end process;

end Prac5;
