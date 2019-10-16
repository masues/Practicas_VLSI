LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY control_asm_ee IS
  PORT (
    entradas : std_logic_vector(3 DOWNTO 0);
    reloj : std_logic;
    salidas : OUT std_logic_vector(5 DOWNTO 0));

END control_asm_ee;

ARCHITECTURE Prac7_1 OF control_asm_ee IS
  --Divisor de frecuencia
  SIGNAL delay : INTEGER RANGE 0 TO 24999999;
  SIGNAL div : std_logic;
  --Datos obtenidos de la memoria
  SIGNAL data : std_logic_vector(13 DOWNTO 0);
  --Dirección de la memoria
  SIGNAL memory_address : std_logic_vector(2 DOWNTO 0);
  --Registro que almacena la dirección actual de la memoria
  SIGNAL reg_liga : std_logic_vector(2 DOWNTO 0);
  --Registro de salidas
  SIGNAL reg_salida : std_logic_vector(5 DOWNTO 0);
  --División de la memoria en partes
  SIGNAL prueba : std_logic_vector(1 DOWNTO 0);
  SIGNAL liga_falsa : std_logic_vector(2 DOWNTO 0);
  SIGNAL liga_verdadera : std_logic_vector(2 DOWNTO 0);
  --Señal auxiliar para el selector de liga
  SIGNAL seg_selector_liga : std_logic;
BEGIN
  ROM : ENTITY work.rom_entrada_estado --Se crea una "instancia" del otro módulo
    PORT MAP(addr => memory_address, data => data);
  --Separación de las salidas de la memoria en señales independientes

  --Prueba
  prueba(1) <= data(13);
  prueba(0) <= data(12);

  --Ligas
  liga_falsa(2) <= data(11);
  liga_falsa(1) <= data(10);
  liga_falsa(0) <= data(9);

  liga_verdadera(2) <= data(8);
  liga_verdadera(1) <= data(7);
  liga_verdadera(0) <= data(6);

  --Salidas
  reg_salida(5) <= data(5);
  reg_salida(4) <= data(4);
  reg_salida(3) <= data(3);
  reg_salida(2) <= data(2);
  reg_salida(1) <= data(1);
  reg_salida(0) <= data(0);

  divisor : PROCESS (reloj)
  BEGIN
    IF (rising_edge(reloj)) THEN
      IF (delay = 24999999) THEN --1Hz
        delay <= 0;
        div <= NOT (div);
      ELSE
        delay <= delay + 1;
      END IF;
    END IF;
  END PROCESS divisor;

  --Multiplexor del selector de entradas
  mux_entradas : PROCESS (prueba)
  BEGIN
    CASE(prueba) IS
      WHEN "00" => --Entrada A de la ASM
      seg_selector_liga <= entradas(0);
      WHEN "01" => --Entrada B de la ASM
      seg_selector_liga <= entradas(1);
      WHEN "10" => --Entrada C de la ASM
      seg_selector_liga <= entradas(2);
      WHEN OTHERS => --Entrada auxiliar
      seg_selector_liga <= entradas(3);
    END CASE;
  END PROCESS mux_entradas;

  --Multiplexor del selector de liga
  mux_liga : PROCESS (seg_selector_liga)
  BEGIN
    CASE(seg_selector_liga) IS
      WHEN '0' =>
      reg_liga <= liga_falsa;
      WHEN OTHERS =>
      reg_liga <= liga_verdadera;
    END CASE;
  END PROCESS mux_liga;

  --Registro de dirección actual
  reg_dir : PROCESS (div)
  BEGIN
    IF rising_edge(div) THEN
      memory_address <= reg_liga;
    END IF;
  END PROCESS reg_dir;

  --Registro de salidas
  reg_sal : PROCESS (div)
  BEGIN
    IF rising_edge(div) THEN
      salidas <= reg_salida;
    END IF;
  END PROCESS reg_sal;

END Prac7_1;