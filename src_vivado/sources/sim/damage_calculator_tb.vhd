--- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity damage_calculator_tb is
end;

architecture bench of damage_calculator_tb is

  component damage_calculator
      Port ( stage : in std_logic_vector (3 downto 0);
             stab : in std_logic;
             atk_stat : in unsigned (6 downto 0);
             def_stat :in unsigned (6 downto 0);
             used_atk_stat :in unsigned (6 downto 0);
             type1_mult : in std_logic_vector (1 downto 0);
             type2_mult : in std_logic_vector (1 downto 0);
             damage : out unsigned (6 downto 0)
              );
  end component;

  signal stage: std_logic_vector (3 downto 0);
  signal stab: std_logic;
  signal atk_stat: unsigned (6 downto 0);
  signal def_stat: unsigned (6 downto 0);
  signal used_atk_stat: unsigned (6 downto 0);
  signal type1_mult: std_logic_vector (1 downto 0);
  signal type2_mult: std_logic_vector (1 downto 0);
  signal damage: unsigned (6 downto 0) ;

begin

  uut: damage_calculator port map ( stage         => stage,
                                    stab          => stab,
                                    atk_stat      => atk_stat,
                                    def_stat      => def_stat,
                                    used_atk_stat => used_atk_stat,
                                    type1_mult    => type1_mult,
                                    type2_mult    => type2_mult,
                                    damage        => damage );

  stimulus: process
  begin
  
stage <= "0100";
stab <= '1';
atk_stat <= TO_UNSIGNED(12,7);
def_stat <=TO_UNSIGNED(23,7);
used_atk_stat <= TO_UNSIGNED(13,7);
type1_mult <= "00";
type2_mult <= "00";

    wait;
  end process;


end;