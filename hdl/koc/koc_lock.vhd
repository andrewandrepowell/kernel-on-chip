library ieee;
use ieee.std_logic_1164.all;          
use ieee.numeric_std.all;                  
use work.plasoc_gpio_pack.all;

entity koc_lock is
    generic (
        axi_address_width : integer := 16;            --! Defines the AXI4-Lite Address Width.
        axi_data_width : integer := 32;               --! Defines the AXI4-Lite Data Width.   
        axi_control_offset : integer := 0             --! Defines the offset for the Control register.
    );
    port (
        aclk : in std_logic;                                                --! Clock. Tested with 50 MHz.
        aresetn : in std_logic; 
        -- Slave AXI4-Lite Write interface.
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
        -- Slave AXI4-Lite Read interface.
        axi_araddr : in std_logic_vector(axi_address_width-1 downto 0);                 --! AXI4-Lite Address Read signal.
        axi_arprot : in std_logic_vector(2 downto 0);                                   --! AXI4-Lite Address Read signal.
        axi_arvalid : in std_logic;                                                     --! AXI4-Lite Address Read signal.
        axi_arready : out std_logic;                                                    --! AXI4-Lite Address Read signal.
        axi_rdata : out std_logic_vector(axi_data_width-1 downto 0) := (others=>'0');   --! AXI4-Lite Read Data signal.
        axi_rvalid : out std_logic;                                                     --! AXI4-Lite Read Data signal.
        axi_rready : in std_logic;                                                      --! AXI4-Lite Read Data signal.
        axi_rresp : out std_logic_vector(1 downto 0)  
    );
end koc_lock;

architecture Behavioral of koc_lock is
    component koc_lock_axi4_write_cntrl is
        generic (
            axi_address_width : integer := 16;
            axi_data_width : integer := 32;
            reg_control_offset : std_logic_vector := X"0000"
        );
        port (
            aclk : in std_logic;                                                
            aresetn : in std_logic; 
            axi_awaddr : in std_logic_vector(axi_address_width-1 downto 0);    
            axi_awprot : in std_logic_vector(2 downto 0);                 
            axi_awvalid : in std_logic; 
            axi_awready : out std_logic;
            axi_wvalid : in std_logic;
            axi_wready : out std_logic;
            axi_wdata : in std_logic_vector(axi_data_width-1 downto 0);
            axi_wstrb : in std_logic_vector(axi_data_width/8-1 downto 0);
            axi_bvalid : out std_logic;
            axi_bready : in std_logic;
            axi_bresp : out std_logic_vector(1 downto 0);
            reg_control : out std_logic_vector(axi_data_width-1 downto 0)
        );
    end component;
    component koc_lock_axi4_read_cntrl is
        generic (
            axi_address_width : integer := 16;
            axi_data_width : integer := 32;
            reg_control_offset : std_logic_vector := X"0000"
        );
        port (
            aclk : in std_logic;                                                            
            aresetn : in std_logic;                                                         
            axi_araddr : in std_logic_vector(axi_address_width-1 downto 0);                 --! AXI4-Lite Address Read signal.
            axi_arprot : in std_logic_vector(2 downto 0);                                   --! AXI4-Lite Address Read signal.
            axi_arvalid : in std_logic;                                                     --! AXI4-Lite Address Read signal.
            axi_arready : out std_logic;                                                    --! AXI4-Lite Address Read signal.
            axi_rdata : out std_logic_vector(axi_data_width-1 downto 0) := (others=>'0');   --! AXI4-Lite Read Data signal.
            axi_rvalid : out std_logic;                                                     --! AXI4-Lite Read Data signal.
            axi_rready : in std_logic;                                                      --! AXI4-Lite Read Data signal.
            axi_rresp : out std_logic_vector(1 downto 0);                                   --! AXI4-Lite Read Data signal.
            reg_control : in std_logic_vector(axi_data_width-1 downto 0)
        );
    end component;
    constant axi_control_offset_slv : std_logic_vector := std_logic_vector(to_unsigned(axi_control_offset,axi_address_width));
    signal reg_control : std_logic_vector(axi_data_width-1 downto 0);
begin

    koc_lock_axi4_write_cntrl_inst : koc_lock_axi4_write_cntrl
        generic map (
            axi_address_width => axi_address_width,
            axi_data_width => axi_data_width,
            reg_control_offset => axi_control_offset_slv)
        port map (
            aclk => aclk,
            aresetn => aresetn,
            axi_awaddr => axi_awaddr,
            axi_awprot => axi_awprot,
            axi_awvalid => axi_awvalid,
            axi_awready => axi_awready,
            axi_wvalid => axi_wvalid,
            axi_wready => axi_wready,
            axi_wdata => axi_wdata,
            axi_wstrb => axi_wstrb,
            axi_bvalid => axi_bvalid,
            axi_bready => axi_bready,
            axi_bresp => axi_bresp,
            reg_control => reg_control);
            
    koc_lock_axi4_read_cntrl_inst : koc_lock_axi4_read_cntrl
        generic map (
            axi_address_width => axi_address_width,
            axi_data_width => axi_data_width,
            reg_control_offset => axi_control_offset_slv)
        port map (
            aclk => aclk,
            aresetn => aresetn,
            axi_araddr => axi_araddr,
            axi_arprot => axi_arprot,
            axi_arvalid => axi_arvalid,
            axi_arready => axi_arready,
            axi_rdata => axi_rdata,
            axi_rvalid => axi_rvalid,
            axi_rready => axi_rready,
            axi_rresp => axi_rresp,
            reg_control => reg_control);

end Behavioral;
