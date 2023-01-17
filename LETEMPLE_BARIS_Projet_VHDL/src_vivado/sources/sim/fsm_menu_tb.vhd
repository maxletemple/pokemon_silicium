----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.01.2023 18:21:52
-- Design Name: 
-- Module Name: fsm_menu_tb - Behavioral
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity fsm_menu_tb is
end;

architecture bench of fsm_menu_tb is

  component fsm_menu
      Port ( clk : in STD_LOGIC;
             rst : in STD_LOGIC;
             position : in std_logic_vector(1 downto 0) ;
             fwd : in STD_LOGIC;
             bwd : in STD_LOGIC;
             dead : in std_logic ;
             player : out STD_LOGIC;
             stage : out std_logic_vector (3 downto 0);
             poke1 : out std_logic_vector (1 downto 0);
             poke2 : out std_logic_vector (1 downto 0);
             atk : out std_logic_vector (1 downto 0));
  end component;

  signal clk: STD_LOGIC;
  signal rst: STD_LOGIC;
  signal position: std_logic_vector(1 downto 0);
  signal fwd: STD_LOGIC;
  signal bwd: STD_LOGIC;
  signal dead: std_logic;
  signal player: STD_LOGIC;
  signal stage: std_logic_vector (3 downto 0);
  signal poke1: std_logic_vector (1 downto 0);
  signal poke2: std_logic_vector (1 downto 0);
  signal atk: std_logic_vector (1 downto 0);

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: fsm_menu port map ( clk      => clk,
                           rst      => rst,
                           position => position,
                           fwd      => fwd,
                           bwd      => bwd,
                           dead     => dead,
                           player   => player,
                           stage    => stage,
                           poke1    => poke1,
                           poke2    => poke2,
                           atk      => atk );

  stimulus: process
  begin
  
    -- Put initialisation code here

   rst <= '0'; wait for clock_period;
    rst <= '1'; wait for clock_period * 3;
     rst <= '0'; wait for clock_period;
     fwd <= '1'; position <= "10"; wait for clock_period;
     fwd <= '0'; wait for clock_period;
       fwd <= '1'; wait for clock_period; wait for clock_period;
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
