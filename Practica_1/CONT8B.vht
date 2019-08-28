-- Copyright (C) 2018  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "08/21/2019 23:17:06"
                                                            
-- Vhdl Test Bench template for design  :  CONT8B
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY CONT8B_vhd_tst IS
END CONT8B_vhd_tst;
ARCHITECTURE CONT8B_arch OF CONT8B_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL IP : STD_LOGIC;
SIGNAL LEDS : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL RELOJ : STD_LOGIC;
SIGNAL RESET : STD_LOGIC;
COMPONENT CONT8B
	PORT (
	IP : IN STD_LOGIC;
	LEDS : BUFFER STD_LOGIC_VECTOR(7 DOWNTO 0);
	RELOJ : IN STD_LOGIC;
	RESET : IN STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : CONT8B
	PORT MAP (
-- list connections between master ports and signals
	IP => IP,
	LEDS => LEDS,
	RELOJ => RELOJ,
	RESET => RESET
	);
clk_tb : PROCESS                                               
-- variable declarations                                     
BEGIN                                                        
	RELOJ <= '0';
	WAIT for 10 ps;
	RELOJ <= '1';
	WAIT for 10 ps;
END PROCESS clk_tb;

ip_tb : process
begin
	ip <= '0';
	wait for 200 ps;
	ip <= '1';
	wait;
end process ip_tb;
                                          
reset_tb : PROCESS                                              
BEGIN                                                         
	RESET <= '1';
	WAIT for 200 ps;
	RESET <= '0';
	WAIT for 800 ps;
	RESET <= '1';
	WAIT;
END PROCESS reset_tb;                                          
END CONT8B_arch;
