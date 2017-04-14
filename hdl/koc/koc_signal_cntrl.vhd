
library ieee;
use ieee.std_logic_1164.all;  

entity koc_signal_cntrl is
    port (
        aclk : in std_logic;
        aresetn : in std_Logic;
        sig_ack : in std_logic;
        sig_trig : in std_logic;
        sig_in : in std_logic;
        sig_out : out std_logic;
        int : out std_logic);
end koc_signal_cntrl;

architecture Behavioral of koc_signal_cntrl is
    signal sig_occurred : boolean := false;
    signal sig_out_buff : std_logic := '0';
    signal int_buff : std_logic := '0';
begin

    sig_out <= sig_out_buff;
    int <= int_buff;  

    process (aclk)
        variable sig_event : boolean;
    begin
        if rising_edge(aclk) then
            if aresetn='0' then
                sig_out_buff <= '0';
                sig_occurred <= false;
                int_buff <= '0';
            else
                sig_event := sig_in='1' or sig_trig='1';
                if sig_event and not sig_occurred then
                    sig_out_buff <= '1';
                else
                    sig_out_buff <= '0';
                end if;
                if sig_event then
                    sig_occurred <= true;
                else
                    sig_occurred <= false;
                end if;
                if sig_ack='1' then
                    int_buff <= '0';
                elsif sig_in='1' then
                    int_buff <= '1';
                end if;
            end if;
        end if;
    end process;

end Behavioral;
