----------------------------------------------------------------------------------
-- Universidad Nacional Autónoma de México 
-- Engineers: Cabrera Beltrán Héctor Eduardo
--				  Castillo López Humberto Serafín
--				  García Racilla Sandra
--				  Suárez Espinoza Mario Alberto
-- 
-- Create Date:    25/11/2019 
-- Module Name:    memoria ram - Behavioral 
-- Project Name:   Traductor Código Morse
-- Additional Comments: 
--		Almacenamiento del mensaje
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity memoria is
	generic(	--Se utiliza para describir el contenido de la memoria, la estructura de la ROM
	  addr_width: integer :=20;  --# localidades
	  addr_bits: integer := 5;
	  data_width: integer := 8); --Se van a almacenar 8 bits


	port(
	  addr_r: in std_logic_vector(addr_bits-1 downto 0);
	  data: out std_logic_vector(data_width-1 downto 0);
	  mode: in std_logic; --Indica si está en modo de escritura/lectura, 0/1
	  message: in std_logic_vector(1 downto 0); --Fragmento de un caracter
	  clk: in std_logic;
	  rst: in std_logic);
	  
end memoria;

architecture Behavioral of memoria is
type ram is array(0 to addr_width-1) of std_logic_vector (data_width-1 downto 0);
signal mens: ram;
signal cs: STD_LOGIC:='1';
signal cont_caracter: integer range 0 to 3; --Posición símbolo dentro de la letra
signal addr: std_logic_vector(addr_bits-1 downto 0);
signal addr_w: std_logic_vector(addr_bits-1 downto 0);

begin
rw_simbol: process(cs,mode,clk,mens,message,cont_caracter)
	begin
		if clk'event and clk='1' then
		data <= (others=> 'Z');
		
			if cs='1' then   --1 available, 0 unavailable
				if mode='0' then    --1 read,  0 write
					if (rst = '0') then --Depende del hardware, pull down
						case cont_caracter is
							when 0 => mens(conv_integer(addr))(7) <= message(1);
										 mens(conv_integer(addr))(6) <= message(0);
							when 1 => mens(conv_integer(addr))(5) <= message(1);
										 mens(conv_integer(addr))(4) <= message(0);
							when 2 => mens(conv_integer(addr))(3) <= message(1);
										 mens(conv_integer(addr))(2) <= message(0);
							when others => mens(conv_integer(addr))(1) <= message(1);
										 mens(conv_integer(addr))(0) <= message(0);
						end case;
--					else
--						addr_w <= "00000";
--						cont_caracter <= 0;
--						mens(0)<="00000000";
--						mens(1)<="00000000";
--						mens(2)<="00000000";
--						mens(3)<="00000000";
--						mens(4)<="00000000";
--						mens(5)<="00000000";
--						mens(7)<="00000000";
--						mens(8)<="00000000";
--						mens(9)<="00000000";
--						mens(10)<="00000000";
--						mens(11)<="00000000";
--						mens(12)<="00000000";
--						mens(13)<="00000000";
--						mens(14)<="00000000";
--						mens(15)<="00000000";
--						mens(16)<="00000000";
--						mens(17)<="00000000";
--						mens(18)<="00000000";
--						mens(19)<="00000000";	
					end if;
				else
					data <= mens(conv_integer(addr));
				end if;
			end if;
		end if;
	end process;


w_letter: process(message, cont_caracter,addr_W, cs)
		begin
			--Si no ha llegado al tope de la memoria
			if (addr_w < addr_width) then
				if (message = "00" or cont_caracter = 3) then
					addr_w <= addr_w + 1;
					cont_caracter <= 0;
				else
					addr_w <= addr_w;
					cont_caracter <= cont_caracter + 1;
				end if;
			--En caso que llegue al tope de la memoria
			else 
				cs<='0';
			end if;
	end process;

muxi_addr: process(mode)
	begin
			case (mode) is
				when '0'=> addr<=addr_w;
				when others=>addr<=addr_r;
			end case;
	end process;	
	
end Behavioral;


