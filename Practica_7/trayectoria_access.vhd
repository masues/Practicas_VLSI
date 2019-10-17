library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity trayectoria_access is
	port(
		reloj: in std_logic;
		switches: in std_logic_vector(2 downto 0);
		leds: out std_logic_vector(5 downto 0));
end trayectoria_access;

architecture Prac7_2 of trayectoria_access is
	--Divisor de frecuencia
	signal delay: integer range 0 to 24999999;
	signal div: std_logic;
	--Datos obtenidos de la memoria
	signal data: std_logic_vector(8 downto 0);
	--Dirección de la memoria
	signal memory_address: std_logic_vector(5 downto 0);
	--Registro que almacena la dirección actual de la memoria
	signal liga: std_logic_vector(2 downto 0);
	--Registro de salidas
	signal salidas: std_logic_vector(5 downto 0);

begin
	ROM: entity work.trayectoria --Se crea una "instancia" del otro módulo
   PORT MAP(addr => memory_address, data => data);
	--Separación de las salidas de la memoria en señales independientes
	--Ligas
	liga(2) <= data(8);
	liga(1) <= data(7);
	liga(0) <= data(6);
	--Salidas
	salidas(5) <= data(5);
	salidas(4) <= data(4);
	salidas(3) <= data(3);
	salidas(2) <= data(2);
	salidas(1) <= data(1);
	salidas(0) <= data(0);
	
	divisor: process(reloj)
	begin
    if(rising_edge(reloj)) then
      if (delay = 24999999) then --1Hz
        delay <= 0;
        div <= not (div);
      else
        delay <= delay + 1;
      end if;
    end if;
  end process divisor;
  
  --Registro de dirección actual
  reg_dir: process(div)
  begin
    if rising_edge(div) then
      memory_address(5) <= liga(2);
		memory_address(4) <= liga(1);
		memory_address(3) <= liga(0);
		memory_address(2) <= switches(2);
		memory_address(1) <= switches(1);
		memory_address(0) <= switches(0);				
    end if;
  end process reg_dir;

  --Registro de salidas
  reg_sal: process(div)
  begin
    if rising_edge(div) then
      leds <= salidas;
    end if;
  end process reg_sal;
end Prac7_2;

