LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY UART IS
	PORT (
		CLK : IN std_logic; --Reloj de FPGA
		RX : IN std_logic; --Pin de recepci?n de RS232
		TX : OUT std_logic; --Pin de transmisi?n de RS232
		leds : OUT std_logic_vector(7 DOWNTO 0);
		switch : IN std_logic_vector(7 DOWNTO 0)
	);
END UART;

ARCHITECTURE Behavioral OF UART IS
	--Señal para recibir el dato
	SIGNAL datain_s,dout_s : std_logic_vector(7 DOWNTO 0);
	SIGNAL rx_in_s,tx_fin_s,tx_ini_s : std_logic;

	COMPONENT RS232 IS
		GENERIC (
			FPGA_CLK : INTEGER := 50000000; --FRECUENCIA DEL FPGA 
			BAUD_RS232 : INTEGER := 9600 --BAUDIOS
		);
		PORT (
			CLK : IN std_logic; --Reloj de FPGA
			RX : IN std_logic; --Pin de recepci?n de RS232
			TX_INI : IN std_logic; --Debe ponerse a '1' para inciar transmisi?n
			TX_FIN : OUT std_logic; --Se pone '1' cuando termina la transmisi?n
			TX : OUT std_logic; --Pin de transmisi?n de RS232
			RX_IN : OUT std_logic; --Se pone a '1' cuando se ha recibido un Byte. Solo dura un 
			--Ciclo de reloj
			DATAIN : IN std_logic_vector(7 DOWNTO 0); --Puerto de datos de entrada para transmisi?n
			DOUT : OUT std_logic_vector(7 DOWNTO 0) --Puerto de datos de salida para recepci?n
		);
	END COMPONENT;
BEGIN
	u1 : RS232 GENERIC MAP(FPGA_CLK => 50000000, BAUD_RS232 => 9600)
	PORT MAP(
		CLK => CLK, RX => RX, TX_INI => tx_ini_s, TX_FIN => tx_fin_s, TX => TX,
		RX_IN => rx_in_s, DATAIN => datain_s, DOUT => dout_s);

	datos_entrada : PROCESS (rx_in_s)
	BEGIN
		IF (rx_in_s = '1') THEN
			leds <= std_logic_vector(signed(dout_s));
		END IF;
	END PROCESS datos_entrada;

	--Proceso de transmision
	datos_salida : PROCESS (tx_fin_s)
	BEGIN
		IF (tx_fin_s = '0') THEN
			tx_ini_s<='1';
			datain_s <= std_logic_vector(signed(switch));
		else
			tx_ini_s<='0';
		END IF;
	END PROCESS datos_salida;
END Behavioral;