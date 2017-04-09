library ieee;
use ieee.std_logic_1164.all;   
use ieee.numeric_std.all;    
use work.koc_lock_pack.all;

entity koc_lock_axi4_write_cntrl is
    generic (
        axi_address_width : integer := 16;
        axi_data_width : integer := 32;
        reg_control_offset : std_logic_vector := X"0000"
    );
    port (
        aclk : in std_logic;                                                --! Clock. Tested with 50 MHz.
        aresetn : in std_logic; 
        axi_awaddr : in std_logic_vector(axi_address_width-1 downto 0);     --! AXI4-Lite Address Write signal.
        axi_awprot : in std_logic_vector(2 downto 0);                       --! AXI4-Lite Address Write signal.
        axi_awvalid : in std_logic;                                         --! AXI4-Lite Address Write signal.
        axi_awready : out std_logic;                                        --! AXI4-Lite Address Write signal.
        axi_wvalid : in std_logic;                                          --! AXI4-Lite Write Data signal.
        axi_wready : out std_logic;                                         --! AXI4-Lite Write Data signal.
        axi_wdata : in std_logic_vector(axi_data_width-1 downto 0);         --! AXI4-Lite Write Data signal.
        axi_wstrb : in std_logic_vector(axi_data_width/8-1 downto 0);       --! AXI4-Lite Write Data signal.
        axi_bvalid : out std_logic;                                         --! AXI4-Lite Write Response signal.
        axi_bready : in std_logic;                                          --! AXI4-Lite Write Response signal.
        axi_bresp : out std_logic_vector(1 downto 0);                       --! AXI4-Lite Write Response signal.
        reg_control : out std_logic_vector(axi_data_width-1 downto 0)
    );
end koc_lock_axi4_write_cntrl;

architecture Behavioral of koc_lock_axi4_write_cntrl is
    type state_type is (state_wait,state_write,state_response);
    signal state : state_type := state_wait;
    signal axi_awready_buff : std_logic := '0';
    signal axi_awaddr_buff : std_logic_vector(axi_address_width-1 downto 0);
    signal axi_wready_buff : std_logic := '0';
    signal axi_bvalid_buff : std_logic := '0';
    signal reg_control_buff : std_logic_vector(axi_data_width-1 downto 0) := (others=>'0');
begin
    axi_awready <= axi_awready_buff;
    axi_wready <= axi_wready_buff;
    axi_bvalid <= axi_bvalid_buff;
    axi_bresp <= axi_resp_okay;
    
    reg_control <= reg_control_buff;

     -- Drive the axi write interface.
    process (aclk)
        variable reg_control_var : std_logic_vector(axi_data_width-1 downto 0);
    begin
        -- Perform operations on the clock's positive edge.
        if rising_edge(aclk) then
            if aresetn='0' then
                axi_awready_buff <= '0';
                axi_wready_buff <= '0';
                axi_bvalid_buff <= '0';
                reg_control_buff <= (others=>'0');
                state <= state_wait;
            else
                case state is
                when state_wait=>
                    if axi_awvalid='1' and axi_awready_buff='1' then
                        axi_awready_buff <= '0';
                        axi_awaddr_buff <= axi_awaddr;
                        axi_wready_buff <= '1';
                        state <= state_write;
                    else
                        axi_awready_buff <= '1';
                    end if;
                when state_write=>
                    if axi_wvalid='1' and axi_wready_buff='1' then
                        axi_wready_buff <= '0';
                        
                        -- Determine control value from device requesting lock.
                        reg_control_var := (others=>'0');
                        for each_byte in 0 to axi_data_width/8-1 loop
                            if axi_awaddr_buff=reg_control_offset and axi_wstrb(each_byte)='1' then
                                reg_control_var(7+each_byte*8 downto each_byte*8) :=
                                    axi_wdata(7+each_byte*8 downto each_byte*8);
                            end if;
                        end loop;
                        
                        -- Perform lock if lock is available, or release it.
                        if reg_control_buff=reg_control_var then
                            reg_control_buff <= (others=>'0');
                        elsif reg_control_buff=std_logic_vector(to_unsigned(0,axi_data_width)) then
                            reg_control_buff <= reg_control_var;
                        end if;
                        
                        state <= state_response;
                        axi_bvalid_buff <= '1';
                    end if;
                when state_response=>
                    if axi_bvalid_buff='1' and axi_bready='1' then
                        state <= state_wait;
                    end if;
                end case;
            end if;
        end if;
    end process;  

end Behavioral;
