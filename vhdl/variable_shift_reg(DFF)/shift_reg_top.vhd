-- shift_reg.vhd
-- author:manaka
-- date:19/09/07
-- Description:First

-- History
-- v0.1 first

-- Library
library	IEEE;
use IEEE.std_logic_1164.all;

-- entity
entity SHIFT_REG_TOP is
  port (
    RST         : in  std_logic;
    CLK         : in  std_logic;
    DATA_IN_01  : in  std_logic_vector(11 downto 0);
    DATA_OUT_01 : out std_logic_vector(11 downto 0);
    DATA_IN_02  : in  std_logic_vector(31 downto 0);
    DATA_OUT_02 : out std_logic_vector(31 downto 0);
    DATA_IN_03  : in  std_logic_vector( 0 downto 0);
    DATA_OUT_03 : out std_logic_vector( 0 downto 0)
	);
end SHIFT_REG_TOP;

-- architecture
architecture RTL of SHIFT_REG_TOP is

component SHIFT_REG is
   generic
   (
       SHIFT_CYCLE : integer := 5  ;
       SHIFT_WIDTH : integer := 12 
   );
  port (
    RST       : in  std_logic;
    CLK       : in  std_logic;
    DATA_IN   : in  std_logic_vector( SHIFT_WIDTH - 1 downto 0);
    DATA_OUT  : out std_logic_vector( SHIFT_WIDTH - 1 downto 0) 
  );
end component;

begin

    ------------------------
    --  shift_reg module
    ------------------------
    shift_reg_i1: SHIFT_REG 
	generic map(
	  SHIFT_CYCLE => 5,
	  SHIFT_WIDTH => 12 
	) 
	port map( 
	  RST      => RST,
	  CLK      => CLK,
	  DATA_IN  => DATA_IN_01,
	  DATA_OUT => DATA_OUT_01
	);
	
    shift_reg_i2: SHIFT_REG 
	generic map(
	  SHIFT_CYCLE => 11,
	  SHIFT_WIDTH => 32 
	) 
	port map( 
	  RST      => RST,
	  CLK      => CLK,
	  DATA_IN  => DATA_IN_02,
	  DATA_OUT => DATA_OUT_02
	);
	
    shift_reg_i3: SHIFT_REG 
	generic map(
	  SHIFT_CYCLE => 22,
	  SHIFT_WIDTH =>  1 
	) 
	port map( 
	  RST      => RST,
	  CLK      => CLK,
	  DATA_IN  => DATA_IN_03,
	  DATA_OUT => DATA_OUT_03
	);

end RTL;
