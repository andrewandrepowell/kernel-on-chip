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
    constant clock_period : time := 10 ns;
    constant uart_period : time := 104167 ns;
    constant time_out_threshold : integer := 2**30;
    subtype gpio_type is std_logic_vector(data_out_width-1 downto 0);
    signal sys_clk_i : std_logic := '1';
    signal sys_rst : std_logic := '0';
    signal gpio_output : gpio_type;
    signal gpio_input : gpio_type := (others=>'0');
    signal uart_tx : std_logic;
    signal uart_clock : std_logic := '1';
    signal uart_tx_data_avail : std_logic := '0';
    signal uart_tx_data_ack : std_logic := '0';
    signal uart_tx_started : boolean := false;
    signal uart_tx_counter : integer range 0 to 8 := 0;
    signal uart_tx_buffer : std_logic_vector(7 downto 0) := (others=>'0');
    signal uart_tx_data : std_logic_vector(7 downto 0) := (others=>'0');
    signal uart_rx : std_logic;
    signal uart_rx_enable : std_logic := '0';
    signal uart_rx_done : std_logic := '0';
    signal uart_rx_data : std_logic_vector(7 downto 0) := (others=>'0');
    signal uart_rx_counter : integer range 0 to 9 := 0;
begin

    sys_clk_i <= not sys_clk_i after clock_period/2;
    sys_rst <= '1' after 10*clock_period;

    koc_wrapper_inst : koc_wrapper
        port map (
            sys_clk_i => sys_clk_i,
            sys_rst => sys_rst,
            gpio_output => gpio_output,
            gpio_input => gpio_input,
            uart_tx => uart_tx,
            uart_rx => uart_rx,
            DDR2_addr => open,
            DDR2_ba => open,
            DDR2_cas_n => open,
            DDR2_ck_n => open,
            DDR2_ck_p => open,
            DDR2_cke => open,
            DDR2_cs_n => open,
            DDR2_dm => open,
            DDR2_dq => open,
            DDR2_dqs_n => open,
            DDR2_dqs_p => open,
            DDR2_odt => open,
            DDR2_ras_n => open,
            DDR2_we_n => open);
            
    -- Get uart_tx
    uart_clock <= not uart_clock after uart_period/2;
    process (uart_clock)
    begin
        if rising_edge(uart_clock) then
            if uart_tx_started then
                uart_tx_counter <= uart_tx_counter+1;
                if uart_tx_counter=8 then
                    uart_tx_data <= uart_tx_buffer;
                    uart_tx_started <= false;
                else
                    uart_tx_buffer(uart_tx_counter) <= uart_tx;
                end if;
            elsif uart_tx='0' then
                uart_tx_started <= true;
                uart_tx_counter <= 0;
            end if;
            if uart_tx_data_ack='1' then
                uart_tx_data_avail <= '0';
            elsif uart_tx_started and uart_tx_counter=8 then
                uart_tx_data_avail <= '1';
            end if;
        end if;
    end process;
    
    -- Set uart_rx
    uart_rx_done <= '1' when uart_rx_counter=9 else '0';
    process (uart_clock)
    begin
        if rising_edge(uart_clock) then
            if uart_rx_enable='1' then
                if uart_rx_counter/=9 then
                    uart_rx_counter <= uart_rx_counter+1;
                    if uart_rx_counter=0 then
                        uart_rx <= '0';
                    elsif uart_rx_counter<= 8 then
                        uart_rx <= uart_rx_data(uart_rx_counter-1);
                    end if;
                else
                    uart_rx <= '1';
                end if;
            else
                uart_rx_counter <= 0;
                uart_rx <= '1';
            end if;
        end if;
    end process;
    
    -- Run testbench application.
    process 
        -- This procedure should force the simulation to stop if a 
        -- problem becomes apparent.
        procedure assert_procedure( state : boolean; mesg : string ) is
            variable breaksimulation : std_logic_vector(0 downto 0);
        begin
            if not state then
                assert False report mesg severity error;
                breaksimulation(1) := '1';
            end if;
        end;
        -- The procedure sets a single specified bit of the gpio input interface.
        procedure set_gpio_input( gpio_index : integer ) is
            variable gpio_input_buff : gpio_type := (others=>'0');
        begin
            gpio_input_buff(gpio_index) := '1';
            gpio_input <= gpio_input_buff;
            wait for clock_period;
        end;
        -- Waits for the corresponding output response. If it takes too long,
        -- it is assumed there is an error and the simulation should end as a result.
        procedure wait_for_gpio_output is
            variable assert_counter : integer := 0;
        begin
            while gpio_output/=gpio_input loop
                assert_procedure( state => assert_counter/=time_out_threshold, mesg => "Timeout occurred." );
                assert_counter := assert_counter+1;
                wait for clock_period;
            end loop;
            wait for clock_period;
        end;
    begin
        wait until sys_rst='1';
        wait until gpio_output=X"0001";
        wait for 500 us;
        gpio_input <= X"0003";
        wait for 2 ms;
        gpio_input <= X"00f3";
        wait for 2 ms;
        while True loop
            gpio_input <= X"00f1";
            wait for 50 us;
            gpio_input <= X"00f0";
            wait for 50 us;
            gpio_input <= X"00f5";
            wait for 50 us;
            gpio_input <= X"00ff";
            wait for 50 us;
            gpio_input <= X"05f7";
            wait for 50 us;
            gpio_input <= X"10f0";
            wait for 50 us;
        end loop;
        wait;
    end process;

end Behavioral;
