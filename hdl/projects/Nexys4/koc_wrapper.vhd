library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.nexys4_pack.all;
use work.plasoc_interconnect_crossbar_wrap_pack.plasoc_interconnect_crossbar_wrap;
use work.plasoc_interconnect_crossbar_wrap_pack.clogb2;
use work.plasoc_cpu_0_crossbar_wrap_pack.plasoc_cpu_0_crossbar_wrap;
use work.plasoc_cpu_1_crossbar_wrap_pack.plasoc_cpu_1_crossbar_wrap;
use work.plasoc_cpu_2_crossbar_wrap_pack.plasoc_cpu_2_crossbar_wrap;
use work.plasoc_cpu_pack.plasoc_cpu;
use work.plasoc_int_pack.plasoc_int;
use work.plasoc_timer_pack.plasoc_timer;
use work.plasoc_gpio_pack.plasoc_gpio;
use work.plasoc_uart_pack.plasoc_uart;
use work.plasoc_axi4_full2lite_pack.plasoc_axi4_full2lite;
use work.koc_lock_pack.koc_lock;
use work.koc_signal_pack.koc_signal;

entity koc_wrapper is
    generic (
        lower_app : string := "boot";
        upper_app : string := "none";
        upper_ext : boolean := true);
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
end koc_wrapper;

architecture Behavioral of koc_wrapper is

    ----------------------------
    -- Component Declarations --
    ----------------------------

    component bd_wrapper is
        port (
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
            DDR2_we_n : out STD_LOGIC;
            S00_AXI_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
            S00_AXI_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
            S00_AXI_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
            S00_AXI_arid : in STD_LOGIC_VECTOR ( 3 downto 0 );
            S00_AXI_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
            S00_AXI_arlock : in STD_LOGIC_VECTOR ( 0 to 0 );
            S00_AXI_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
            S00_AXI_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
            S00_AXI_arready : out STD_LOGIC;
            S00_AXI_arregion : in STD_LOGIC_VECTOR ( 3 downto 0 );
            S00_AXI_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
            S00_AXI_arvalid : in STD_LOGIC;
            S00_AXI_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
            S00_AXI_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
            S00_AXI_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
            S00_AXI_awid : in STD_LOGIC_VECTOR ( 3 downto 0 );
            S00_AXI_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
            S00_AXI_awlock : in STD_LOGIC_VECTOR ( 0 to 0 );
            S00_AXI_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
            S00_AXI_awqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
            S00_AXI_awready : out STD_LOGIC;
            S00_AXI_awregion : in STD_LOGIC_VECTOR ( 3 downto 0 );
            S00_AXI_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
            S00_AXI_awvalid : in STD_LOGIC;
            S00_AXI_bid : out STD_LOGIC_VECTOR ( 3 downto 0 );
            S00_AXI_bready : in STD_LOGIC;
            S00_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
            S00_AXI_bvalid : out STD_LOGIC;
            S00_AXI_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
            S00_AXI_rid : out STD_LOGIC_VECTOR ( 3 downto 0 );
            S00_AXI_rlast : out STD_LOGIC;
            S00_AXI_rready : in STD_LOGIC;
            S00_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
            S00_AXI_rvalid : out STD_LOGIC;
            S00_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
            S00_AXI_wlast : in STD_LOGIC;
            S00_AXI_wready : out STD_LOGIC;
            S00_AXI_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
            S00_AXI_wvalid : in STD_LOGIC;
            aclk : out STD_LOGIC;
            interconnect_aresetn : out STD_LOGIC_VECTOR ( 0 to 0 );
            peripheral_aresetn : out STD_LOGIC_VECTOR ( 0 to 0 );
            sys_clk_i : in STD_LOGIC;
            sys_rst : in STD_LOGIC);
    end component; 
    component bram is
        generic (
            select_app : string := "none"; -- jump, boot, main
            address_width : integer := 18;
            data_width : integer := 32;
            bram_depth : integer := 65536);
        port(
            bram_rst_a : in std_logic;
            bram_clk_a : in std_logic;
            bram_en_a : in std_logic;
            bram_we_a : in std_logic_vector(data_width/8-1 downto 0);
            bram_addr_a : in std_logic_vector(address_width-1 downto 0);
            bram_wrdata_a : in std_logic_vector(data_width-1 downto 0);
            bram_rddata_a : out std_logic_vector(data_width-1 downto 0) := (others=>'0'));
    end component;
    component axi_bram_ctrl_0 IS
        port (
            s_axi_aclk : IN STD_LOGIC;
            s_axi_aresetn : IN STD_LOGIC;
            s_axi_awaddr : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            s_axi_awlen : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            s_axi_awsize : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            s_axi_awburst : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            s_axi_awlock : IN STD_LOGIC;
            s_axi_awcache : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            s_axi_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            s_axi_awvalid : IN STD_LOGIC;
            s_axi_awready : OUT STD_LOGIC;
            s_axi_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            s_axi_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            s_axi_wlast : IN STD_LOGIC;
            s_axi_wvalid : IN STD_LOGIC;
            s_axi_wready : OUT STD_LOGIC;
            s_axi_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            s_axi_bvalid : OUT STD_LOGIC;
            s_axi_bready : IN STD_LOGIC;
            s_axi_araddr : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            s_axi_arlen : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            s_axi_arsize : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            s_axi_arburst : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            s_axi_arlock : IN STD_LOGIC;
            s_axi_arcache : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            s_axi_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            s_axi_arvalid : IN STD_LOGIC;
            s_axi_arready : OUT STD_LOGIC;
            s_axi_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            s_axi_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            s_axi_rlast : OUT STD_LOGIC;
            s_axi_rvalid : OUT STD_LOGIC;
            s_axi_rready : IN STD_LOGIC;
            bram_rst_a : OUT STD_LOGIC;
            bram_clk_a : OUT STD_LOGIC;
            bram_en_a : OUT STD_LOGIC;
            bram_we_a : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            bram_addr_a : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            bram_wrdata_a : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            bram_rddata_a : IN STD_LOGIC_VECTOR(31 DOWNTO 0));
    end component;
    component clk_wiz_0 
        port (
            aclk : out std_logic;
            resetn : in std_logic;
            locked : out std_logic;
            sys_clk_i : in std_logic);
    end component;
    component proc_sys_reset_0 is
        port (
            slowest_sync_clk : IN STD_LOGIC;
            ext_reset_in : IN STD_LOGIC;
            aux_reset_in : IN STD_LOGIC;
            mb_debug_sys_rst : IN STD_LOGIC;
            dcm_locked : IN STD_LOGIC;
            mb_reset : OUT STD_LOGIC;
            bus_struct_reset : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
            peripheral_reset : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
            interconnect_aresetn : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
            peripheral_aresetn : OUT STD_LOGIC_VECTOR(0 DOWNTO 0));
    end component;
    
    constant axi_cpu_bus_slave_amount : integer := 1;
    constant axi_cpu_bus_slave_id_width : integer := 0;
    constant axi_cpu_bus_master_id_width : integer := clogb2(axi_cpu_bus_slave_amount)+axi_cpu_bus_slave_id_width;
    
    constant axi_slave_amount : integer := 3;
    constant axi_slave_id_width : integer := axi_cpu_bus_master_id_width;
    constant axi_master_id_width : integer := clogb2(axi_slave_amount)+axi_slave_id_width;
    constant axi_address_width : integer := 32;
    constant axi_address_periph_width : integer := 16;
    constant axi_data_width : integer := 32;
    
    constant bram_address_width : integer := 16;
    constant bram_data_width : integer := axi_data_width;
    constant bram_bram_depth : integer := 16384;
    
    signal aclk : std_logic;
    signal interconnect_aresetn : std_logic_vector(0 downto 0);
    signal peripheral_aresetn : std_logic_vector(0 downto 0);
    signal dcm_locked : std_logic;
    
    signal ram_bram_rst_a : std_logic;
    signal ram_bram_clk_a : std_logic;
    signal ram_bram_en_a : std_logic;
    signal ram_bram_we_a : std_logic_vector(3 downto 0);
    signal ram_bram_addr_a : std_logic_vector(15 downto 0);
    signal ram_bram_wrdata_a : std_logic_vector(31 downto 0);
    signal ram_bram_rddata_a : std_logic_vector(31 downto 0);
    
    signal boot_bram_rst_a : std_logic;
    signal boot_bram_clk_a : std_logic;
    signal boot_bram_en_a : std_logic;
    signal boot_bram_we_a : std_logic_vector(3 downto 0);
    signal boot_bram_addr_a : std_logic_vector(15 downto 0);
    signal boot_bram_wrdata_a : std_logic_vector(31 downto 0);
    signal boot_bram_rddata_a : std_logic_vector(31 downto 0);
    
    -------------------------------
    -- Main Interconnect Signals --
    -------------------------------
    
    signal cpu_0_axi_full_awid : std_logic_vector(axi_slave_id_width-1 downto 0);
    signal cpu_0_axi_full_awaddr : std_logic_vector(axi_address_width-1 downto 0);
    signal cpu_0_axi_full_awlen : std_logic_vector(7 downto 0);
    signal cpu_0_axi_full_awsize : std_logic_vector(2 downto 0);
    signal cpu_0_axi_full_awburst : std_logic_vector(1 downto 0);
    signal cpu_0_axi_full_awlock : std_logic;
    signal cpu_0_axi_full_awcache : std_logic_vector(3 downto 0);
    signal cpu_0_axi_full_awprot : std_logic_vector(2 downto 0);
    signal cpu_0_axi_full_awqos : std_logic_vector(3 downto 0);
    signal cpu_0_axi_full_awregion : std_logic_vector(3 downto 0);
    signal cpu_0_axi_full_awvalid : std_logic;
    signal cpu_0_axi_full_awready : std_logic;
    signal cpu_0_axi_full_wdata : std_logic_vector(axi_data_width-1 downto 0);
    signal cpu_0_axi_full_wstrb : std_logic_vector(axi_data_width/8-1 downto 0);
    signal cpu_0_axi_full_wlast : std_logic;
    signal cpu_0_axi_full_wvalid : std_logic;
    signal cpu_0_axi_full_wready : std_logic;
    signal cpu_0_axi_full_bid : std_logic_vector(axi_slave_id_width-1 downto 0);
    signal cpu_0_axi_full_bresp : std_logic_vector(1 downto 0);
    signal cpu_0_axi_full_bvalid : std_logic;
    signal cpu_0_axi_full_bready : std_logic;
    signal cpu_0_axi_full_arid : std_logic_vector(axi_slave_id_width-1 downto 0);
    signal cpu_0_axi_full_araddr : std_logic_vector(axi_address_width-1 downto 0);
    signal cpu_0_axi_full_arlen : std_logic_vector(7 downto 0);
    signal cpu_0_axi_full_arsize : std_logic_vector(2 downto 0);
    signal cpu_0_axi_full_arburst : std_logic_vector(1 downto 0);
    signal cpu_0_axi_full_arlock : std_logic;
    signal cpu_0_axi_full_arcache : std_logic_vector(3 downto 0);
    signal cpu_0_axi_full_arprot : std_logic_vector(2 downto 0);
    signal cpu_0_axi_full_arqos : std_logic_vector(3 downto 0);
    signal cpu_0_axi_full_arregion : std_logic_vector(3 downto 0);
    signal cpu_0_axi_full_arvalid : std_logic;
    signal cpu_0_axi_full_arready : std_logic;
    signal cpu_0_axi_full_rid : std_logic_vector(axi_slave_id_width-1 downto 0);
    signal cpu_0_axi_full_rdata : std_logic_vector(axi_data_width-1 downto 0);
    signal cpu_0_axi_full_rresp : std_logic_vector(1 downto 0);
    signal cpu_0_axi_full_rlast : std_logic;
    signal cpu_0_axi_full_rvalid : std_logic;
    signal cpu_0_axi_full_rready : std_logic;
    signal cpu_1_axi_full_awid : std_logic_vector(axi_slave_id_width-1 downto 0);
    signal cpu_1_axi_full_awaddr : std_logic_vector(axi_address_width-1 downto 0);
    signal cpu_1_axi_full_awlen : std_logic_vector(7 downto 0);
    signal cpu_1_axi_full_awsize : std_logic_vector(2 downto 0);
    signal cpu_1_axi_full_awburst : std_logic_vector(1 downto 0);
    signal cpu_1_axi_full_awlock : std_logic;
    signal cpu_1_axi_full_awcache : std_logic_vector(3 downto 0);
    signal cpu_1_axi_full_awprot : std_logic_vector(2 downto 0);
    signal cpu_1_axi_full_awqos : std_logic_vector(3 downto 0);
    signal cpu_1_axi_full_awregion : std_logic_vector(3 downto 0);
    signal cpu_1_axi_full_awvalid : std_logic;
    signal cpu_1_axi_full_awready : std_logic;
    signal cpu_1_axi_full_wdata : std_logic_vector(axi_data_width-1 downto 0);
    signal cpu_1_axi_full_wstrb : std_logic_vector(axi_data_width/8-1 downto 0);
    signal cpu_1_axi_full_wlast : std_logic;
    signal cpu_1_axi_full_wvalid : std_logic;
    signal cpu_1_axi_full_wready : std_logic;
    signal cpu_1_axi_full_bid : std_logic_vector(axi_slave_id_width-1 downto 0);
    signal cpu_1_axi_full_bresp : std_logic_vector(1 downto 0);
    signal cpu_1_axi_full_bvalid : std_logic;
    signal cpu_1_axi_full_bready : std_logic;
    signal cpu_1_axi_full_arid : std_logic_vector(axi_slave_id_width-1 downto 0);
    signal cpu_1_axi_full_araddr : std_logic_vector(axi_address_width-1 downto 0);
    signal cpu_1_axi_full_arlen : std_logic_vector(7 downto 0);
    signal cpu_1_axi_full_arsize : std_logic_vector(2 downto 0);
    signal cpu_1_axi_full_arburst : std_logic_vector(1 downto 0);
    signal cpu_1_axi_full_arlock : std_logic;
    signal cpu_1_axi_full_arcache : std_logic_vector(3 downto 0);
    signal cpu_1_axi_full_arprot : std_logic_vector(2 downto 0);
    signal cpu_1_axi_full_arqos : std_logic_vector(3 downto 0);
    signal cpu_1_axi_full_arregion : std_logic_vector(3 downto 0);
    signal cpu_1_axi_full_arvalid : std_logic;
    signal cpu_1_axi_full_arready : std_logic;
    signal cpu_1_axi_full_rid : std_logic_vector(axi_slave_id_width-1 downto 0);
    signal cpu_1_axi_full_rdata : std_logic_vector(axi_data_width-1 downto 0);
    signal cpu_1_axi_full_rresp : std_logic_vector(1 downto 0);
    signal cpu_1_axi_full_rlast : std_logic;
    signal cpu_1_axi_full_rvalid : std_logic;
    signal cpu_1_axi_full_rready : std_logic;
    signal cpu_2_axi_full_awid : std_logic_vector(axi_slave_id_width-1 downto 0);
    signal cpu_2_axi_full_awaddr : std_logic_vector(axi_address_width-1 downto 0);
    signal cpu_2_axi_full_awlen : std_logic_vector(7 downto 0);
    signal cpu_2_axi_full_awsize : std_logic_vector(2 downto 0);
    signal cpu_2_axi_full_awburst : std_logic_vector(1 downto 0);
    signal cpu_2_axi_full_awlock : std_logic;
    signal cpu_2_axi_full_awcache : std_logic_vector(3 downto 0);
    signal cpu_2_axi_full_awprot : std_logic_vector(2 downto 0);
    signal cpu_2_axi_full_awqos : std_logic_vector(3 downto 0);
    signal cpu_2_axi_full_awregion : std_logic_vector(3 downto 0);
    signal cpu_2_axi_full_awvalid : std_logic;
    signal cpu_2_axi_full_awready : std_logic;
    signal cpu_2_axi_full_wdata : std_logic_vector(axi_data_width-1 downto 0);
    signal cpu_2_axi_full_wstrb : std_logic_vector(axi_data_width/8-1 downto 0);
    signal cpu_2_axi_full_wlast : std_logic;
    signal cpu_2_axi_full_wvalid : std_logic;
    signal cpu_2_axi_full_wready : std_logic;
    signal cpu_2_axi_full_bid : std_logic_vector(axi_slave_id_width-1 downto 0);
    signal cpu_2_axi_full_bresp : std_logic_vector(1 downto 0);
    signal cpu_2_axi_full_bvalid : std_logic;
    signal cpu_2_axi_full_bready : std_logic;
    signal cpu_2_axi_full_arid : std_logic_vector(axi_slave_id_width-1 downto 0);
    signal cpu_2_axi_full_araddr : std_logic_vector(axi_address_width-1 downto 0);
    signal cpu_2_axi_full_arlen : std_logic_vector(7 downto 0);
    signal cpu_2_axi_full_arsize : std_logic_vector(2 downto 0);
    signal cpu_2_axi_full_arburst : std_logic_vector(1 downto 0);
    signal cpu_2_axi_full_arlock : std_logic;
    signal cpu_2_axi_full_arcache : std_logic_vector(3 downto 0);
    signal cpu_2_axi_full_arprot : std_logic_vector(2 downto 0);
    signal cpu_2_axi_full_arqos : std_logic_vector(3 downto 0);
    signal cpu_2_axi_full_arregion : std_logic_vector(3 downto 0);
    signal cpu_2_axi_full_arvalid : std_logic;
    signal cpu_2_axi_full_arready : std_logic;
    signal cpu_2_axi_full_rid : std_logic_vector(axi_slave_id_width-1 downto 0);
    signal cpu_2_axi_full_rdata : std_logic_vector(axi_data_width-1 downto 0);
    signal cpu_2_axi_full_rresp : std_logic_vector(1 downto 0);
    signal cpu_2_axi_full_rlast : std_logic;
    signal cpu_2_axi_full_rvalid : std_logic;
    signal cpu_2_axi_full_rready : std_logic;
    signal boot_bram_axi_full_awid : std_logic_vector(axi_master_id_width-1 downto 0);
    signal boot_bram_axi_full_awaddr : std_logic_vector(axi_address_width-1 downto 0);
    signal boot_bram_axi_full_awlen : std_logic_vector(7 downto 0);
    signal boot_bram_axi_full_awsize : std_logic_vector(2 downto 0);
    signal boot_bram_axi_full_awburst : std_logic_vector(1 downto 0);
    signal boot_bram_axi_full_awlock : std_logic;
    signal boot_bram_axi_full_awcache : std_logic_vector(3 downto 0);
    signal boot_bram_axi_full_awprot : std_logic_vector(2 downto 0);
    signal boot_bram_axi_full_awqos : std_logic_vector(3 downto 0);
    signal boot_bram_axi_full_awregion : std_logic_vector(3 downto 0);
    signal boot_bram_axi_full_awvalid : std_logic;
    signal boot_bram_axi_full_awready : std_logic;
    signal boot_bram_axi_full_wdata : std_logic_vector(axi_data_width-1 downto 0);
    signal boot_bram_axi_full_wstrb : std_logic_vector(axi_data_width/8-1 downto 0);
    signal boot_bram_axi_full_wlast : std_logic;
    signal boot_bram_axi_full_wvalid : std_logic;
    signal boot_bram_axi_full_wready : std_logic;
    signal boot_bram_axi_full_bid : std_logic_vector(axi_master_id_width-1 downto 0);
    signal boot_bram_axi_full_bresp : std_logic_vector(1 downto 0);
    signal boot_bram_axi_full_bvalid : std_logic;
    signal boot_bram_axi_full_bready : std_logic;
    signal boot_bram_axi_full_arid : std_logic_vector(axi_master_id_width-1 downto 0);
    signal boot_bram_axi_full_araddr : std_logic_vector(axi_address_width-1 downto 0);
    signal boot_bram_axi_full_arlen : std_logic_vector(7 downto 0);
    signal boot_bram_axi_full_arsize : std_logic_vector(2 downto 0);
    signal boot_bram_axi_full_arburst : std_logic_vector(1 downto 0);
    signal boot_bram_axi_full_arlock : std_logic;
    signal boot_bram_axi_full_arcache : std_logic_vector(3 downto 0);
    signal boot_bram_axi_full_arprot : std_logic_vector(2 downto 0);
    signal boot_bram_axi_full_arqos : std_logic_vector(3 downto 0);
    signal boot_bram_axi_full_arregion : std_logic_vector(3 downto 0);
    signal boot_bram_axi_full_arvalid : std_logic;
    signal boot_bram_axi_full_arready : std_logic;
    signal boot_bram_axi_full_rid : std_logic_vector(axi_master_id_width-1 downto 0);
    signal boot_bram_axi_full_rdata : std_logic_vector(axi_data_width-1 downto 0);
    signal boot_bram_axi_full_rresp : std_logic_vector(1 downto 0);
    signal boot_bram_axi_full_rlast : std_logic;
    signal boot_bram_axi_full_rvalid : std_logic;
    signal boot_bram_axi_full_rready : std_logic;
    signal ram_axi_full_awid : std_logic_vector(axi_master_id_width-1 downto 0);
    signal ram_axi_full_awid_ext : std_logic_vector(3 downto 0) := (others=>'0');
    signal ram_axi_full_awaddr : std_logic_vector(axi_address_width-1 downto 0) := (others=>'0');
    signal ram_axi_full_awlen : std_logic_vector(7 downto 0);
    signal ram_axi_full_awsize : std_logic_vector(2 downto 0);
    signal ram_axi_full_awburst : std_logic_vector(1 downto 0);
    signal ram_axi_full_awlock : std_logic;
    signal ram_axi_full_awlock_slv : std_logic_vector(0 downto 0);
    signal ram_axi_full_awcache : std_logic_vector(3 downto 0);
    signal ram_axi_full_awprot : std_logic_vector(2 downto 0);
    signal ram_axi_full_awqos : std_logic_vector(3 downto 0);
    signal ram_axi_full_awregion : std_logic_vector(3 downto 0);
    signal ram_axi_full_awvalid : std_logic;
    signal ram_axi_full_awready : std_logic;
    signal ram_axi_full_wdata : std_logic_vector(axi_data_width-1 downto 0);
    signal ram_axi_full_wstrb : std_logic_vector(axi_data_width/8-1 downto 0);
    signal ram_axi_full_wlast : std_logic;
    signal ram_axi_full_wvalid : std_logic;
    signal ram_axi_full_wready : std_logic;
    signal ram_axi_full_bid : std_logic_vector(axi_master_id_width-1 downto 0);
    signal ram_axi_full_bid_ext : std_logic_vector(3 downto 0) := (others=>'0');
    signal ram_axi_full_bresp : std_logic_vector(1 downto 0);
    signal ram_axi_full_bvalid : std_logic;
    signal ram_axi_full_bready : std_logic;
    signal ram_axi_full_arid : std_logic_vector(axi_master_id_width-1 downto 0);
    signal ram_axi_full_arid_ext : std_logic_vector(3 downto 0) := (others=>'0');
    signal ram_axi_full_araddr : std_logic_vector(axi_address_width-1 downto 0) := (others=>'0');
    signal ram_axi_full_arlen : std_logic_vector(7 downto 0);
    signal ram_axi_full_arsize : std_logic_vector(2 downto 0);
    signal ram_axi_full_arburst : std_logic_vector(1 downto 0);
    signal ram_axi_full_arlock : std_logic;
    signal ram_axi_full_arlock_slv : std_logic_vector(0 downto 0);
    signal ram_axi_full_arcache : std_logic_vector(3 downto 0);
    signal ram_axi_full_arprot : std_logic_vector(2 downto 0);
    signal ram_axi_full_arqos : std_logic_vector(3 downto 0);
    signal ram_axi_full_arregion : std_logic_vector(3 downto 0);
    signal ram_axi_full_arvalid : std_logic;
    signal ram_axi_full_arready : std_logic;
    signal ram_axi_full_rid : std_logic_vector(axi_master_id_width-1 downto 0);
    signal ram_axi_full_rid_ext : std_logic_vector(3 downto 0) := (others=>'0');
    signal ram_axi_full_rdata : std_logic_vector(axi_data_width-1 downto 0);
    signal ram_axi_full_rresp : std_logic_vector(1 downto 0);
    signal ram_axi_full_rlast : std_logic;
    signal ram_axi_full_rvalid : std_logic;
    signal ram_axi_full_rready : std_logic;
    signal int_axi_full_awid : std_logic_vector(axi_master_id_width-1 downto 0);
    signal int_axi_full_awaddr : std_logic_vector(axi_address_width-1 downto 0);
    signal int_axi_full_awlen : std_logic_vector(7 downto 0);
    signal int_axi_full_awsize : std_logic_vector(2 downto 0);
    signal int_axi_full_awburst : std_logic_vector(1 downto 0);
    signal int_axi_full_awlock : std_logic;
    signal int_axi_full_awcache : std_logic_vector(3 downto 0);
    signal int_axi_full_awprot : std_logic_vector(2 downto 0);
    signal int_axi_full_awqos : std_logic_vector(3 downto 0);
    signal int_axi_full_awregion : std_logic_vector(3 downto 0);
    signal int_axi_full_awvalid : std_logic;
    signal int_axi_full_awready : std_logic;
    signal int_axi_full_wdata : std_logic_vector(axi_data_width-1 downto 0);
    signal int_axi_full_wstrb : std_logic_vector(axi_data_width/8-1 downto 0);
    signal int_axi_full_wlast : std_logic;
    signal int_axi_full_wvalid : std_logic;
    signal int_axi_full_wready : std_logic;
    signal int_axi_full_bid : std_logic_vector(axi_master_id_width-1 downto 0);
    signal int_axi_full_bresp : std_logic_vector(1 downto 0);
    signal int_axi_full_bvalid : std_logic;
    signal int_axi_full_bready : std_logic;
    signal int_axi_full_arid : std_logic_vector(axi_master_id_width-1 downto 0);
    signal int_axi_full_araddr : std_logic_vector(axi_address_width-1 downto 0);
    signal int_axi_full_arlen : std_logic_vector(7 downto 0);
    signal int_axi_full_arsize : std_logic_vector(2 downto 0);
    signal int_axi_full_arburst : std_logic_vector(1 downto 0);
    signal int_axi_full_arlock : std_logic;
    signal int_axi_full_arcache : std_logic_vector(3 downto 0);
    signal int_axi_full_arprot : std_logic_vector(2 downto 0);
    signal int_axi_full_arqos : std_logic_vector(3 downto 0);
    signal int_axi_full_arregion : std_logic_vector(3 downto 0);
    signal int_axi_full_arvalid : std_logic;
    signal int_axi_full_arready : std_logic;
    signal int_axi_full_rid : std_logic_vector(axi_master_id_width-1 downto 0);
    signal int_axi_full_rdata : std_logic_vector(axi_data_width-1 downto 0);
    signal int_axi_full_rresp : std_logic_vector(1 downto 0);
    signal int_axi_full_rlast : std_logic;
    signal int_axi_full_rvalid : std_logic;
    signal int_axi_full_rready : std_logic;
    signal timer_axi_full_awid : std_logic_vector(axi_master_id_width-1 downto 0);
    signal timer_axi_full_awaddr : std_logic_vector(axi_address_width-1 downto 0);
    signal timer_axi_full_awlen : std_logic_vector(7 downto 0);
    signal timer_axi_full_awsize : std_logic_vector(2 downto 0);
    signal timer_axi_full_awburst : std_logic_vector(1 downto 0);
    signal timer_axi_full_awlock : std_logic;
    signal timer_axi_full_awcache : std_logic_vector(3 downto 0);
    signal timer_axi_full_awprot : std_logic_vector(2 downto 0);
    signal timer_axi_full_awqos : std_logic_vector(3 downto 0);
    signal timer_axi_full_awregion : std_logic_vector(3 downto 0);
    signal timer_axi_full_awvalid : std_logic;
    signal timer_axi_full_awready : std_logic;
    signal timer_axi_full_wdata : std_logic_vector(axi_data_width-1 downto 0);
    signal timer_axi_full_wstrb : std_logic_vector(axi_data_width/8-1 downto 0);
    signal timer_axi_full_wlast : std_logic;
    signal timer_axi_full_wvalid : std_logic;
    signal timer_axi_full_wready : std_logic;
    signal timer_axi_full_bid : std_logic_vector(axi_master_id_width-1 downto 0);
    signal timer_axi_full_bresp : std_logic_vector(1 downto 0);
    signal timer_axi_full_bvalid : std_logic;
    signal timer_axi_full_bready : std_logic;
    signal timer_axi_full_arid : std_logic_vector(axi_master_id_width-1 downto 0);
    signal timer_axi_full_araddr : std_logic_vector(axi_address_width-1 downto 0);
    signal timer_axi_full_arlen : std_logic_vector(7 downto 0);
    signal timer_axi_full_arsize : std_logic_vector(2 downto 0);
    signal timer_axi_full_arburst : std_logic_vector(1 downto 0);
    signal timer_axi_full_arlock : std_logic;
    signal timer_axi_full_arcache : std_logic_vector(3 downto 0);
    signal timer_axi_full_arprot : std_logic_vector(2 downto 0);
    signal timer_axi_full_arqos : std_logic_vector(3 downto 0);
    signal timer_axi_full_arregion : std_logic_vector(3 downto 0);
    signal timer_axi_full_arvalid : std_logic;
    signal timer_axi_full_arready : std_logic;
    signal timer_axi_full_rid : std_logic_vector(axi_master_id_width-1 downto 0);
    signal timer_axi_full_rdata : std_logic_vector(axi_data_width-1 downto 0);
    signal timer_axi_full_rresp : std_logic_vector(1 downto 0);
    signal timer_axi_full_rlast : std_logic;
    signal timer_axi_full_rvalid : std_logic;
    signal timer_axi_full_rready : std_logic;
    signal gpio_axi_full_awid : std_logic_vector(axi_master_id_width-1 downto 0);
    signal gpio_axi_full_awaddr : std_logic_vector(axi_address_width-1 downto 0);
    signal gpio_axi_full_awlen : std_logic_vector(7 downto 0);
    signal gpio_axi_full_awsize : std_logic_vector(2 downto 0);
    signal gpio_axi_full_awburst : std_logic_vector(1 downto 0);
    signal gpio_axi_full_awlock : std_logic;
    signal gpio_axi_full_awcache : std_logic_vector(3 downto 0);
    signal gpio_axi_full_awprot : std_logic_vector(2 downto 0);
    signal gpio_axi_full_awqos : std_logic_vector(3 downto 0);
    signal gpio_axi_full_awregion : std_logic_vector(3 downto 0);
    signal gpio_axi_full_awvalid : std_logic;
    signal gpio_axi_full_awready : std_logic;
    signal gpio_axi_full_wdata : std_logic_vector(axi_data_width-1 downto 0);
    signal gpio_axi_full_wstrb : std_logic_vector(axi_data_width/8-1 downto 0);
    signal gpio_axi_full_wlast : std_logic;
    signal gpio_axi_full_wvalid : std_logic;
    signal gpio_axi_full_wready : std_logic;
    signal gpio_axi_full_bid : std_logic_vector(axi_master_id_width-1 downto 0);
    signal gpio_axi_full_bresp : std_logic_vector(1 downto 0);
    signal gpio_axi_full_bvalid : std_logic;
    signal gpio_axi_full_bready : std_logic;
    signal gpio_axi_full_arid : std_logic_vector(axi_master_id_width-1 downto 0);
    signal gpio_axi_full_araddr : std_logic_vector(axi_address_width-1 downto 0);
    signal gpio_axi_full_arlen : std_logic_vector(7 downto 0);
    signal gpio_axi_full_arsize : std_logic_vector(2 downto 0);
    signal gpio_axi_full_arburst : std_logic_vector(1 downto 0);
    signal gpio_axi_full_arlock : std_logic;
    signal gpio_axi_full_arcache : std_logic_vector(3 downto 0);
    signal gpio_axi_full_arprot : std_logic_vector(2 downto 0);
    signal gpio_axi_full_arqos : std_logic_vector(3 downto 0);
    signal gpio_axi_full_arregion : std_logic_vector(3 downto 0);
    signal gpio_axi_full_arvalid : std_logic;
    signal gpio_axi_full_arready : std_logic;
    signal gpio_axi_full_rid : std_logic_vector(axi_master_id_width-1 downto 0);
    signal gpio_axi_full_rdata : std_logic_vector(axi_data_width-1 downto 0);
    signal gpio_axi_full_rresp : std_logic_vector(1 downto 0);
    signal gpio_axi_full_rlast : std_logic;
    signal gpio_axi_full_rvalid : std_logic;
    signal gpio_axi_full_rready : std_logic;
    signal uart_axi_full_awid : std_logic_vector(axi_master_id_width-1 downto 0);
    signal uart_axi_full_awaddr : std_logic_vector(axi_address_width-1 downto 0);
    signal uart_axi_full_awlen : std_logic_vector(7 downto 0);
    signal uart_axi_full_awsize : std_logic_vector(2 downto 0);
    signal uart_axi_full_awburst : std_logic_vector(1 downto 0);
    signal uart_axi_full_awlock : std_logic;
    signal uart_axi_full_awcache : std_logic_vector(3 downto 0);
    signal uart_axi_full_awprot : std_logic_vector(2 downto 0);
    signal uart_axi_full_awqos : std_logic_vector(3 downto 0);
    signal uart_axi_full_awregion : std_logic_vector(3 downto 0);
    signal uart_axi_full_awvalid : std_logic;
    signal uart_axi_full_awready : std_logic;
    signal uart_axi_full_wdata : std_logic_vector(axi_data_width-1 downto 0);
    signal uart_axi_full_wstrb : std_logic_vector(axi_data_width/8-1 downto 0);
    signal uart_axi_full_wlast : std_logic;
    signal uart_axi_full_wvalid : std_logic;
    signal uart_axi_full_wready : std_logic;
    signal uart_axi_full_bid : std_logic_vector(axi_master_id_width-1 downto 0);
    signal uart_axi_full_bresp : std_logic_vector(1 downto 0);
    signal uart_axi_full_bvalid : std_logic;
    signal uart_axi_full_bready : std_logic;
    signal uart_axi_full_arid : std_logic_vector(axi_master_id_width-1 downto 0);
    signal uart_axi_full_araddr : std_logic_vector(axi_address_width-1 downto 0);
    signal uart_axi_full_arlen : std_logic_vector(7 downto 0);
    signal uart_axi_full_arsize : std_logic_vector(2 downto 0);
    signal uart_axi_full_arburst : std_logic_vector(1 downto 0);
    signal uart_axi_full_arlock : std_logic;
    signal uart_axi_full_arcache : std_logic_vector(3 downto 0);
    signal uart_axi_full_arprot : std_logic_vector(2 downto 0);
    signal uart_axi_full_arqos : std_logic_vector(3 downto 0);
    signal uart_axi_full_arregion : std_logic_vector(3 downto 0);
    signal uart_axi_full_arvalid : std_logic;
    signal uart_axi_full_arready : std_logic;
    signal uart_axi_full_rid : std_logic_vector(axi_master_id_width-1 downto 0);
    signal uart_axi_full_rdata : std_logic_vector(axi_data_width-1 downto 0);
    signal uart_axi_full_rresp : std_logic_vector(1 downto 0);
    signal uart_axi_full_rlast : std_logic;
    signal uart_axi_full_rvalid : std_logic;
    signal uart_axi_full_rready : std_logic;
    signal lock_axi_full_awid : std_logic_vector(axi_master_id_width-1 downto 0);
    signal lock_axi_full_awaddr : std_logic_vector(axi_address_width-1 downto 0);
    signal lock_axi_full_awlen : std_logic_vector(7 downto 0);
    signal lock_axi_full_awsize : std_logic_vector(2 downto 0);
    signal lock_axi_full_awburst : std_logic_vector(1 downto 0);
    signal lock_axi_full_awlock : std_logic;
    signal lock_axi_full_awcache : std_logic_vector(3 downto 0);
    signal lock_axi_full_awprot : std_logic_vector(2 downto 0);
    signal lock_axi_full_awqos : std_logic_vector(3 downto 0);
    signal lock_axi_full_awregion : std_logic_vector(3 downto 0);
    signal lock_axi_full_awvalid : std_logic;
    signal lock_axi_full_awready : std_logic;
    signal lock_axi_full_wdata : std_logic_vector(axi_data_width-1 downto 0);
    signal lock_axi_full_wstrb : std_logic_vector(axi_data_width/8-1 downto 0);
    signal lock_axi_full_wlast : std_logic;
    signal lock_axi_full_wvalid : std_logic;
    signal lock_axi_full_wready : std_logic;
    signal lock_axi_full_bid : std_logic_vector(axi_master_id_width-1 downto 0);
    signal lock_axi_full_bresp : std_logic_vector(1 downto 0);
    signal lock_axi_full_bvalid : std_logic;
    signal lock_axi_full_bready : std_logic;
    signal lock_axi_full_arid : std_logic_vector(axi_master_id_width-1 downto 0);
    signal lock_axi_full_araddr : std_logic_vector(axi_address_width-1 downto 0);
    signal lock_axi_full_arlen : std_logic_vector(7 downto 0);
    signal lock_axi_full_arsize : std_logic_vector(2 downto 0);
    signal lock_axi_full_arburst : std_logic_vector(1 downto 0);
    signal lock_axi_full_arlock : std_logic;
    signal lock_axi_full_arcache : std_logic_vector(3 downto 0);
    signal lock_axi_full_arprot : std_logic_vector(2 downto 0);
    signal lock_axi_full_arqos : std_logic_vector(3 downto 0);
    signal lock_axi_full_arregion : std_logic_vector(3 downto 0);
    signal lock_axi_full_arvalid : std_logic;
    signal lock_axi_full_arready : std_logic;
    signal lock_axi_full_rid : std_logic_vector(axi_master_id_width-1 downto 0);
    signal lock_axi_full_rdata : std_logic_vector(axi_data_width-1 downto 0);
    signal lock_axi_full_rresp : std_logic_vector(1 downto 0);
    signal lock_axi_full_rlast : std_logic;
    signal lock_axi_full_rvalid : std_logic;
    signal lock_axi_full_rready : std_logic;
    
    ---------------------
    -- CPU Bus Signals --
    ---------------------
    
    signal cpu_bus_0_full_awid : std_logic_vector(axi_cpu_bus_slave_id_width-1 downto 0);
    signal cpu_bus_0_full_awaddr : std_logic_vector(axi_address_width-1 downto 0);
    signal cpu_bus_0_full_awlen : std_logic_vector(7 downto 0);
    signal cpu_bus_0_full_awsize : std_logic_vector(2 downto 0);
    signal cpu_bus_0_full_awburst : std_logic_vector(1 downto 0);
    signal cpu_bus_0_full_awlock : std_logic;
    signal cpu_bus_0_full_awcache : std_logic_vector(3 downto 0);
    signal cpu_bus_0_full_awprot : std_logic_vector(2 downto 0);
    signal cpu_bus_0_full_awqos : std_logic_vector(3 downto 0);
    signal cpu_bus_0_full_awregion : std_logic_vector(3 downto 0);
    signal cpu_bus_0_full_awvalid : std_logic;
    signal cpu_bus_0_full_awready : std_logic;
    signal cpu_bus_0_full_wdata : std_logic_vector(axi_data_width-1 downto 0);
    signal cpu_bus_0_full_wstrb : std_logic_vector(axi_data_width/8-1 downto 0);
    signal cpu_bus_0_full_wlast : std_logic;
    signal cpu_bus_0_full_wvalid : std_logic;
    signal cpu_bus_0_full_wready : std_logic;
    signal cpu_bus_0_full_bid : std_logic_vector(axi_cpu_bus_slave_id_width-1 downto 0);
    signal cpu_bus_0_full_bresp : std_logic_vector(1 downto 0);
    signal cpu_bus_0_full_bvalid : std_logic;
    signal cpu_bus_0_full_bready : std_logic;
    signal cpu_bus_0_full_arid : std_logic_vector(axi_cpu_bus_slave_id_width-1 downto 0);
    signal cpu_bus_0_full_araddr : std_logic_vector(axi_address_width-1 downto 0);
    signal cpu_bus_0_full_arlen : std_logic_vector(7 downto 0);
    signal cpu_bus_0_full_arsize : std_logic_vector(2 downto 0);
    signal cpu_bus_0_full_arburst : std_logic_vector(1 downto 0);
    signal cpu_bus_0_full_arlock : std_logic;
    signal cpu_bus_0_full_arcache : std_logic_vector(3 downto 0);
    signal cpu_bus_0_full_arprot : std_logic_vector(2 downto 0);
    signal cpu_bus_0_full_arqos : std_logic_vector(3 downto 0);
    signal cpu_bus_0_full_arregion : std_logic_vector(3 downto 0);
    signal cpu_bus_0_full_arvalid : std_logic;
    signal cpu_bus_0_full_arready : std_logic;
    signal cpu_bus_0_full_rid : std_logic_vector(axi_cpu_bus_slave_id_width-1 downto 0);
    signal cpu_bus_0_full_rdata : std_logic_vector(axi_data_width-1 downto 0);
    signal cpu_bus_0_full_rresp : std_logic_vector(1 downto 0);
    signal cpu_bus_0_full_rlast : std_logic;
    signal cpu_bus_0_full_rvalid : std_logic;
    signal cpu_bus_0_full_rready : std_logic;
    signal cpuid_gpio_bus_0_full_awid : std_logic_vector(axi_cpu_bus_master_id_width-1 downto 0);
    signal cpuid_gpio_bus_0_full_awaddr : std_logic_vector(axi_address_width-1 downto 0);
    signal cpuid_gpio_bus_0_full_awlen : std_logic_vector(7 downto 0);
    signal cpuid_gpio_bus_0_full_awsize : std_logic_vector(2 downto 0);
    signal cpuid_gpio_bus_0_full_awburst : std_logic_vector(1 downto 0);
    signal cpuid_gpio_bus_0_full_awlock : std_logic;
    signal cpuid_gpio_bus_0_full_awcache : std_logic_vector(3 downto 0);
    signal cpuid_gpio_bus_0_full_awprot : std_logic_vector(2 downto 0);
    signal cpuid_gpio_bus_0_full_awqos : std_logic_vector(3 downto 0);
    signal cpuid_gpio_bus_0_full_awregion : std_logic_vector(3 downto 0);
    signal cpuid_gpio_bus_0_full_awvalid : std_logic;
    signal cpuid_gpio_bus_0_full_awready : std_logic;
    signal cpuid_gpio_bus_0_full_wdata : std_logic_vector(axi_data_width-1 downto 0);
    signal cpuid_gpio_bus_0_full_wstrb : std_logic_vector(axi_data_width/8-1 downto 0);
    signal cpuid_gpio_bus_0_full_wlast : std_logic;
    signal cpuid_gpio_bus_0_full_wvalid : std_logic;
    signal cpuid_gpio_bus_0_full_wready : std_logic;
    signal cpuid_gpio_bus_0_full_bid : std_logic_vector(axi_cpu_bus_master_id_width-1 downto 0);
    signal cpuid_gpio_bus_0_full_bresp : std_logic_vector(1 downto 0);
    signal cpuid_gpio_bus_0_full_bvalid : std_logic;
    signal cpuid_gpio_bus_0_full_bready : std_logic;
    signal cpuid_gpio_bus_0_full_arid : std_logic_vector(axi_cpu_bus_master_id_width-1 downto 0);
    signal cpuid_gpio_bus_0_full_araddr : std_logic_vector(axi_address_width-1 downto 0);
    signal cpuid_gpio_bus_0_full_arlen : std_logic_vector(7 downto 0);
    signal cpuid_gpio_bus_0_full_arsize : std_logic_vector(2 downto 0);
    signal cpuid_gpio_bus_0_full_arburst : std_logic_vector(1 downto 0);
    signal cpuid_gpio_bus_0_full_arlock : std_logic;
    signal cpuid_gpio_bus_0_full_arcache : std_logic_vector(3 downto 0);
    signal cpuid_gpio_bus_0_full_arprot : std_logic_vector(2 downto 0);
    signal cpuid_gpio_bus_0_full_arqos : std_logic_vector(3 downto 0);
    signal cpuid_gpio_bus_0_full_arregion : std_logic_vector(3 downto 0);
    signal cpuid_gpio_bus_0_full_arvalid : std_logic;
    signal cpuid_gpio_bus_0_full_arready : std_logic;
    signal cpuid_gpio_bus_0_full_rid : std_logic_vector(axi_cpu_bus_master_id_width-1 downto 0);
    signal cpuid_gpio_bus_0_full_rdata : std_logic_vector(axi_data_width-1 downto 0);
    signal cpuid_gpio_bus_0_full_rresp : std_logic_vector(1 downto 0);
    signal cpuid_gpio_bus_0_full_rlast : std_logic;
    signal cpuid_gpio_bus_0_full_rvalid : std_logic;
    signal cpuid_gpio_bus_0_full_rready : std_logic;
    signal int_bus_0_full_awid : std_logic_vector(axi_cpu_bus_master_id_width-1 downto 0);
    signal int_bus_0_full_awaddr : std_logic_vector(axi_address_width-1 downto 0);
    signal int_bus_0_full_awlen : std_logic_vector(7 downto 0);
    signal int_bus_0_full_awsize : std_logic_vector(2 downto 0);
    signal int_bus_0_full_awburst : std_logic_vector(1 downto 0);
    signal int_bus_0_full_awlock : std_logic;
    signal int_bus_0_full_awcache : std_logic_vector(3 downto 0);
    signal int_bus_0_full_awprot : std_logic_vector(2 downto 0);
    signal int_bus_0_full_awqos : std_logic_vector(3 downto 0);
    signal int_bus_0_full_awregion : std_logic_vector(3 downto 0);
    signal int_bus_0_full_awvalid : std_logic;
    signal int_bus_0_full_awready : std_logic;
    signal int_bus_0_full_wdata : std_logic_vector(axi_data_width-1 downto 0);
    signal int_bus_0_full_wstrb : std_logic_vector(axi_data_width/8-1 downto 0);
    signal int_bus_0_full_wlast : std_logic;
    signal int_bus_0_full_wvalid : std_logic;
    signal int_bus_0_full_wready : std_logic;
    signal int_bus_0_full_bid : std_logic_vector(axi_cpu_bus_master_id_width-1 downto 0);
    signal int_bus_0_full_bresp : std_logic_vector(1 downto 0);
    signal int_bus_0_full_bvalid : std_logic;
    signal int_bus_0_full_bready : std_logic;
    signal int_bus_0_full_arid : std_logic_vector(axi_cpu_bus_master_id_width-1 downto 0);
    signal int_bus_0_full_araddr : std_logic_vector(axi_address_width-1 downto 0);
    signal int_bus_0_full_arlen : std_logic_vector(7 downto 0);
    signal int_bus_0_full_arsize : std_logic_vector(2 downto 0);
    signal int_bus_0_full_arburst : std_logic_vector(1 downto 0);
    signal int_bus_0_full_arlock : std_logic;
    signal int_bus_0_full_arcache : std_logic_vector(3 downto 0);
    signal int_bus_0_full_arprot : std_logic_vector(2 downto 0);
    signal int_bus_0_full_arqos : std_logic_vector(3 downto 0);
    signal int_bus_0_full_arregion : std_logic_vector(3 downto 0);
    signal int_bus_0_full_arvalid : std_logic;
    signal int_bus_0_full_arready : std_logic;
    signal int_bus_0_full_rid : std_logic_vector(axi_cpu_bus_master_id_width-1 downto 0);
    signal int_bus_0_full_rdata : std_logic_vector(axi_data_width-1 downto 0);
    signal int_bus_0_full_rresp : std_logic_vector(1 downto 0);
    signal int_bus_0_full_rlast : std_logic;
    signal int_bus_0_full_rvalid : std_logic;
    signal int_bus_0_full_rready : std_logic;
    signal signal_bus_0_full_awid : std_logic_vector(axi_cpu_bus_master_id_width-1 downto 0);
    signal signal_bus_0_full_awaddr : std_logic_vector(axi_address_width-1 downto 0);
    signal signal_bus_0_full_awlen : std_logic_vector(7 downto 0);
    signal signal_bus_0_full_awsize : std_logic_vector(2 downto 0);
    signal signal_bus_0_full_awburst : std_logic_vector(1 downto 0);
    signal signal_bus_0_full_awlock : std_logic;
    signal signal_bus_0_full_awcache : std_logic_vector(3 downto 0);
    signal signal_bus_0_full_awprot : std_logic_vector(2 downto 0);
    signal signal_bus_0_full_awqos : std_logic_vector(3 downto 0);
    signal signal_bus_0_full_awregion : std_logic_vector(3 downto 0);
    signal signal_bus_0_full_awvalid : std_logic;
    signal signal_bus_0_full_awready : std_logic;
    signal signal_bus_0_full_wdata : std_logic_vector(axi_data_width-1 downto 0);
    signal signal_bus_0_full_wstrb : std_logic_vector(axi_data_width/8-1 downto 0);
    signal signal_bus_0_full_wlast : std_logic;
    signal signal_bus_0_full_wvalid : std_logic;
    signal signal_bus_0_full_wready : std_logic;
    signal signal_bus_0_full_bid : std_logic_vector(axi_cpu_bus_master_id_width-1 downto 0);
    signal signal_bus_0_full_bresp : std_logic_vector(1 downto 0);
    signal signal_bus_0_full_bvalid : std_logic;
    signal signal_bus_0_full_bready : std_logic;
    signal signal_bus_0_full_arid : std_logic_vector(axi_cpu_bus_master_id_width-1 downto 0);
    signal signal_bus_0_full_araddr : std_logic_vector(axi_address_width-1 downto 0);
    signal signal_bus_0_full_arlen : std_logic_vector(7 downto 0);
    signal signal_bus_0_full_arsize : std_logic_vector(2 downto 0);
    signal signal_bus_0_full_arburst : std_logic_vector(1 downto 0);
    signal signal_bus_0_full_arlock : std_logic;
    signal signal_bus_0_full_arcache : std_logic_vector(3 downto 0);
    signal signal_bus_0_full_arprot : std_logic_vector(2 downto 0);
    signal signal_bus_0_full_arqos : std_logic_vector(3 downto 0);
    signal signal_bus_0_full_arregion : std_logic_vector(3 downto 0);
    signal signal_bus_0_full_arvalid : std_logic;
    signal signal_bus_0_full_arready : std_logic;
    signal signal_bus_0_full_rid : std_logic_vector(axi_cpu_bus_master_id_width-1 downto 0);
    signal signal_bus_0_full_rdata : std_logic_vector(axi_data_width-1 downto 0);
    signal signal_bus_0_full_rresp : std_logic_vector(1 downto 0);
    signal signal_bus_0_full_rlast : std_logic;
    signal signal_bus_0_full_rvalid : std_logic;
    signal signal_bus_0_full_rready : std_logic;
    
    signal cpu_bus_1_full_awid : std_logic_vector(axi_cpu_bus_slave_id_width-1 downto 0);
    signal cpu_bus_1_full_awaddr : std_logic_vector(axi_address_width-1 downto 0);
    signal cpu_bus_1_full_awlen : std_logic_vector(7 downto 0);
    signal cpu_bus_1_full_awsize : std_logic_vector(2 downto 0);
    signal cpu_bus_1_full_awburst : std_logic_vector(1 downto 0);
    signal cpu_bus_1_full_awlock : std_logic;
    signal cpu_bus_1_full_awcache : std_logic_vector(3 downto 0);
    signal cpu_bus_1_full_awprot : std_logic_vector(2 downto 0);
    signal cpu_bus_1_full_awqos : std_logic_vector(3 downto 0);
    signal cpu_bus_1_full_awregion : std_logic_vector(3 downto 0);
    signal cpu_bus_1_full_awvalid : std_logic;
    signal cpu_bus_1_full_awready : std_logic;
    signal cpu_bus_1_full_wdata : std_logic_vector(axi_data_width-1 downto 0);
    signal cpu_bus_1_full_wstrb : std_logic_vector(axi_data_width/8-1 downto 0);
    signal cpu_bus_1_full_wlast : std_logic;
    signal cpu_bus_1_full_wvalid : std_logic;
    signal cpu_bus_1_full_wready : std_logic;
    signal cpu_bus_1_full_bid : std_logic_vector(axi_cpu_bus_slave_id_width-1 downto 0);
    signal cpu_bus_1_full_bresp : std_logic_vector(1 downto 0);
    signal cpu_bus_1_full_bvalid : std_logic;
    signal cpu_bus_1_full_bready : std_logic;
    signal cpu_bus_1_full_arid : std_logic_vector(axi_cpu_bus_slave_id_width-1 downto 0);
    signal cpu_bus_1_full_araddr : std_logic_vector(axi_address_width-1 downto 0);
    signal cpu_bus_1_full_arlen : std_logic_vector(7 downto 0);
    signal cpu_bus_1_full_arsize : std_logic_vector(2 downto 0);
    signal cpu_bus_1_full_arburst : std_logic_vector(1 downto 0);
    signal cpu_bus_1_full_arlock : std_logic;
    signal cpu_bus_1_full_arcache : std_logic_vector(3 downto 0);
    signal cpu_bus_1_full_arprot : std_logic_vector(2 downto 0);
    signal cpu_bus_1_full_arqos : std_logic_vector(3 downto 0);
    signal cpu_bus_1_full_arregion : std_logic_vector(3 downto 0);
    signal cpu_bus_1_full_arvalid : std_logic;
    signal cpu_bus_1_full_arready : std_logic;
    signal cpu_bus_1_full_rid : std_logic_vector(axi_cpu_bus_slave_id_width-1 downto 0);
    signal cpu_bus_1_full_rdata : std_logic_vector(axi_data_width-1 downto 0);
    signal cpu_bus_1_full_rresp : std_logic_vector(1 downto 0);
    signal cpu_bus_1_full_rlast : std_logic;
    signal cpu_bus_1_full_rvalid : std_logic;
    signal cpu_bus_1_full_rready : std_logic;
    signal cpuid_gpio_bus_1_full_awid : std_logic_vector(axi_cpu_bus_master_id_width-1 downto 0);
    signal cpuid_gpio_bus_1_full_awaddr : std_logic_vector(axi_address_width-1 downto 0);
    signal cpuid_gpio_bus_1_full_awlen : std_logic_vector(7 downto 0);
    signal cpuid_gpio_bus_1_full_awsize : std_logic_vector(2 downto 0);
    signal cpuid_gpio_bus_1_full_awburst : std_logic_vector(1 downto 0);
    signal cpuid_gpio_bus_1_full_awlock : std_logic;
    signal cpuid_gpio_bus_1_full_awcache : std_logic_vector(3 downto 0);
    signal cpuid_gpio_bus_1_full_awprot : std_logic_vector(2 downto 0);
    signal cpuid_gpio_bus_1_full_awqos : std_logic_vector(3 downto 0);
    signal cpuid_gpio_bus_1_full_awregion : std_logic_vector(3 downto 0);
    signal cpuid_gpio_bus_1_full_awvalid : std_logic;
    signal cpuid_gpio_bus_1_full_awready : std_logic;
    signal cpuid_gpio_bus_1_full_wdata : std_logic_vector(axi_data_width-1 downto 0);
    signal cpuid_gpio_bus_1_full_wstrb : std_logic_vector(axi_data_width/8-1 downto 0);
    signal cpuid_gpio_bus_1_full_wlast : std_logic;
    signal cpuid_gpio_bus_1_full_wvalid : std_logic;
    signal cpuid_gpio_bus_1_full_wready : std_logic;
    signal cpuid_gpio_bus_1_full_bid : std_logic_vector(axi_cpu_bus_master_id_width-1 downto 0);
    signal cpuid_gpio_bus_1_full_bresp : std_logic_vector(1 downto 0);
    signal cpuid_gpio_bus_1_full_bvalid : std_logic;
    signal cpuid_gpio_bus_1_full_bready : std_logic;
    signal cpuid_gpio_bus_1_full_arid : std_logic_vector(axi_cpu_bus_master_id_width-1 downto 0);
    signal cpuid_gpio_bus_1_full_araddr : std_logic_vector(axi_address_width-1 downto 0);
    signal cpuid_gpio_bus_1_full_arlen : std_logic_vector(7 downto 0);
    signal cpuid_gpio_bus_1_full_arsize : std_logic_vector(2 downto 0);
    signal cpuid_gpio_bus_1_full_arburst : std_logic_vector(1 downto 0);
    signal cpuid_gpio_bus_1_full_arlock : std_logic;
    signal cpuid_gpio_bus_1_full_arcache : std_logic_vector(3 downto 0);
    signal cpuid_gpio_bus_1_full_arprot : std_logic_vector(2 downto 0);
    signal cpuid_gpio_bus_1_full_arqos : std_logic_vector(3 downto 0);
    signal cpuid_gpio_bus_1_full_arregion : std_logic_vector(3 downto 0);
    signal cpuid_gpio_bus_1_full_arvalid : std_logic;
    signal cpuid_gpio_bus_1_full_arready : std_logic;
    signal cpuid_gpio_bus_1_full_rid : std_logic_vector(axi_cpu_bus_master_id_width-1 downto 0);
    signal cpuid_gpio_bus_1_full_rdata : std_logic_vector(axi_data_width-1 downto 0);
    signal cpuid_gpio_bus_1_full_rresp : std_logic_vector(1 downto 0);
    signal cpuid_gpio_bus_1_full_rlast : std_logic;
    signal cpuid_gpio_bus_1_full_rvalid : std_logic;
    signal cpuid_gpio_bus_1_full_rready : std_logic;
    signal int_bus_1_full_awid : std_logic_vector(axi_cpu_bus_master_id_width-1 downto 0);
    signal int_bus_1_full_awaddr : std_logic_vector(axi_address_width-1 downto 0);
    signal int_bus_1_full_awlen : std_logic_vector(7 downto 0);
    signal int_bus_1_full_awsize : std_logic_vector(2 downto 0);
    signal int_bus_1_full_awburst : std_logic_vector(1 downto 0);
    signal int_bus_1_full_awlock : std_logic;
    signal int_bus_1_full_awcache : std_logic_vector(3 downto 0);
    signal int_bus_1_full_awprot : std_logic_vector(2 downto 0);
    signal int_bus_1_full_awqos : std_logic_vector(3 downto 0);
    signal int_bus_1_full_awregion : std_logic_vector(3 downto 0);
    signal int_bus_1_full_awvalid : std_logic;
    signal int_bus_1_full_awready : std_logic;
    signal int_bus_1_full_wdata : std_logic_vector(axi_data_width-1 downto 0);
    signal int_bus_1_full_wstrb : std_logic_vector(axi_data_width/8-1 downto 0);
    signal int_bus_1_full_wlast : std_logic;
    signal int_bus_1_full_wvalid : std_logic;
    signal int_bus_1_full_wready : std_logic;
    signal int_bus_1_full_bid : std_logic_vector(axi_cpu_bus_master_id_width-1 downto 0);
    signal int_bus_1_full_bresp : std_logic_vector(1 downto 0);
    signal int_bus_1_full_bvalid : std_logic;
    signal int_bus_1_full_bready : std_logic;
    signal int_bus_1_full_arid : std_logic_vector(axi_cpu_bus_master_id_width-1 downto 0);
    signal int_bus_1_full_araddr : std_logic_vector(axi_address_width-1 downto 0);
    signal int_bus_1_full_arlen : std_logic_vector(7 downto 0);
    signal int_bus_1_full_arsize : std_logic_vector(2 downto 0);
    signal int_bus_1_full_arburst : std_logic_vector(1 downto 0);
    signal int_bus_1_full_arlock : std_logic;
    signal int_bus_1_full_arcache : std_logic_vector(3 downto 0);
    signal int_bus_1_full_arprot : std_logic_vector(2 downto 0);
    signal int_bus_1_full_arqos : std_logic_vector(3 downto 0);
    signal int_bus_1_full_arregion : std_logic_vector(3 downto 0);
    signal int_bus_1_full_arvalid : std_logic;
    signal int_bus_1_full_arready : std_logic;
    signal int_bus_1_full_rid : std_logic_vector(axi_cpu_bus_master_id_width-1 downto 0);
    signal int_bus_1_full_rdata : std_logic_vector(axi_data_width-1 downto 0);
    signal int_bus_1_full_rresp : std_logic_vector(1 downto 0);
    signal int_bus_1_full_rlast : std_logic;
    signal int_bus_1_full_rvalid : std_logic;
    signal int_bus_1_full_rready : std_logic;
    signal signal_bus_1_full_awid : std_logic_vector(axi_cpu_bus_master_id_width-1 downto 0);
    signal signal_bus_1_full_awaddr : std_logic_vector(axi_address_width-1 downto 0);
    signal signal_bus_1_full_awlen : std_logic_vector(7 downto 0);
    signal signal_bus_1_full_awsize : std_logic_vector(2 downto 0);
    signal signal_bus_1_full_awburst : std_logic_vector(1 downto 0);
    signal signal_bus_1_full_awlock : std_logic;
    signal signal_bus_1_full_awcache : std_logic_vector(3 downto 0);
    signal signal_bus_1_full_awprot : std_logic_vector(2 downto 0);
    signal signal_bus_1_full_awqos : std_logic_vector(3 downto 0);
    signal signal_bus_1_full_awregion : std_logic_vector(3 downto 0);
    signal signal_bus_1_full_awvalid : std_logic;
    signal signal_bus_1_full_awready : std_logic;
    signal signal_bus_1_full_wdata : std_logic_vector(axi_data_width-1 downto 0);
    signal signal_bus_1_full_wstrb : std_logic_vector(axi_data_width/8-1 downto 0);
    signal signal_bus_1_full_wlast : std_logic;
    signal signal_bus_1_full_wvalid : std_logic;
    signal signal_bus_1_full_wready : std_logic;
    signal signal_bus_1_full_bid : std_logic_vector(axi_cpu_bus_master_id_width-1 downto 0);
    signal signal_bus_1_full_bresp : std_logic_vector(1 downto 0);
    signal signal_bus_1_full_bvalid : std_logic;
    signal signal_bus_1_full_bready : std_logic;
    signal signal_bus_1_full_arid : std_logic_vector(axi_cpu_bus_master_id_width-1 downto 0);
    signal signal_bus_1_full_araddr : std_logic_vector(axi_address_width-1 downto 0);
    signal signal_bus_1_full_arlen : std_logic_vector(7 downto 0);
    signal signal_bus_1_full_arsize : std_logic_vector(2 downto 0);
    signal signal_bus_1_full_arburst : std_logic_vector(1 downto 0);
    signal signal_bus_1_full_arlock : std_logic;
    signal signal_bus_1_full_arcache : std_logic_vector(3 downto 0);
    signal signal_bus_1_full_arprot : std_logic_vector(2 downto 0);
    signal signal_bus_1_full_arqos : std_logic_vector(3 downto 0);
    signal signal_bus_1_full_arregion : std_logic_vector(3 downto 0);
    signal signal_bus_1_full_arvalid : std_logic;
    signal signal_bus_1_full_arready : std_logic;
    signal signal_bus_1_full_rid : std_logic_vector(axi_cpu_bus_master_id_width-1 downto 0);
    signal signal_bus_1_full_rdata : std_logic_vector(axi_data_width-1 downto 0);
    signal signal_bus_1_full_rresp : std_logic_vector(1 downto 0);
    signal signal_bus_1_full_rlast : std_logic;
    signal signal_bus_1_full_rvalid : std_logic;
    signal signal_bus_1_full_rready : std_logic;
    
    signal cpu_bus_2_full_awid : std_logic_vector(axi_cpu_bus_slave_id_width-1 downto 0);
    signal cpu_bus_2_full_awaddr : std_logic_vector(axi_address_width-1 downto 0);
    signal cpu_bus_2_full_awlen : std_logic_vector(7 downto 0);
    signal cpu_bus_2_full_awsize : std_logic_vector(2 downto 0);
    signal cpu_bus_2_full_awburst : std_logic_vector(1 downto 0);
    signal cpu_bus_2_full_awlock : std_logic;
    signal cpu_bus_2_full_awcache : std_logic_vector(3 downto 0);
    signal cpu_bus_2_full_awprot : std_logic_vector(2 downto 0);
    signal cpu_bus_2_full_awqos : std_logic_vector(3 downto 0);
    signal cpu_bus_2_full_awregion : std_logic_vector(3 downto 0);
    signal cpu_bus_2_full_awvalid : std_logic;
    signal cpu_bus_2_full_awready : std_logic;
    signal cpu_bus_2_full_wdata : std_logic_vector(axi_data_width-1 downto 0);
    signal cpu_bus_2_full_wstrb : std_logic_vector(axi_data_width/8-1 downto 0);
    signal cpu_bus_2_full_wlast : std_logic;
    signal cpu_bus_2_full_wvalid : std_logic;
    signal cpu_bus_2_full_wready : std_logic;
    signal cpu_bus_2_full_bid : std_logic_vector(axi_cpu_bus_slave_id_width-1 downto 0);
    signal cpu_bus_2_full_bresp : std_logic_vector(1 downto 0);
    signal cpu_bus_2_full_bvalid : std_logic;
    signal cpu_bus_2_full_bready : std_logic;
    signal cpu_bus_2_full_arid : std_logic_vector(axi_cpu_bus_slave_id_width-1 downto 0);
    signal cpu_bus_2_full_araddr : std_logic_vector(axi_address_width-1 downto 0);
    signal cpu_bus_2_full_arlen : std_logic_vector(7 downto 0);
    signal cpu_bus_2_full_arsize : std_logic_vector(2 downto 0);
    signal cpu_bus_2_full_arburst : std_logic_vector(1 downto 0);
    signal cpu_bus_2_full_arlock : std_logic;
    signal cpu_bus_2_full_arcache : std_logic_vector(3 downto 0);
    signal cpu_bus_2_full_arprot : std_logic_vector(2 downto 0);
    signal cpu_bus_2_full_arqos : std_logic_vector(3 downto 0);
    signal cpu_bus_2_full_arregion : std_logic_vector(3 downto 0);
    signal cpu_bus_2_full_arvalid : std_logic;
    signal cpu_bus_2_full_arready : std_logic;
    signal cpu_bus_2_full_rid : std_logic_vector(axi_cpu_bus_slave_id_width-1 downto 0);
    signal cpu_bus_2_full_rdata : std_logic_vector(axi_data_width-1 downto 0);
    signal cpu_bus_2_full_rresp : std_logic_vector(1 downto 0);
    signal cpu_bus_2_full_rlast : std_logic;
    signal cpu_bus_2_full_rvalid : std_logic;
    signal cpu_bus_2_full_rready : std_logic;
    signal cpuid_gpio_bus_2_full_awid : std_logic_vector(axi_cpu_bus_master_id_width-1 downto 0);
    signal cpuid_gpio_bus_2_full_awaddr : std_logic_vector(axi_address_width-1 downto 0);
    signal cpuid_gpio_bus_2_full_awlen : std_logic_vector(7 downto 0);
    signal cpuid_gpio_bus_2_full_awsize : std_logic_vector(2 downto 0);
    signal cpuid_gpio_bus_2_full_awburst : std_logic_vector(1 downto 0);
    signal cpuid_gpio_bus_2_full_awlock : std_logic;
    signal cpuid_gpio_bus_2_full_awcache : std_logic_vector(3 downto 0);
    signal cpuid_gpio_bus_2_full_awprot : std_logic_vector(2 downto 0);
    signal cpuid_gpio_bus_2_full_awqos : std_logic_vector(3 downto 0);
    signal cpuid_gpio_bus_2_full_awregion : std_logic_vector(3 downto 0);
    signal cpuid_gpio_bus_2_full_awvalid : std_logic;
    signal cpuid_gpio_bus_2_full_awready : std_logic;
    signal cpuid_gpio_bus_2_full_wdata : std_logic_vector(axi_data_width-1 downto 0);
    signal cpuid_gpio_bus_2_full_wstrb : std_logic_vector(axi_data_width/8-1 downto 0);
    signal cpuid_gpio_bus_2_full_wlast : std_logic;
    signal cpuid_gpio_bus_2_full_wvalid : std_logic;
    signal cpuid_gpio_bus_2_full_wready : std_logic;
    signal cpuid_gpio_bus_2_full_bid : std_logic_vector(axi_cpu_bus_master_id_width-1 downto 0);
    signal cpuid_gpio_bus_2_full_bresp : std_logic_vector(1 downto 0);
    signal cpuid_gpio_bus_2_full_bvalid : std_logic;
    signal cpuid_gpio_bus_2_full_bready : std_logic;
    signal cpuid_gpio_bus_2_full_arid : std_logic_vector(axi_cpu_bus_master_id_width-1 downto 0);
    signal cpuid_gpio_bus_2_full_araddr : std_logic_vector(axi_address_width-1 downto 0);
    signal cpuid_gpio_bus_2_full_arlen : std_logic_vector(7 downto 0);
    signal cpuid_gpio_bus_2_full_arsize : std_logic_vector(2 downto 0);
    signal cpuid_gpio_bus_2_full_arburst : std_logic_vector(1 downto 0);
    signal cpuid_gpio_bus_2_full_arlock : std_logic;
    signal cpuid_gpio_bus_2_full_arcache : std_logic_vector(3 downto 0);
    signal cpuid_gpio_bus_2_full_arprot : std_logic_vector(2 downto 0);
    signal cpuid_gpio_bus_2_full_arqos : std_logic_vector(3 downto 0);
    signal cpuid_gpio_bus_2_full_arregion : std_logic_vector(3 downto 0);
    signal cpuid_gpio_bus_2_full_arvalid : std_logic;
    signal cpuid_gpio_bus_2_full_arready : std_logic;
    signal cpuid_gpio_bus_2_full_rid : std_logic_vector(axi_cpu_bus_master_id_width-1 downto 0);
    signal cpuid_gpio_bus_2_full_rdata : std_logic_vector(axi_data_width-1 downto 0);
    signal cpuid_gpio_bus_2_full_rresp : std_logic_vector(1 downto 0);
    signal cpuid_gpio_bus_2_full_rlast : std_logic;
    signal cpuid_gpio_bus_2_full_rvalid : std_logic;
    signal cpuid_gpio_bus_2_full_rready : std_logic;
    signal int_bus_2_full_awid : std_logic_vector(axi_cpu_bus_master_id_width-1 downto 0);
    signal int_bus_2_full_awaddr : std_logic_vector(axi_address_width-1 downto 0);
    signal int_bus_2_full_awlen : std_logic_vector(7 downto 0);
    signal int_bus_2_full_awsize : std_logic_vector(2 downto 0);
    signal int_bus_2_full_awburst : std_logic_vector(1 downto 0);
    signal int_bus_2_full_awlock : std_logic;
    signal int_bus_2_full_awcache : std_logic_vector(3 downto 0);
    signal int_bus_2_full_awprot : std_logic_vector(2 downto 0);
    signal int_bus_2_full_awqos : std_logic_vector(3 downto 0);
    signal int_bus_2_full_awregion : std_logic_vector(3 downto 0);
    signal int_bus_2_full_awvalid : std_logic;
    signal int_bus_2_full_awready : std_logic;
    signal int_bus_2_full_wdata : std_logic_vector(axi_data_width-1 downto 0);
    signal int_bus_2_full_wstrb : std_logic_vector(axi_data_width/8-1 downto 0);
    signal int_bus_2_full_wlast : std_logic;
    signal int_bus_2_full_wvalid : std_logic;
    signal int_bus_2_full_wready : std_logic;
    signal int_bus_2_full_bid : std_logic_vector(axi_cpu_bus_master_id_width-1 downto 0);
    signal int_bus_2_full_bresp : std_logic_vector(1 downto 0);
    signal int_bus_2_full_bvalid : std_logic;
    signal int_bus_2_full_bready : std_logic;
    signal int_bus_2_full_arid : std_logic_vector(axi_cpu_bus_master_id_width-1 downto 0);
    signal int_bus_2_full_araddr : std_logic_vector(axi_address_width-1 downto 0);
    signal int_bus_2_full_arlen : std_logic_vector(7 downto 0);
    signal int_bus_2_full_arsize : std_logic_vector(2 downto 0);
    signal int_bus_2_full_arburst : std_logic_vector(1 downto 0);
    signal int_bus_2_full_arlock : std_logic;
    signal int_bus_2_full_arcache : std_logic_vector(3 downto 0);
    signal int_bus_2_full_arprot : std_logic_vector(2 downto 0);
    signal int_bus_2_full_arqos : std_logic_vector(3 downto 0);
    signal int_bus_2_full_arregion : std_logic_vector(3 downto 0);
    signal int_bus_2_full_arvalid : std_logic;
    signal int_bus_2_full_arready : std_logic;
    signal int_bus_2_full_rid : std_logic_vector(axi_cpu_bus_master_id_width-1 downto 0);
    signal int_bus_2_full_rdata : std_logic_vector(axi_data_width-1 downto 0);
    signal int_bus_2_full_rresp : std_logic_vector(1 downto 0);
    signal int_bus_2_full_rlast : std_logic;
    signal int_bus_2_full_rvalid : std_logic;
    signal int_bus_2_full_rready : std_logic;
    signal signal_bus_2_full_awid : std_logic_vector(axi_cpu_bus_master_id_width-1 downto 0);
    signal signal_bus_2_full_awaddr : std_logic_vector(axi_address_width-1 downto 0);
    signal signal_bus_2_full_awlen : std_logic_vector(7 downto 0);
    signal signal_bus_2_full_awsize : std_logic_vector(2 downto 0);
    signal signal_bus_2_full_awburst : std_logic_vector(1 downto 0);
    signal signal_bus_2_full_awlock : std_logic;
    signal signal_bus_2_full_awcache : std_logic_vector(3 downto 0);
    signal signal_bus_2_full_awprot : std_logic_vector(2 downto 0);
    signal signal_bus_2_full_awqos : std_logic_vector(3 downto 0);
    signal signal_bus_2_full_awregion : std_logic_vector(3 downto 0);
    signal signal_bus_2_full_awvalid : std_logic;
    signal signal_bus_2_full_awready : std_logic;
    signal signal_bus_2_full_wdata : std_logic_vector(axi_data_width-1 downto 0);
    signal signal_bus_2_full_wstrb : std_logic_vector(axi_data_width/8-1 downto 0);
    signal signal_bus_2_full_wlast : std_logic;
    signal signal_bus_2_full_wvalid : std_logic;
    signal signal_bus_2_full_wready : std_logic;
    signal signal_bus_2_full_bid : std_logic_vector(axi_cpu_bus_master_id_width-1 downto 0);
    signal signal_bus_2_full_bresp : std_logic_vector(1 downto 0);
    signal signal_bus_2_full_bvalid : std_logic;
    signal signal_bus_2_full_bready : std_logic;
    signal signal_bus_2_full_arid : std_logic_vector(axi_cpu_bus_master_id_width-1 downto 0);
    signal signal_bus_2_full_araddr : std_logic_vector(axi_address_width-1 downto 0);
    signal signal_bus_2_full_arlen : std_logic_vector(7 downto 0);
    signal signal_bus_2_full_arsize : std_logic_vector(2 downto 0);
    signal signal_bus_2_full_arburst : std_logic_vector(1 downto 0);
    signal signal_bus_2_full_arlock : std_logic;
    signal signal_bus_2_full_arcache : std_logic_vector(3 downto 0);
    signal signal_bus_2_full_arprot : std_logic_vector(2 downto 0);
    signal signal_bus_2_full_arqos : std_logic_vector(3 downto 0);
    signal signal_bus_2_full_arregion : std_logic_vector(3 downto 0);
    signal signal_bus_2_full_arvalid : std_logic;
    signal signal_bus_2_full_arready : std_logic;
    signal signal_bus_2_full_rid : std_logic_vector(axi_cpu_bus_master_id_width-1 downto 0);
    signal signal_bus_2_full_rdata : std_logic_vector(axi_data_width-1 downto 0);
    signal signal_bus_2_full_rresp : std_logic_vector(1 downto 0);
    signal signal_bus_2_full_rlast : std_logic;
    signal signal_bus_2_full_rvalid : std_logic;
    signal signal_bus_2_full_rready : std_logic;
    
    --------------------------------------
    -- CPUID GPIO AXI Full2Lite Signals --
    --------------------------------------
    
    signal cpuid_gpio_bus_0_lite_awaddr : std_logic_vector(axi_address_width-1 downto 0);                 
    signal cpuid_gpio_bus_0_lite_awprot : std_logic_vector(2 downto 0);                                   
    signal cpuid_gpio_bus_0_lite_awvalid : std_logic;                                                     
    signal cpuid_gpio_bus_0_lite_awready : std_logic;                                                    
    signal cpuid_gpio_bus_0_lite_wvalid : std_logic;                                                      
    signal cpuid_gpio_bus_0_lite_wready : std_logic;                                                     
    signal cpuid_gpio_bus_0_lite_wdata : std_logic_vector(axi_data_width-1 downto 0);                     
    signal cpuid_gpio_bus_0_lite_wstrb : std_logic_vector(axi_data_width/8-1 downto 0);                   
    signal cpuid_gpio_bus_0_lite_bvalid : std_logic;                                                     
    signal cpuid_gpio_bus_0_lite_bready : std_logic;                                                      
    signal cpuid_gpio_bus_0_lite_bresp : std_logic_vector(1 downto 0);                     
    signal cpuid_gpio_bus_0_lite_araddr : std_logic_vector(axi_address_width-1 downto 0);                 
    signal cpuid_gpio_bus_0_lite_arprot : std_logic_vector(2 downto 0);                                   
    signal cpuid_gpio_bus_0_lite_arvalid : std_logic;                                                     
    signal cpuid_gpio_bus_0_lite_arready : std_logic;                                                    
    signal cpuid_gpio_bus_0_lite_rdata : std_logic_vector(axi_data_width-1 downto 0);   
    signal cpuid_gpio_bus_0_lite_rvalid : std_logic;                                                     
    signal cpuid_gpio_bus_0_lite_rready : std_logic;                                                      
    signal cpuid_gpio_bus_0_lite_rresp : std_logic_vector(1 downto 0);  
    
    signal cpuid_gpio_bus_1_lite_awaddr : std_logic_vector(axi_address_width-1 downto 0);                 
    signal cpuid_gpio_bus_1_lite_awprot : std_logic_vector(2 downto 0);                                   
    signal cpuid_gpio_bus_1_lite_awvalid : std_logic;                                                     
    signal cpuid_gpio_bus_1_lite_awready : std_logic;                                                    
    signal cpuid_gpio_bus_1_lite_wvalid : std_logic;                                                      
    signal cpuid_gpio_bus_1_lite_wready : std_logic;                                                     
    signal cpuid_gpio_bus_1_lite_wdata : std_logic_vector(axi_data_width-1 downto 0);                     
    signal cpuid_gpio_bus_1_lite_wstrb : std_logic_vector(axi_data_width/8-1 downto 0);                   
    signal cpuid_gpio_bus_1_lite_bvalid : std_logic;                                                     
    signal cpuid_gpio_bus_1_lite_bready : std_logic;                                                      
    signal cpuid_gpio_bus_1_lite_bresp : std_logic_vector(1 downto 0);                     
    signal cpuid_gpio_bus_1_lite_araddr : std_logic_vector(axi_address_width-1 downto 0);                 
    signal cpuid_gpio_bus_1_lite_arprot : std_logic_vector(2 downto 0);                                   
    signal cpuid_gpio_bus_1_lite_arvalid : std_logic;                                                     
    signal cpuid_gpio_bus_1_lite_arready : std_logic;                                                    
    signal cpuid_gpio_bus_1_lite_rdata : std_logic_vector(axi_data_width-1 downto 0);   
    signal cpuid_gpio_bus_1_lite_rvalid : std_logic;                                                     
    signal cpuid_gpio_bus_1_lite_rready : std_logic;                                                      
    signal cpuid_gpio_bus_1_lite_rresp : std_logic_vector(1 downto 0); 
    
    signal cpuid_gpio_bus_2_lite_awaddr : std_logic_vector(axi_address_width-1 downto 0);                 
    signal cpuid_gpio_bus_2_lite_awprot : std_logic_vector(2 downto 0);                                   
    signal cpuid_gpio_bus_2_lite_awvalid : std_logic;                                                     
    signal cpuid_gpio_bus_2_lite_awready : std_logic;                                                    
    signal cpuid_gpio_bus_2_lite_wvalid : std_logic;                                                      
    signal cpuid_gpio_bus_2_lite_wready : std_logic;                                                     
    signal cpuid_gpio_bus_2_lite_wdata : std_logic_vector(axi_data_width-1 downto 0);                     
    signal cpuid_gpio_bus_2_lite_wstrb : std_logic_vector(axi_data_width/8-1 downto 0);                   
    signal cpuid_gpio_bus_2_lite_bvalid : std_logic;                                                     
    signal cpuid_gpio_bus_2_lite_bready : std_logic;                                                      
    signal cpuid_gpio_bus_2_lite_bresp : std_logic_vector(1 downto 0);                     
    signal cpuid_gpio_bus_2_lite_araddr : std_logic_vector(axi_address_width-1 downto 0);                 
    signal cpuid_gpio_bus_2_lite_arprot : std_logic_vector(2 downto 0);                                   
    signal cpuid_gpio_bus_2_lite_arvalid : std_logic;                                                     
    signal cpuid_gpio_bus_2_lite_arready : std_logic;                                                    
    signal cpuid_gpio_bus_2_lite_rdata : std_logic_vector(axi_data_width-1 downto 0);   
    signal cpuid_gpio_bus_2_lite_rvalid : std_logic;                                                     
    signal cpuid_gpio_bus_2_lite_rready : std_logic;                                                      
    signal cpuid_gpio_bus_2_lite_rresp : std_logic_vector(1 downto 0); 
    
    -----------------------------------
    -- CPU INT AXI Full2Lite Signals --
    -----------------------------------
    
    signal int_bus_0_lite_awaddr : std_logic_vector(axi_address_width-1 downto 0);                 
    signal int_bus_0_lite_awprot : std_logic_vector(2 downto 0);                                   
    signal int_bus_0_lite_awvalid : std_logic;                                                     
    signal int_bus_0_lite_awready : std_logic;                                                    
    signal int_bus_0_lite_wvalid : std_logic;                                                      
    signal int_bus_0_lite_wready : std_logic;                                                     
    signal int_bus_0_lite_wdata : std_logic_vector(axi_data_width-1 downto 0);                     
    signal int_bus_0_lite_wstrb : std_logic_vector(axi_data_width/8-1 downto 0);                   
    signal int_bus_0_lite_bvalid : std_logic;                                                     
    signal int_bus_0_lite_bready : std_logic;                                                      
    signal int_bus_0_lite_bresp : std_logic_vector(1 downto 0);                     
    signal int_bus_0_lite_araddr : std_logic_vector(axi_address_width-1 downto 0);                 
    signal int_bus_0_lite_arprot : std_logic_vector(2 downto 0);                                   
    signal int_bus_0_lite_arvalid : std_logic;                                                     
    signal int_bus_0_lite_arready : std_logic;                                                    
    signal int_bus_0_lite_rdata : std_logic_vector(axi_data_width-1 downto 0);   
    signal int_bus_0_lite_rvalid : std_logic;                                                     
    signal int_bus_0_lite_rready : std_logic;                                                      
    signal int_bus_0_lite_rresp : std_logic_vector(1 downto 0);  
    
    signal int_bus_1_lite_awaddr : std_logic_vector(axi_address_width-1 downto 0);                 
    signal int_bus_1_lite_awprot : std_logic_vector(2 downto 0);                                   
    signal int_bus_1_lite_awvalid : std_logic;                                                     
    signal int_bus_1_lite_awready : std_logic;                                                    
    signal int_bus_1_lite_wvalid : std_logic;                                                      
    signal int_bus_1_lite_wready : std_logic;                                                     
    signal int_bus_1_lite_wdata : std_logic_vector(axi_data_width-1 downto 0);                     
    signal int_bus_1_lite_wstrb : std_logic_vector(axi_data_width/8-1 downto 0);                   
    signal int_bus_1_lite_bvalid : std_logic;                                                     
    signal int_bus_1_lite_bready : std_logic;                                                      
    signal int_bus_1_lite_bresp : std_logic_vector(1 downto 0);                     
    signal int_bus_1_lite_araddr : std_logic_vector(axi_address_width-1 downto 0);                 
    signal int_bus_1_lite_arprot : std_logic_vector(2 downto 0);                                   
    signal int_bus_1_lite_arvalid : std_logic;                                                     
    signal int_bus_1_lite_arready : std_logic;                                                    
    signal int_bus_1_lite_rdata : std_logic_vector(axi_data_width-1 downto 0);   
    signal int_bus_1_lite_rvalid : std_logic;                                                     
    signal int_bus_1_lite_rready : std_logic;                                                      
    signal int_bus_1_lite_rresp : std_logic_vector(1 downto 0); 
    
    signal int_bus_2_lite_awaddr : std_logic_vector(axi_address_width-1 downto 0);                 
    signal int_bus_2_lite_awprot : std_logic_vector(2 downto 0);                                   
    signal int_bus_2_lite_awvalid : std_logic;                                                     
    signal int_bus_2_lite_awready : std_logic;                                                    
    signal int_bus_2_lite_wvalid : std_logic;                                                      
    signal int_bus_2_lite_wready : std_logic;                                                     
    signal int_bus_2_lite_wdata : std_logic_vector(axi_data_width-1 downto 0);                     
    signal int_bus_2_lite_wstrb : std_logic_vector(axi_data_width/8-1 downto 0);                   
    signal int_bus_2_lite_bvalid : std_logic;                                                     
    signal int_bus_2_lite_bready : std_logic;                                                      
    signal int_bus_2_lite_bresp : std_logic_vector(1 downto 0);                     
    signal int_bus_2_lite_araddr : std_logic_vector(axi_address_width-1 downto 0);                 
    signal int_bus_2_lite_arprot : std_logic_vector(2 downto 0);                                   
    signal int_bus_2_lite_arvalid : std_logic;                                                     
    signal int_bus_2_lite_arready : std_logic;                                                    
    signal int_bus_2_lite_rdata : std_logic_vector(axi_data_width-1 downto 0);   
    signal int_bus_2_lite_rvalid : std_logic;                                                     
    signal int_bus_2_lite_rready : std_logic;                                                      
    signal int_bus_2_lite_rresp : std_logic_vector(1 downto 0); 
    
    --------------------------------------
    -- CPU Signal AXI Full2Lite Signals --
    --------------------------------------
    
    signal signal_bus_0_lite_awaddr : std_logic_vector(axi_address_width-1 downto 0);                 
    signal signal_bus_0_lite_awprot : std_logic_vector(2 downto 0);                                   
    signal signal_bus_0_lite_awvalid : std_logic;                                                     
    signal signal_bus_0_lite_awready : std_logic;                                                    
    signal signal_bus_0_lite_wvalid : std_logic;                                                      
    signal signal_bus_0_lite_wready : std_logic;                                                     
    signal signal_bus_0_lite_wdata : std_logic_vector(axi_data_width-1 downto 0);                     
    signal signal_bus_0_lite_wstrb : std_logic_vector(axi_data_width/8-1 downto 0);                   
    signal signal_bus_0_lite_bvalid : std_logic;                                                     
    signal signal_bus_0_lite_bready : std_logic;                                                      
    signal signal_bus_0_lite_bresp : std_logic_vector(1 downto 0);                     
    signal signal_bus_0_lite_araddr : std_logic_vector(axi_address_width-1 downto 0);                 
    signal signal_bus_0_lite_arprot : std_logic_vector(2 downto 0);                                   
    signal signal_bus_0_lite_arvalid : std_logic;                                                     
    signal signal_bus_0_lite_arready : std_logic;                                                    
    signal signal_bus_0_lite_rdata : std_logic_vector(axi_data_width-1 downto 0);   
    signal signal_bus_0_lite_rvalid : std_logic;                                                     
    signal signal_bus_0_lite_rready : std_logic;                                                      
    signal signal_bus_0_lite_rresp : std_logic_vector(1 downto 0);  
    
    signal signal_bus_1_lite_awaddr : std_logic_vector(axi_address_width-1 downto 0);                 
    signal signal_bus_1_lite_awprot : std_logic_vector(2 downto 0);                                   
    signal signal_bus_1_lite_awvalid : std_logic;                                                     
    signal signal_bus_1_lite_awready : std_logic;                                                    
    signal signal_bus_1_lite_wvalid : std_logic;                                                      
    signal signal_bus_1_lite_wready : std_logic;                                                     
    signal signal_bus_1_lite_wdata : std_logic_vector(axi_data_width-1 downto 0);                     
    signal signal_bus_1_lite_wstrb : std_logic_vector(axi_data_width/8-1 downto 0);                   
    signal signal_bus_1_lite_bvalid : std_logic;                                                     
    signal signal_bus_1_lite_bready : std_logic;                                                      
    signal signal_bus_1_lite_bresp : std_logic_vector(1 downto 0);                     
    signal signal_bus_1_lite_araddr : std_logic_vector(axi_address_width-1 downto 0);                 
    signal signal_bus_1_lite_arprot : std_logic_vector(2 downto 0);                                   
    signal signal_bus_1_lite_arvalid : std_logic;                                                     
    signal signal_bus_1_lite_arready : std_logic;                                                    
    signal signal_bus_1_lite_rdata : std_logic_vector(axi_data_width-1 downto 0);   
    signal signal_bus_1_lite_rvalid : std_logic;                                                     
    signal signal_bus_1_lite_rready : std_logic;                                                      
    signal signal_bus_1_lite_rresp : std_logic_vector(1 downto 0); 
    
    signal signal_bus_2_lite_awaddr : std_logic_vector(axi_address_width-1 downto 0);                 
    signal signal_bus_2_lite_awprot : std_logic_vector(2 downto 0);                                   
    signal signal_bus_2_lite_awvalid : std_logic;                                                     
    signal signal_bus_2_lite_awready : std_logic;                                                    
    signal signal_bus_2_lite_wvalid : std_logic;                                                      
    signal signal_bus_2_lite_wready : std_logic;                                                     
    signal signal_bus_2_lite_wdata : std_logic_vector(axi_data_width-1 downto 0);                     
    signal signal_bus_2_lite_wstrb : std_logic_vector(axi_data_width/8-1 downto 0);                   
    signal signal_bus_2_lite_bvalid : std_logic;                                                     
    signal signal_bus_2_lite_bready : std_logic;                                                      
    signal signal_bus_2_lite_bresp : std_logic_vector(1 downto 0);                     
    signal signal_bus_2_lite_araddr : std_logic_vector(axi_address_width-1 downto 0);                 
    signal signal_bus_2_lite_arprot : std_logic_vector(2 downto 0);                                   
    signal signal_bus_2_lite_arvalid : std_logic;                                                     
    signal signal_bus_2_lite_arready : std_logic;                                                    
    signal signal_bus_2_lite_rdata : std_logic_vector(axi_data_width-1 downto 0);   
    signal signal_bus_2_lite_rvalid : std_logic;                                                     
    signal signal_bus_2_lite_rready : std_logic;                                                      
    signal signal_bus_2_lite_rresp : std_logic_vector(1 downto 0); 
    
    ---------------------------------------------
    -- Main Interconnect AXI Full2Lite Signals --
    ---------------------------------------------
    
    signal int_axi_lite_awaddr : std_logic_vector(axi_address_width-1 downto 0);                 
    signal int_axi_lite_awprot : std_logic_vector(2 downto 0);                                   
    signal int_axi_lite_awvalid : std_logic;                                                     
    signal int_axi_lite_awready : std_logic;                                                    
    signal int_axi_lite_wvalid : std_logic;                                                      
    signal int_axi_lite_wready : std_logic;                                                     
    signal int_axi_lite_wdata : std_logic_vector(axi_data_width-1 downto 0);                     
    signal int_axi_lite_wstrb : std_logic_vector(axi_data_width/8-1 downto 0);                   
    signal int_axi_lite_bvalid : std_logic;                                                     
    signal int_axi_lite_bready : std_logic;                                                      
    signal int_axi_lite_bresp : std_logic_vector(1 downto 0);                     
    signal int_axi_lite_araddr : std_logic_vector(axi_address_width-1 downto 0);                 
    signal int_axi_lite_arprot : std_logic_vector(2 downto 0);                                   
    signal int_axi_lite_arvalid : std_logic;                                                     
    signal int_axi_lite_arready : std_logic;                                                    
    signal int_axi_lite_rdata : std_logic_vector(axi_data_width-1 downto 0);   
    signal int_axi_lite_rvalid : std_logic;                                                     
    signal int_axi_lite_rready : std_logic;                                                      
    signal int_axi_lite_rresp : std_logic_vector(1 downto 0); 
    
    signal timer_axi_lite_awaddr : std_logic_vector(axi_address_width-1 downto 0);                 
    signal timer_axi_lite_awprot : std_logic_vector(2 downto 0);                                   
    signal timer_axi_lite_awvalid : std_logic;                                                     
    signal timer_axi_lite_awready : std_logic;                                                    
    signal timer_axi_lite_wvalid : std_logic;                                                      
    signal timer_axi_lite_wready : std_logic;                                                     
    signal timer_axi_lite_wdata : std_logic_vector(axi_data_width-1 downto 0);                     
    signal timer_axi_lite_wstrb : std_logic_vector(axi_data_width/8-1 downto 0);                   
    signal timer_axi_lite_bvalid : std_logic;                                                     
    signal timer_axi_lite_bready : std_logic;                                                      
    signal timer_axi_lite_bresp : std_logic_vector(1 downto 0);                     
    signal timer_axi_lite_araddr : std_logic_vector(axi_address_width-1 downto 0);                 
    signal timer_axi_lite_arprot : std_logic_vector(2 downto 0);                                   
    signal timer_axi_lite_arvalid : std_logic;                                                     
    signal timer_axi_lite_arready : std_logic;                                                    
    signal timer_axi_lite_rdata : std_logic_vector(axi_data_width-1 downto 0);   
    signal timer_axi_lite_rvalid : std_logic;                                                     
    signal timer_axi_lite_rready : std_logic;                                                      
    signal timer_axi_lite_rresp : std_logic_vector(1 downto 0); 
    
    signal gpio_axi_lite_awaddr : std_logic_vector(axi_address_width-1 downto 0);                 
    signal gpio_axi_lite_awprot : std_logic_vector(2 downto 0);                                   
    signal gpio_axi_lite_awvalid : std_logic;                                                     
    signal gpio_axi_lite_awready : std_logic;                                                    
    signal gpio_axi_lite_wvalid : std_logic;                                                      
    signal gpio_axi_lite_wready : std_logic;                                                     
    signal gpio_axi_lite_wdata : std_logic_vector(axi_data_width-1 downto 0);                     
    signal gpio_axi_lite_wstrb : std_logic_vector(axi_data_width/8-1 downto 0);                   
    signal gpio_axi_lite_bvalid : std_logic;                                                     
    signal gpio_axi_lite_bready : std_logic;                                                      
    signal gpio_axi_lite_bresp : std_logic_vector(1 downto 0);                     
    signal gpio_axi_lite_araddr : std_logic_vector(axi_address_width-1 downto 0);                 
    signal gpio_axi_lite_arprot : std_logic_vector(2 downto 0);                                   
    signal gpio_axi_lite_arvalid : std_logic;                                                     
    signal gpio_axi_lite_arready : std_logic;                                                    
    signal gpio_axi_lite_rdata : std_logic_vector(axi_data_width-1 downto 0);   
    signal gpio_axi_lite_rvalid : std_logic;                                                     
    signal gpio_axi_lite_rready : std_logic;                                                      
    signal gpio_axi_lite_rresp : std_logic_vector(1 downto 0); 
    
    signal uart_axi_lite_awaddr : std_logic_vector(axi_address_width-1 downto 0);                 
    signal uart_axi_lite_awprot : std_logic_vector(2 downto 0);                                   
    signal uart_axi_lite_awvalid : std_logic;                                                     
    signal uart_axi_lite_awready : std_logic;                                                    
    signal uart_axi_lite_wvalid : std_logic;                                                      
    signal uart_axi_lite_wready : std_logic;                                                     
    signal uart_axi_lite_wdata : std_logic_vector(axi_data_width-1 downto 0);                     
    signal uart_axi_lite_wstrb : std_logic_vector(axi_data_width/8-1 downto 0);                   
    signal uart_axi_lite_bvalid : std_logic;                                                     
    signal uart_axi_lite_bready : std_logic;                                                      
    signal uart_axi_lite_bresp : std_logic_vector(1 downto 0);                     
    signal uart_axi_lite_araddr : std_logic_vector(axi_address_width-1 downto 0);                 
    signal uart_axi_lite_arprot : std_logic_vector(2 downto 0);                                   
    signal uart_axi_lite_arvalid : std_logic;                                                     
    signal uart_axi_lite_arready : std_logic;                                                    
    signal uart_axi_lite_rdata : std_logic_vector(axi_data_width-1 downto 0);   
    signal uart_axi_lite_rvalid : std_logic;                                                     
    signal uart_axi_lite_rready : std_logic;                                                      
    signal uart_axi_lite_rresp : std_logic_vector(1 downto 0); 
    
    signal lock_axi_lite_awaddr : std_logic_vector(axi_address_width-1 downto 0);                 
    signal lock_axi_lite_awprot : std_logic_vector(2 downto 0);                                   
    signal lock_axi_lite_awvalid : std_logic;                                                     
    signal lock_axi_lite_awready : std_logic;                                                    
    signal lock_axi_lite_wvalid : std_logic;                                                      
    signal lock_axi_lite_wready : std_logic;                                                     
    signal lock_axi_lite_wdata : std_logic_vector(axi_data_width-1 downto 0);                     
    signal lock_axi_lite_wstrb : std_logic_vector(axi_data_width/8-1 downto 0);                   
    signal lock_axi_lite_bvalid : std_logic;                                                     
    signal lock_axi_lite_bready : std_logic;                                                      
    signal lock_axi_lite_bresp : std_logic_vector(1 downto 0);                     
    signal lock_axi_lite_araddr : std_logic_vector(axi_address_width-1 downto 0);                 
    signal lock_axi_lite_arprot : std_logic_vector(2 downto 0);                                   
    signal lock_axi_lite_arvalid : std_logic;                                                     
    signal lock_axi_lite_arready : std_logic;                                                    
    signal lock_axi_lite_rdata : std_logic_vector(axi_data_width-1 downto 0);   
    signal lock_axi_lite_rvalid : std_logic;                                                     
    signal lock_axi_lite_rready : std_logic;                                                      
    signal lock_axi_lite_rresp : std_logic_vector(1 downto 0); 

    ------------------------
    -- Peripheral Signals --
    ------------------------
    
    signal cpu_int : std_logic;
    signal dev_ints : std_logic_vector(axi_data_width-1 downto 0) := (others=>'0');
    
    signal cpu_0_int : std_logic;
    signal dev_0_ints : std_logic_vector(axi_data_width-1 downto 0) := (others=>'0');
    signal cpu_1_int : std_logic;
    signal dev_1_ints : std_logic_vector(axi_data_width-1 downto 0) := (others=>'0');
    signal cpu_2_int : std_logic;
    signal dev_2_ints : std_logic_vector(axi_data_width-1 downto 0) := (others=>'0');
    
    signal sig_0_1 : std_logic;
    signal sig_1_2 : std_logic;
begin

    ram_axi_full_arlock_slv(0) <= ram_axi_full_arlock;
    ram_axi_full_awlock_slv(0) <= ram_axi_full_awlock;
    
    ram_axi_full_awid_ext(axi_master_id_width-1 downto 0) <= ram_axi_full_awid;
    ram_axi_full_bid_ext(axi_master_id_width-1 downto 0) <= ram_axi_full_bid;
    ram_axi_full_arid_ext(axi_master_id_width-1 downto 0) <= ram_axi_full_arid;
    ram_axi_full_rid_ext(axi_master_id_width-1 downto 0) <= ram_axi_full_rid;
    
    -----------------
    -- ID samplers --
    -----------------
    
    process (aclk)
    begin
        if rising_edge (aclk) then
            if boot_bram_axi_full_awvalid='1' and boot_bram_axi_full_awready='1' then
                boot_bram_axi_full_bid <= boot_bram_axi_full_awid;
            end if;
            if boot_bram_axi_full_arvalid='1' and boot_bram_axi_full_arready='1' then
                boot_bram_axi_full_rid <= boot_bram_axi_full_arid;
            end if; 
            if upper_ext=false then
                if ram_axi_full_awvalid='1'and ram_axi_full_awready='1' then
                    ram_axi_full_bid <= ram_axi_full_awid;
                end if;
                if ram_axi_full_arvalid='1' and ram_axi_full_arready='1' then
                    ram_axi_full_rid <= ram_axi_full_arid;
                end if;
            end if;
        end if;
    end process;
    
    ------------------------------
    -- Boot Bram Instantiations --
    ------------------------------ 
    
    boot_bram_axi_bram_ctrl_0_inst : axi_bram_ctrl_0 
        port map (
            s_axi_aclk => aclk,
            s_axi_aresetn => peripheral_aresetn(0),
            s_axi_awaddr => boot_bram_axi_full_awaddr(bram_address_width-1 downto 0),
            s_axi_awlen => boot_bram_axi_full_awlen,
            s_axi_awsize => boot_bram_axi_full_awsize,
            s_axi_awburst => boot_bram_axi_full_awburst,
            s_axi_awlock => boot_bram_axi_full_awlock,
            s_axi_awcache => boot_bram_axi_full_awcache,
            s_axi_awprot => boot_bram_axi_full_awprot,
            s_axi_awvalid => boot_bram_axi_full_awvalid,
            s_axi_awready => boot_bram_axi_full_awready,
            s_axi_wdata => boot_bram_axi_full_wdata,
            s_axi_wstrb => boot_bram_axi_full_wstrb,
            s_axi_wlast => boot_bram_axi_full_wlast,
            s_axi_wvalid => boot_bram_axi_full_wvalid,
            s_axi_wready => boot_bram_axi_full_wready,
            s_axi_bresp => boot_bram_axi_full_bresp,
            s_axi_bvalid => boot_bram_axi_full_bvalid,
            s_axi_bready => boot_bram_axi_full_bready,
            s_axi_araddr => boot_bram_axi_full_araddr(bram_address_width-1 downto 0),
            s_axi_arlen => boot_bram_axi_full_arlen,
            s_axi_arsize => boot_bram_axi_full_arsize,
            s_axi_arburst => boot_bram_axi_full_arburst,
            s_axi_arlock => boot_bram_axi_full_arlock,
            s_axi_arcache => boot_bram_axi_full_arcache,
            s_axi_arprot => boot_bram_axi_full_arprot,
            s_axi_arvalid => boot_bram_axi_full_arvalid,
            s_axi_arready => boot_bram_axi_full_arready,
            s_axi_rdata => boot_bram_axi_full_rdata,
            s_axi_rresp => boot_bram_axi_full_rresp,
            s_axi_rlast => boot_bram_axi_full_rlast,
            s_axi_rvalid => boot_bram_axi_full_rvalid,
            s_axi_rready => boot_bram_axi_full_rready,
            bram_rst_a => boot_bram_rst_a,
            bram_clk_a => boot_bram_clk_a,
            bram_en_a => boot_bram_en_a,
            bram_we_a => boot_bram_we_a,
            bram_addr_a => boot_bram_addr_a,
            bram_wrdata_a => boot_bram_wrdata_a,
            bram_rddata_a => boot_bram_rddata_a);
    boot_bram_inst : bram 
        generic map (
            select_app => lower_app,
            address_width => bram_address_width,
            data_width => bram_data_width,
            bram_depth => bram_bram_depth)
        port map (
            bram_rst_a => boot_bram_rst_a,
            bram_clk_a => boot_bram_clk_a,
            bram_en_a => boot_bram_en_a,
            bram_we_a => boot_bram_we_a,
            bram_addr_a => boot_bram_addr_a,
            bram_wrdata_a => boot_bram_wrdata_a,
            bram_rddata_a => boot_bram_rddata_a);

    -------------------------------------
    -- Main Memory and Synchronization --
    -------------------------------------
    
    gen_ext_mm :
    if upper_ext=true generate
        bd_wrapper_inst : bd_wrapper 
            port map (
                DDR2_addr => DDR2_addr,
                DDR2_ba => DDR2_ba,
                DDR2_cas_n => DDR2_cas_n,
                DDR2_ck_n => DDR2_ck_n,
                DDR2_ck_p => DDR2_ck_p,
                DDR2_cke => DDR2_cke,
                DDR2_cs_n => DDR2_cs_n,
                DDR2_dm => DDR2_dm,
                DDR2_dq => DDR2_dq,
                DDR2_dqs_n => DDR2_dqs_n,
                DDR2_dqs_p => DDR2_dqs_p,
                DDR2_odt => DDR2_odt,
                DDR2_ras_n => DDR2_ras_n,
                DDR2_we_n => DDR2_we_n,
                S00_AXI_araddr => ram_axi_full_araddr,
                S00_AXI_arburst => ram_axi_full_arburst,
                S00_AXI_arcache => ram_axi_full_arcache,
                S00_AXI_arid => ram_axi_full_arid_ext,
                S00_AXI_arlen => ram_axi_full_arlen,
                S00_AXI_arlock => ram_axi_full_arlock_slv,
                S00_AXI_arprot => ram_axi_full_arprot,
                S00_AXI_arqos => ram_axi_full_arqos,
                S00_AXI_arready => ram_axi_full_arready,
                S00_AXI_arregion => ram_axi_full_arregion,
                S00_AXI_arsize => ram_axi_full_arsize,
                S00_AXI_arvalid => ram_axi_full_arvalid,
                S00_AXI_awaddr => ram_axi_full_awaddr,
                S00_AXI_awburst => ram_axi_full_awburst,
                S00_AXI_awcache => ram_axi_full_awcache,
                S00_AXI_awid => ram_axi_full_awid_ext,
                S00_AXI_awlen => ram_axi_full_awlen,
                S00_AXI_awlock => ram_axi_full_awlock_slv,
                S00_AXI_awprot => ram_axi_full_awprot,
                S00_AXI_awqos => ram_axi_full_awqos,
                S00_AXI_awready => ram_axi_full_awready,
                S00_AXI_awregion => ram_axi_full_awregion,
                S00_AXI_awsize => ram_axi_full_awsize,
                S00_AXI_awvalid => ram_axi_full_awvalid,
                S00_AXI_bid => ram_axi_full_bid_ext,
                S00_AXI_bready => ram_axi_full_bready,
                S00_AXI_bresp => ram_axi_full_bresp,
                S00_AXI_bvalid => ram_axi_full_bvalid,
                S00_AXI_rdata => ram_axi_full_rdata,
                S00_AXI_rid => ram_axi_full_rid_ext,
                S00_AXI_rlast => ram_axi_full_rlast,
                S00_AXI_rready => ram_axi_full_rready,
                S00_AXI_rresp => ram_axi_full_rresp,
                S00_AXI_rvalid => ram_axi_full_rvalid,
                S00_AXI_wdata => ram_axi_full_wdata,
                S00_AXI_wlast => ram_axi_full_wlast,
                S00_AXI_wready => ram_axi_full_wready,
                S00_AXI_wstrb => ram_axi_full_wstrb,
                S00_AXI_wvalid => ram_axi_full_wvalid,
                aclk => aclk,
                interconnect_aresetn => interconnect_aresetn,
                peripheral_aresetn => peripheral_aresetn,
                sys_clk_i => sys_clk_i,
                sys_rst => sys_rst);
    end generate;

    gen_int_mm :
    if upper_ext=false generate
        bd_axi_bram_ctrl_0_inst : axi_bram_ctrl_0
            port map (
                s_axi_aclk => aclk,
                s_axi_aresetn => peripheral_aresetn(0),
                s_axi_awaddr => ram_axi_full_awaddr(bram_address_width-1 downto 0),
                s_axi_awlen => ram_axi_full_awlen,
                s_axi_awsize => ram_axi_full_awsize,
                s_axi_awburst => ram_axi_full_awburst,
                s_axi_awlock => ram_axi_full_awlock,
                s_axi_awcache => ram_axi_full_awcache,
                s_axi_awprot => ram_axi_full_awprot,
                s_axi_awvalid => ram_axi_full_awvalid,
                s_axi_awready => ram_axi_full_awready,
                s_axi_wdata => ram_axi_full_wdata,
                s_axi_wstrb => ram_axi_full_wstrb,
                s_axi_wlast => ram_axi_full_wlast,
                s_axi_wvalid => ram_axi_full_wvalid,
                s_axi_wready => ram_axi_full_wready,
                s_axi_bresp => ram_axi_full_bresp,
                s_axi_bvalid => ram_axi_full_bvalid,
                s_axi_bready => ram_axi_full_bready,
                s_axi_araddr => ram_axi_full_araddr(bram_address_width-1 downto 0),
                s_axi_arlen => ram_axi_full_arlen,
                s_axi_arsize => ram_axi_full_arsize,
                s_axi_arburst => ram_axi_full_arburst,
                s_axi_arlock => ram_axi_full_arlock,
                s_axi_arcache => ram_axi_full_arcache,
                s_axi_arprot => ram_axi_full_arprot,
                s_axi_arvalid => ram_axi_full_arvalid,
                s_axi_arready => ram_axi_full_arready,
                s_axi_rdata => ram_axi_full_rdata,
                s_axi_rresp => ram_axi_full_rresp,
                s_axi_rlast => ram_axi_full_rlast,
                s_axi_rvalid => ram_axi_full_rvalid,
                s_axi_rready => ram_axi_full_rready,
                bram_rst_a => ram_bram_rst_a,
                bram_clk_a => ram_bram_clk_a,
                bram_en_a => ram_bram_en_a,
                bram_we_a => ram_bram_we_a,
                bram_addr_a => ram_bram_addr_a,
                bram_wrdata_a => ram_bram_wrdata_a,
                bram_rddata_a => ram_bram_rddata_a);
        bd_bram_inst : bram 
            generic map (
                select_app => upper_app,
                address_width => bram_address_width,
                data_width => bram_data_width,
                bram_depth => bram_bram_depth)
            port map (
                bram_rst_a => ram_bram_rst_a,
                bram_clk_a => ram_bram_clk_a,
                bram_en_a => ram_bram_en_a,
                bram_we_a => ram_bram_we_a,
                bram_addr_a => ram_bram_addr_a,
                bram_wrdata_a => ram_bram_wrdata_a,
                bram_rddata_a => ram_bram_rddata_a);
        bd_clk_wiz_inst : clk_wiz_0 
            port map (
                aclk => aclk,
                resetn => sys_rst,
                locked => dcm_locked,
                sys_clk_i => sys_clk_i);
        bd_proc_sys_reset_inst : proc_sys_reset_0 
            port map (
                slowest_sync_clk => aclk,
                ext_reset_in => sys_clk_i,
                aux_reset_in => '0',
                mb_debug_sys_rst => '0',
                dcm_locked => dcm_locked,
                mb_reset => open,
                bus_struct_reset => open,
                peripheral_reset => open,
                interconnect_aresetn => interconnect_aresetn,
                peripheral_aresetn => peripheral_aresetn);
    end generate;
    
    -----------------------
    -- Main Interconnect --
    -----------------------
    
    plasoc_interconnect_crossbar_wrap_inst : plasoc_interconnect_crossbar_wrap
        port map (
            cpu_0_s_axi_awid => cpu_0_axi_full_awid,
            cpu_0_s_axi_awaddr => cpu_0_axi_full_awaddr,
            cpu_0_s_axi_awlen => cpu_0_axi_full_awlen,
            cpu_0_s_axi_awsize => cpu_0_axi_full_awsize,
            cpu_0_s_axi_awburst => cpu_0_axi_full_awburst,
            cpu_0_s_axi_awlock => cpu_0_axi_full_awlock,
            cpu_0_s_axi_awcache => cpu_0_axi_full_awcache,
            cpu_0_s_axi_awprot => cpu_0_axi_full_awprot,
            cpu_0_s_axi_awqos => cpu_0_axi_full_awqos,
            cpu_0_s_axi_awregion => cpu_0_axi_full_awregion,
            cpu_0_s_axi_awvalid => cpu_0_axi_full_awvalid,
            cpu_0_s_axi_awready => cpu_0_axi_full_awready,
            cpu_0_s_axi_wdata => cpu_0_axi_full_wdata,
            cpu_0_s_axi_wstrb => cpu_0_axi_full_wstrb,
            cpu_0_s_axi_wlast => cpu_0_axi_full_wlast,
            cpu_0_s_axi_wvalid => cpu_0_axi_full_wvalid,
            cpu_0_s_axi_wready => cpu_0_axi_full_wready,
            cpu_0_s_axi_bid => cpu_0_axi_full_bid,
            cpu_0_s_axi_bresp => cpu_0_axi_full_bresp,
            cpu_0_s_axi_bvalid => cpu_0_axi_full_bvalid,
            cpu_0_s_axi_bready => cpu_0_axi_full_bready,
            cpu_0_s_axi_arid => cpu_0_axi_full_arid,
            cpu_0_s_axi_araddr => cpu_0_axi_full_araddr,
            cpu_0_s_axi_arlen => cpu_0_axi_full_arlen,
            cpu_0_s_axi_arsize => cpu_0_axi_full_arsize,
            cpu_0_s_axi_arburst => cpu_0_axi_full_arburst,
            cpu_0_s_axi_arlock => cpu_0_axi_full_arlock,
            cpu_0_s_axi_arcache => cpu_0_axi_full_arcache,
            cpu_0_s_axi_arprot => cpu_0_axi_full_arprot,
            cpu_0_s_axi_arqos => cpu_0_axi_full_arqos,
            cpu_0_s_axi_arregion => cpu_0_axi_full_arregion,
            cpu_0_s_axi_arvalid => cpu_0_axi_full_arvalid,
            cpu_0_s_axi_arready => cpu_0_axi_full_arready,
            cpu_0_s_axi_rid => cpu_0_axi_full_rid,
            cpu_0_s_axi_rdata => cpu_0_axi_full_rdata,
            cpu_0_s_axi_rresp => cpu_0_axi_full_rresp,
            cpu_0_s_axi_rlast => cpu_0_axi_full_rlast,
            cpu_0_s_axi_rvalid => cpu_0_axi_full_rvalid,
            cpu_0_s_axi_rready => cpu_0_axi_full_rready,
            cpu_1_s_axi_awid => cpu_1_axi_full_awid,
            cpu_1_s_axi_awaddr => cpu_1_axi_full_awaddr,
            cpu_1_s_axi_awlen => cpu_1_axi_full_awlen,
            cpu_1_s_axi_awsize => cpu_1_axi_full_awsize,
            cpu_1_s_axi_awburst => cpu_1_axi_full_awburst,
            cpu_1_s_axi_awlock => cpu_1_axi_full_awlock,
            cpu_1_s_axi_awcache => cpu_1_axi_full_awcache,
            cpu_1_s_axi_awprot => cpu_1_axi_full_awprot,
            cpu_1_s_axi_awqos => cpu_1_axi_full_awqos,
            cpu_1_s_axi_awregion => cpu_1_axi_full_awregion,
            cpu_1_s_axi_awvalid => cpu_1_axi_full_awvalid,
            cpu_1_s_axi_awready => cpu_1_axi_full_awready,
            cpu_1_s_axi_wdata => cpu_1_axi_full_wdata,
            cpu_1_s_axi_wstrb => cpu_1_axi_full_wstrb,
            cpu_1_s_axi_wlast => cpu_1_axi_full_wlast,
            cpu_1_s_axi_wvalid => cpu_1_axi_full_wvalid,
            cpu_1_s_axi_wready => cpu_1_axi_full_wready,
            cpu_1_s_axi_bid => cpu_1_axi_full_bid,
            cpu_1_s_axi_bresp => cpu_1_axi_full_bresp,
            cpu_1_s_axi_bvalid => cpu_1_axi_full_bvalid,
            cpu_1_s_axi_bready => cpu_1_axi_full_bready,
            cpu_1_s_axi_arid => cpu_1_axi_full_arid,
            cpu_1_s_axi_araddr => cpu_1_axi_full_araddr,
            cpu_1_s_axi_arlen => cpu_1_axi_full_arlen,
            cpu_1_s_axi_arsize => cpu_1_axi_full_arsize,
            cpu_1_s_axi_arburst => cpu_1_axi_full_arburst,
            cpu_1_s_axi_arlock => cpu_1_axi_full_arlock,
            cpu_1_s_axi_arcache => cpu_1_axi_full_arcache,
            cpu_1_s_axi_arprot => cpu_1_axi_full_arprot,
            cpu_1_s_axi_arqos => cpu_1_axi_full_arqos,
            cpu_1_s_axi_arregion => cpu_1_axi_full_arregion,
            cpu_1_s_axi_arvalid => cpu_1_axi_full_arvalid,
            cpu_1_s_axi_arready => cpu_1_axi_full_arready,
            cpu_1_s_axi_rid => cpu_1_axi_full_rid,
            cpu_1_s_axi_rdata => cpu_1_axi_full_rdata,
            cpu_1_s_axi_rresp => cpu_1_axi_full_rresp,
            cpu_1_s_axi_rlast => cpu_1_axi_full_rlast,
            cpu_1_s_axi_rvalid => cpu_1_axi_full_rvalid,
            cpu_1_s_axi_rready => cpu_1_axi_full_rready,
            cpu_2_s_axi_awid => cpu_2_axi_full_awid,
            cpu_2_s_axi_awaddr => cpu_2_axi_full_awaddr,
            cpu_2_s_axi_awlen => cpu_2_axi_full_awlen,
            cpu_2_s_axi_awsize => cpu_2_axi_full_awsize,
            cpu_2_s_axi_awburst => cpu_2_axi_full_awburst,
            cpu_2_s_axi_awlock => cpu_2_axi_full_awlock,
            cpu_2_s_axi_awcache => cpu_2_axi_full_awcache,
            cpu_2_s_axi_awprot => cpu_2_axi_full_awprot,
            cpu_2_s_axi_awqos => cpu_2_axi_full_awqos,
            cpu_2_s_axi_awregion => cpu_2_axi_full_awregion,
            cpu_2_s_axi_awvalid => cpu_2_axi_full_awvalid,
            cpu_2_s_axi_awready => cpu_2_axi_full_awready,
            cpu_2_s_axi_wdata => cpu_2_axi_full_wdata,
            cpu_2_s_axi_wstrb => cpu_2_axi_full_wstrb,
            cpu_2_s_axi_wlast => cpu_2_axi_full_wlast,
            cpu_2_s_axi_wvalid => cpu_2_axi_full_wvalid,
            cpu_2_s_axi_wready => cpu_2_axi_full_wready,
            cpu_2_s_axi_bid => cpu_2_axi_full_bid,
            cpu_2_s_axi_bresp => cpu_2_axi_full_bresp,
            cpu_2_s_axi_bvalid => cpu_2_axi_full_bvalid,
            cpu_2_s_axi_bready => cpu_2_axi_full_bready,
            cpu_2_s_axi_arid => cpu_2_axi_full_arid,
            cpu_2_s_axi_araddr => cpu_2_axi_full_araddr,
            cpu_2_s_axi_arlen => cpu_2_axi_full_arlen,
            cpu_2_s_axi_arsize => cpu_2_axi_full_arsize,
            cpu_2_s_axi_arburst => cpu_2_axi_full_arburst,
            cpu_2_s_axi_arlock => cpu_2_axi_full_arlock,
            cpu_2_s_axi_arcache => cpu_2_axi_full_arcache,
            cpu_2_s_axi_arprot => cpu_2_axi_full_arprot,
            cpu_2_s_axi_arqos => cpu_2_axi_full_arqos,
            cpu_2_s_axi_arregion => cpu_2_axi_full_arregion,
            cpu_2_s_axi_arvalid => cpu_2_axi_full_arvalid,
            cpu_2_s_axi_arready => cpu_2_axi_full_arready,
            cpu_2_s_axi_rid => cpu_2_axi_full_rid,
            cpu_2_s_axi_rdata => cpu_2_axi_full_rdata,
            cpu_2_s_axi_rresp => cpu_2_axi_full_rresp,
            cpu_2_s_axi_rlast => cpu_2_axi_full_rlast,
            cpu_2_s_axi_rvalid => cpu_2_axi_full_rvalid,
            cpu_2_s_axi_rready => cpu_2_axi_full_rready,
            boot_bram_m_axi_awid => boot_bram_axi_full_awid,
            boot_bram_m_axi_awaddr => boot_bram_axi_full_awaddr,
            boot_bram_m_axi_awlen => boot_bram_axi_full_awlen,
            boot_bram_m_axi_awsize => boot_bram_axi_full_awsize,
            boot_bram_m_axi_awburst => boot_bram_axi_full_awburst,
            boot_bram_m_axi_awlock => boot_bram_axi_full_awlock,
            boot_bram_m_axi_awcache => boot_bram_axi_full_awcache,
            boot_bram_m_axi_awprot => boot_bram_axi_full_awprot,
            boot_bram_m_axi_awqos => boot_bram_axi_full_awqos,
            boot_bram_m_axi_awregion => boot_bram_axi_full_awregion,
            boot_bram_m_axi_awvalid => boot_bram_axi_full_awvalid,
            boot_bram_m_axi_awready => boot_bram_axi_full_awready,
            boot_bram_m_axi_wdata => boot_bram_axi_full_wdata,
            boot_bram_m_axi_wstrb => boot_bram_axi_full_wstrb,
            boot_bram_m_axi_wlast => boot_bram_axi_full_wlast,
            boot_bram_m_axi_wvalid => boot_bram_axi_full_wvalid,
            boot_bram_m_axi_wready => boot_bram_axi_full_wready,
            boot_bram_m_axi_bid => boot_bram_axi_full_bid,
            boot_bram_m_axi_bresp => boot_bram_axi_full_bresp,
            boot_bram_m_axi_bvalid => boot_bram_axi_full_bvalid,
            boot_bram_m_axi_bready => boot_bram_axi_full_bready,
            boot_bram_m_axi_arid => boot_bram_axi_full_arid,
            boot_bram_m_axi_araddr => boot_bram_axi_full_araddr,
            boot_bram_m_axi_arlen => boot_bram_axi_full_arlen,
            boot_bram_m_axi_arsize => boot_bram_axi_full_arsize,
            boot_bram_m_axi_arburst => boot_bram_axi_full_arburst,
            boot_bram_m_axi_arlock => boot_bram_axi_full_arlock,
            boot_bram_m_axi_arcache => boot_bram_axi_full_arcache,
            boot_bram_m_axi_arprot => boot_bram_axi_full_arprot,
            boot_bram_m_axi_arqos => boot_bram_axi_full_arqos,
            boot_bram_m_axi_arregion => boot_bram_axi_full_arregion,
            boot_bram_m_axi_arvalid => boot_bram_axi_full_arvalid,
            boot_bram_m_axi_arready => boot_bram_axi_full_arready,
            boot_bram_m_axi_rid => boot_bram_axi_full_rid,
            boot_bram_m_axi_rdata => boot_bram_axi_full_rdata,
            boot_bram_m_axi_rresp => boot_bram_axi_full_rresp,
            boot_bram_m_axi_rlast => boot_bram_axi_full_rlast,
            boot_bram_m_axi_rvalid => boot_bram_axi_full_rvalid,
            boot_bram_m_axi_rready => boot_bram_axi_full_rready,
            ram_m_axi_awid => ram_axi_full_awid,
            ram_m_axi_awaddr => ram_axi_full_awaddr,
            ram_m_axi_awlen => ram_axi_full_awlen,
            ram_m_axi_awsize => ram_axi_full_awsize,
            ram_m_axi_awburst => ram_axi_full_awburst,
            ram_m_axi_awlock => ram_axi_full_awlock,
            ram_m_axi_awcache => ram_axi_full_awcache,
            ram_m_axi_awprot => ram_axi_full_awprot,
            ram_m_axi_awqos => ram_axi_full_awqos,
            ram_m_axi_awregion => ram_axi_full_awregion,
            ram_m_axi_awvalid => ram_axi_full_awvalid,
            ram_m_axi_awready => ram_axi_full_awready,
            ram_m_axi_wdata => ram_axi_full_wdata,
            ram_m_axi_wstrb => ram_axi_full_wstrb,
            ram_m_axi_wlast => ram_axi_full_wlast,
            ram_m_axi_wvalid => ram_axi_full_wvalid,
            ram_m_axi_wready => ram_axi_full_wready,
            ram_m_axi_bid => ram_axi_full_bid,
            ram_m_axi_bresp => ram_axi_full_bresp,
            ram_m_axi_bvalid => ram_axi_full_bvalid,
            ram_m_axi_bready => ram_axi_full_bready,
            ram_m_axi_arid => ram_axi_full_arid,
            ram_m_axi_araddr => ram_axi_full_araddr,
            ram_m_axi_arlen => ram_axi_full_arlen,
            ram_m_axi_arsize => ram_axi_full_arsize,
            ram_m_axi_arburst => ram_axi_full_arburst,
            ram_m_axi_arlock => ram_axi_full_arlock,
            ram_m_axi_arcache => ram_axi_full_arcache,
            ram_m_axi_arprot => ram_axi_full_arprot,
            ram_m_axi_arqos => ram_axi_full_arqos,
            ram_m_axi_arregion => ram_axi_full_arregion,
            ram_m_axi_arvalid => ram_axi_full_arvalid,
            ram_m_axi_arready => ram_axi_full_arready,
            ram_m_axi_rid => ram_axi_full_rid,
            ram_m_axi_rdata => ram_axi_full_rdata,
            ram_m_axi_rresp => ram_axi_full_rresp,
            ram_m_axi_rlast => ram_axi_full_rlast,
            ram_m_axi_rvalid => ram_axi_full_rvalid,
            ram_m_axi_rready => ram_axi_full_rready,
            int_m_axi_awid => int_axi_full_awid,
            int_m_axi_awaddr => int_axi_full_awaddr,
            int_m_axi_awlen => int_axi_full_awlen,
            int_m_axi_awsize => int_axi_full_awsize,
            int_m_axi_awburst => int_axi_full_awburst,
            int_m_axi_awlock => int_axi_full_awlock,
            int_m_axi_awcache => int_axi_full_awcache,
            int_m_axi_awprot => int_axi_full_awprot,
            int_m_axi_awqos => int_axi_full_awqos,
            int_m_axi_awregion => int_axi_full_awregion,
            int_m_axi_awvalid => int_axi_full_awvalid,
            int_m_axi_awready => int_axi_full_awready,
            int_m_axi_wdata => int_axi_full_wdata,
            int_m_axi_wstrb => int_axi_full_wstrb,
            int_m_axi_wlast => int_axi_full_wlast,
            int_m_axi_wvalid => int_axi_full_wvalid,
            int_m_axi_wready => int_axi_full_wready,
            int_m_axi_bid => int_axi_full_bid,
            int_m_axi_bresp => int_axi_full_bresp,
            int_m_axi_bvalid => int_axi_full_bvalid,
            int_m_axi_bready => int_axi_full_bready,
            int_m_axi_arid => int_axi_full_arid,
            int_m_axi_araddr => int_axi_full_araddr,
            int_m_axi_arlen => int_axi_full_arlen,
            int_m_axi_arsize => int_axi_full_arsize,
            int_m_axi_arburst => int_axi_full_arburst,
            int_m_axi_arlock => int_axi_full_arlock,
            int_m_axi_arcache => int_axi_full_arcache,
            int_m_axi_arprot => int_axi_full_arprot,
            int_m_axi_arqos => int_axi_full_arqos,
            int_m_axi_arregion => int_axi_full_arregion,
            int_m_axi_arvalid => int_axi_full_arvalid,
            int_m_axi_arready => int_axi_full_arready,
            int_m_axi_rid => int_axi_full_rid,
            int_m_axi_rdata => int_axi_full_rdata,
            int_m_axi_rresp => int_axi_full_rresp,
            int_m_axi_rlast => int_axi_full_rlast,
            int_m_axi_rvalid => int_axi_full_rvalid,
            int_m_axi_rready => int_axi_full_rready,
            timer_m_axi_awid => timer_axi_full_awid,
            timer_m_axi_awaddr => timer_axi_full_awaddr,
            timer_m_axi_awlen => timer_axi_full_awlen,
            timer_m_axi_awsize => timer_axi_full_awsize,
            timer_m_axi_awburst => timer_axi_full_awburst,
            timer_m_axi_awlock => timer_axi_full_awlock,
            timer_m_axi_awcache => timer_axi_full_awcache,
            timer_m_axi_awprot => timer_axi_full_awprot,
            timer_m_axi_awqos => timer_axi_full_awqos,
            timer_m_axi_awregion => timer_axi_full_awregion,
            timer_m_axi_awvalid => timer_axi_full_awvalid,
            timer_m_axi_awready => timer_axi_full_awready,
            timer_m_axi_wdata => timer_axi_full_wdata,
            timer_m_axi_wstrb => timer_axi_full_wstrb,
            timer_m_axi_wlast => timer_axi_full_wlast,
            timer_m_axi_wvalid => timer_axi_full_wvalid,
            timer_m_axi_wready => timer_axi_full_wready,
            timer_m_axi_bid => timer_axi_full_bid,
            timer_m_axi_bresp => timer_axi_full_bresp,
            timer_m_axi_bvalid => timer_axi_full_bvalid,
            timer_m_axi_bready => timer_axi_full_bready,
            timer_m_axi_arid => timer_axi_full_arid,
            timer_m_axi_araddr => timer_axi_full_araddr,
            timer_m_axi_arlen => timer_axi_full_arlen,
            timer_m_axi_arsize => timer_axi_full_arsize,
            timer_m_axi_arburst => timer_axi_full_arburst,
            timer_m_axi_arlock => timer_axi_full_arlock,
            timer_m_axi_arcache => timer_axi_full_arcache,
            timer_m_axi_arprot => timer_axi_full_arprot,
            timer_m_axi_arqos => timer_axi_full_arqos,
            timer_m_axi_arregion => timer_axi_full_arregion,
            timer_m_axi_arvalid => timer_axi_full_arvalid,
            timer_m_axi_arready => timer_axi_full_arready,
            timer_m_axi_rid => timer_axi_full_rid,
            timer_m_axi_rdata => timer_axi_full_rdata,
            timer_m_axi_rresp => timer_axi_full_rresp,
            timer_m_axi_rlast => timer_axi_full_rlast,
            timer_m_axi_rvalid => timer_axi_full_rvalid,
            timer_m_axi_rready => timer_axi_full_rready,
            gpio_m_axi_awid => gpio_axi_full_awid,
            gpio_m_axi_awaddr => gpio_axi_full_awaddr,
            gpio_m_axi_awlen => gpio_axi_full_awlen,
            gpio_m_axi_awsize => gpio_axi_full_awsize,
            gpio_m_axi_awburst => gpio_axi_full_awburst,
            gpio_m_axi_awlock => gpio_axi_full_awlock,
            gpio_m_axi_awcache => gpio_axi_full_awcache,
            gpio_m_axi_awprot => gpio_axi_full_awprot,
            gpio_m_axi_awqos => gpio_axi_full_awqos,
            gpio_m_axi_awregion => gpio_axi_full_awregion,
            gpio_m_axi_awvalid => gpio_axi_full_awvalid,
            gpio_m_axi_awready => gpio_axi_full_awready,
            gpio_m_axi_wdata => gpio_axi_full_wdata,
            gpio_m_axi_wstrb => gpio_axi_full_wstrb,
            gpio_m_axi_wlast => gpio_axi_full_wlast,
            gpio_m_axi_wvalid => gpio_axi_full_wvalid,
            gpio_m_axi_wready => gpio_axi_full_wready,
            gpio_m_axi_bid => gpio_axi_full_bid,
            gpio_m_axi_bresp => gpio_axi_full_bresp,
            gpio_m_axi_bvalid => gpio_axi_full_bvalid,
            gpio_m_axi_bready => gpio_axi_full_bready,
            gpio_m_axi_arid => gpio_axi_full_arid,
            gpio_m_axi_araddr => gpio_axi_full_araddr,
            gpio_m_axi_arlen => gpio_axi_full_arlen,
            gpio_m_axi_arsize => gpio_axi_full_arsize,
            gpio_m_axi_arburst => gpio_axi_full_arburst,
            gpio_m_axi_arlock => gpio_axi_full_arlock,
            gpio_m_axi_arcache => gpio_axi_full_arcache,
            gpio_m_axi_arprot => gpio_axi_full_arprot,
            gpio_m_axi_arqos => gpio_axi_full_arqos,
            gpio_m_axi_arregion => gpio_axi_full_arregion,
            gpio_m_axi_arvalid => gpio_axi_full_arvalid,
            gpio_m_axi_arready => gpio_axi_full_arready,
            gpio_m_axi_rid => gpio_axi_full_rid,
            gpio_m_axi_rdata => gpio_axi_full_rdata,
            gpio_m_axi_rresp => gpio_axi_full_rresp,
            gpio_m_axi_rlast => gpio_axi_full_rlast,
            gpio_m_axi_rvalid => gpio_axi_full_rvalid,
            gpio_m_axi_rready => gpio_axi_full_rready,
            uart_m_axi_awid => uart_axi_full_awid,
            uart_m_axi_awaddr => uart_axi_full_awaddr,
            uart_m_axi_awlen => uart_axi_full_awlen,
            uart_m_axi_awsize => uart_axi_full_awsize,
            uart_m_axi_awburst => uart_axi_full_awburst,
            uart_m_axi_awlock => uart_axi_full_awlock,
            uart_m_axi_awcache => uart_axi_full_awcache,
            uart_m_axi_awprot => uart_axi_full_awprot,
            uart_m_axi_awqos => uart_axi_full_awqos,
            uart_m_axi_awregion => uart_axi_full_awregion,
            uart_m_axi_awvalid => uart_axi_full_awvalid,
            uart_m_axi_awready => uart_axi_full_awready,
            uart_m_axi_wdata => uart_axi_full_wdata,
            uart_m_axi_wstrb => uart_axi_full_wstrb,
            uart_m_axi_wlast => uart_axi_full_wlast,
            uart_m_axi_wvalid => uart_axi_full_wvalid,
            uart_m_axi_wready => uart_axi_full_wready,
            uart_m_axi_bid => uart_axi_full_bid,
            uart_m_axi_bresp => uart_axi_full_bresp,
            uart_m_axi_bvalid => uart_axi_full_bvalid,
            uart_m_axi_bready => uart_axi_full_bready,
            uart_m_axi_arid => uart_axi_full_arid,
            uart_m_axi_araddr => uart_axi_full_araddr,
            uart_m_axi_arlen => uart_axi_full_arlen,
            uart_m_axi_arsize => uart_axi_full_arsize,
            uart_m_axi_arburst => uart_axi_full_arburst,
            uart_m_axi_arlock => uart_axi_full_arlock,
            uart_m_axi_arcache => uart_axi_full_arcache,
            uart_m_axi_arprot => uart_axi_full_arprot,
            uart_m_axi_arqos => uart_axi_full_arqos,
            uart_m_axi_arregion => uart_axi_full_arregion,
            uart_m_axi_arvalid => uart_axi_full_arvalid,
            uart_m_axi_arready => uart_axi_full_arready,
            uart_m_axi_rid => uart_axi_full_rid,
            uart_m_axi_rdata => uart_axi_full_rdata,
            uart_m_axi_rresp => uart_axi_full_rresp,
            uart_m_axi_rlast => uart_axi_full_rlast,
            uart_m_axi_rvalid => uart_axi_full_rvalid,
            uart_m_axi_rready => uart_axi_full_rready,
            lock_m_axi_awid => lock_axi_full_awid,
            lock_m_axi_awaddr => lock_axi_full_awaddr,
            lock_m_axi_awlen => lock_axi_full_awlen,
            lock_m_axi_awsize => lock_axi_full_awsize,
            lock_m_axi_awburst => lock_axi_full_awburst,
            lock_m_axi_awlock => lock_axi_full_awlock,
            lock_m_axi_awcache => lock_axi_full_awcache,
            lock_m_axi_awprot => lock_axi_full_awprot,
            lock_m_axi_awqos => lock_axi_full_awqos,
            lock_m_axi_awregion => lock_axi_full_awregion,
            lock_m_axi_awvalid => lock_axi_full_awvalid,
            lock_m_axi_awready => lock_axi_full_awready,
            lock_m_axi_wdata => lock_axi_full_wdata,
            lock_m_axi_wstrb => lock_axi_full_wstrb,
            lock_m_axi_wlast => lock_axi_full_wlast,
            lock_m_axi_wvalid => lock_axi_full_wvalid,
            lock_m_axi_wready => lock_axi_full_wready,
            lock_m_axi_bid => lock_axi_full_bid,
            lock_m_axi_bresp => lock_axi_full_bresp,
            lock_m_axi_bvalid => lock_axi_full_bvalid,
            lock_m_axi_bready => lock_axi_full_bready,
            lock_m_axi_arid => lock_axi_full_arid,
            lock_m_axi_araddr => lock_axi_full_araddr,
            lock_m_axi_arlen => lock_axi_full_arlen,
            lock_m_axi_arsize => lock_axi_full_arsize,
            lock_m_axi_arburst => lock_axi_full_arburst,
            lock_m_axi_arlock => lock_axi_full_arlock,
            lock_m_axi_arcache => lock_axi_full_arcache,
            lock_m_axi_arprot => lock_axi_full_arprot,
            lock_m_axi_arqos => lock_axi_full_arqos,
            lock_m_axi_arregion => lock_axi_full_arregion,
            lock_m_axi_arvalid => lock_axi_full_arvalid,
            lock_m_axi_arready => lock_axi_full_arready,
            lock_m_axi_rid => lock_axi_full_rid,
            lock_m_axi_rdata => lock_axi_full_rdata,
            lock_m_axi_rresp => lock_axi_full_rresp,
            lock_m_axi_rlast => lock_axi_full_rlast,
            lock_m_axi_rvalid => lock_axi_full_rvalid,
            lock_m_axi_rready => lock_axi_full_rready,
            aclk => aclk, aresetn => interconnect_aresetn(0));
            
    ---------------
    -- CPU Buses --
    ---------------
            
    cpu_0_bus_inst : plasoc_cpu_0_crossbar_wrap
        port map (
            cpu_s_axi_awid => cpu_bus_0_full_awid,
            cpu_s_axi_awaddr => cpu_bus_0_full_awaddr,
            cpu_s_axi_awlen => cpu_bus_0_full_awlen,
            cpu_s_axi_awsize => cpu_bus_0_full_awsize,
            cpu_s_axi_awburst => cpu_bus_0_full_awburst,
            cpu_s_axi_awlock => cpu_bus_0_full_awlock,
            cpu_s_axi_awcache => cpu_bus_0_full_awcache,
            cpu_s_axi_awprot => cpu_bus_0_full_awprot,
            cpu_s_axi_awqos => cpu_bus_0_full_awqos,
            cpu_s_axi_awregion => cpu_bus_0_full_awregion,
            cpu_s_axi_awvalid => cpu_bus_0_full_awvalid,
            cpu_s_axi_awready => cpu_bus_0_full_awready,
            cpu_s_axi_wdata => cpu_bus_0_full_wdata,
            cpu_s_axi_wstrb => cpu_bus_0_full_wstrb,
            cpu_s_axi_wlast => cpu_bus_0_full_wlast,
            cpu_s_axi_wvalid => cpu_bus_0_full_wvalid,
            cpu_s_axi_wready => cpu_bus_0_full_wready,
            cpu_s_axi_bid => cpu_bus_0_full_bid,
            cpu_s_axi_bresp => cpu_bus_0_full_bresp,
            cpu_s_axi_bvalid => cpu_bus_0_full_bvalid,
            cpu_s_axi_bready => cpu_bus_0_full_bready,
            cpu_s_axi_arid => cpu_bus_0_full_arid,
            cpu_s_axi_araddr => cpu_bus_0_full_araddr,
            cpu_s_axi_arlen => cpu_bus_0_full_arlen,
            cpu_s_axi_arsize => cpu_bus_0_full_arsize,
            cpu_s_axi_arburst => cpu_bus_0_full_arburst,
            cpu_s_axi_arlock => cpu_bus_0_full_arlock,
            cpu_s_axi_arcache => cpu_bus_0_full_arcache,
            cpu_s_axi_arprot => cpu_bus_0_full_arprot,
            cpu_s_axi_arqos => cpu_bus_0_full_arqos,
            cpu_s_axi_arregion => cpu_bus_0_full_arregion,
            cpu_s_axi_arvalid => cpu_bus_0_full_arvalid,
            cpu_s_axi_arready => cpu_bus_0_full_arready,
            cpu_s_axi_rid => cpu_bus_0_full_rid,
            cpu_s_axi_rdata => cpu_bus_0_full_rdata,
            cpu_s_axi_rresp => cpu_bus_0_full_rresp,
            cpu_s_axi_rlast => cpu_bus_0_full_rlast,
            cpu_s_axi_rvalid => cpu_bus_0_full_rvalid,
            cpu_s_axi_rready => cpu_bus_0_full_rready,
            ip_m_axi_awid => cpu_0_axi_full_awid,
            ip_m_axi_awaddr => cpu_0_axi_full_awaddr,
            ip_m_axi_awlen => cpu_0_axi_full_awlen,
            ip_m_axi_awsize => cpu_0_axi_full_awsize,
            ip_m_axi_awburst => cpu_0_axi_full_awburst,
            ip_m_axi_awlock => cpu_0_axi_full_awlock,
            ip_m_axi_awcache => cpu_0_axi_full_awcache,
            ip_m_axi_awprot => cpu_0_axi_full_awprot,
            ip_m_axi_awqos => cpu_0_axi_full_awqos,
            ip_m_axi_awregion => cpu_0_axi_full_awregion,
            ip_m_axi_awvalid => cpu_0_axi_full_awvalid,
            ip_m_axi_awready => cpu_0_axi_full_awready,
            ip_m_axi_wdata => cpu_0_axi_full_wdata,
            ip_m_axi_wstrb => cpu_0_axi_full_wstrb,
            ip_m_axi_wlast => cpu_0_axi_full_wlast,
            ip_m_axi_wvalid => cpu_0_axi_full_wvalid,
            ip_m_axi_wready => cpu_0_axi_full_wready,
            ip_m_axi_bid => cpu_0_axi_full_bid,
            ip_m_axi_bresp => cpu_0_axi_full_bresp,
            ip_m_axi_bvalid => cpu_0_axi_full_bvalid,
            ip_m_axi_bready => cpu_0_axi_full_bready,
            ip_m_axi_arid => cpu_0_axi_full_arid,
            ip_m_axi_araddr => cpu_0_axi_full_araddr,
            ip_m_axi_arlen => cpu_0_axi_full_arlen,
            ip_m_axi_arsize => cpu_0_axi_full_arsize,
            ip_m_axi_arburst => cpu_0_axi_full_arburst,
            ip_m_axi_arlock => cpu_0_axi_full_arlock,
            ip_m_axi_arcache => cpu_0_axi_full_arcache,
            ip_m_axi_arprot => cpu_0_axi_full_arprot,
            ip_m_axi_arqos => cpu_0_axi_full_arqos,
            ip_m_axi_arregion => cpu_0_axi_full_arregion,
            ip_m_axi_arvalid => cpu_0_axi_full_arvalid,
            ip_m_axi_arready => cpu_0_axi_full_arready,
            ip_m_axi_rid => cpu_0_axi_full_rid,
            ip_m_axi_rdata => cpu_0_axi_full_rdata,
            ip_m_axi_rresp => cpu_0_axi_full_rresp,
            ip_m_axi_rlast => cpu_0_axi_full_rlast,
            ip_m_axi_rvalid => cpu_0_axi_full_rvalid,
            ip_m_axi_rready => cpu_0_axi_full_rready,
            cpuid_gpio_m_axi_awid => cpuid_gpio_bus_0_full_awid,
            cpuid_gpio_m_axi_awaddr => cpuid_gpio_bus_0_full_awaddr,
            cpuid_gpio_m_axi_awlen => cpuid_gpio_bus_0_full_awlen,
            cpuid_gpio_m_axi_awsize => cpuid_gpio_bus_0_full_awsize,
            cpuid_gpio_m_axi_awburst => cpuid_gpio_bus_0_full_awburst,
            cpuid_gpio_m_axi_awlock => cpuid_gpio_bus_0_full_awlock,
            cpuid_gpio_m_axi_awcache => cpuid_gpio_bus_0_full_awcache,
            cpuid_gpio_m_axi_awprot => cpuid_gpio_bus_0_full_awprot,
            cpuid_gpio_m_axi_awqos => cpuid_gpio_bus_0_full_awqos,
            cpuid_gpio_m_axi_awregion => cpuid_gpio_bus_0_full_awregion,
            cpuid_gpio_m_axi_awvalid => cpuid_gpio_bus_0_full_awvalid,
            cpuid_gpio_m_axi_awready => cpuid_gpio_bus_0_full_awready,
            cpuid_gpio_m_axi_wdata => cpuid_gpio_bus_0_full_wdata,
            cpuid_gpio_m_axi_wstrb => cpuid_gpio_bus_0_full_wstrb,
            cpuid_gpio_m_axi_wlast => cpuid_gpio_bus_0_full_wlast,
            cpuid_gpio_m_axi_wvalid => cpuid_gpio_bus_0_full_wvalid,
            cpuid_gpio_m_axi_wready => cpuid_gpio_bus_0_full_wready,
            cpuid_gpio_m_axi_bid => cpuid_gpio_bus_0_full_bid,
            cpuid_gpio_m_axi_bresp => cpuid_gpio_bus_0_full_bresp,
            cpuid_gpio_m_axi_bvalid => cpuid_gpio_bus_0_full_bvalid,
            cpuid_gpio_m_axi_bready => cpuid_gpio_bus_0_full_bready,
            cpuid_gpio_m_axi_arid => cpuid_gpio_bus_0_full_arid,
            cpuid_gpio_m_axi_araddr => cpuid_gpio_bus_0_full_araddr,
            cpuid_gpio_m_axi_arlen => cpuid_gpio_bus_0_full_arlen,
            cpuid_gpio_m_axi_arsize => cpuid_gpio_bus_0_full_arsize,
            cpuid_gpio_m_axi_arburst => cpuid_gpio_bus_0_full_arburst,
            cpuid_gpio_m_axi_arlock => cpuid_gpio_bus_0_full_arlock,
            cpuid_gpio_m_axi_arcache => cpuid_gpio_bus_0_full_arcache,
            cpuid_gpio_m_axi_arprot => cpuid_gpio_bus_0_full_arprot,
            cpuid_gpio_m_axi_arqos => cpuid_gpio_bus_0_full_arqos,
            cpuid_gpio_m_axi_arregion => cpuid_gpio_bus_0_full_arregion,
            cpuid_gpio_m_axi_arvalid => cpuid_gpio_bus_0_full_arvalid,
            cpuid_gpio_m_axi_arready => cpuid_gpio_bus_0_full_arready,
            cpuid_gpio_m_axi_rid => cpuid_gpio_bus_0_full_rid,
            cpuid_gpio_m_axi_rdata => cpuid_gpio_bus_0_full_rdata,
            cpuid_gpio_m_axi_rresp => cpuid_gpio_bus_0_full_rresp,
            cpuid_gpio_m_axi_rlast => cpuid_gpio_bus_0_full_rlast,
            cpuid_gpio_m_axi_rvalid => cpuid_gpio_bus_0_full_rvalid,
            cpuid_gpio_m_axi_rready => cpuid_gpio_bus_0_full_rready,
            int_m_axi_awid => int_bus_0_full_awid,
            int_m_axi_awaddr => int_bus_0_full_awaddr,
            int_m_axi_awlen => int_bus_0_full_awlen,
            int_m_axi_awsize => int_bus_0_full_awsize,
            int_m_axi_awburst => int_bus_0_full_awburst,
            int_m_axi_awlock => int_bus_0_full_awlock,
            int_m_axi_awcache => int_bus_0_full_awcache,
            int_m_axi_awprot => int_bus_0_full_awprot,
            int_m_axi_awqos => int_bus_0_full_awqos,
            int_m_axi_awregion => int_bus_0_full_awregion,
            int_m_axi_awvalid => int_bus_0_full_awvalid,
            int_m_axi_awready => int_bus_0_full_awready,
            int_m_axi_wdata => int_bus_0_full_wdata,
            int_m_axi_wstrb => int_bus_0_full_wstrb,
            int_m_axi_wlast => int_bus_0_full_wlast,
            int_m_axi_wvalid => int_bus_0_full_wvalid,
            int_m_axi_wready => int_bus_0_full_wready,
            int_m_axi_bid => int_bus_0_full_bid,
            int_m_axi_bresp => int_bus_0_full_bresp,
            int_m_axi_bvalid => int_bus_0_full_bvalid,
            int_m_axi_bready => int_bus_0_full_bready,
            int_m_axi_arid => int_bus_0_full_arid,
            int_m_axi_araddr => int_bus_0_full_araddr,
            int_m_axi_arlen => int_bus_0_full_arlen,
            int_m_axi_arsize => int_bus_0_full_arsize,
            int_m_axi_arburst => int_bus_0_full_arburst,
            int_m_axi_arlock => int_bus_0_full_arlock,
            int_m_axi_arcache => int_bus_0_full_arcache,
            int_m_axi_arprot => int_bus_0_full_arprot,
            int_m_axi_arqos => int_bus_0_full_arqos,
            int_m_axi_arregion => int_bus_0_full_arregion,
            int_m_axi_arvalid => int_bus_0_full_arvalid,
            int_m_axi_arready => int_bus_0_full_arready,
            int_m_axi_rid => int_bus_0_full_rid,
            int_m_axi_rdata => int_bus_0_full_rdata,
            int_m_axi_rresp => int_bus_0_full_rresp,
            int_m_axi_rlast => int_bus_0_full_rlast,
            int_m_axi_rvalid => int_bus_0_full_rvalid,
            int_m_axi_rready => int_bus_0_full_rready,
            signal_m_axi_awid => signal_bus_0_full_awid,
            signal_m_axi_awaddr => signal_bus_0_full_awaddr,
            signal_m_axi_awlen => signal_bus_0_full_awlen,
            signal_m_axi_awsize => signal_bus_0_full_awsize,
            signal_m_axi_awburst => signal_bus_0_full_awburst,
            signal_m_axi_awlock => signal_bus_0_full_awlock,
            signal_m_axi_awcache => signal_bus_0_full_awcache,
            signal_m_axi_awprot => signal_bus_0_full_awprot,
            signal_m_axi_awqos => signal_bus_0_full_awqos,
            signal_m_axi_awregion => signal_bus_0_full_awregion,
            signal_m_axi_awvalid => signal_bus_0_full_awvalid,
            signal_m_axi_awready => signal_bus_0_full_awready,
            signal_m_axi_wdata => signal_bus_0_full_wdata,
            signal_m_axi_wstrb => signal_bus_0_full_wstrb,
            signal_m_axi_wlast => signal_bus_0_full_wlast,
            signal_m_axi_wvalid => signal_bus_0_full_wvalid,
            signal_m_axi_wready => signal_bus_0_full_wready,
            signal_m_axi_bid => signal_bus_0_full_bid,
            signal_m_axi_bresp => signal_bus_0_full_bresp,
            signal_m_axi_bvalid => signal_bus_0_full_bvalid,
            signal_m_axi_bready => signal_bus_0_full_bready,
            signal_m_axi_arid => signal_bus_0_full_arid,
            signal_m_axi_araddr => signal_bus_0_full_araddr,
            signal_m_axi_arlen => signal_bus_0_full_arlen,
            signal_m_axi_arsize => signal_bus_0_full_arsize,
            signal_m_axi_arburst => signal_bus_0_full_arburst,
            signal_m_axi_arlock => signal_bus_0_full_arlock,
            signal_m_axi_arcache => signal_bus_0_full_arcache,
            signal_m_axi_arprot => signal_bus_0_full_arprot,
            signal_m_axi_arqos => signal_bus_0_full_arqos,
            signal_m_axi_arregion => signal_bus_0_full_arregion,
            signal_m_axi_arvalid => signal_bus_0_full_arvalid,
            signal_m_axi_arready => signal_bus_0_full_arready,
            signal_m_axi_rid => signal_bus_0_full_rid,
            signal_m_axi_rdata => signal_bus_0_full_rdata,
            signal_m_axi_rresp => signal_bus_0_full_rresp,
            signal_m_axi_rlast => signal_bus_0_full_rlast,
            signal_m_axi_rvalid => signal_bus_0_full_rvalid,
            aclk => aclk, aresetn => peripheral_aresetn(0));
            
    cpu_1_bus_inst : plasoc_cpu_1_crossbar_wrap
        port map (
            cpu_s_axi_awid => cpu_bus_1_full_awid,
            cpu_s_axi_awaddr => cpu_bus_1_full_awaddr,
            cpu_s_axi_awlen => cpu_bus_1_full_awlen,
            cpu_s_axi_awsize => cpu_bus_1_full_awsize,
            cpu_s_axi_awburst => cpu_bus_1_full_awburst,
            cpu_s_axi_awlock => cpu_bus_1_full_awlock,
            cpu_s_axi_awcache => cpu_bus_1_full_awcache,
            cpu_s_axi_awprot => cpu_bus_1_full_awprot,
            cpu_s_axi_awqos => cpu_bus_1_full_awqos,
            cpu_s_axi_awregion => cpu_bus_1_full_awregion,
            cpu_s_axi_awvalid => cpu_bus_1_full_awvalid,
            cpu_s_axi_awready => cpu_bus_1_full_awready,
            cpu_s_axi_wdata => cpu_bus_1_full_wdata,
            cpu_s_axi_wstrb => cpu_bus_1_full_wstrb,
            cpu_s_axi_wlast => cpu_bus_1_full_wlast,
            cpu_s_axi_wvalid => cpu_bus_1_full_wvalid,
            cpu_s_axi_wready => cpu_bus_1_full_wready,
            cpu_s_axi_bid => cpu_bus_1_full_bid,
            cpu_s_axi_bresp => cpu_bus_1_full_bresp,
            cpu_s_axi_bvalid => cpu_bus_1_full_bvalid,
            cpu_s_axi_bready => cpu_bus_1_full_bready,
            cpu_s_axi_arid => cpu_bus_1_full_arid,
            cpu_s_axi_araddr => cpu_bus_1_full_araddr,
            cpu_s_axi_arlen => cpu_bus_1_full_arlen,
            cpu_s_axi_arsize => cpu_bus_1_full_arsize,
            cpu_s_axi_arburst => cpu_bus_1_full_arburst,
            cpu_s_axi_arlock => cpu_bus_1_full_arlock,
            cpu_s_axi_arcache => cpu_bus_1_full_arcache,
            cpu_s_axi_arprot => cpu_bus_1_full_arprot,
            cpu_s_axi_arqos => cpu_bus_1_full_arqos,
            cpu_s_axi_arregion => cpu_bus_1_full_arregion,
            cpu_s_axi_arvalid => cpu_bus_1_full_arvalid,
            cpu_s_axi_arready => cpu_bus_1_full_arready,
            cpu_s_axi_rid => cpu_bus_1_full_rid,
            cpu_s_axi_rdata => cpu_bus_1_full_rdata,
            cpu_s_axi_rresp => cpu_bus_1_full_rresp,
            cpu_s_axi_rlast => cpu_bus_1_full_rlast,
            cpu_s_axi_rvalid => cpu_bus_1_full_rvalid,
            cpu_s_axi_rready => cpu_bus_1_full_rready,
            ip_m_axi_awid => cpu_1_axi_full_awid,
            ip_m_axi_awaddr => cpu_1_axi_full_awaddr,
            ip_m_axi_awlen => cpu_1_axi_full_awlen,
            ip_m_axi_awsize => cpu_1_axi_full_awsize,
            ip_m_axi_awburst => cpu_1_axi_full_awburst,
            ip_m_axi_awlock => cpu_1_axi_full_awlock,
            ip_m_axi_awcache => cpu_1_axi_full_awcache,
            ip_m_axi_awprot => cpu_1_axi_full_awprot,
            ip_m_axi_awqos => cpu_1_axi_full_awqos,
            ip_m_axi_awregion => cpu_1_axi_full_awregion,
            ip_m_axi_awvalid => cpu_1_axi_full_awvalid,
            ip_m_axi_awready => cpu_1_axi_full_awready,
            ip_m_axi_wdata => cpu_1_axi_full_wdata,
            ip_m_axi_wstrb => cpu_1_axi_full_wstrb,
            ip_m_axi_wlast => cpu_1_axi_full_wlast,
            ip_m_axi_wvalid => cpu_1_axi_full_wvalid,
            ip_m_axi_wready => cpu_1_axi_full_wready,
            ip_m_axi_bid => cpu_1_axi_full_bid,
            ip_m_axi_bresp => cpu_1_axi_full_bresp,
            ip_m_axi_bvalid => cpu_1_axi_full_bvalid,
            ip_m_axi_bready => cpu_1_axi_full_bready,
            ip_m_axi_arid => cpu_1_axi_full_arid,
            ip_m_axi_araddr => cpu_1_axi_full_araddr,
            ip_m_axi_arlen => cpu_1_axi_full_arlen,
            ip_m_axi_arsize => cpu_1_axi_full_arsize,
            ip_m_axi_arburst => cpu_1_axi_full_arburst,
            ip_m_axi_arlock => cpu_1_axi_full_arlock,
            ip_m_axi_arcache => cpu_1_axi_full_arcache,
            ip_m_axi_arprot => cpu_1_axi_full_arprot,
            ip_m_axi_arqos => cpu_1_axi_full_arqos,
            ip_m_axi_arregion => cpu_1_axi_full_arregion,
            ip_m_axi_arvalid => cpu_1_axi_full_arvalid,
            ip_m_axi_arready => cpu_1_axi_full_arready,
            ip_m_axi_rid => cpu_1_axi_full_rid,
            ip_m_axi_rdata => cpu_1_axi_full_rdata,
            ip_m_axi_rresp => cpu_1_axi_full_rresp,
            ip_m_axi_rlast => cpu_1_axi_full_rlast,
            ip_m_axi_rvalid => cpu_1_axi_full_rvalid,
            ip_m_axi_rready => cpu_1_axi_full_rready,
            cpuid_gpio_m_axi_awid => cpuid_gpio_bus_1_full_awid,
            cpuid_gpio_m_axi_awaddr => cpuid_gpio_bus_1_full_awaddr,
            cpuid_gpio_m_axi_awlen => cpuid_gpio_bus_1_full_awlen,
            cpuid_gpio_m_axi_awsize => cpuid_gpio_bus_1_full_awsize,
            cpuid_gpio_m_axi_awburst => cpuid_gpio_bus_1_full_awburst,
            cpuid_gpio_m_axi_awlock => cpuid_gpio_bus_1_full_awlock,
            cpuid_gpio_m_axi_awcache => cpuid_gpio_bus_1_full_awcache,
            cpuid_gpio_m_axi_awprot => cpuid_gpio_bus_1_full_awprot,
            cpuid_gpio_m_axi_awqos => cpuid_gpio_bus_1_full_awqos,
            cpuid_gpio_m_axi_awregion => cpuid_gpio_bus_1_full_awregion,
            cpuid_gpio_m_axi_awvalid => cpuid_gpio_bus_1_full_awvalid,
            cpuid_gpio_m_axi_awready => cpuid_gpio_bus_1_full_awready,
            cpuid_gpio_m_axi_wdata => cpuid_gpio_bus_1_full_wdata,
            cpuid_gpio_m_axi_wstrb => cpuid_gpio_bus_1_full_wstrb,
            cpuid_gpio_m_axi_wlast => cpuid_gpio_bus_1_full_wlast,
            cpuid_gpio_m_axi_wvalid => cpuid_gpio_bus_1_full_wvalid,
            cpuid_gpio_m_axi_wready => cpuid_gpio_bus_1_full_wready,
            cpuid_gpio_m_axi_bid => cpuid_gpio_bus_1_full_bid,
            cpuid_gpio_m_axi_bresp => cpuid_gpio_bus_1_full_bresp,
            cpuid_gpio_m_axi_bvalid => cpuid_gpio_bus_1_full_bvalid,
            cpuid_gpio_m_axi_bready => cpuid_gpio_bus_1_full_bready,
            cpuid_gpio_m_axi_arid => cpuid_gpio_bus_1_full_arid,
            cpuid_gpio_m_axi_araddr => cpuid_gpio_bus_1_full_araddr,
            cpuid_gpio_m_axi_arlen => cpuid_gpio_bus_1_full_arlen,
            cpuid_gpio_m_axi_arsize => cpuid_gpio_bus_1_full_arsize,
            cpuid_gpio_m_axi_arburst => cpuid_gpio_bus_1_full_arburst,
            cpuid_gpio_m_axi_arlock => cpuid_gpio_bus_1_full_arlock,
            cpuid_gpio_m_axi_arcache => cpuid_gpio_bus_1_full_arcache,
            cpuid_gpio_m_axi_arprot => cpuid_gpio_bus_1_full_arprot,
            cpuid_gpio_m_axi_arqos => cpuid_gpio_bus_1_full_arqos,
            cpuid_gpio_m_axi_arregion => cpuid_gpio_bus_1_full_arregion,
            cpuid_gpio_m_axi_arvalid => cpuid_gpio_bus_1_full_arvalid,
            cpuid_gpio_m_axi_arready => cpuid_gpio_bus_1_full_arready,
            cpuid_gpio_m_axi_rid => cpuid_gpio_bus_1_full_rid,
            cpuid_gpio_m_axi_rdata => cpuid_gpio_bus_1_full_rdata,
            cpuid_gpio_m_axi_rresp => cpuid_gpio_bus_1_full_rresp,
            cpuid_gpio_m_axi_rlast => cpuid_gpio_bus_1_full_rlast,
            cpuid_gpio_m_axi_rvalid => cpuid_gpio_bus_1_full_rvalid,
            cpuid_gpio_m_axi_rready => cpuid_gpio_bus_1_full_rready,
            int_m_axi_awid => int_bus_1_full_awid,
            int_m_axi_awaddr => int_bus_1_full_awaddr,
            int_m_axi_awlen => int_bus_1_full_awlen,
            int_m_axi_awsize => int_bus_1_full_awsize,
            int_m_axi_awburst => int_bus_1_full_awburst,
            int_m_axi_awlock => int_bus_1_full_awlock,
            int_m_axi_awcache => int_bus_1_full_awcache,
            int_m_axi_awprot => int_bus_1_full_awprot,
            int_m_axi_awqos => int_bus_1_full_awqos,
            int_m_axi_awregion => int_bus_1_full_awregion,
            int_m_axi_awvalid => int_bus_1_full_awvalid,
            int_m_axi_awready => int_bus_1_full_awready,
            int_m_axi_wdata => int_bus_1_full_wdata,
            int_m_axi_wstrb => int_bus_1_full_wstrb,
            int_m_axi_wlast => int_bus_1_full_wlast,
            int_m_axi_wvalid => int_bus_1_full_wvalid,
            int_m_axi_wready => int_bus_1_full_wready,
            int_m_axi_bid => int_bus_1_full_bid,
            int_m_axi_bresp => int_bus_1_full_bresp,
            int_m_axi_bvalid => int_bus_1_full_bvalid,
            int_m_axi_bready => int_bus_1_full_bready,
            int_m_axi_arid => int_bus_1_full_arid,
            int_m_axi_araddr => int_bus_1_full_araddr,
            int_m_axi_arlen => int_bus_1_full_arlen,
            int_m_axi_arsize => int_bus_1_full_arsize,
            int_m_axi_arburst => int_bus_1_full_arburst,
            int_m_axi_arlock => int_bus_1_full_arlock,
            int_m_axi_arcache => int_bus_1_full_arcache,
            int_m_axi_arprot => int_bus_1_full_arprot,
            int_m_axi_arqos => int_bus_1_full_arqos,
            int_m_axi_arregion => int_bus_1_full_arregion,
            int_m_axi_arvalid => int_bus_1_full_arvalid,
            int_m_axi_arready => int_bus_1_full_arready,
            int_m_axi_rid => int_bus_1_full_rid,
            int_m_axi_rdata => int_bus_1_full_rdata,
            int_m_axi_rresp => int_bus_1_full_rresp,
            int_m_axi_rlast => int_bus_1_full_rlast,
            int_m_axi_rvalid => int_bus_1_full_rvalid,
            int_m_axi_rready => int_bus_1_full_rready,
            signal_m_axi_awid => signal_bus_1_full_awid,
            signal_m_axi_awaddr => signal_bus_1_full_awaddr,
            signal_m_axi_awlen => signal_bus_1_full_awlen,
            signal_m_axi_awsize => signal_bus_1_full_awsize,
            signal_m_axi_awburst => signal_bus_1_full_awburst,
            signal_m_axi_awlock => signal_bus_1_full_awlock,
            signal_m_axi_awcache => signal_bus_1_full_awcache,
            signal_m_axi_awprot => signal_bus_1_full_awprot,
            signal_m_axi_awqos => signal_bus_1_full_awqos,
            signal_m_axi_awregion => signal_bus_1_full_awregion,
            signal_m_axi_awvalid => signal_bus_1_full_awvalid,
            signal_m_axi_awready => signal_bus_1_full_awready,
            signal_m_axi_wdata => signal_bus_1_full_wdata,
            signal_m_axi_wstrb => signal_bus_1_full_wstrb,
            signal_m_axi_wlast => signal_bus_1_full_wlast,
            signal_m_axi_wvalid => signal_bus_1_full_wvalid,
            signal_m_axi_wready => signal_bus_1_full_wready,
            signal_m_axi_bid => signal_bus_1_full_bid,
            signal_m_axi_bresp => signal_bus_1_full_bresp,
            signal_m_axi_bvalid => signal_bus_1_full_bvalid,
            signal_m_axi_bready => signal_bus_1_full_bready,
            signal_m_axi_arid => signal_bus_1_full_arid,
            signal_m_axi_araddr => signal_bus_1_full_araddr,
            signal_m_axi_arlen => signal_bus_1_full_arlen,
            signal_m_axi_arsize => signal_bus_1_full_arsize,
            signal_m_axi_arburst => signal_bus_1_full_arburst,
            signal_m_axi_arlock => signal_bus_1_full_arlock,
            signal_m_axi_arcache => signal_bus_1_full_arcache,
            signal_m_axi_arprot => signal_bus_1_full_arprot,
            signal_m_axi_arqos => signal_bus_1_full_arqos,
            signal_m_axi_arregion => signal_bus_1_full_arregion,
            signal_m_axi_arvalid => signal_bus_1_full_arvalid,
            signal_m_axi_arready => signal_bus_1_full_arready,
            signal_m_axi_rid => signal_bus_1_full_rid,
            signal_m_axi_rdata => signal_bus_1_full_rdata,
            signal_m_axi_rresp => signal_bus_1_full_rresp,
            signal_m_axi_rlast => signal_bus_1_full_rlast,
            signal_m_axi_rvalid => signal_bus_1_full_rvalid,
            aclk => aclk, aresetn => peripheral_aresetn(0));
            
    cpu_2_bus_inst : plasoc_cpu_2_crossbar_wrap
        port map (
            cpu_s_axi_awid => cpu_bus_2_full_awid,
            cpu_s_axi_awaddr => cpu_bus_2_full_awaddr,
            cpu_s_axi_awlen => cpu_bus_2_full_awlen,
            cpu_s_axi_awsize => cpu_bus_2_full_awsize,
            cpu_s_axi_awburst => cpu_bus_2_full_awburst,
            cpu_s_axi_awlock => cpu_bus_2_full_awlock,
            cpu_s_axi_awcache => cpu_bus_2_full_awcache,
            cpu_s_axi_awprot => cpu_bus_2_full_awprot,
            cpu_s_axi_awqos => cpu_bus_2_full_awqos,
            cpu_s_axi_awregion => cpu_bus_2_full_awregion,
            cpu_s_axi_awvalid => cpu_bus_2_full_awvalid,
            cpu_s_axi_awready => cpu_bus_2_full_awready,
            cpu_s_axi_wdata => cpu_bus_2_full_wdata,
            cpu_s_axi_wstrb => cpu_bus_2_full_wstrb,
            cpu_s_axi_wlast => cpu_bus_2_full_wlast,
            cpu_s_axi_wvalid => cpu_bus_2_full_wvalid,
            cpu_s_axi_wready => cpu_bus_2_full_wready,
            cpu_s_axi_bid => cpu_bus_2_full_bid,
            cpu_s_axi_bresp => cpu_bus_2_full_bresp,
            cpu_s_axi_bvalid => cpu_bus_2_full_bvalid,
            cpu_s_axi_bready => cpu_bus_2_full_bready,
            cpu_s_axi_arid => cpu_bus_2_full_arid,
            cpu_s_axi_araddr => cpu_bus_2_full_araddr,
            cpu_s_axi_arlen => cpu_bus_2_full_arlen,
            cpu_s_axi_arsize => cpu_bus_2_full_arsize,
            cpu_s_axi_arburst => cpu_bus_2_full_arburst,
            cpu_s_axi_arlock => cpu_bus_2_full_arlock,
            cpu_s_axi_arcache => cpu_bus_2_full_arcache,
            cpu_s_axi_arprot => cpu_bus_2_full_arprot,
            cpu_s_axi_arqos => cpu_bus_2_full_arqos,
            cpu_s_axi_arregion => cpu_bus_2_full_arregion,
            cpu_s_axi_arvalid => cpu_bus_2_full_arvalid,
            cpu_s_axi_arready => cpu_bus_2_full_arready,
            cpu_s_axi_rid => cpu_bus_2_full_rid,
            cpu_s_axi_rdata => cpu_bus_2_full_rdata,
            cpu_s_axi_rresp => cpu_bus_2_full_rresp,
            cpu_s_axi_rlast => cpu_bus_2_full_rlast,
            cpu_s_axi_rvalid => cpu_bus_2_full_rvalid,
            cpu_s_axi_rready => cpu_bus_2_full_rready,
            ip_m_axi_awid => cpu_2_axi_full_awid,
            ip_m_axi_awaddr => cpu_2_axi_full_awaddr,
            ip_m_axi_awlen => cpu_2_axi_full_awlen,
            ip_m_axi_awsize => cpu_2_axi_full_awsize,
            ip_m_axi_awburst => cpu_2_axi_full_awburst,
            ip_m_axi_awlock => cpu_2_axi_full_awlock,
            ip_m_axi_awcache => cpu_2_axi_full_awcache,
            ip_m_axi_awprot => cpu_2_axi_full_awprot,
            ip_m_axi_awqos => cpu_2_axi_full_awqos,
            ip_m_axi_awregion => cpu_2_axi_full_awregion,
            ip_m_axi_awvalid => cpu_2_axi_full_awvalid,
            ip_m_axi_awready => cpu_2_axi_full_awready,
            ip_m_axi_wdata => cpu_2_axi_full_wdata,
            ip_m_axi_wstrb => cpu_2_axi_full_wstrb,
            ip_m_axi_wlast => cpu_2_axi_full_wlast,
            ip_m_axi_wvalid => cpu_2_axi_full_wvalid,
            ip_m_axi_wready => cpu_2_axi_full_wready,
            ip_m_axi_bid => cpu_2_axi_full_bid,
            ip_m_axi_bresp => cpu_2_axi_full_bresp,
            ip_m_axi_bvalid => cpu_2_axi_full_bvalid,
            ip_m_axi_bready => cpu_2_axi_full_bready,
            ip_m_axi_arid => cpu_2_axi_full_arid,
            ip_m_axi_araddr => cpu_2_axi_full_araddr,
            ip_m_axi_arlen => cpu_2_axi_full_arlen,
            ip_m_axi_arsize => cpu_2_axi_full_arsize,
            ip_m_axi_arburst => cpu_2_axi_full_arburst,
            ip_m_axi_arlock => cpu_2_axi_full_arlock,
            ip_m_axi_arcache => cpu_2_axi_full_arcache,
            ip_m_axi_arprot => cpu_2_axi_full_arprot,
            ip_m_axi_arqos => cpu_2_axi_full_arqos,
            ip_m_axi_arregion => cpu_2_axi_full_arregion,
            ip_m_axi_arvalid => cpu_2_axi_full_arvalid,
            ip_m_axi_arready => cpu_2_axi_full_arready,
            ip_m_axi_rid => cpu_2_axi_full_rid,
            ip_m_axi_rdata => cpu_2_axi_full_rdata,
            ip_m_axi_rresp => cpu_2_axi_full_rresp,
            ip_m_axi_rlast => cpu_2_axi_full_rlast,
            ip_m_axi_rvalid => cpu_2_axi_full_rvalid,
            ip_m_axi_rready => cpu_2_axi_full_rready,
            cpuid_gpio_m_axi_awid => cpuid_gpio_bus_2_full_awid,
            cpuid_gpio_m_axi_awaddr => cpuid_gpio_bus_2_full_awaddr,
            cpuid_gpio_m_axi_awlen => cpuid_gpio_bus_2_full_awlen,
            cpuid_gpio_m_axi_awsize => cpuid_gpio_bus_2_full_awsize,
            cpuid_gpio_m_axi_awburst => cpuid_gpio_bus_2_full_awburst,
            cpuid_gpio_m_axi_awlock => cpuid_gpio_bus_2_full_awlock,
            cpuid_gpio_m_axi_awcache => cpuid_gpio_bus_2_full_awcache,
            cpuid_gpio_m_axi_awprot => cpuid_gpio_bus_2_full_awprot,
            cpuid_gpio_m_axi_awqos => cpuid_gpio_bus_2_full_awqos,
            cpuid_gpio_m_axi_awregion => cpuid_gpio_bus_2_full_awregion,
            cpuid_gpio_m_axi_awvalid => cpuid_gpio_bus_2_full_awvalid,
            cpuid_gpio_m_axi_awready => cpuid_gpio_bus_2_full_awready,
            cpuid_gpio_m_axi_wdata => cpuid_gpio_bus_2_full_wdata,
            cpuid_gpio_m_axi_wstrb => cpuid_gpio_bus_2_full_wstrb,
            cpuid_gpio_m_axi_wlast => cpuid_gpio_bus_2_full_wlast,
            cpuid_gpio_m_axi_wvalid => cpuid_gpio_bus_2_full_wvalid,
            cpuid_gpio_m_axi_wready => cpuid_gpio_bus_2_full_wready,
            cpuid_gpio_m_axi_bid => cpuid_gpio_bus_2_full_bid,
            cpuid_gpio_m_axi_bresp => cpuid_gpio_bus_2_full_bresp,
            cpuid_gpio_m_axi_bvalid => cpuid_gpio_bus_2_full_bvalid,
            cpuid_gpio_m_axi_bready => cpuid_gpio_bus_2_full_bready,
            cpuid_gpio_m_axi_arid => cpuid_gpio_bus_2_full_arid,
            cpuid_gpio_m_axi_araddr => cpuid_gpio_bus_2_full_araddr,
            cpuid_gpio_m_axi_arlen => cpuid_gpio_bus_2_full_arlen,
            cpuid_gpio_m_axi_arsize => cpuid_gpio_bus_2_full_arsize,
            cpuid_gpio_m_axi_arburst => cpuid_gpio_bus_2_full_arburst,
            cpuid_gpio_m_axi_arlock => cpuid_gpio_bus_2_full_arlock,
            cpuid_gpio_m_axi_arcache => cpuid_gpio_bus_2_full_arcache,
            cpuid_gpio_m_axi_arprot => cpuid_gpio_bus_2_full_arprot,
            cpuid_gpio_m_axi_arqos => cpuid_gpio_bus_2_full_arqos,
            cpuid_gpio_m_axi_arregion => cpuid_gpio_bus_2_full_arregion,
            cpuid_gpio_m_axi_arvalid => cpuid_gpio_bus_2_full_arvalid,
            cpuid_gpio_m_axi_arready => cpuid_gpio_bus_2_full_arready,
            cpuid_gpio_m_axi_rid => cpuid_gpio_bus_2_full_rid,
            cpuid_gpio_m_axi_rdata => cpuid_gpio_bus_2_full_rdata,
            cpuid_gpio_m_axi_rresp => cpuid_gpio_bus_2_full_rresp,
            cpuid_gpio_m_axi_rlast => cpuid_gpio_bus_2_full_rlast,
            cpuid_gpio_m_axi_rvalid => cpuid_gpio_bus_2_full_rvalid,
            cpuid_gpio_m_axi_rready => cpuid_gpio_bus_2_full_rready,
            int_m_axi_awid => int_bus_2_full_awid,
            int_m_axi_awaddr => int_bus_2_full_awaddr,
            int_m_axi_awlen => int_bus_2_full_awlen,
            int_m_axi_awsize => int_bus_2_full_awsize,
            int_m_axi_awburst => int_bus_2_full_awburst,
            int_m_axi_awlock => int_bus_2_full_awlock,
            int_m_axi_awcache => int_bus_2_full_awcache,
            int_m_axi_awprot => int_bus_2_full_awprot,
            int_m_axi_awqos => int_bus_2_full_awqos,
            int_m_axi_awregion => int_bus_2_full_awregion,
            int_m_axi_awvalid => int_bus_2_full_awvalid,
            int_m_axi_awready => int_bus_2_full_awready,
            int_m_axi_wdata => int_bus_2_full_wdata,
            int_m_axi_wstrb => int_bus_2_full_wstrb,
            int_m_axi_wlast => int_bus_2_full_wlast,
            int_m_axi_wvalid => int_bus_2_full_wvalid,
            int_m_axi_wready => int_bus_2_full_wready,
            int_m_axi_bid => int_bus_2_full_bid,
            int_m_axi_bresp => int_bus_2_full_bresp,
            int_m_axi_bvalid => int_bus_2_full_bvalid,
            int_m_axi_bready => int_bus_2_full_bready,
            int_m_axi_arid => int_bus_2_full_arid,
            int_m_axi_araddr => int_bus_2_full_araddr,
            int_m_axi_arlen => int_bus_2_full_arlen,
            int_m_axi_arsize => int_bus_2_full_arsize,
            int_m_axi_arburst => int_bus_2_full_arburst,
            int_m_axi_arlock => int_bus_2_full_arlock,
            int_m_axi_arcache => int_bus_2_full_arcache,
            int_m_axi_arprot => int_bus_2_full_arprot,
            int_m_axi_arqos => int_bus_2_full_arqos,
            int_m_axi_arregion => int_bus_2_full_arregion,
            int_m_axi_arvalid => int_bus_2_full_arvalid,
            int_m_axi_arready => int_bus_2_full_arready,
            int_m_axi_rid => int_bus_2_full_rid,
            int_m_axi_rdata => int_bus_2_full_rdata,
            int_m_axi_rresp => int_bus_2_full_rresp,
            int_m_axi_rlast => int_bus_2_full_rlast,
            int_m_axi_rvalid => int_bus_2_full_rvalid,
            int_m_axi_rready => int_bus_2_full_rready,
            signal_m_axi_awid => signal_bus_2_full_awid,
            signal_m_axi_awaddr => signal_bus_2_full_awaddr,
            signal_m_axi_awlen => signal_bus_2_full_awlen,
            signal_m_axi_awsize => signal_bus_2_full_awsize,
            signal_m_axi_awburst => signal_bus_2_full_awburst,
            signal_m_axi_awlock => signal_bus_2_full_awlock,
            signal_m_axi_awcache => signal_bus_2_full_awcache,
            signal_m_axi_awprot => signal_bus_2_full_awprot,
            signal_m_axi_awqos => signal_bus_2_full_awqos,
            signal_m_axi_awregion => signal_bus_2_full_awregion,
            signal_m_axi_awvalid => signal_bus_2_full_awvalid,
            signal_m_axi_awready => signal_bus_2_full_awready,
            signal_m_axi_wdata => signal_bus_2_full_wdata,
            signal_m_axi_wstrb => signal_bus_2_full_wstrb,
            signal_m_axi_wlast => signal_bus_2_full_wlast,
            signal_m_axi_wvalid => signal_bus_2_full_wvalid,
            signal_m_axi_wready => signal_bus_2_full_wready,
            signal_m_axi_bid => signal_bus_2_full_bid,
            signal_m_axi_bresp => signal_bus_2_full_bresp,
            signal_m_axi_bvalid => signal_bus_2_full_bvalid,
            signal_m_axi_bready => signal_bus_2_full_bready,
            signal_m_axi_arid => signal_bus_2_full_arid,
            signal_m_axi_araddr => signal_bus_2_full_araddr,
            signal_m_axi_arlen => signal_bus_2_full_arlen,
            signal_m_axi_arsize => signal_bus_2_full_arsize,
            signal_m_axi_arburst => signal_bus_2_full_arburst,
            signal_m_axi_arlock => signal_bus_2_full_arlock,
            signal_m_axi_arcache => signal_bus_2_full_arcache,
            signal_m_axi_arprot => signal_bus_2_full_arprot,
            signal_m_axi_arqos => signal_bus_2_full_arqos,
            signal_m_axi_arregion => signal_bus_2_full_arregion,
            signal_m_axi_arvalid => signal_bus_2_full_arvalid,
            signal_m_axi_arready => signal_bus_2_full_arready,
            signal_m_axi_rid => signal_bus_2_full_rid,
            signal_m_axi_rdata => signal_bus_2_full_rdata,
            signal_m_axi_rresp => signal_bus_2_full_rresp,
            signal_m_axi_rlast => signal_bus_2_full_rlast,
            signal_m_axi_rvalid => signal_bus_2_full_rvalid,
            aclk => aclk, aresetn => peripheral_aresetn(0));
            
    ------------------------
    -- CPU Instantiations --
    ------------------------
    
    plasoc_cpu_0_inst : plasoc_cpu 
        generic map (
            cache_address_width => cache_address_width,
            cache_way_width => cache_way_width,
            cache_index_width => cache_index_width,
            cache_offset_width => cache_offset_width,
            cache_replace_strat => cache_replace_strat)
        port map (
            aclk => aclk,
            aresetn => peripheral_aresetn(0),
            axi_awid => cpu_bus_0_full_awid,
            axi_awaddr => cpu_bus_0_full_awaddr,
            axi_awlen => cpu_bus_0_full_awlen,
            axi_awsize => cpu_bus_0_full_awsize,
            axi_awburst => cpu_bus_0_full_awburst,
            axi_awlock => cpu_bus_0_full_awlock,
            axi_awcache => cpu_bus_0_full_awcache,
            axi_awprot => cpu_bus_0_full_awprot,
            axi_awqos => cpu_bus_0_full_awqos,
            axi_awregion => cpu_bus_0_full_awregion,
            axi_awvalid => cpu_bus_0_full_awvalid,
            axi_awready => cpu_bus_0_full_awready,
            axi_wdata => cpu_bus_0_full_wdata,
            axi_wstrb => cpu_bus_0_full_wstrb,
            axi_wlast => cpu_bus_0_full_wlast,
            axi_wvalid => cpu_bus_0_full_wvalid,
            axi_wready => cpu_bus_0_full_wready,
            axi_bid => cpu_bus_0_full_bid,
            axi_bresp => cpu_bus_0_full_bresp,
            axi_bvalid => cpu_bus_0_full_bvalid,
            axi_bready => cpu_bus_0_full_bready,
            axi_arid => cpu_bus_0_full_arid,
            axi_araddr => cpu_bus_0_full_araddr,
            axi_arlen => cpu_bus_0_full_arlen,
            axi_arsize => cpu_bus_0_full_arsize,
            axi_arburst => cpu_bus_0_full_arburst,
            axi_arlock => cpu_bus_0_full_arlock,
            axi_arcache => cpu_bus_0_full_arcache,
            axi_arprot => cpu_bus_0_full_arprot,
            axi_arqos => cpu_bus_0_full_arqos,
            axi_arregion => cpu_bus_0_full_arregion,
            axi_arvalid => cpu_bus_0_full_arvalid,
            axi_arready => cpu_bus_0_full_arready,
            axi_rid => cpu_bus_0_full_rid,
            axi_rdata => cpu_bus_0_full_rdata,
            axi_rresp => cpu_bus_0_full_rresp,
            axi_rlast => cpu_bus_0_full_rlast,
            axi_rvalid => cpu_bus_0_full_rvalid,
            axi_rready => cpu_bus_0_full_rready,
            intr_in => cpu_0_int);
    
    plasoc_cpu_1_inst : plasoc_cpu 
        generic map (
            cache_address_width => cache_address_width,
            cache_way_width => cache_way_width,
            cache_index_width => cache_index_width,
            cache_offset_width => cache_offset_width,
            cache_replace_strat => cache_replace_strat)
        port map (
            aclk => aclk,
            aresetn => peripheral_aresetn(0),
            axi_awid => cpu_bus_1_full_awid,
            axi_awaddr => cpu_bus_1_full_awaddr,
            axi_awlen => cpu_bus_1_full_awlen,
            axi_awsize => cpu_bus_1_full_awsize,
            axi_awburst => cpu_bus_1_full_awburst,
            axi_awlock => cpu_bus_1_full_awlock,
            axi_awcache => cpu_bus_1_full_awcache,
            axi_awprot => cpu_bus_1_full_awprot,
            axi_awqos => cpu_bus_1_full_awqos,
            axi_awregion => cpu_bus_1_full_awregion,
            axi_awvalid => cpu_bus_1_full_awvalid,
            axi_awready => cpu_bus_1_full_awready,
            axi_wdata => cpu_bus_1_full_wdata,
            axi_wstrb => cpu_bus_1_full_wstrb,
            axi_wlast => cpu_bus_1_full_wlast,
            axi_wvalid => cpu_bus_1_full_wvalid,
            axi_wready => cpu_bus_1_full_wready,
            axi_bid => cpu_bus_1_full_bid,
            axi_bresp => cpu_bus_1_full_bresp,
            axi_bvalid => cpu_bus_1_full_bvalid,
            axi_bready => cpu_bus_1_full_bready,
            axi_arid => cpu_bus_1_full_arid,
            axi_araddr => cpu_bus_1_full_araddr,
            axi_arlen => cpu_bus_1_full_arlen,
            axi_arsize => cpu_bus_1_full_arsize,
            axi_arburst => cpu_bus_1_full_arburst,
            axi_arlock => cpu_bus_1_full_arlock,
            axi_arcache => cpu_bus_1_full_arcache,
            axi_arprot => cpu_bus_1_full_arprot,
            axi_arqos => cpu_bus_1_full_arqos,
            axi_arregion => cpu_bus_1_full_arregion,
            axi_arvalid => cpu_bus_1_full_arvalid,
            axi_arready => cpu_bus_1_full_arready,
            axi_rid => cpu_bus_1_full_rid,
            axi_rdata => cpu_bus_1_full_rdata,
            axi_rresp => cpu_bus_1_full_rresp,
            axi_rlast => cpu_bus_1_full_rlast,
            axi_rvalid => cpu_bus_1_full_rvalid,
            axi_rready => cpu_bus_1_full_rready,
            intr_in => cpu_1_int);
            
    plasoc_cpu_2_inst : plasoc_cpu 
        generic map (
            cache_address_width => cache_address_width,
            cache_way_width => cache_way_width,
            cache_index_width => cache_index_width,
            cache_offset_width => cache_offset_width,
            cache_replace_strat => cache_replace_strat)
        port map (
            aclk => aclk,
            aresetn => peripheral_aresetn(0),
            axi_awid => cpu_bus_2_full_awid,
            axi_awaddr => cpu_bus_2_full_awaddr,
            axi_awlen => cpu_bus_2_full_awlen,
            axi_awsize => cpu_bus_2_full_awsize,
            axi_awburst => cpu_bus_2_full_awburst,
            axi_awlock => cpu_bus_2_full_awlock,
            axi_awcache => cpu_bus_2_full_awcache,
            axi_awprot => cpu_bus_2_full_awprot,
            axi_awqos => cpu_bus_2_full_awqos,
            axi_awregion => cpu_bus_2_full_awregion,
            axi_awvalid => cpu_bus_2_full_awvalid,
            axi_awready => cpu_bus_2_full_awready,
            axi_wdata => cpu_bus_2_full_wdata,
            axi_wstrb => cpu_bus_2_full_wstrb,
            axi_wlast => cpu_bus_2_full_wlast,
            axi_wvalid => cpu_bus_2_full_wvalid,
            axi_wready => cpu_bus_2_full_wready,
            axi_bid => cpu_bus_2_full_bid,
            axi_bresp => cpu_bus_2_full_bresp,
            axi_bvalid => cpu_bus_2_full_bvalid,
            axi_bready => cpu_bus_2_full_bready,
            axi_arid => cpu_bus_2_full_arid,
            axi_araddr => cpu_bus_2_full_araddr,
            axi_arlen => cpu_bus_2_full_arlen,
            axi_arsize => cpu_bus_2_full_arsize,
            axi_arburst => cpu_bus_2_full_arburst,
            axi_arlock => cpu_bus_2_full_arlock,
            axi_arcache => cpu_bus_2_full_arcache,
            axi_arprot => cpu_bus_2_full_arprot,
            axi_arqos => cpu_bus_2_full_arqos,
            axi_arregion => cpu_bus_2_full_arregion,
            axi_arvalid => cpu_bus_2_full_arvalid,
            axi_arready => cpu_bus_2_full_arready,
            axi_rid => cpu_bus_2_full_rid,
            axi_rdata => cpu_bus_2_full_rdata,
            axi_rresp => cpu_bus_2_full_rresp,
            axi_rlast => cpu_bus_2_full_rlast,
            axi_rvalid => cpu_bus_2_full_rvalid,
            axi_rready => cpu_bus_2_full_rready,
            intr_in => cpu_2_int);
            
    ---------------------------------------------
    -- CPUID GPIO AXI Full2Lite Instantiations --
    ---------------------------------------------
    
    cpuid_gpio_0_full2lite : plasoc_axi4_full2lite 
        generic map (
            axi_slave_id_width => axi_cpu_bus_master_id_width,
            axi_address_width => axi_address_width,
            axi_data_width => axi_data_width)
        port map (
            aclk => aclk,                                   
            aresetn => peripheral_aresetn(0),
            s_axi_awid => cpuid_gpio_bus_0_full_awid,
            s_axi_awaddr => cpuid_gpio_bus_0_full_awaddr,
            s_axi_awlen => cpuid_gpio_bus_0_full_awlen,
            s_axi_awsize => cpuid_gpio_bus_0_full_awsize,
            s_axi_awburst => cpuid_gpio_bus_0_full_awburst,
            s_axi_awlock => cpuid_gpio_bus_0_full_awlock,
            s_axi_awcache => cpuid_gpio_bus_0_full_awcache,
            s_axi_awprot => cpuid_gpio_bus_0_full_awprot,
            s_axi_awqos => cpuid_gpio_bus_0_full_awqos,
            s_axi_awregion => cpuid_gpio_bus_0_full_awregion,
            s_axi_awvalid => cpuid_gpio_bus_0_full_awvalid,
            s_axi_awready => cpuid_gpio_bus_0_full_awready,
            s_axi_wdata => cpuid_gpio_bus_0_full_wdata,
            s_axi_wstrb => cpuid_gpio_bus_0_full_wstrb,
            s_axi_wlast => cpuid_gpio_bus_0_full_wlast,
            s_axi_wvalid => cpuid_gpio_bus_0_full_wvalid,
            s_axi_wready => cpuid_gpio_bus_0_full_wready,
            s_axi_bid => cpuid_gpio_bus_0_full_bid,
            s_axi_bresp => cpuid_gpio_bus_0_full_bresp,
            s_axi_bvalid => cpuid_gpio_bus_0_full_bvalid,
            s_axi_bready => cpuid_gpio_bus_0_full_bready,
            s_axi_arid => cpuid_gpio_bus_0_full_arid,
            s_axi_araddr => cpuid_gpio_bus_0_full_araddr,
            s_axi_arlen => cpuid_gpio_bus_0_full_arlen,
            s_axi_arsize => cpuid_gpio_bus_0_full_arsize,
            s_axi_arburst => cpuid_gpio_bus_0_full_arburst,
            s_axi_arlock => cpuid_gpio_bus_0_full_arlock,
            s_axi_arcache => cpuid_gpio_bus_0_full_arcache,
            s_axi_arprot => cpuid_gpio_bus_0_full_arprot,
            s_axi_arqos => cpuid_gpio_bus_0_full_arqos,
            s_axi_arregion => cpuid_gpio_bus_0_full_arregion,
            s_axi_arvalid => cpuid_gpio_bus_0_full_arvalid,
            s_axi_arready => cpuid_gpio_bus_0_full_arready,
            s_axi_rid => cpuid_gpio_bus_0_full_rid,
            s_axi_rdata => cpuid_gpio_bus_0_full_rdata,
            s_axi_rresp => cpuid_gpio_bus_0_full_rresp,
            s_axi_rlast => cpuid_gpio_bus_0_full_rlast,
            s_axi_rvalid => cpuid_gpio_bus_0_full_rvalid,
            s_axi_rready => cpuid_gpio_bus_0_full_rready,
            m_axi_awaddr => cpuid_gpio_bus_0_lite_awaddr,
            m_axi_awprot => cpuid_gpio_bus_0_lite_awprot,
            m_axi_awvalid => cpuid_gpio_bus_0_lite_awvalid,
            m_axi_awready => cpuid_gpio_bus_0_lite_awready,
            m_axi_wvalid => cpuid_gpio_bus_0_lite_wvalid,
            m_axi_wready => cpuid_gpio_bus_0_lite_wready,
            m_axi_wdata => cpuid_gpio_bus_0_lite_wdata,
            m_axi_wstrb => cpuid_gpio_bus_0_lite_wstrb,
            m_axi_bvalid => cpuid_gpio_bus_0_lite_bvalid,
            m_axi_bready => cpuid_gpio_bus_0_lite_bready,
            m_axi_bresp => cpuid_gpio_bus_0_lite_bresp,
            m_axi_araddr => cpuid_gpio_bus_0_lite_araddr,
            m_axi_arprot => cpuid_gpio_bus_0_lite_arprot,
            m_axi_arvalid => cpuid_gpio_bus_0_lite_arvalid,
            m_axi_arready => cpuid_gpio_bus_0_lite_arready,
            m_axi_rdata => cpuid_gpio_bus_0_lite_rdata,
            m_axi_rvalid => cpuid_gpio_bus_0_lite_rvalid,
            m_axi_rready => cpuid_gpio_bus_0_lite_rready,
            m_axi_rresp => cpuid_gpio_bus_0_lite_rresp);
            
    cpuid_gpio_1_full2lite : plasoc_axi4_full2lite 
        generic map (
            axi_slave_id_width => axi_cpu_bus_master_id_width,
            axi_address_width => axi_address_width,
            axi_data_width => axi_data_width)
        port map (
            aclk => aclk,                                   
            aresetn => peripheral_aresetn(0),
            s_axi_awid => cpuid_gpio_bus_1_full_awid,
            s_axi_awaddr => cpuid_gpio_bus_1_full_awaddr,
            s_axi_awlen => cpuid_gpio_bus_1_full_awlen,
            s_axi_awsize => cpuid_gpio_bus_1_full_awsize,
            s_axi_awburst => cpuid_gpio_bus_1_full_awburst,
            s_axi_awlock => cpuid_gpio_bus_1_full_awlock,
            s_axi_awcache => cpuid_gpio_bus_1_full_awcache,
            s_axi_awprot => cpuid_gpio_bus_1_full_awprot,
            s_axi_awqos => cpuid_gpio_bus_1_full_awqos,
            s_axi_awregion => cpuid_gpio_bus_1_full_awregion,
            s_axi_awvalid => cpuid_gpio_bus_1_full_awvalid,
            s_axi_awready => cpuid_gpio_bus_1_full_awready,
            s_axi_wdata => cpuid_gpio_bus_1_full_wdata,
            s_axi_wstrb => cpuid_gpio_bus_1_full_wstrb,
            s_axi_wlast => cpuid_gpio_bus_1_full_wlast,
            s_axi_wvalid => cpuid_gpio_bus_1_full_wvalid,
            s_axi_wready => cpuid_gpio_bus_1_full_wready,
            s_axi_bid => cpuid_gpio_bus_1_full_bid,
            s_axi_bresp => cpuid_gpio_bus_1_full_bresp,
            s_axi_bvalid => cpuid_gpio_bus_1_full_bvalid,
            s_axi_bready => cpuid_gpio_bus_1_full_bready,
            s_axi_arid => cpuid_gpio_bus_1_full_arid,
            s_axi_araddr => cpuid_gpio_bus_1_full_araddr,
            s_axi_arlen => cpuid_gpio_bus_1_full_arlen,
            s_axi_arsize => cpuid_gpio_bus_1_full_arsize,
            s_axi_arburst => cpuid_gpio_bus_1_full_arburst,
            s_axi_arlock => cpuid_gpio_bus_1_full_arlock,
            s_axi_arcache => cpuid_gpio_bus_1_full_arcache,
            s_axi_arprot => cpuid_gpio_bus_1_full_arprot,
            s_axi_arqos => cpuid_gpio_bus_1_full_arqos,
            s_axi_arregion => cpuid_gpio_bus_1_full_arregion,
            s_axi_arvalid => cpuid_gpio_bus_1_full_arvalid,
            s_axi_arready => cpuid_gpio_bus_1_full_arready,
            s_axi_rid => cpuid_gpio_bus_1_full_rid,
            s_axi_rdata => cpuid_gpio_bus_1_full_rdata,
            s_axi_rresp => cpuid_gpio_bus_1_full_rresp,
            s_axi_rlast => cpuid_gpio_bus_1_full_rlast,
            s_axi_rvalid => cpuid_gpio_bus_1_full_rvalid,
            s_axi_rready => cpuid_gpio_bus_1_full_rready,
            m_axi_awaddr => cpuid_gpio_bus_1_lite_awaddr,
            m_axi_awprot => cpuid_gpio_bus_1_lite_awprot,
            m_axi_awvalid => cpuid_gpio_bus_1_lite_awvalid,
            m_axi_awready => cpuid_gpio_bus_1_lite_awready,
            m_axi_wvalid => cpuid_gpio_bus_1_lite_wvalid,
            m_axi_wready => cpuid_gpio_bus_1_lite_wready,
            m_axi_wdata => cpuid_gpio_bus_1_lite_wdata,
            m_axi_wstrb => cpuid_gpio_bus_1_lite_wstrb,
            m_axi_bvalid => cpuid_gpio_bus_1_lite_bvalid,
            m_axi_bready => cpuid_gpio_bus_1_lite_bready,
            m_axi_bresp => cpuid_gpio_bus_1_lite_bresp,
            m_axi_araddr => cpuid_gpio_bus_1_lite_araddr,
            m_axi_arprot => cpuid_gpio_bus_1_lite_arprot,
            m_axi_arvalid => cpuid_gpio_bus_1_lite_arvalid,
            m_axi_arready => cpuid_gpio_bus_1_lite_arready,
            m_axi_rdata => cpuid_gpio_bus_1_lite_rdata,
            m_axi_rvalid => cpuid_gpio_bus_1_lite_rvalid,
            m_axi_rready => cpuid_gpio_bus_1_lite_rready,
            m_axi_rresp => cpuid_gpio_bus_1_lite_rresp);
            
    cpuid_gpio_2_full2lite : plasoc_axi4_full2lite 
        generic map (
            axi_slave_id_width => axi_cpu_bus_master_id_width,
            axi_address_width => axi_address_width,
            axi_data_width => axi_data_width)
        port map (
            aclk => aclk,                                   
            aresetn => peripheral_aresetn(0),
            s_axi_awid => cpuid_gpio_bus_2_full_awid,
            s_axi_awaddr => cpuid_gpio_bus_2_full_awaddr,
            s_axi_awlen => cpuid_gpio_bus_2_full_awlen,
            s_axi_awsize => cpuid_gpio_bus_2_full_awsize,
            s_axi_awburst => cpuid_gpio_bus_2_full_awburst,
            s_axi_awlock => cpuid_gpio_bus_2_full_awlock,
            s_axi_awcache => cpuid_gpio_bus_2_full_awcache,
            s_axi_awprot => cpuid_gpio_bus_2_full_awprot,
            s_axi_awqos => cpuid_gpio_bus_2_full_awqos,
            s_axi_awregion => cpuid_gpio_bus_2_full_awregion,
            s_axi_awvalid => cpuid_gpio_bus_2_full_awvalid,
            s_axi_awready => cpuid_gpio_bus_2_full_awready,
            s_axi_wdata => cpuid_gpio_bus_2_full_wdata,
            s_axi_wstrb => cpuid_gpio_bus_2_full_wstrb,
            s_axi_wlast => cpuid_gpio_bus_2_full_wlast,
            s_axi_wvalid => cpuid_gpio_bus_2_full_wvalid,
            s_axi_wready => cpuid_gpio_bus_2_full_wready,
            s_axi_bid => cpuid_gpio_bus_2_full_bid,
            s_axi_bresp => cpuid_gpio_bus_2_full_bresp,
            s_axi_bvalid => cpuid_gpio_bus_2_full_bvalid,
            s_axi_bready => cpuid_gpio_bus_2_full_bready,
            s_axi_arid => cpuid_gpio_bus_2_full_arid,
            s_axi_araddr => cpuid_gpio_bus_2_full_araddr,
            s_axi_arlen => cpuid_gpio_bus_2_full_arlen,
            s_axi_arsize => cpuid_gpio_bus_2_full_arsize,
            s_axi_arburst => cpuid_gpio_bus_2_full_arburst,
            s_axi_arlock => cpuid_gpio_bus_2_full_arlock,
            s_axi_arcache => cpuid_gpio_bus_2_full_arcache,
            s_axi_arprot => cpuid_gpio_bus_2_full_arprot,
            s_axi_arqos => cpuid_gpio_bus_2_full_arqos,
            s_axi_arregion => cpuid_gpio_bus_2_full_arregion,
            s_axi_arvalid => cpuid_gpio_bus_2_full_arvalid,
            s_axi_arready => cpuid_gpio_bus_2_full_arready,
            s_axi_rid => cpuid_gpio_bus_2_full_rid,
            s_axi_rdata => cpuid_gpio_bus_2_full_rdata,
            s_axi_rresp => cpuid_gpio_bus_2_full_rresp,
            s_axi_rlast => cpuid_gpio_bus_2_full_rlast,
            s_axi_rvalid => cpuid_gpio_bus_2_full_rvalid,
            s_axi_rready => cpuid_gpio_bus_2_full_rready,
            m_axi_awaddr => cpuid_gpio_bus_2_lite_awaddr,
            m_axi_awprot => cpuid_gpio_bus_2_lite_awprot,
            m_axi_awvalid => cpuid_gpio_bus_2_lite_awvalid,
            m_axi_awready => cpuid_gpio_bus_2_lite_awready,
            m_axi_wvalid => cpuid_gpio_bus_2_lite_wvalid,
            m_axi_wready => cpuid_gpio_bus_2_lite_wready,
            m_axi_wdata => cpuid_gpio_bus_2_lite_wdata,
            m_axi_wstrb => cpuid_gpio_bus_2_lite_wstrb,
            m_axi_bvalid => cpuid_gpio_bus_2_lite_bvalid,
            m_axi_bready => cpuid_gpio_bus_2_lite_bready,
            m_axi_bresp => cpuid_gpio_bus_2_lite_bresp,
            m_axi_araddr => cpuid_gpio_bus_2_lite_araddr,
            m_axi_arprot => cpuid_gpio_bus_2_lite_arprot,
            m_axi_arvalid => cpuid_gpio_bus_2_lite_arvalid,
            m_axi_arready => cpuid_gpio_bus_2_lite_arready,
            m_axi_rdata => cpuid_gpio_bus_2_lite_rdata,
            m_axi_rvalid => cpuid_gpio_bus_2_lite_rvalid,
            m_axi_rready => cpuid_gpio_bus_2_lite_rready,
            m_axi_rresp => cpuid_gpio_bus_2_lite_rresp);
            
    ------------------------------------------
    -- CPU INT AXI Full2Lite Instantiations --
    ------------------------------------------
    
    int_0_full2lite : plasoc_axi4_full2lite 
        generic map (
            axi_slave_id_width => axi_cpu_bus_master_id_width,
            axi_address_width => axi_address_width,
            axi_data_width => axi_data_width)
        port map (
            aclk => aclk,                                   
            aresetn => peripheral_aresetn(0),
            s_axi_awid => int_bus_0_full_awid,
            s_axi_awaddr => int_bus_0_full_awaddr,
            s_axi_awlen => int_bus_0_full_awlen,
            s_axi_awsize => int_bus_0_full_awsize,
            s_axi_awburst => int_bus_0_full_awburst,
            s_axi_awlock => int_bus_0_full_awlock,
            s_axi_awcache => int_bus_0_full_awcache,
            s_axi_awprot => int_bus_0_full_awprot,
            s_axi_awqos => int_bus_0_full_awqos,
            s_axi_awregion => int_bus_0_full_awregion,
            s_axi_awvalid => int_bus_0_full_awvalid,
            s_axi_awready => int_bus_0_full_awready,
            s_axi_wdata => int_bus_0_full_wdata,
            s_axi_wstrb => int_bus_0_full_wstrb,
            s_axi_wlast => int_bus_0_full_wlast,
            s_axi_wvalid => int_bus_0_full_wvalid,
            s_axi_wready => int_bus_0_full_wready,
            s_axi_bid => int_bus_0_full_bid,
            s_axi_bresp => int_bus_0_full_bresp,
            s_axi_bvalid => int_bus_0_full_bvalid,
            s_axi_bready => int_bus_0_full_bready,
            s_axi_arid => int_bus_0_full_arid,
            s_axi_araddr => int_bus_0_full_araddr,
            s_axi_arlen => int_bus_0_full_arlen,
            s_axi_arsize => int_bus_0_full_arsize,
            s_axi_arburst => int_bus_0_full_arburst,
            s_axi_arlock => int_bus_0_full_arlock,
            s_axi_arcache => int_bus_0_full_arcache,
            s_axi_arprot => int_bus_0_full_arprot,
            s_axi_arqos => int_bus_0_full_arqos,
            s_axi_arregion => int_bus_0_full_arregion,
            s_axi_arvalid => int_bus_0_full_arvalid,
            s_axi_arready => int_bus_0_full_arready,
            s_axi_rid => int_bus_0_full_rid,
            s_axi_rdata => int_bus_0_full_rdata,
            s_axi_rresp => int_bus_0_full_rresp,
            s_axi_rlast => int_bus_0_full_rlast,
            s_axi_rvalid => int_bus_0_full_rvalid,
            s_axi_rready => int_bus_0_full_rready,
            m_axi_awaddr => int_bus_0_lite_awaddr,
            m_axi_awprot => int_bus_0_lite_awprot,
            m_axi_awvalid => int_bus_0_lite_awvalid,
            m_axi_awready => int_bus_0_lite_awready,
            m_axi_wvalid => int_bus_0_lite_wvalid,
            m_axi_wready => int_bus_0_lite_wready,
            m_axi_wdata => int_bus_0_lite_wdata,
            m_axi_wstrb => int_bus_0_lite_wstrb,
            m_axi_bvalid => int_bus_0_lite_bvalid,
            m_axi_bready => int_bus_0_lite_bready,
            m_axi_bresp => int_bus_0_lite_bresp,
            m_axi_araddr => int_bus_0_lite_araddr,
            m_axi_arprot => int_bus_0_lite_arprot,
            m_axi_arvalid => int_bus_0_lite_arvalid,
            m_axi_arready => int_bus_0_lite_arready,
            m_axi_rdata => int_bus_0_lite_rdata,
            m_axi_rvalid => int_bus_0_lite_rvalid,
            m_axi_rready => int_bus_0_lite_rready,
            m_axi_rresp => int_bus_0_lite_rresp);
            
    int_1_full2lite : plasoc_axi4_full2lite 
        generic map (
            axi_slave_id_width => axi_cpu_bus_master_id_width,
            axi_address_width => axi_address_width,
            axi_data_width => axi_data_width)
        port map (
            aclk => aclk,                                   
            aresetn => peripheral_aresetn(0),
            s_axi_awid => int_bus_1_full_awid,
            s_axi_awaddr => int_bus_1_full_awaddr,
            s_axi_awlen => int_bus_1_full_awlen,
            s_axi_awsize => int_bus_1_full_awsize,
            s_axi_awburst => int_bus_1_full_awburst,
            s_axi_awlock => int_bus_1_full_awlock,
            s_axi_awcache => int_bus_1_full_awcache,
            s_axi_awprot => int_bus_1_full_awprot,
            s_axi_awqos => int_bus_1_full_awqos,
            s_axi_awregion => int_bus_1_full_awregion,
            s_axi_awvalid => int_bus_1_full_awvalid,
            s_axi_awready => int_bus_1_full_awready,
            s_axi_wdata => int_bus_1_full_wdata,
            s_axi_wstrb => int_bus_1_full_wstrb,
            s_axi_wlast => int_bus_1_full_wlast,
            s_axi_wvalid => int_bus_1_full_wvalid,
            s_axi_wready => int_bus_1_full_wready,
            s_axi_bid => int_bus_1_full_bid,
            s_axi_bresp => int_bus_1_full_bresp,
            s_axi_bvalid => int_bus_1_full_bvalid,
            s_axi_bready => int_bus_1_full_bready,
            s_axi_arid => int_bus_1_full_arid,
            s_axi_araddr => int_bus_1_full_araddr,
            s_axi_arlen => int_bus_1_full_arlen,
            s_axi_arsize => int_bus_1_full_arsize,
            s_axi_arburst => int_bus_1_full_arburst,
            s_axi_arlock => int_bus_1_full_arlock,
            s_axi_arcache => int_bus_1_full_arcache,
            s_axi_arprot => int_bus_1_full_arprot,
            s_axi_arqos => int_bus_1_full_arqos,
            s_axi_arregion => int_bus_1_full_arregion,
            s_axi_arvalid => int_bus_1_full_arvalid,
            s_axi_arready => int_bus_1_full_arready,
            s_axi_rid => int_bus_1_full_rid,
            s_axi_rdata => int_bus_1_full_rdata,
            s_axi_rresp => int_bus_1_full_rresp,
            s_axi_rlast => int_bus_1_full_rlast,
            s_axi_rvalid => int_bus_1_full_rvalid,
            s_axi_rready => int_bus_1_full_rready,
            m_axi_awaddr => int_bus_1_lite_awaddr,
            m_axi_awprot => int_bus_1_lite_awprot,
            m_axi_awvalid => int_bus_1_lite_awvalid,
            m_axi_awready => int_bus_1_lite_awready,
            m_axi_wvalid => int_bus_1_lite_wvalid,
            m_axi_wready => int_bus_1_lite_wready,
            m_axi_wdata => int_bus_1_lite_wdata,
            m_axi_wstrb => int_bus_1_lite_wstrb,
            m_axi_bvalid => int_bus_1_lite_bvalid,
            m_axi_bready => int_bus_1_lite_bready,
            m_axi_bresp => int_bus_1_lite_bresp,
            m_axi_araddr => int_bus_1_lite_araddr,
            m_axi_arprot => int_bus_1_lite_arprot,
            m_axi_arvalid => int_bus_1_lite_arvalid,
            m_axi_arready => int_bus_1_lite_arready,
            m_axi_rdata => int_bus_1_lite_rdata,
            m_axi_rvalid => int_bus_1_lite_rvalid,
            m_axi_rready => int_bus_1_lite_rready,
            m_axi_rresp => int_bus_1_lite_rresp);
            
    int_2_full2lite : plasoc_axi4_full2lite 
        generic map (
            axi_slave_id_width => axi_cpu_bus_master_id_width,
            axi_address_width => axi_address_width,
            axi_data_width => axi_data_width)
        port map (
            aclk => aclk,                                   
            aresetn => peripheral_aresetn(0),
            s_axi_awid => int_bus_2_full_awid,
            s_axi_awaddr => int_bus_2_full_awaddr,
            s_axi_awlen => int_bus_2_full_awlen,
            s_axi_awsize => int_bus_2_full_awsize,
            s_axi_awburst => int_bus_2_full_awburst,
            s_axi_awlock => int_bus_2_full_awlock,
            s_axi_awcache => int_bus_2_full_awcache,
            s_axi_awprot => int_bus_2_full_awprot,
            s_axi_awqos => int_bus_2_full_awqos,
            s_axi_awregion => int_bus_2_full_awregion,
            s_axi_awvalid => int_bus_2_full_awvalid,
            s_axi_awready => int_bus_2_full_awready,
            s_axi_wdata => int_bus_2_full_wdata,
            s_axi_wstrb => int_bus_2_full_wstrb,
            s_axi_wlast => int_bus_2_full_wlast,
            s_axi_wvalid => int_bus_2_full_wvalid,
            s_axi_wready => int_bus_2_full_wready,
            s_axi_bid => int_bus_2_full_bid,
            s_axi_bresp => int_bus_2_full_bresp,
            s_axi_bvalid => int_bus_2_full_bvalid,
            s_axi_bready => int_bus_2_full_bready,
            s_axi_arid => int_bus_2_full_arid,
            s_axi_araddr => int_bus_2_full_araddr,
            s_axi_arlen => int_bus_2_full_arlen,
            s_axi_arsize => int_bus_2_full_arsize,
            s_axi_arburst => int_bus_2_full_arburst,
            s_axi_arlock => int_bus_2_full_arlock,
            s_axi_arcache => int_bus_2_full_arcache,
            s_axi_arprot => int_bus_2_full_arprot,
            s_axi_arqos => int_bus_2_full_arqos,
            s_axi_arregion => int_bus_2_full_arregion,
            s_axi_arvalid => int_bus_2_full_arvalid,
            s_axi_arready => int_bus_2_full_arready,
            s_axi_rid => int_bus_2_full_rid,
            s_axi_rdata => int_bus_2_full_rdata,
            s_axi_rresp => int_bus_2_full_rresp,
            s_axi_rlast => int_bus_2_full_rlast,
            s_axi_rvalid => int_bus_2_full_rvalid,
            s_axi_rready => int_bus_2_full_rready,
            m_axi_awaddr => int_bus_2_lite_awaddr,
            m_axi_awprot => int_bus_2_lite_awprot,
            m_axi_awvalid => int_bus_2_lite_awvalid,
            m_axi_awready => int_bus_2_lite_awready,
            m_axi_wvalid => int_bus_2_lite_wvalid,
            m_axi_wready => int_bus_2_lite_wready,
            m_axi_wdata => int_bus_2_lite_wdata,
            m_axi_wstrb => int_bus_2_lite_wstrb,
            m_axi_bvalid => int_bus_2_lite_bvalid,
            m_axi_bready => int_bus_2_lite_bready,
            m_axi_bresp => int_bus_2_lite_bresp,
            m_axi_araddr => int_bus_2_lite_araddr,
            m_axi_arprot => int_bus_2_lite_arprot,
            m_axi_arvalid => int_bus_2_lite_arvalid,
            m_axi_arready => int_bus_2_lite_arready,
            m_axi_rdata => int_bus_2_lite_rdata,
            m_axi_rvalid => int_bus_2_lite_rvalid,
            m_axi_rready => int_bus_2_lite_rready,
            m_axi_rresp => int_bus_2_lite_rresp);
            
    ---------------------------------------------
    -- CPU Signal AXI Full2Lite Instantiations --
    ---------------------------------------------
    
    signal_0_full2lite : plasoc_axi4_full2lite 
        generic map (
            axi_slave_id_width => axi_cpu_bus_master_id_width,
            axi_address_width => axi_address_width,
            axi_data_width => axi_data_width)
        port map (
            aclk => aclk,                                   
            aresetn => peripheral_aresetn(0),
            s_axi_awid => signal_bus_0_full_awid,
            s_axi_awaddr => signal_bus_0_full_awaddr,
            s_axi_awlen => signal_bus_0_full_awlen,
            s_axi_awsize => signal_bus_0_full_awsize,
            s_axi_awburst => signal_bus_0_full_awburst,
            s_axi_awlock => signal_bus_0_full_awlock,
            s_axi_awcache => signal_bus_0_full_awcache,
            s_axi_awprot => signal_bus_0_full_awprot,
            s_axi_awqos => signal_bus_0_full_awqos,
            s_axi_awregion => signal_bus_0_full_awregion,
            s_axi_awvalid => signal_bus_0_full_awvalid,
            s_axi_awready => signal_bus_0_full_awready,
            s_axi_wdata => signal_bus_0_full_wdata,
            s_axi_wstrb => signal_bus_0_full_wstrb,
            s_axi_wlast => signal_bus_0_full_wlast,
            s_axi_wvalid => signal_bus_0_full_wvalid,
            s_axi_wready => signal_bus_0_full_wready,
            s_axi_bid => signal_bus_0_full_bid,
            s_axi_bresp => signal_bus_0_full_bresp,
            s_axi_bvalid => signal_bus_0_full_bvalid,
            s_axi_bready => signal_bus_0_full_bready,
            s_axi_arid => signal_bus_0_full_arid,
            s_axi_araddr => signal_bus_0_full_araddr,
            s_axi_arlen => signal_bus_0_full_arlen,
            s_axi_arsize => signal_bus_0_full_arsize,
            s_axi_arburst => signal_bus_0_full_arburst,
            s_axi_arlock => signal_bus_0_full_arlock,
            s_axi_arcache => signal_bus_0_full_arcache,
            s_axi_arprot => signal_bus_0_full_arprot,
            s_axi_arqos => signal_bus_0_full_arqos,
            s_axi_arregion => signal_bus_0_full_arregion,
            s_axi_arvalid => signal_bus_0_full_arvalid,
            s_axi_arready => signal_bus_0_full_arready,
            s_axi_rid => signal_bus_0_full_rid,
            s_axi_rdata => signal_bus_0_full_rdata,
            s_axi_rresp => signal_bus_0_full_rresp,
            s_axi_rlast => signal_bus_0_full_rlast,
            s_axi_rvalid => signal_bus_0_full_rvalid,
            s_axi_rready => signal_bus_0_full_rready,
            m_axi_awaddr => signal_bus_0_lite_awaddr,
            m_axi_awprot => signal_bus_0_lite_awprot,
            m_axi_awvalid => signal_bus_0_lite_awvalid,
            m_axi_awready => signal_bus_0_lite_awready,
            m_axi_wvalid => signal_bus_0_lite_wvalid,
            m_axi_wready => signal_bus_0_lite_wready,
            m_axi_wdata => signal_bus_0_lite_wdata,
            m_axi_wstrb => signal_bus_0_lite_wstrb,
            m_axi_bvalid => signal_bus_0_lite_bvalid,
            m_axi_bready => signal_bus_0_lite_bready,
            m_axi_bresp => signal_bus_0_lite_bresp,
            m_axi_araddr => signal_bus_0_lite_araddr,
            m_axi_arprot => signal_bus_0_lite_arprot,
            m_axi_arvalid => signal_bus_0_lite_arvalid,
            m_axi_arready => signal_bus_0_lite_arready,
            m_axi_rdata => signal_bus_0_lite_rdata,
            m_axi_rvalid => signal_bus_0_lite_rvalid,
            m_axi_rready => signal_bus_0_lite_rready,
            m_axi_rresp => signal_bus_0_lite_rresp);
            
    signal_1_full2lite : plasoc_axi4_full2lite 
        generic map (
            axi_slave_id_width => axi_cpu_bus_master_id_width,
            axi_address_width => axi_address_width,
            axi_data_width => axi_data_width)
        port map (
            aclk => aclk,                                   
            aresetn => peripheral_aresetn(0),
            s_axi_awid => signal_bus_1_full_awid,
            s_axi_awaddr => signal_bus_1_full_awaddr,
            s_axi_awlen => signal_bus_1_full_awlen,
            s_axi_awsize => signal_bus_1_full_awsize,
            s_axi_awburst => signal_bus_1_full_awburst,
            s_axi_awlock => signal_bus_1_full_awlock,
            s_axi_awcache => signal_bus_1_full_awcache,
            s_axi_awprot => signal_bus_1_full_awprot,
            s_axi_awqos => signal_bus_1_full_awqos,
            s_axi_awregion => signal_bus_1_full_awregion,
            s_axi_awvalid => signal_bus_1_full_awvalid,
            s_axi_awready => signal_bus_1_full_awready,
            s_axi_wdata => signal_bus_1_full_wdata,
            s_axi_wstrb => signal_bus_1_full_wstrb,
            s_axi_wlast => signal_bus_1_full_wlast,
            s_axi_wvalid => signal_bus_1_full_wvalid,
            s_axi_wready => signal_bus_1_full_wready,
            s_axi_bid => signal_bus_1_full_bid,
            s_axi_bresp => signal_bus_1_full_bresp,
            s_axi_bvalid => signal_bus_1_full_bvalid,
            s_axi_bready => signal_bus_1_full_bready,
            s_axi_arid => signal_bus_1_full_arid,
            s_axi_araddr => signal_bus_1_full_araddr,
            s_axi_arlen => signal_bus_1_full_arlen,
            s_axi_arsize => signal_bus_1_full_arsize,
            s_axi_arburst => signal_bus_1_full_arburst,
            s_axi_arlock => signal_bus_1_full_arlock,
            s_axi_arcache => signal_bus_1_full_arcache,
            s_axi_arprot => signal_bus_1_full_arprot,
            s_axi_arqos => signal_bus_1_full_arqos,
            s_axi_arregion => signal_bus_1_full_arregion,
            s_axi_arvalid => signal_bus_1_full_arvalid,
            s_axi_arready => signal_bus_1_full_arready,
            s_axi_rid => signal_bus_1_full_rid,
            s_axi_rdata => signal_bus_1_full_rdata,
            s_axi_rresp => signal_bus_1_full_rresp,
            s_axi_rlast => signal_bus_1_full_rlast,
            s_axi_rvalid => signal_bus_1_full_rvalid,
            s_axi_rready => signal_bus_1_full_rready,
            m_axi_awaddr => signal_bus_1_lite_awaddr,
            m_axi_awprot => signal_bus_1_lite_awprot,
            m_axi_awvalid => signal_bus_1_lite_awvalid,
            m_axi_awready => signal_bus_1_lite_awready,
            m_axi_wvalid => signal_bus_1_lite_wvalid,
            m_axi_wready => signal_bus_1_lite_wready,
            m_axi_wdata => signal_bus_1_lite_wdata,
            m_axi_wstrb => signal_bus_1_lite_wstrb,
            m_axi_bvalid => signal_bus_1_lite_bvalid,
            m_axi_bready => signal_bus_1_lite_bready,
            m_axi_bresp => signal_bus_1_lite_bresp,
            m_axi_araddr => signal_bus_1_lite_araddr,
            m_axi_arprot => signal_bus_1_lite_arprot,
            m_axi_arvalid => signal_bus_1_lite_arvalid,
            m_axi_arready => signal_bus_1_lite_arready,
            m_axi_rdata => signal_bus_1_lite_rdata,
            m_axi_rvalid => signal_bus_1_lite_rvalid,
            m_axi_rready => signal_bus_1_lite_rready,
            m_axi_rresp => signal_bus_1_lite_rresp);
            
    signal_2_full2lite : plasoc_axi4_full2lite 
        generic map (
            axi_slave_id_width => axi_cpu_bus_master_id_width,
            axi_address_width => axi_address_width,
            axi_data_width => axi_data_width)
        port map (
            aclk => aclk,                                   
            aresetn => peripheral_aresetn(0),
            s_axi_awid => signal_bus_2_full_awid,
            s_axi_awaddr => signal_bus_2_full_awaddr,
            s_axi_awlen => signal_bus_2_full_awlen,
            s_axi_awsize => signal_bus_2_full_awsize,
            s_axi_awburst => signal_bus_2_full_awburst,
            s_axi_awlock => signal_bus_2_full_awlock,
            s_axi_awcache => signal_bus_2_full_awcache,
            s_axi_awprot => signal_bus_2_full_awprot,
            s_axi_awqos => signal_bus_2_full_awqos,
            s_axi_awregion => signal_bus_2_full_awregion,
            s_axi_awvalid => signal_bus_2_full_awvalid,
            s_axi_awready => signal_bus_2_full_awready,
            s_axi_wdata => signal_bus_2_full_wdata,
            s_axi_wstrb => signal_bus_2_full_wstrb,
            s_axi_wlast => signal_bus_2_full_wlast,
            s_axi_wvalid => signal_bus_2_full_wvalid,
            s_axi_wready => signal_bus_2_full_wready,
            s_axi_bid => signal_bus_2_full_bid,
            s_axi_bresp => signal_bus_2_full_bresp,
            s_axi_bvalid => signal_bus_2_full_bvalid,
            s_axi_bready => signal_bus_2_full_bready,
            s_axi_arid => signal_bus_2_full_arid,
            s_axi_araddr => signal_bus_2_full_araddr,
            s_axi_arlen => signal_bus_2_full_arlen,
            s_axi_arsize => signal_bus_2_full_arsize,
            s_axi_arburst => signal_bus_2_full_arburst,
            s_axi_arlock => signal_bus_2_full_arlock,
            s_axi_arcache => signal_bus_2_full_arcache,
            s_axi_arprot => signal_bus_2_full_arprot,
            s_axi_arqos => signal_bus_2_full_arqos,
            s_axi_arregion => signal_bus_2_full_arregion,
            s_axi_arvalid => signal_bus_2_full_arvalid,
            s_axi_arready => signal_bus_2_full_arready,
            s_axi_rid => signal_bus_2_full_rid,
            s_axi_rdata => signal_bus_2_full_rdata,
            s_axi_rresp => signal_bus_2_full_rresp,
            s_axi_rlast => signal_bus_2_full_rlast,
            s_axi_rvalid => signal_bus_2_full_rvalid,
            s_axi_rready => signal_bus_2_full_rready,
            m_axi_awaddr => signal_bus_2_lite_awaddr,
            m_axi_awprot => signal_bus_2_lite_awprot,
            m_axi_awvalid => signal_bus_2_lite_awvalid,
            m_axi_awready => signal_bus_2_lite_awready,
            m_axi_wvalid => signal_bus_2_lite_wvalid,
            m_axi_wready => signal_bus_2_lite_wready,
            m_axi_wdata => signal_bus_2_lite_wdata,
            m_axi_wstrb => signal_bus_2_lite_wstrb,
            m_axi_bvalid => signal_bus_2_lite_bvalid,
            m_axi_bready => signal_bus_2_lite_bready,
            m_axi_bresp => signal_bus_2_lite_bresp,
            m_axi_araddr => signal_bus_2_lite_araddr,
            m_axi_arprot => signal_bus_2_lite_arprot,
            m_axi_arvalid => signal_bus_2_lite_arvalid,
            m_axi_arready => signal_bus_2_lite_arready,
            m_axi_rdata => signal_bus_2_lite_rdata,
            m_axi_rvalid => signal_bus_2_lite_rvalid,
            m_axi_rready => signal_bus_2_lite_rready,
            m_axi_rresp => signal_bus_2_lite_rresp);
            
    ----------------------------------------------------
    -- Main Interconnect AXI Full2Lite Instantiations --
    ----------------------------------------------------
        
    int_main_full2lite : plasoc_axi4_full2lite 
        generic map (
            axi_slave_id_width => axi_master_id_width,
            axi_address_width => axi_address_width,
            axi_data_width => axi_data_width)
        port map (
            aclk => aclk,                                   
            aresetn => peripheral_aresetn(0),
            s_axi_awid => int_axi_full_awid,
            s_axi_awaddr => int_axi_full_awaddr,
            s_axi_awlen => int_axi_full_awlen,
            s_axi_awsize => int_axi_full_awsize,
            s_axi_awburst => int_axi_full_awburst,
            s_axi_awlock => int_axi_full_awlock,
            s_axi_awcache => int_axi_full_awcache,
            s_axi_awprot => int_axi_full_awprot,
            s_axi_awqos => int_axi_full_awqos,
            s_axi_awregion => int_axi_full_awregion,
            s_axi_awvalid => int_axi_full_awvalid,
            s_axi_awready => int_axi_full_awready,
            s_axi_wdata => int_axi_full_wdata,
            s_axi_wstrb => int_axi_full_wstrb,
            s_axi_wlast => int_axi_full_wlast,
            s_axi_wvalid => int_axi_full_wvalid,
            s_axi_wready => int_axi_full_wready,
            s_axi_bid => int_axi_full_bid,
            s_axi_bresp => int_axi_full_bresp,
            s_axi_bvalid => int_axi_full_bvalid,
            s_axi_bready => int_axi_full_bready,
            s_axi_arid => int_axi_full_arid,
            s_axi_araddr => int_axi_full_araddr,
            s_axi_arlen => int_axi_full_arlen,
            s_axi_arsize => int_axi_full_arsize,
            s_axi_arburst => int_axi_full_arburst,
            s_axi_arlock => int_axi_full_arlock,
            s_axi_arcache => int_axi_full_arcache,
            s_axi_arprot => int_axi_full_arprot,
            s_axi_arqos => int_axi_full_arqos,
            s_axi_arregion => int_axi_full_arregion,
            s_axi_arvalid => int_axi_full_arvalid,
            s_axi_arready => int_axi_full_arready,
            s_axi_rid => int_axi_full_rid,
            s_axi_rdata => int_axi_full_rdata,
            s_axi_rresp => int_axi_full_rresp,
            s_axi_rlast => int_axi_full_rlast,
            s_axi_rvalid => int_axi_full_rvalid,
            s_axi_rready => int_axi_full_rready,
            m_axi_awaddr => int_axi_lite_awaddr,
            m_axi_awprot => int_axi_lite_awprot,
            m_axi_awvalid => int_axi_lite_awvalid,
            m_axi_awready => int_axi_lite_awready,
            m_axi_wvalid => int_axi_lite_wvalid,
            m_axi_wready => int_axi_lite_wready,
            m_axi_wdata => int_axi_lite_wdata,
            m_axi_wstrb => int_axi_lite_wstrb,
            m_axi_bvalid => int_axi_lite_bvalid,
            m_axi_bready => int_axi_lite_bready,
            m_axi_bresp => int_axi_lite_bresp,
            m_axi_araddr => int_axi_lite_araddr,
            m_axi_arprot => int_axi_lite_arprot,
            m_axi_arvalid => int_axi_lite_arvalid,
            m_axi_arready => int_axi_lite_arready,
            m_axi_rdata => int_axi_lite_rdata,
            m_axi_rvalid => int_axi_lite_rvalid,
            m_axi_rready => int_axi_lite_rready,
            m_axi_rresp => int_axi_lite_rresp);
            
    timer_main_full2lite : plasoc_axi4_full2lite 
        generic map (
            axi_slave_id_width => axi_master_id_width,
            axi_address_width => axi_address_width,
            axi_data_width => axi_data_width)
        port map (
            aclk => aclk,                                   
            aresetn => peripheral_aresetn(0),
            s_axi_awid => timer_axi_full_awid,
            s_axi_awaddr => timer_axi_full_awaddr,
            s_axi_awlen => timer_axi_full_awlen,
            s_axi_awsize => timer_axi_full_awsize,
            s_axi_awburst => timer_axi_full_awburst,
            s_axi_awlock => timer_axi_full_awlock,
            s_axi_awcache => timer_axi_full_awcache,
            s_axi_awprot => timer_axi_full_awprot,
            s_axi_awqos => timer_axi_full_awqos,
            s_axi_awregion => timer_axi_full_awregion,
            s_axi_awvalid => timer_axi_full_awvalid,
            s_axi_awready => timer_axi_full_awready,
            s_axi_wdata => timer_axi_full_wdata,
            s_axi_wstrb => timer_axi_full_wstrb,
            s_axi_wlast => timer_axi_full_wlast,
            s_axi_wvalid => timer_axi_full_wvalid,
            s_axi_wready => timer_axi_full_wready,
            s_axi_bid => timer_axi_full_bid,
            s_axi_bresp => timer_axi_full_bresp,
            s_axi_bvalid => timer_axi_full_bvalid,
            s_axi_bready => timer_axi_full_bready,
            s_axi_arid => timer_axi_full_arid,
            s_axi_araddr => timer_axi_full_araddr,
            s_axi_arlen => timer_axi_full_arlen,
            s_axi_arsize => timer_axi_full_arsize,
            s_axi_arburst => timer_axi_full_arburst,
            s_axi_arlock => timer_axi_full_arlock,
            s_axi_arcache => timer_axi_full_arcache,
            s_axi_arprot => timer_axi_full_arprot,
            s_axi_arqos => timer_axi_full_arqos,
            s_axi_arregion => timer_axi_full_arregion,
            s_axi_arvalid => timer_axi_full_arvalid,
            s_axi_arready => timer_axi_full_arready,
            s_axi_rid => timer_axi_full_rid,
            s_axi_rdata => timer_axi_full_rdata,
            s_axi_rresp => timer_axi_full_rresp,
            s_axi_rlast => timer_axi_full_rlast,
            s_axi_rvalid => timer_axi_full_rvalid,
            s_axi_rready => timer_axi_full_rready,
            m_axi_awaddr => timer_axi_lite_awaddr,
            m_axi_awprot => timer_axi_lite_awprot,
            m_axi_awvalid => timer_axi_lite_awvalid,
            m_axi_awready => timer_axi_lite_awready,
            m_axi_wvalid => timer_axi_lite_wvalid,
            m_axi_wready => timer_axi_lite_wready,
            m_axi_wdata => timer_axi_lite_wdata,
            m_axi_wstrb => timer_axi_lite_wstrb,
            m_axi_bvalid => timer_axi_lite_bvalid,
            m_axi_bready => timer_axi_lite_bready,
            m_axi_bresp => timer_axi_lite_bresp,
            m_axi_araddr => timer_axi_lite_araddr,
            m_axi_arprot => timer_axi_lite_arprot,
            m_axi_arvalid => timer_axi_lite_arvalid,
            m_axi_arready => timer_axi_lite_arready,
            m_axi_rdata => timer_axi_lite_rdata,
            m_axi_rvalid => timer_axi_lite_rvalid,
            m_axi_rready => timer_axi_lite_rready,
            m_axi_rresp => timer_axi_lite_rresp);
            
    gpio_main_full2lite : plasoc_axi4_full2lite 
        generic map (
            axi_slave_id_width => axi_master_id_width,
            axi_address_width => axi_address_width,
            axi_data_width => axi_data_width)
        port map (
            aclk => aclk,                                   
            aresetn => peripheral_aresetn(0),
            s_axi_awid => gpio_axi_full_awid,
            s_axi_awaddr => gpio_axi_full_awaddr,
            s_axi_awlen => gpio_axi_full_awlen,
            s_axi_awsize => gpio_axi_full_awsize,
            s_axi_awburst => gpio_axi_full_awburst,
            s_axi_awlock => gpio_axi_full_awlock,
            s_axi_awcache => gpio_axi_full_awcache,
            s_axi_awprot => gpio_axi_full_awprot,
            s_axi_awqos => gpio_axi_full_awqos,
            s_axi_awregion => gpio_axi_full_awregion,
            s_axi_awvalid => gpio_axi_full_awvalid,
            s_axi_awready => gpio_axi_full_awready,
            s_axi_wdata => gpio_axi_full_wdata,
            s_axi_wstrb => gpio_axi_full_wstrb,
            s_axi_wlast => gpio_axi_full_wlast,
            s_axi_wvalid => gpio_axi_full_wvalid,
            s_axi_wready => gpio_axi_full_wready,
            s_axi_bid => gpio_axi_full_bid,
            s_axi_bresp => gpio_axi_full_bresp,
            s_axi_bvalid => gpio_axi_full_bvalid,
            s_axi_bready => gpio_axi_full_bready,
            s_axi_arid => gpio_axi_full_arid,
            s_axi_araddr => gpio_axi_full_araddr,
            s_axi_arlen => gpio_axi_full_arlen,
            s_axi_arsize => gpio_axi_full_arsize,
            s_axi_arburst => gpio_axi_full_arburst,
            s_axi_arlock => gpio_axi_full_arlock,
            s_axi_arcache => gpio_axi_full_arcache,
            s_axi_arprot => gpio_axi_full_arprot,
            s_axi_arqos => gpio_axi_full_arqos,
            s_axi_arregion => gpio_axi_full_arregion,
            s_axi_arvalid => gpio_axi_full_arvalid,
            s_axi_arready => gpio_axi_full_arready,
            s_axi_rid => gpio_axi_full_rid,
            s_axi_rdata => gpio_axi_full_rdata,
            s_axi_rresp => gpio_axi_full_rresp,
            s_axi_rlast => gpio_axi_full_rlast,
            s_axi_rvalid => gpio_axi_full_rvalid,
            s_axi_rready => gpio_axi_full_rready,
            m_axi_awaddr => gpio_axi_lite_awaddr,
            m_axi_awprot => gpio_axi_lite_awprot,
            m_axi_awvalid => gpio_axi_lite_awvalid,
            m_axi_awready => gpio_axi_lite_awready,
            m_axi_wvalid => gpio_axi_lite_wvalid,
            m_axi_wready => gpio_axi_lite_wready,
            m_axi_wdata => gpio_axi_lite_wdata,
            m_axi_wstrb => gpio_axi_lite_wstrb,
            m_axi_bvalid => gpio_axi_lite_bvalid,
            m_axi_bready => gpio_axi_lite_bready,
            m_axi_bresp => gpio_axi_lite_bresp,
            m_axi_araddr => gpio_axi_lite_araddr,
            m_axi_arprot => gpio_axi_lite_arprot,
            m_axi_arvalid => gpio_axi_lite_arvalid,
            m_axi_arready => gpio_axi_lite_arready,
            m_axi_rdata => gpio_axi_lite_rdata,
            m_axi_rvalid => gpio_axi_lite_rvalid,
            m_axi_rready => gpio_axi_lite_rready,
            m_axi_rresp => gpio_axi_lite_rresp);
                
    uart_main_full2lite : plasoc_axi4_full2lite 
        generic map (
            axi_slave_id_width => axi_master_id_width,
            axi_address_width => axi_address_width,
            axi_data_width => axi_data_width)
        port map (
            aclk => aclk,                                   
            aresetn => peripheral_aresetn(0),
            s_axi_awid => uart_axi_full_awid,
            s_axi_awaddr => uart_axi_full_awaddr,
            s_axi_awlen => uart_axi_full_awlen,
            s_axi_awsize => uart_axi_full_awsize,
            s_axi_awburst => uart_axi_full_awburst,
            s_axi_awlock => uart_axi_full_awlock,
            s_axi_awcache => uart_axi_full_awcache,
            s_axi_awprot => uart_axi_full_awprot,
            s_axi_awqos => uart_axi_full_awqos,
            s_axi_awregion => uart_axi_full_awregion,
            s_axi_awvalid => uart_axi_full_awvalid,
            s_axi_awready => uart_axi_full_awready,
            s_axi_wdata => uart_axi_full_wdata,
            s_axi_wstrb => uart_axi_full_wstrb,
            s_axi_wlast => uart_axi_full_wlast,
            s_axi_wvalid => uart_axi_full_wvalid,
            s_axi_wready => uart_axi_full_wready,
            s_axi_bid => uart_axi_full_bid,
            s_axi_bresp => uart_axi_full_bresp,
            s_axi_bvalid => uart_axi_full_bvalid,
            s_axi_bready => uart_axi_full_bready,
            s_axi_arid => uart_axi_full_arid,
            s_axi_araddr => uart_axi_full_araddr,
            s_axi_arlen => uart_axi_full_arlen,
            s_axi_arsize => uart_axi_full_arsize,
            s_axi_arburst => uart_axi_full_arburst,
            s_axi_arlock => uart_axi_full_arlock,
            s_axi_arcache => uart_axi_full_arcache,
            s_axi_arprot => uart_axi_full_arprot,
            s_axi_arqos => uart_axi_full_arqos,
            s_axi_arregion => uart_axi_full_arregion,
            s_axi_arvalid => uart_axi_full_arvalid,
            s_axi_arready => uart_axi_full_arready,
            s_axi_rid => uart_axi_full_rid,
            s_axi_rdata => uart_axi_full_rdata,
            s_axi_rresp => uart_axi_full_rresp,
            s_axi_rlast => uart_axi_full_rlast,
            s_axi_rvalid => uart_axi_full_rvalid,
            s_axi_rready => uart_axi_full_rready,
            m_axi_awaddr => uart_axi_lite_awaddr,
            m_axi_awprot => uart_axi_lite_awprot,
            m_axi_awvalid => uart_axi_lite_awvalid,
            m_axi_awready => uart_axi_lite_awready,
            m_axi_wvalid => uart_axi_lite_wvalid,
            m_axi_wready => uart_axi_lite_wready,
            m_axi_wdata => uart_axi_lite_wdata,
            m_axi_wstrb => uart_axi_lite_wstrb,
            m_axi_bvalid => uart_axi_lite_bvalid,
            m_axi_bready => uart_axi_lite_bready,
            m_axi_bresp => uart_axi_lite_bresp,
            m_axi_araddr => uart_axi_lite_araddr,
            m_axi_arprot => uart_axi_lite_arprot,
            m_axi_arvalid => uart_axi_lite_arvalid,
            m_axi_arready => uart_axi_lite_arready,
            m_axi_rdata => uart_axi_lite_rdata,
            m_axi_rvalid => uart_axi_lite_rvalid,
            m_axi_rready => uart_axi_lite_rready,
            m_axi_rresp => uart_axi_lite_rresp);
            
    lock_main_full2lite : plasoc_axi4_full2lite 
        generic map (
            axi_slave_id_width => axi_master_id_width,
            axi_address_width => axi_address_width,
            axi_data_width => axi_data_width)
        port map (
            aclk => aclk,                                   
            aresetn => peripheral_aresetn(0),
            s_axi_awid => lock_axi_full_awid,
            s_axi_awaddr => lock_axi_full_awaddr,
            s_axi_awlen => lock_axi_full_awlen,
            s_axi_awsize => lock_axi_full_awsize,
            s_axi_awburst => lock_axi_full_awburst,
            s_axi_awlock => lock_axi_full_awlock,
            s_axi_awcache => lock_axi_full_awcache,
            s_axi_awprot => lock_axi_full_awprot,
            s_axi_awqos => lock_axi_full_awqos,
            s_axi_awregion => lock_axi_full_awregion,
            s_axi_awvalid => lock_axi_full_awvalid,
            s_axi_awready => lock_axi_full_awready,
            s_axi_wdata => lock_axi_full_wdata,
            s_axi_wstrb => lock_axi_full_wstrb,
            s_axi_wlast => lock_axi_full_wlast,
            s_axi_wvalid => lock_axi_full_wvalid,
            s_axi_wready => lock_axi_full_wready,
            s_axi_bid => lock_axi_full_bid,
            s_axi_bresp => lock_axi_full_bresp,
            s_axi_bvalid => lock_axi_full_bvalid,
            s_axi_bready => lock_axi_full_bready,
            s_axi_arid => lock_axi_full_arid,
            s_axi_araddr => lock_axi_full_araddr,
            s_axi_arlen => lock_axi_full_arlen,
            s_axi_arsize => lock_axi_full_arsize,
            s_axi_arburst => lock_axi_full_arburst,
            s_axi_arlock => lock_axi_full_arlock,
            s_axi_arcache => lock_axi_full_arcache,
            s_axi_arprot => lock_axi_full_arprot,
            s_axi_arqos => lock_axi_full_arqos,
            s_axi_arregion => lock_axi_full_arregion,
            s_axi_arvalid => lock_axi_full_arvalid,
            s_axi_arready => lock_axi_full_arready,
            s_axi_rid => lock_axi_full_rid,
            s_axi_rdata => lock_axi_full_rdata,
            s_axi_rresp => lock_axi_full_rresp,
            s_axi_rlast => lock_axi_full_rlast,
            s_axi_rvalid => lock_axi_full_rvalid,
            s_axi_rready => lock_axi_full_rready,
            m_axi_awaddr => lock_axi_lite_awaddr,
            m_axi_awprot => lock_axi_lite_awprot,
            m_axi_awvalid => lock_axi_lite_awvalid,
            m_axi_awready => lock_axi_lite_awready,
            m_axi_wvalid => lock_axi_lite_wvalid,
            m_axi_wready => lock_axi_lite_wready,
            m_axi_wdata => lock_axi_lite_wdata,
            m_axi_wstrb => lock_axi_lite_wstrb,
            m_axi_bvalid => lock_axi_lite_bvalid,
            m_axi_bready => lock_axi_lite_bready,
            m_axi_bresp => lock_axi_lite_bresp,
            m_axi_araddr => lock_axi_lite_araddr,
            m_axi_arprot => lock_axi_lite_arprot,
            m_axi_arvalid => lock_axi_lite_arvalid,
            m_axi_arready => lock_axi_lite_arready,
            m_axi_rdata => lock_axi_lite_rdata,
            m_axi_rvalid => lock_axi_lite_rvalid,
            m_axi_rready => lock_axi_lite_rready,
            m_axi_rresp => lock_axi_lite_rresp);
            
    ----------------------
    -- CPUID GPIO Cores --
    ----------------------
    
    cpuid_gpio_0_inst : plasoc_gpio
        generic map (
            data_in_width => axi_data_width,
            data_out_width => 0,
            axi_address_width => axi_address_periph_width,
            axi_data_width => axi_data_width)
        port map (
            aclk => aclk,                                             
            aresetn => peripheral_aresetn(0),
            data_in => std_logic_vector(to_unsigned(0,axi_data_width)),
            data_out => open,
            axi_awaddr => cpuid_gpio_bus_0_lite_awaddr(axi_address_periph_width-1 downto 0),
            axi_awprot => cpuid_gpio_bus_0_lite_awprot,
            axi_awvalid => cpuid_gpio_bus_0_lite_awvalid,
            axi_awready => cpuid_gpio_bus_0_lite_awready,
            axi_wvalid => cpuid_gpio_bus_0_lite_wvalid,
            axi_wready => cpuid_gpio_bus_0_lite_wready,
            axi_wdata => cpuid_gpio_bus_0_lite_wdata,
            axi_wstrb => cpuid_gpio_bus_0_lite_wstrb,
            axi_bvalid => cpuid_gpio_bus_0_lite_bvalid,
            axi_bready => cpuid_gpio_bus_0_lite_bready,
            axi_bresp => cpuid_gpio_bus_0_lite_bresp,
            axi_araddr => cpuid_gpio_bus_0_lite_araddr(axi_address_periph_width-1 downto 0),
            axi_arprot => cpuid_gpio_bus_0_lite_arprot,
            axi_arvalid => cpuid_gpio_bus_0_lite_arvalid,
            axi_arready => cpuid_gpio_bus_0_lite_arready,
            axi_rdata => cpuid_gpio_bus_0_lite_rdata,
            axi_rvalid => cpuid_gpio_bus_0_lite_rvalid,
            axi_rready => cpuid_gpio_bus_0_lite_rready,
            axi_rresp => cpuid_gpio_bus_0_lite_rresp,
            int => open);
    
    cpuid_gpio_1_inst : plasoc_gpio
        generic map (
            data_in_width => axi_data_width,
            data_out_width => 0,
            axi_address_width => axi_address_periph_width,
            axi_data_width => axi_data_width)
        port map (
            aclk => aclk,                                             
            aresetn => peripheral_aresetn(0),
            data_in => std_logic_vector(to_unsigned(1,axi_data_width)),
            data_out => open,
            axi_awaddr => cpuid_gpio_bus_1_lite_awaddr(axi_address_periph_width-1 downto 0),
            axi_awprot => cpuid_gpio_bus_1_lite_awprot,
            axi_awvalid => cpuid_gpio_bus_1_lite_awvalid,
            axi_awready => cpuid_gpio_bus_1_lite_awready,
            axi_wvalid => cpuid_gpio_bus_1_lite_wvalid,
            axi_wready => cpuid_gpio_bus_1_lite_wready,
            axi_wdata => cpuid_gpio_bus_1_lite_wdata,
            axi_wstrb => cpuid_gpio_bus_1_lite_wstrb,
            axi_bvalid => cpuid_gpio_bus_1_lite_bvalid,
            axi_bready => cpuid_gpio_bus_1_lite_bready,
            axi_bresp => cpuid_gpio_bus_1_lite_bresp,
            axi_araddr => cpuid_gpio_bus_1_lite_araddr(axi_address_periph_width-1 downto 0),
            axi_arprot => cpuid_gpio_bus_1_lite_arprot,
            axi_arvalid => cpuid_gpio_bus_1_lite_arvalid,
            axi_arready => cpuid_gpio_bus_1_lite_arready,
            axi_rdata => cpuid_gpio_bus_1_lite_rdata,
            axi_rvalid => cpuid_gpio_bus_1_lite_rvalid,
            axi_rready => cpuid_gpio_bus_1_lite_rready,
            axi_rresp => cpuid_gpio_bus_1_lite_rresp,
            int => open);
            
    cpuid_gpio_2_inst : plasoc_gpio
        generic map (
            data_in_width => axi_data_width,
            data_out_width => 0,
            axi_address_width => axi_address_periph_width,
            axi_data_width => axi_data_width)
        port map (
            aclk => aclk,                                             
            aresetn => peripheral_aresetn(0),
            data_in => std_logic_vector(to_unsigned(2,axi_data_width)),
            data_out => open,
            axi_awaddr => cpuid_gpio_bus_2_lite_awaddr(axi_address_periph_width-1 downto 0),
            axi_awprot => cpuid_gpio_bus_2_lite_awprot,
            axi_awvalid => cpuid_gpio_bus_2_lite_awvalid,
            axi_awready => cpuid_gpio_bus_2_lite_awready,
            axi_wvalid => cpuid_gpio_bus_2_lite_wvalid,
            axi_wready => cpuid_gpio_bus_2_lite_wready,
            axi_wdata => cpuid_gpio_bus_2_lite_wdata,
            axi_wstrb => cpuid_gpio_bus_2_lite_wstrb,
            axi_bvalid => cpuid_gpio_bus_2_lite_bvalid,
            axi_bready => cpuid_gpio_bus_2_lite_bready,
            axi_bresp => cpuid_gpio_bus_2_lite_bresp,
            axi_araddr => cpuid_gpio_bus_2_lite_araddr(axi_address_periph_width-1 downto 0),
            axi_arprot => cpuid_gpio_bus_2_lite_arprot,
            axi_arvalid => cpuid_gpio_bus_2_lite_arvalid,
            axi_arready => cpuid_gpio_bus_2_lite_arready,
            axi_rdata => cpuid_gpio_bus_2_lite_rdata,
            axi_rvalid => cpuid_gpio_bus_2_lite_rvalid,
            axi_rready => cpuid_gpio_bus_2_lite_rready,
            axi_rresp => cpuid_gpio_bus_2_lite_rresp,
            int => open);
            
    -------------------
    -- CPU INT Cores --
    -------------------
    
    int_0_inst : plasoc_int
        generic map (
            axi_address_width => axi_address_periph_width,
            axi_data_width => axi_data_width,
            interrupt_total => axi_data_width)
        port map (
            aclk => aclk,
            aresetn => peripheral_aresetn(0),
            axi_awaddr => int_bus_0_lite_awaddr(axi_address_periph_width-1 downto 0),
            axi_awprot => int_bus_0_lite_awprot,
            axi_awvalid => int_bus_0_lite_awvalid,
            axi_awready => int_bus_0_lite_awready,
            axi_wvalid => int_bus_0_lite_wvalid,
            axi_wready => int_bus_0_lite_wready,
            axi_wdata => int_bus_0_lite_wdata,
            axi_wstrb => int_bus_0_lite_wstrb,
            axi_bvalid => int_bus_0_lite_bvalid,
            axi_bready => int_bus_0_lite_bready,
            axi_bresp => int_bus_0_lite_bresp,
            axi_araddr => int_bus_0_lite_araddr(axi_address_periph_width-1 downto 0),
            axi_arprot => int_bus_0_lite_arprot,
            axi_arvalid => int_bus_0_lite_arvalid,
            axi_arready => int_bus_0_lite_arready,
            axi_rdata => int_bus_0_lite_rdata,
            axi_rvalid => int_bus_0_lite_rvalid,
            axi_rready => int_bus_0_lite_rready,
            axi_rresp => int_bus_0_lite_rresp,
            cpu_int => cpu_0_int,
            dev_ints => dev_0_ints);
            
    int_1_inst : plasoc_int
        generic map (
            axi_address_width => axi_address_periph_width,
            axi_data_width => axi_data_width,
            interrupt_total => axi_data_width)
        port map (
            aclk => aclk,
            aresetn => peripheral_aresetn(0),
            axi_awaddr => int_bus_1_lite_awaddr(axi_address_periph_width-1 downto 0),
            axi_awprot => int_bus_1_lite_awprot,
            axi_awvalid => int_bus_1_lite_awvalid,
            axi_awready => int_bus_1_lite_awready,
            axi_wvalid => int_bus_1_lite_wvalid,
            axi_wready => int_bus_1_lite_wready,
            axi_wdata => int_bus_1_lite_wdata,
            axi_wstrb => int_bus_1_lite_wstrb,
            axi_bvalid => int_bus_1_lite_bvalid,
            axi_bready => int_bus_1_lite_bready,
            axi_bresp => int_bus_1_lite_bresp,
            axi_araddr => int_bus_1_lite_araddr(axi_address_periph_width-1 downto 0),
            axi_arprot => int_bus_1_lite_arprot,
            axi_arvalid => int_bus_1_lite_arvalid,
            axi_arready => int_bus_1_lite_arready,
            axi_rdata => int_bus_1_lite_rdata,
            axi_rvalid => int_bus_1_lite_rvalid,
            axi_rready => int_bus_1_lite_rready,
            axi_rresp => int_bus_1_lite_rresp,
            cpu_int => cpu_1_int,
            dev_ints => dev_1_ints);
            
    int_2_inst : plasoc_int
        generic map (
            axi_address_width => axi_address_periph_width,
            axi_data_width => axi_data_width,
            interrupt_total => axi_data_width)
        port map (
            aclk => aclk,
            aresetn => peripheral_aresetn(0),
            axi_awaddr => int_bus_2_lite_awaddr(axi_address_periph_width-1 downto 0),
            axi_awprot => int_bus_2_lite_awprot,
            axi_awvalid => int_bus_2_lite_awvalid,
            axi_awready => int_bus_2_lite_awready,
            axi_wvalid => int_bus_2_lite_wvalid,
            axi_wready => int_bus_2_lite_wready,
            axi_wdata => int_bus_2_lite_wdata,
            axi_wstrb => int_bus_2_lite_wstrb,
            axi_bvalid => int_bus_2_lite_bvalid,
            axi_bready => int_bus_2_lite_bready,
            axi_bresp => int_bus_2_lite_bresp,
            axi_araddr => int_bus_2_lite_araddr(axi_address_periph_width-1 downto 0),
            axi_arprot => int_bus_2_lite_arprot,
            axi_arvalid => int_bus_2_lite_arvalid,
            axi_arready => int_bus_2_lite_arready,
            axi_rdata => int_bus_2_lite_rdata,
            axi_rvalid => int_bus_2_lite_rvalid,
            axi_rready => int_bus_2_lite_rready,
            axi_rresp => int_bus_2_lite_rresp,
            cpu_int => cpu_2_int,
            dev_ints => dev_2_ints);
            
    ----------------------
    -- CPU Signal Cores --
    ----------------------
    
    signal_0_inst : koc_signal 
        generic map (
            axi_address_width => axi_address_periph_width,
            axi_data_width => axi_data_width)
        port map (
            aclk => aclk,
            aresetn => peripheral_aresetn(0),
            axi_awaddr => signal_bus_0_lite_awaddr(axi_address_periph_width-1 downto 0),
            axi_awprot => signal_bus_0_lite_awprot,
            axi_awvalid => signal_bus_0_lite_awvalid,
            axi_awready => signal_bus_0_lite_awready,
            axi_wvalid => signal_bus_0_lite_wvalid,
            axi_wready => signal_bus_0_lite_wready,
            axi_wdata => signal_bus_0_lite_wdata,
            axi_wstrb => signal_bus_0_lite_wstrb,
            axi_bvalid => signal_bus_0_lite_bvalid,
            axi_bready => signal_bus_0_lite_bready,
            axi_bresp => signal_bus_0_lite_bresp,
            axi_araddr => signal_bus_0_lite_araddr(axi_address_periph_width-1 downto 0),
            axi_arprot => signal_bus_0_lite_arprot,
            axi_arvalid => signal_bus_0_lite_arvalid,
            axi_arready => signal_bus_0_lite_arready,
            axi_rdata => signal_bus_0_lite_rdata,
            axi_rvalid => signal_bus_0_lite_rvalid,
            axi_rready => signal_bus_0_lite_rready,
            axi_rresp => signal_bus_0_lite_rresp,
            sig_out => sig_0_1,
            sig_in => '0',
            int => dev_0_ints(0));
            
    signal_1_inst : koc_signal 
        generic map (
            axi_address_width => axi_address_periph_width,
            axi_data_width => axi_data_width)
        port map (
            aclk => aclk,
            aresetn => peripheral_aresetn(0),
            axi_awaddr => signal_bus_1_lite_awaddr(axi_address_periph_width-1 downto 0),
            axi_awprot => signal_bus_1_lite_awprot,
            axi_awvalid => signal_bus_1_lite_awvalid,
            axi_awready => signal_bus_1_lite_awready,
            axi_wvalid => signal_bus_1_lite_wvalid,
            axi_wready => signal_bus_1_lite_wready,
            axi_wdata => signal_bus_1_lite_wdata,
            axi_wstrb => signal_bus_1_lite_wstrb,
            axi_bvalid => signal_bus_1_lite_bvalid,
            axi_bready => signal_bus_1_lite_bready,
            axi_bresp => signal_bus_1_lite_bresp,
            axi_araddr => signal_bus_1_lite_araddr(axi_address_periph_width-1 downto 0),
            axi_arprot => signal_bus_1_lite_arprot,
            axi_arvalid => signal_bus_1_lite_arvalid,
            axi_arready => signal_bus_1_lite_arready,
            axi_rdata => signal_bus_1_lite_rdata,
            axi_rvalid => signal_bus_1_lite_rvalid,
            axi_rready => signal_bus_1_lite_rready,
            axi_rresp => signal_bus_1_lite_rresp,
            sig_out => sig_1_2,
            sig_in => sig_0_1,
            int => dev_1_ints(0));
            
    signal_2_inst : koc_signal 
        generic map (
            axi_address_width => axi_address_periph_width,
            axi_data_width => axi_data_width)
        port map (
            aclk => aclk,
            aresetn => peripheral_aresetn(0),
            axi_awaddr => signal_bus_2_lite_awaddr(axi_address_periph_width-1 downto 0),
            axi_awprot => signal_bus_2_lite_awprot,
            axi_awvalid => signal_bus_2_lite_awvalid,
            axi_awready => signal_bus_2_lite_awready,
            axi_wvalid => signal_bus_2_lite_wvalid,
            axi_wready => signal_bus_2_lite_wready,
            axi_wdata => signal_bus_2_lite_wdata,
            axi_wstrb => signal_bus_2_lite_wstrb,
            axi_bvalid => signal_bus_2_lite_bvalid,
            axi_bready => signal_bus_2_lite_bready,
            axi_bresp => signal_bus_2_lite_bresp,
            axi_araddr => signal_bus_2_lite_araddr(axi_address_periph_width-1 downto 0),
            axi_arprot => signal_bus_2_lite_arprot,
            axi_arvalid => signal_bus_2_lite_arvalid,
            axi_arready => signal_bus_2_lite_arready,
            axi_rdata => signal_bus_2_lite_rdata,
            axi_rvalid => signal_bus_2_lite_rvalid,
            axi_rready => signal_bus_2_lite_rready,
            axi_rresp => signal_bus_2_lite_rresp,
            sig_out => open,
            sig_in => sig_1_2,
            int => dev_2_ints(0));
            
    -----------------------------
    -- Main Interconnect Cores --
    -----------------------------
        
    int_main_inst : plasoc_int
        generic map (
            axi_address_width => axi_address_periph_width,
            axi_data_width => axi_data_width,
            interrupt_total => axi_data_width)
        port map (
            aclk => aclk,
            aresetn => peripheral_aresetn(0),
            axi_awaddr => int_axi_lite_awaddr(axi_address_periph_width-1 downto 0),
            axi_awprot => int_axi_lite_awprot,
            axi_awvalid => int_axi_lite_awvalid,
            axi_awready => int_axi_lite_awready,
            axi_wvalid => int_axi_lite_wvalid,
            axi_wready => int_axi_lite_wready,
            axi_wdata => int_axi_lite_wdata,
            axi_wstrb => int_axi_lite_wstrb,
            axi_bvalid => int_axi_lite_bvalid,
            axi_bready => int_axi_lite_bready,
            axi_bresp => int_axi_lite_bresp,
            axi_araddr => int_axi_lite_araddr(axi_address_periph_width-1 downto 0),
            axi_arprot => int_axi_lite_arprot,
            axi_arvalid => int_axi_lite_arvalid,
            axi_arready => int_axi_lite_arready,
            axi_rdata => int_axi_lite_rdata,
            axi_rvalid => int_axi_lite_rvalid,
            axi_rready => int_axi_lite_rready,
            axi_rresp => int_axi_lite_rresp,
            cpu_int => dev_0_ints(1),
            dev_ints => dev_ints);
            
    timer_main_inst : plasoc_timer 
        generic map (
            timer_width => axi_data_width,
            axi_address_width => axi_address_periph_width,
            axi_data_width => axi_data_width)
        port map (
            aclk => aclk,
            aresetn => peripheral_aresetn(0),
            axi_awaddr => timer_axi_lite_awaddr(axi_address_periph_width-1 downto 0),
            axi_awprot => timer_axi_lite_awprot,
            axi_awvalid => timer_axi_lite_awvalid,
            axi_awready => timer_axi_lite_awready,
            axi_wvalid => timer_axi_lite_wvalid,
            axi_wready => timer_axi_lite_wready,
            axi_wdata => timer_axi_lite_wdata,
            axi_wstrb => timer_axi_lite_wstrb,
            axi_bvalid => timer_axi_lite_bvalid,
            axi_bready => timer_axi_lite_bready,
            axi_bresp => timer_axi_lite_bresp,
            axi_araddr => timer_axi_lite_araddr(axi_address_periph_width-1 downto 0),
            axi_arprot => timer_axi_lite_arprot,
            axi_arvalid => timer_axi_lite_arvalid,
            axi_arready => timer_axi_lite_arready,
            axi_rdata => timer_axi_lite_rdata,
            axi_rvalid => timer_axi_lite_rvalid,
            axi_rready => timer_axi_lite_rready,
            axi_rresp => timer_axi_lite_rresp,
            done => dev_ints(0));
            
    gpio_main_inst : plasoc_gpio
        generic map (
            data_in_width => data_in_width,
            data_out_width => data_out_width,
            axi_address_width => axi_address_periph_width,                   
            axi_data_width => axi_data_width)
        port map (
            aclk => aclk,
            aresetn => peripheral_aresetn(0),
            data_in => gpio_input,
            data_out => gpio_output,
            axi_awaddr => gpio_axi_lite_awaddr(axi_address_periph_width-1 downto 0),
            axi_awprot => gpio_axi_lite_awprot,
            axi_awvalid => gpio_axi_lite_awvalid,
            axi_awready => gpio_axi_lite_awready,
            axi_wvalid => gpio_axi_lite_wvalid,
            axi_wready => gpio_axi_lite_wready,
            axi_wdata => gpio_axi_lite_wdata,
            axi_wstrb => gpio_axi_lite_wstrb,
            axi_bvalid => gpio_axi_lite_bvalid,
            axi_bready => gpio_axi_lite_bready,
            axi_bresp => gpio_axi_lite_bresp,
            axi_araddr => gpio_axi_lite_araddr(axi_address_periph_width-1 downto 0),
            axi_arprot => gpio_axi_lite_arprot,
            axi_arvalid => gpio_axi_lite_arvalid,
            axi_arready => gpio_axi_lite_arready,
            axi_rdata => gpio_axi_lite_rdata,
            axi_rvalid => gpio_axi_lite_rvalid,
            axi_rready => gpio_axi_lite_rready,
            axi_rresp => gpio_axi_lite_rresp,
            int => dev_ints(1));
            
    uart_main_inst : plasoc_uart
        generic map (
            axi_address_width => axi_address_periph_width,
            axi_data_width => axi_data_width,
            baud => uart_baud,
            clock_frequency => uart_clock_frequency)
        port map (
            aclk => aclk,
            aresetn => peripheral_aresetn(0),
            axi_awaddr => uart_axi_lite_awaddr(axi_address_periph_width-1 downto 0),
            axi_awprot => uart_axi_lite_awprot,
            axi_awvalid => uart_axi_lite_awvalid,
            axi_awready => uart_axi_lite_awready,
            axi_wvalid => uart_axi_lite_wvalid,
            axi_wready => uart_axi_lite_wready,
            axi_wdata => uart_axi_lite_wdata,
            axi_wstrb => uart_axi_lite_wstrb,
            axi_bvalid => uart_axi_lite_bvalid,
            axi_bready => uart_axi_lite_bready,
            axi_bresp => uart_axi_lite_bresp,
            axi_araddr => uart_axi_lite_araddr(axi_address_periph_width-1 downto 0),
            axi_arprot => uart_axi_lite_arprot,
            axi_arvalid => uart_axi_lite_arvalid,
            axi_arready => uart_axi_lite_arready,
            axi_rdata => uart_axi_lite_rdata,
            axi_rvalid => uart_axi_lite_rvalid,
            axi_rready => uart_axi_lite_rready,
            axi_rresp => uart_axi_lite_rresp,
            tx => uart_tx,
            rx => uart_rx,
            status_in_avail => dev_ints(2));
            
    lock_main_inst : koc_lock
        generic map (
            axi_address_width => axi_address_periph_width,
            axi_data_width => axi_data_width,
            control_default => 1)
        port map (
            aclk => aclk,
            aresetn => peripheral_aresetn(0),
            axi_awaddr => lock_axi_lite_awaddr(axi_address_periph_width-1 downto 0),
            axi_awprot => lock_axi_lite_awprot,
            axi_awvalid => lock_axi_lite_awvalid,
            axi_awready => lock_axi_lite_awready,
            axi_wvalid => lock_axi_lite_wvalid,
            axi_wready => lock_axi_lite_wready,
            axi_wdata => lock_axi_lite_wdata,
            axi_wstrb => lock_axi_lite_wstrb,
            axi_bvalid => lock_axi_lite_bvalid,
            axi_bready => lock_axi_lite_bready,
            axi_bresp => lock_axi_lite_bresp,
            axi_araddr => lock_axi_lite_araddr(axi_address_periph_width-1 downto 0),
            axi_arprot => lock_axi_lite_arprot,
            axi_arvalid => lock_axi_lite_arvalid,
            axi_arready => lock_axi_lite_arready,
            axi_rdata => lock_axi_lite_rdata,
            axi_rvalid => lock_axi_lite_rvalid,
            axi_rready => lock_axi_lite_rready,
            axi_rresp => lock_axi_lite_rresp);
        
end Behavioral;
