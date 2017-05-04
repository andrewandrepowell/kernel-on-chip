library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 
use work.plasoc_gpio_pack.all;

entity koc_lock_axi4_read_cntrl is
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
end koc_lock_axi4_read_cntrl;

architecture Behavioral of koc_lock_axi4_read_cntrl is
    type state_type is (state_wait,state_read);
    signal state : state_type := state_wait;
    signal axi_arready_buff : std_logic := '0';
    signal axi_rvalid_buff : std_logic := '0';
    signal axi_araddr_buff : std_logic_vector(axi_address_width-1 downto 0);
begin
    axi_arready <= axi_arready_buff;
    axi_rvalid <= axi_rvalid_buff;
    axi_rresp <= axi_resp_okay;

    process (aclk)
    begin
        if rising_edge(aclk) then
            if aresetn='0' then
                axi_arready_buff <= '0';
                axi_rvalid_buff <= '0';
                state <= state_wait;
            else
                case state is
                when state_wait=>
                    if axi_arvalid='1' and axi_arready_buff='1' then
                        axi_arready_buff <= '0';
                        axi_rvalid_buff <= '1';
                        state <= state_read;
                        if axi_araddr=reg_control_offset then 
                            axi_rdata <= reg_control;
                        else
                            axi_rdata <= (others=>'0');
                        end if;
                    else
                        axi_arready_buff <= '1';
                    end if;
                when state_read=>
                    if axi_rvalid_buff='1' and axi_rready='1' then
                        axi_rvalid_buff <= '0';
                        state <= state_wait;
                    end if;
                end case;
            end if;
        end if;
    end process;
    
end Behavioral;
