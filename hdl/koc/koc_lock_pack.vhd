library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

package koc_lock_pack is

    constant default_axi_address_width : integer := 32;
    constant default_axi_data_width : integer := 32;
    constant default_axi_control_offset : integer := 0;
    constant default_control_default : integer := 1;

    constant axi_resp_okay : std_logic_vector := "00";
    
    component koc_lock is
        generic (
            axi_address_width : integer := default_axi_address_width;            --! Defines the AXI4-Lite Address Width.
            axi_data_width : integer := default_axi_data_width;               --! Defines the AXI4-Lite Data Width.   
            axi_control_offset : integer := default_axi_control_offset;            --! Defines the offset for the Control register.
            control_default : integer := default_control_default
        );
        port (
            aclk : in std_logic;                                                --! Clock. Tested with 50 MHz.
            aresetn : in std_logic;
            axi_awaddr : in std_logic_vector(axi_address_width-1 downto 0);                 --! AXI4-Lite Address Write signal.
            axi_awprot : in std_logic_vector(2 downto 0);                                   --! AXI4-Lite Address Write signal.
            axi_awvalid : in std_logic;                                                     --! AXI4-Lite Address Write signal.
            axi_awready : out std_logic;                                                    --! AXI4-Lite Address Write signal.
            axi_wvalid : in std_logic;                                                      --! AXI4-Lite Write Data signal.
            axi_wready : out std_logic;                                                     --! AXI4-Lite Write Data signal.
            axi_wdata : in std_logic_vector(axi_data_width-1 downto 0);                     --! AXI4-Lite Write Data signal.    
            axi_wstrb : in std_logic_vector(axi_data_width/8-1 downto 0);                   --! AXI4-Lite Write Data signal.
            axi_bvalid : out std_logic;                                                     --! AXI4-Lite Write Response signal.
            axi_bready : in std_logic;                                                      --! AXI4-Lite Write Response signal.
            axi_bresp : out std_logic_vector(1 downto 0);                                   --! AXI4-Lite Write Response signal.
            axi_araddr : in std_logic_vector(axi_address_width-1 downto 0);                 --! AXI4-Lite Address Read signal.
            axi_arprot : in std_logic_vector(2 downto 0);                                   --! AXI4-Lite Address Read signal.
            axi_arvalid : in std_logic;                                                     --! AXI4-Lite Address Read signal.
            axi_arready : out std_logic;                                                    --! AXI4-Lite Address Read signal.
            axi_rdata : out std_logic_vector(axi_data_width-1 downto 0) := (others=>'0');   --! AXI4-Lite Read Data signal.
            axi_rvalid : out std_logic;                                                     --! AXI4-Lite Read Data signal.
            axi_rready : in std_logic;                                                      --! AXI4-Lite Read Data signal.
            axi_rresp : out std_logic_vector(1 downto 0)  
        );
    end component;
end package;