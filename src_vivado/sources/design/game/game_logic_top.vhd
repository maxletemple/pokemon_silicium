----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/06/2023 03:32:07 PM
-- Design Name: 
-- Module Name: game_logic_top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity game_logic_top is
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
           position : out std_logic_vector (1 downto 0);
           atk : out std_logic_vector (1 downto 0);
           efficiency : out std_logic_vector (1 downto 0);
           life_poke1 : out unsigned (6 downto 0);
           life_poke2 : out unsigned (6 downto 0));
end game_logic_top;

architecture Behavioral of game_logic_top is

component Input2Position is
  Port (   clk : in std_logic;
           rst : in std_logic;
           left : in STD_LOGIC;
           up : in STD_LOGIC;
           down : in STD_LOGIC;
           right : in STD_LOGIC;
           position : out std_logic_vector (1 downto 0));
end component;

component fsm_menu is
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

component Stats_Types is
    Port ( player : in std_logic ;
           poke1 : in std_logic_vector (1 downto 0);
           poke2 : in std_logic_vector (1 downto 0);
           atk : in std_logic_vector (1 downto 0);
           stab : out std_logic;
           atk_stat : out unsigned (6 downto 0);
           def_stat :out unsigned  (6 downto 0);
           used_atk_stat :out unsigned (6 downto 0);
           used_atk_type :out  std_logic_vector  (4 downto 0);
           def_type1 :out std_logic_vector  (4 downto 0);
           def_type2 :out std_logic_vector  (4 downto 0));

end component;

component type_table is
    Port (  atk_type : in std_logic_vector  (4 downto 0);
            def_type : in std_logic_vector  (4 downto 0);
            type_mult : out std_logic_vector (1 downto 0) );
end component;

component damage_calculator is
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


component efficiency_test is
    Port (  type1_mult : in std_logic_vector  (1 downto 0);
            type2_mult : in std_logic_vector  (1 downto 0);
            efficiency : out std_logic_vector (1 downto 0) );
end component;

component life_enabler is
    Port (
          clk : in std_logic;
          rst : in std_logic;
          stage : in std_logic_vector(3 downto 0);
          player : in std_logic; 
          poke1 : in std_logic_vector(1 downto 0);
          poke2 : in std_logic_vector(1 downto 0);
          enable1_00 : out std_logic;
          enable1_01 : out std_logic;
          enable1_10 : out std_logic;
          enable1_11 : out std_logic;
          enable2_00 : out std_logic;
          enable2_01 : out std_logic;
          enable2_10 : out std_logic;
          enable2_11 : out std_logic);
end component;

component life_register is
  Port (    clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            base_life : in unsigned (6 downto 0);
            enable : in std_logic;
            damage : in unsigned (6 downto 0);
            dead : out std_logic ;
            life : out unsigned (6 downto 0));
end component;

component one_dead_tester is
  Port ( 
          clk : in std_logic;
          rst : in std_logic;
          poke1 : in std_logic_vector (1 downto 0);
          poke2 : in std_logic_vector (1 downto 0);
          dead1_00 : in std_logic;
          dead1_01 : in std_logic;
          dead1_10 : in std_logic;
          dead1_11 : in std_logic;
          dead2_00 : in std_logic;
          dead2_01 : in std_logic;
          dead2_10 : in std_logic;
          dead2_11 : in std_logic;
          dead : out std_logic);
end component;

component life_selector is
    Port (  clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            life_poke1_00 : in unsigned (6 downto 0);
            life_poke1_01 : in unsigned (6 downto 0); 
            life_poke1_10 : in unsigned (6 downto 0); 
            life_poke1_11 : in unsigned (6 downto 0);
            life_poke2_00 : in unsigned (6 downto 0); 
            life_poke2_01 : in unsigned (6 downto 0); 
            life_poke2_10 : in unsigned (6 downto 0);
            life_poke2_11 : in unsigned (6 downto 0);
            poke1 : in std_logic_vector (1 downto 0);
            poke2 : in std_logic_vector (1 downto 0); 
            life_poke1 : out unsigned (6 downto 0);
            life_poke2 : out unsigned (6 downto 0));
end component;

signal position_temp, poke1_temp, poke2_temp, atk_temp, type1_mult, type2_mult  : std_logic_vector (1 downto 0);
signal dead, player_temp, stab: std_logic;
signal enable1_00,enable1_01,enable1_10,enable1_11,enable2_00,enable2_01,enable2_10,enable2_11: std_logic;
signal dead1_00,dead1_01,dead1_10,dead1_11,dead2_00,dead2_01,dead2_10,dead2_11: std_logic;
signal life_poke1_00,life_poke1_01,life_poke1_10,life_poke1_11,life_poke2_00,life_poke2_01,life_poke2_10,life_poke2_11:  unsigned (6 downto 0);
signal stage_temp : std_logic_vector (3 downto 0);
signal atk_stat, def_stat, used_atk_stat, damage : unsigned (6 downto 0);
signal used_atk_type,def_type1,def_type2:std_logic_vector (4 downto 0);

begin

position_convertisor : Input2Position port map(clk => clk, rst => rst ,left => left ,up => up ,down => down, right => right , position => position_temp);
fsm : fsm_menu port map(clk => clk, rst => rst ,position => position_temp ,fwd => fwd ,bwd => bwd, dead => dead , player => player_temp, stage => stage_temp, poke1 => poke1_temp, poke2 => poke2_temp,atk => atk_temp );
stat_table : Stats_Types port map( player => player_temp , poke1 => poke1_temp, poke2 => poke2_temp, atk => atk_temp, stab => stab, atk_stat => atk_stat, def_stat => def_stat, used_atk_stat => used_atk_stat, used_atk_type => used_atk_type, def_type1 => def_type1, def_type2 => def_type2);
type_mult_1 : type_table  port map (atk_type => used_atk_type, def_type => def_type1, type_mult => type1_mult );
type_mult_2 : type_table  port map (atk_type => used_atk_type, def_type => def_type2, type_mult => type2_mult );
damage_calcul : damage_calculator port map(stage => stage_temp, stab => stab, atk_stat => atk_stat, def_stat  => def_stat, used_atk_stat => used_atk_stat, type1_mult => type1_mult, type2_mult => type2_mult, damage => damage);  
efficiency_info : efficiency_test port map (type1_mult => type1_mult,type2_mult => type2_mult, efficiency => efficiency );
enable_life : life_enabler port map (clk => clk, rst => rst,  stage => stage_temp, player => player_temp , poke1 => poke1_temp, poke2 => poke2_temp, enable1_00 => enable1_00, enable1_01 => enable1_01,enable1_10 => enable1_10,enable1_11 => enable1_11, enable2_00 => enable2_00, enable2_01 => enable2_01,enable2_10 => enable2_10,enable2_11 => enable2_11);
life_register1_00 : life_register port map(clk => clk, rst => rst, base_life => to_unsigned(100,7) , enable => enable1_00,damage => damage, dead => dead1_00, life => life_poke1_00);
life_register1_01 : life_register port map(clk => clk, rst => rst, base_life => to_unsigned(100,7) , enable => enable1_01,damage => damage, dead => dead1_01, life => life_poke1_01);
life_register1_10 : life_register port map(clk => clk, rst => rst, base_life => to_unsigned(100,7) , enable => enable1_10,damage => damage, dead => dead1_10, life => life_poke1_10);
life_register1_11 : life_register port map(clk => clk, rst => rst, base_life => to_unsigned(100,7) , enable => enable1_11,damage => damage, dead => dead1_11, life => life_poke1_11);
life_register2_00 : life_register port map(clk => clk, rst => rst, base_life => to_unsigned(100,7) , enable => enable2_00,damage => damage, dead => dead2_00, life => life_poke2_00);
life_register2_01 : life_register port map(clk => clk, rst => rst, base_life => to_unsigned(100,7) , enable => enable2_01,damage => damage, dead => dead2_01, life => life_poke2_01);
life_register2_10 : life_register port map(clk => clk, rst => rst, base_life => to_unsigned(100,7) , enable => enable2_10,damage => damage, dead => dead2_10, life => life_poke2_10);
life_register2_11 : life_register port map(clk => clk, rst => rst, base_life => to_unsigned(100,7) , enable => enable2_11,damage => damage, dead => dead2_11, life => life_poke2_11);
dead_tester : one_dead_tester port map (clk => clk, rst => rst, poke1 => poke1_temp, poke2 => poke2_temp, dead1_00 => dead1_00, dead1_01 => dead1_01, dead1_10 => dead1_10, dead1_11 => dead1_11, dead2_00 => dead2_00, dead2_01 => dead2_01, dead2_10 => dead2_10, dead2_11 => dead2_11, dead => dead);
life_selection : life_selector port map ( clk => clk, rst => rst, poke1 => poke1_temp, poke2 => poke2_temp, life_poke1_00 => life_poke1_00, life_poke1_01=> life_poke1_01, life_poke1_10 => life_poke1_10, life_poke1_11 => life_poke1_11,life_poke2_00 => life_poke2_00, life_poke2_01=> life_poke2_01, life_poke2_10 => life_poke2_10, life_poke2_11 => life_poke2_11, life_poke1=> life_poke1 , life_poke2 => life_poke2 );

stage <= stage_temp;
poke1 <= poke1_temp;
poke2 <= poke2_temp;
atk <= atk_temp;
position <= position_temp;
player <= player_temp;

end Behavioral;
