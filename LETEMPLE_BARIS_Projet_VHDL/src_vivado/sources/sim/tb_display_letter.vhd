-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity display_letter_tb is
end;

architecture bench of display_letter_tb is

  component display_letter
      Port (rst : in std_logic;
           clk : in std_logic;
           enable : in std_logic;
           addr_letter : in std_logic_vector(6 downto 0);
           addr_start : in std_logic_vector(15 downto 0);
           data_out_letter : out std_logic_vector(7 downto 0);
           addr_out_letter : out std_logic_vector(15 downto 0);
           done : out std_logic);
  end component;

  signal rst: std_logic;
  signal clk: std_logic;
  signal enable: std_logic;
  signal addr_letter: std_logic_vector(6 downto 0);
  signal addr_start: std_logic_vector(15 downto 0);
  signal data_out_letter: std_logic_vector(7 downto 0);
  signal addr_out_letter: std_logic_vector(15 downto 0);
  signal done: std_logic;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: display_letter port map ( rst             => rst,
                                 clk             => clk,
                                 enable          => enable,
                                 addr_letter     => addr_letter,
                                 addr_start      => addr_start,
                                 data_out_letter => data_out_letter,
                                 addr_out_letter => addr_out_letter,
                                 done            => done );

  stimulus: process
  begin
  
    -- Put initialisation code here

    rst <= '1';
    wait for 5 ns;
    rst <= '0';
    wait for 5 ns;
    
    addr_letter <= "0000000";
    addr_start <= std_logic_vector(to_unsigned(1050, 16));
    enable <= '0';
    -- Put test bench stimulus code here
    wait for clock_period * 10;
    enable <= '1';
    wait for clock_period * 3;
    enable <= '0';
    
    
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      clk <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;