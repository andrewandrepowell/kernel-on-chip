library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.nexys4_pack.all;

entity testbench is
end testbench;

architecture Behavioral of testbench is
    component koc_wrapper is
        generic (
            lower_app : string := "jump";
            upper_app : string := "main";
            upper_ext : boolean := false);
        port (
            sys_clk_i : in std_logic;
            sys_rst : in std_logic;
            gpio_output : out std_logic_vector(data_out_width-1 downto 0);
            gpio_input : in std_logic_vector(data_in_width-1 downto 0);
            uart_tx : out std_logic;
            uart_rx : in std_logic;
            DDR2_addr : out STD_LOGIC_VECTOR ( 12 downto 0 );
            DDR2_ba : out STD_LOGIC_VECTOR ( 2 downto 0 );
            DDR2_cas_n : out STD_LOGIC;
            DDR2_ck_n : out STD_LOGIC_VECTOR ( 0 to 0 );
            DDR2_ck_p : out STD_LOGIC_VECTOR ( 0 to 0 );
            DDR2_cke : out STD_LOGIC_VECTOR ( 0 to 0 );
            DDR2_cs_n : out STD_LOGIC_VECTOR ( 0 to 0 );
            DDR2_dm : out STD_LOGIC_VECTOR ( 1 downto 0 );
            DDR2_dq : inout STD_LOGIC_VECTOR ( 15 downto 0 );
            DDR2_dqs_n : inout STD_LOGIC_VECTOR ( 1 downto 0 );
            DDR2_dqs_p : inout STD_LOGIC_VECTOR ( 1 downto 0 );
            DDR2_odt : out STD_LOGIC_VECTOR ( 0 to 0 );
            DDR2_ras_n : out STD_LOGIC;
            DDR2_we_n : out STD_LOGIC);
    end component;
begin


end Behavioral;
