-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 17.11.2022 15:54:03 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_counter_mod_n_enable is
end tb_counter_mod_n_enable;

architecture tb of tb_counter_mod_n_enable is

    component counter_mod_n_enable
        generic (n_bits : integer;
            n_mod : integer);
        port (clk    : in std_logic;
              rst    : in std_logic;
              enable : in std_logic;
              output : out std_logic_vector (n_bits - 1 downto 0));
    end component;

    signal clk    : std_logic;
    signal rst    : std_logic;
    signal enable : std_logic;
    signal output : std_logic_vector (7 downto 0);

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : counter_mod_n_enable
    generic map (n_bits => 8,
                 n_mod => 100)
    port map (clk    => clk,
              rst    => rst,
              enable => enable,
              output => output);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        enable <= '1';

        -- Reset generation
        -- EDIT: Check that rst is really your reset signal
        rst <= '1';
        wait for TbPeriod * 2;
        rst <= '0';
        wait for TbPeriod ;

        -- EDIT Add stimuli here
        wait for 1000000 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;