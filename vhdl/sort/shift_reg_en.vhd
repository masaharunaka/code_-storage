-- shift_reg.vhd
-- author:manaka
-- date:19/09/07
-- Description:First

-- History
-- v0.1 first

-- Library
library IEEE;
use IEEE.std_logic_1164.all;

-- entity
entity SHIFT_REG_EN is
   generic
   (
       SHIFT_CYCLE : integer := 5  ;
       SHIFT_WIDTH : integer := 12 
   );
  port (
    RST       : in  std_logic;
    CLK       : in  std_logic;
    CLR       : in  std_logic;
    EN        : in  std_logic;
    DATA_IN   : in  std_logic_vector( SHIFT_WIDTH - 1 downto 0);
    DATA_OUT  : out std_logic_vector( SHIFT_WIDTH - 1 downto 0) 
  );
end SHIFT_REG_EN;

-- architecture
architecture RTL of SHIFT_REG_EN is

subtype DATA_WIDTH is std_logic_vector( SHIFT_WIDTH-1 downto 0 );
type DFF_ARRAY_WIRE is array ( SHIFT_CYCLE downto 0 ) of DATA_WIDTH;
type DFF_ARRAY_REG  is array ( SHIFT_CYCLE downto 1 ) of DATA_WIDTH;

signal data_ff   : DFF_ARRAY_WIRE;
signal data_ff_r : DFF_ARRAY_REG;

begin
  GEN_SHIFT:
  for reg_lp in 0 to SHIFT_CYCLE-1 generate
    process(RST,CLK)
    begin
      if(RST = '1')then
          data_ff_r(reg_lp+1) <= (others => '0');
      elsif(CLK'event and CLK = '1')then
        if(CLR = '1')then
          data_ff_r(reg_lp+1) <= (others => '0');
        elsif(EN = '1')then
          data_ff_r(reg_lp+1) <= data_ff(reg_lp);
        end if;
      end if;
    end process;
  end generate GEN_SHIFT;

  GEN_WIRE:
  for wire_lp in 1 to SHIFT_CYCLE generate
    data_ff(wire_lp) <= data_ff_r(wire_lp);
  end generate GEN_WIRE;
  
  -- external port --
  data_ff(0) <= data_in              ;
  data_out   <= data_ff(SHIFT_CYCLE) ;
  
end RTL;