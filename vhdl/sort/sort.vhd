-- sort.vhd
-- Author:manaka
-- date:20/07/11
-- Description:First

-- History
-- v0.1 first

-- Library
library	IEEE;
use IEEE.std_logic_1164.all;

-- entity
entity SORT is
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
end SORT;

-- architecture
architecture RTL of SORT is

component SHIFT_REG_EN is
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
end component;

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

-- sort data function
signal swap_en_in  : std_logic_vector( 0 downto 0);
signal swap4_tm    : std_logic_vector( 0 downto 0);
signal swap3_tm    : std_logic_vector( 0 downto 0);
signal swap2_tm    : std_logic_vector( 0 downto 0);
signal swap1_tm    : std_logic_vector( 0 downto 0);
signal swap_tm     : std_logic                    ;-- chcek signal 
signal swap4_flg   : std_logic                    ;
signal swap3_flg   : std_logic                    ;
signal swap2_flg   : std_logic                    ;
signal swap1_flg   : std_logic                    ;
signal swap4_en    : std_logic                    ;
signal swap3_en    : std_logic                    ;
signal swap2_en    : std_logic                    ;
signal swap1_en    : std_logic                    ;
signal data_i      : std_logic_vector( 4 downto 0);
signal data4th_in  : std_logic_vector( 4 downto 0);
signal data4th_out : std_logic_vector( 4 downto 0);
signal data3rd_in  : std_logic_vector( 4 downto 0);
signal data3rd_out : std_logic_vector( 4 downto 0);
signal data2nd_in  : std_logic_vector( 4 downto 0);
signal data2nd_out : std_logic_vector( 4 downto 0);
signal data1st_in  : std_logic_vector( 4 downto 0);
signal data1st_out : std_logic_vector( 4 downto 0);
signal data_o      : std_logic_vector( 4 downto 0);

signal reg4th_en    : std_logic                   ;
signal reg3rd_en    : std_logic                   ;
signal reg2nd_en    : std_logic                   ;
signal reg1st_en    : std_logic                   ;

-- output data function
signal strm_en_in  : std_logic_vector( 0 downto 0);
signal strm1_tm    : std_logic_vector( 0 downto 0);
signal strm2_tm    : std_logic_vector( 0 downto 0);
signal strm3_tm    : std_logic_vector( 0 downto 0);
signal strm4_tm    : std_logic_vector( 0 downto 0);
signal strm_vld    : std_logic  ;

-----------------------------------------------------------
-----------------------------------------------------------
begin

-- input
swap_en_in(0) <= SWAP_EN   ;
data_i        <= DATA_IN   ;

-- swap enable 
swap4_tm(0)   <= swap_en_in(0) and ( not strm_vld ) ; -- ignore if data out  timing 
sft_01_swap3 : SHIFT_REG generic map(1,1)port map(RST,CLK,swap4_tm,swap3_tm);
sft_02_swap2 : SHIFT_REG generic map(1,1)port map(RST,CLK,swap3_tm,swap2_tm);
sft_03_swap1 : SHIFT_REG generic map(1,1)port map(RST,CLK,swap2_tm,swap1_tm);
swap_tm <= swap4_tm(0) or swap3_tm(0) or swap2_tm(0) or swap1_tm(0);
-- swap compare
swap4_flg <= '1' when data_i      > data4th_out else '0' ;
swap3_flg <= '1' when data4th_out > data3rd_out else '0' ;
swap2_flg <= '1' when data3rd_out > data2nd_out else '0' ;
swap1_flg <= '1' when data2nd_out > data1st_out else '0' ;

-- swap enable
swap4_en <= swap4_flg and swap4_tm(0) ;
swap3_en <= swap3_flg and swap3_tm(0) ;
swap2_en <= swap2_flg and swap2_tm(0) ;
swap1_en <= swap1_flg and swap1_tm(0) ;

--------------------
-- Sort registers --
--------------------
-- enable 
reg4th_en <= swap4_en or swap3_en             ;
reg3rd_en <= swap3_en or swap2_en or strm_vld ;
reg2nd_en <= swap2_en or swap1_en or strm_vld ;
reg1st_en <= swap1_en             or strm_vld ;

-- data input selector 
data4th_in <= data3rd_out when swap3_en = '1' else data_i      ;
data3rd_in <= data2nd_out when swap2_en = '1' else data4th_out ;
data2nd_in <= data1st_out when swap1_en = '1' else data3rd_out ;
data1st_in <= data2nd_out                                      ;

-- register
reg_4th : SHIFT_REG_EN generic map(1,5)port map(RST,CLK,CLR,reg4th_en,data4th_in,data4th_out);
reg_3rd : SHIFT_REG_EN generic map(1,5)port map(RST,CLK,CLR,reg3rd_en,data3rd_in,data3rd_out);
reg_2nd : SHIFT_REG_EN generic map(1,5)port map(RST,CLK,CLR,reg2nd_en,data2nd_in,data2nd_out);
reg_1st : SHIFT_REG_EN generic map(1,5)port map(RST,CLK,CLR,reg1st_en,data1st_in,data1st_out);

--------------------------------------
-- User additional register is here --

-- data input selector 

-- register

--------------------------------------

-- output
data_o   <= data1st_out ;
DATA_OUT <= data_o      ;

--------------------
-- stream enable  --
--------------------
-- dout enable shift
strm_en_in(0) <= DOUT_EN and (not swap_tm); -- ignore if swap timing 
sft_01_strm1 : SHIFT_REG generic map(1,1)port map(RST,CLK,strm_en_in,strm1_tm);
sft_02_strm2 : SHIFT_REG generic map(1,1)port map(RST,CLK,  strm1_tm,strm2_tm);
sft_03_strm3 : SHIFT_REG generic map(1,1)port map(RST,CLK,  strm2_tm,strm3_tm);
sft_04_strm4 : SHIFT_REG generic map(1,1)port map(RST,CLK,  strm3_tm,strm4_tm);

-- stream valid
strm_vld <= strm1_tm(0) or strm2_tm(0) or strm3_tm(0) or strm4_tm(0) ;

-- output stream valid
DOUT_VLD <= strm_vld ;

end RTL;
