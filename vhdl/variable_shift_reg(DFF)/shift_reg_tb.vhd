-- shift_reg.vhd
-- author:manaka
-- date:19/09/07
-- Description:First

-- History
-- v0.1 first

-- Library
library	IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

-- entity
entity SHIFT_REG_TB is
end SHIFT_REG_TB;

architecture SIM of SHIFT_REG_TB is

signal   CLK         : std_logic;
constant clk_period  : time := 100 ns;


signal INITIALIZE : std_logic;
signal ENABLE     : std_logic;
signal CARRY      : std_logic;

-- Test Module
component SHIFT_REG is
   generic
   (
       SHIFT_CYCLE : integer := 5  ;
       SHIFT_WIDTH : integer := 12 
   );
  port (
    RST       : in  std_logic;
    CLK       : in  std_logic;
    DATA_IN   : in  std_logic_vector( SHIFT_WIDTH downto 0);
    DATA_OUT  : out std_logic_vector( SHIFT_WIDTH downto 0) 
  );
end component;
	
begin
    -- generate clk
    process begin
        CLK <= '1'; wait for clk_period/2;
        CLK <= '0'; wait for clk_period/2;
    end process;

    -- Instance0 
    shift_reg_i0: SHIFT_REG 
	generic map(
	  SHIFT_CYCLE => 4,
	  SHIFT_WIDTH => 6 
	) 
	port map( 
	  RST      => RST,
	  CLK      => CLK,
	  DATA_IN  => DATA_IN,
	  DATA_OUT => DATA_OUT,
	);

    -- INITIALIZE
    process begin
	  RST <= '1'
	  wait clk_period*10;
	  RST <= '0'
      wait;
    end process;
end SIM;

configuration BEHAVIOR OF SHIFT_REG_TB IS
for SIM end for;
end BEHAVIOR