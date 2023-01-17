-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity Top_tb is
end;

architecture bench of Top_tb is

  component Top
      Port (clk          : in  std_logic;
           rst        : in  std_logic;
           MISO : in std_logic;
           VGA_hs       : out std_logic;
           VGA_vs       : out std_logic;
           VGA_red      : out std_logic_vector(3 downto 0);
           VGA_green    : out std_logic_vector(3 downto 0);
           VGA_blue     : out std_logic_vector(3 downto 0);
           MOSI : out std_logic;
           SS : out std_logic;
           SCLK : out std_logic
          );
  end component;

  signal clk: std_logic;
  signal rst: std_logic;
  signal MISO: std_logic;
  signal VGA_hs: std_logic;
  signal VGA_vs: std_logic;
  signal VGA_red: std_logic_vector(3 downto 0);
  signal VGA_green: std_logic_vector(3 downto 0);
  signal VGA_blue: std_logic_vector(3 downto 0);
  signal MOSI: std_logic;
  signal SS: std_logic;
  signal SCLK: std_logic ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: Top port map ( clk       => clk,
                      rst       => rst,
                      MISO      => MISO,
                      VGA_hs    => VGA_hs,
                      VGA_vs    => VGA_vs,
                      VGA_red   => VGA_red,
                      VGA_green => VGA_green,
                      VGA_blue  => VGA_blue,
                      MOSI      => MOSI,
                      SS        => SS,
                      SCLK      => SCLK );

  stimulus: process
  begin
  
    -- Put initialisation code here

    rst <= '1';
    wait for 5 ns;
    rst <= '0';
    wait for 5 ns;

    -- Put test bench stimulus code here

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