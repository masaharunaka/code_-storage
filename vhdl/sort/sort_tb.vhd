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
entity SORT_TB is
end SORT_TB;

architecture SIM of SORT_TB is

signal   RST         : std_logic;-- Async Reset
signal   CLK         : std_logic;
constant clk_period  : time := 100 ns;

signal clr         : std_logic                     ;-- Sync Clear
signal swap_en     : std_logic                     ;-- Enable swap 1 pulse
signal dout_en     : std_logic                     ;-- Enable data out 1 pulse
signal data_in     : std_logic_vector( 4 downto 0) ;
signal dout_vld    : std_logic                     ;-- Data valid
signal data_out    : std_logic_vector( 4 downto 0) ;

--integer i;

-- Test Module
component SORT is
  port (
    RST         : in  std_logic;-- Async Reset
    CLK         : in  std_logic;-- 
    CLR         : in  std_logic;-- Sync Clear
    SWAP_EN     : in  std_logic;-- Enable swap 1 pulse
    DOUT_EN     : in  std_logic;-- Enable data out 1 pulse
    DATA_IN     : in  std_logic_vector( 4 downto 0);
    DOUT_VLD    : out std_logic;-- Data valid
    DATA_OUT    : out std_logic_vector( 4 downto 0)
    );
end component;

begin
    -- generate clk
    process begin
        CLK <= '1'; wait for clk_period/2;
        CLK <= '0'; wait for clk_period/2;
    end process;

    -- Instance0 
    SORT_inst: sort 
	port map( 
      RST         => RST      , --: in  std_logic                     ;-- Async Reset
      CLK         => CLK      , --: in  std_logic                     ;-- 
      CLR         => clr      , --: in  std_logic                     ;-- Sync Clear
      SWAP_EN     => swap_en  , --: in  std_logic                     ;-- Enable swap 1 pulse
      DOUT_EN     => dout_en  , --: in  std_logic                     ;-- Enable data out 1 pulse
      DATA_IN     => data_in  , --: in  std_logic_vector( 4 downto 0) ;
      DOUT_VLD    => dout_vld , --: in  std_logic                     ;-- Data valid
      DATA_OUT    => data_out   --: out std_logic_vector( 4 downto 0)
    );
    
    -- INITIALIZE
    process begin
      RST      <= '1';
      clr      <= '0';
      swap_en  <= '0';
      dout_en  <= '0';
      data_in  <= (others => '0');
      wait for clk_period*50;
      RST <= '0';
      wait for clk_period*10;
      
      for i in 0 to 31 loop
        data_in  <= CONV_std_logic_vector(i,5); swap_en<='1'; wait for clk_period; swap_en  <= '0' ; wait for clk_period*10;
      end loop;
      
      -- trigger dout
      dout_en  <= '1'; wait for clk_period ; dout_en<='0' ; wait for clk_period*10;
      -- Clear 
      clr  <= '1'; wait for clk_period ; clr  <= '0' ; wait for clk_period*10;
      
      for i in 0 to 31 loop
        data_in  <= CONV_std_logic_vector(31-i,5); swap_en<='1'; wait for clk_period; swap_en  <= '0' ; wait for clk_period*10;
      end loop;
      
      -- trigger dout
      dout_en  <= '1'; wait for clk_period ; dout_en<='0' ; wait for clk_period*10;
      -- Clear 
      clr  <= '1'; wait for clk_period ; clr  <= '0' ; wait for clk_period*10;
      
      data_in  <= CONV_std_logic_vector( 8,5); swap_en<='1'; wait for clk_period; swap_en  <= '0' ; wait for clk_period*10;
      data_in  <= CONV_std_logic_vector(18,5); swap_en<='1'; wait for clk_period; swap_en  <= '0' ; wait for clk_period*10;
      data_in  <= CONV_std_logic_vector(22,5); swap_en<='1'; wait for clk_period; swap_en  <= '0' ; wait for clk_period*10;
      data_in  <= CONV_std_logic_vector(19,5); swap_en<='1'; wait for clk_period; swap_en  <= '0' ; wait for clk_period*10;
      data_in  <= CONV_std_logic_vector(28,5); swap_en<='1'; wait for clk_period; swap_en  <= '0' ; wait for clk_period*10;
      data_in  <= CONV_std_logic_vector(12,5); swap_en<='1'; wait for clk_period; swap_en  <= '0' ; wait for clk_period*10;
      data_in  <= CONV_std_logic_vector(26,5); swap_en<='1'; wait for clk_period; swap_en  <= '0' ; wait for clk_period*10;
      data_in  <= CONV_std_logic_vector(28,5); swap_en<='1'; wait for clk_period; swap_en  <= '0' ; wait for clk_period*10;
      data_in  <= CONV_std_logic_vector(17,5); swap_en<='1'; wait for clk_period; swap_en  <= '0' ; wait for clk_period*10;
      data_in  <= CONV_std_logic_vector( 2,5); swap_en<='1'; wait for clk_period; swap_en  <= '0' ; wait for clk_period*10;
      -- trigger dout
      dout_en  <= '1'; wait for clk_period ; dout_en<='0' ; wait for clk_period*10;
      -- Clear 
      clr  <= '1'; wait for clk_period ; clr  <= '0' ; wait for clk_period*10;
      
      std.env.finish; 
    end process;
end SIM;

configuration BEHAVIOR OF SORT_TB IS
for SIM end for;
end BEHAVIOR;