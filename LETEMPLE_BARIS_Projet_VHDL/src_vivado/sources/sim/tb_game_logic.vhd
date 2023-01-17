-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity game_logic_top_tb is
end;

architecture bench of game_logic_top_tb is

  component game_logic_top
      Port ( clk : in STD_LOGIC;
             rst : in STD_LOGIC;
             left : in STD_LOGIC;
             up : in STD_LOGIC;
             down : in STD_LOGIC;
             right : in STD_LOGIC;
             fwd : in STD_LOGIC;
             bwd : in STD_LOGIC;
             player : out STD_LOGIC;
             stage : out std_logic_vector (3 downto 0);
             poke1 : out std_logic_vector (1 downto 0);
             poke2 : out std_logic_vector (1 downto 0);
             atk : out std_logic_vector (1 downto 0);
             efficiency : out std_logic_vector (1 downto 0);
             life_poke1 : out unsigned (6 downto 0);
             life_poke2 : out unsigned (6 downto 0));
  end component;

  signal clk: STD_LOGIC;
  signal rst: STD_LOGIC;
  signal left: STD_LOGIC;
  signal up: STD_LOGIC;
  signal down: STD_LOGIC;
  signal right: STD_LOGIC;
  signal fwd: STD_LOGIC;
  signal bwd: STD_LOGIC;
  signal player: STD_LOGIC;
  signal stage: std_logic_vector (3 downto 0);
  signal poke1: std_logic_vector (1 downto 0);
  signal poke2: std_logic_vector (1 downto 0);
  signal atk: std_logic_vector (1 downto 0);
  signal efficiency: std_logic_vector (1 downto 0);
  signal life_poke1: unsigned (6 downto 0);
  signal life_poke2: unsigned (6 downto 0);

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: game_logic_top port map ( clk        => clk,
                                 rst        => rst,
                                 left       => left,
                                 up         => up,
                                 down       => down,
                                 right      => right,
                                 fwd        => fwd,
                                 bwd        => bwd,
                                 player     => player,
                                 stage      => stage,
                                 poke1      => poke1,
                                 poke2      => poke2,
                                 atk        => atk,
                                 efficiency => efficiency,
                                 life_poke1 => life_poke1,
                                 life_poke2 => life_poke2 );

  stimulus: process
  begin
  
    -- Put initialisation code here

    rst <= '1';
    wait for 5 ns;
    rst <= '0';
    wait for 5 ns;

    -- Put test bench stimulus code here

    stop_the_clock <= true;
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