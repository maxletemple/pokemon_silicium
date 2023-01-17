----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/01/2022 04:28:13 PM
-- Design Name: 
-- Module Name: Stats_Types - Behavioral
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
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Stats_Types is
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

end Stats_Types;



architecture Behavioral of Stats_Types is

signal poke1_type1, poke1_type2, poke1_type_atk1, poke2_type1, poke2_type2, poke2_type_atk1 : std_logic_vector  (4 downto 0);
signal poke1_stat_atk, poke1_stat_def, poke2_stat_atk, poke2_stat_def :unsigned (6 downto 0);
signal poke1_stat_atk1 , poke2_stat_atk1 : unsigned  (6 downto 0);
signal stab1, stab2 : std_logic ;

begin

process(poke1,poke2,atk,player)
begin
case poke1 is 
    when "00" =>
        poke1_type1 <= "00011";
        poke1_type2 <= "01000";
        poke1_stat_atk <= TO_UNSIGNED(12,7) ;
        poke1_stat_def <= TO_UNSIGNED(20,7) ;
            case atk is 
                when "00" =>
                    poke1_type_atk1 <="00110";
                    poke1_stat_atk1 <= TO_UNSIGNED(39,7);
                    stab1 <= '1';
                when "01" =>
                    poke1_type_atk1 <="00011";
                    poke1_stat_atk1 <= TO_UNSIGNED(16,7);
                    stab1 <= '1';
                when "10" =>
                    poke1_type_atk1 <="01111";
                    poke1_stat_atk1 <= TO_UNSIGNED(30,7);
                    stab1 <= '0';
                when "11" =>
                    poke1_type_atk1 <="00011";
                    poke1_stat_atk1 <= TO_UNSIGNED(42,7);
                    stab1 <= '1';
                when others =>
                    poke1_type_atk1 <="01000";
                    poke1_stat_atk1 <= TO_UNSIGNED(29,7);
                    stab1 <= '1';
            end case;
    when "01" =>
        poke1_type1 <= "01010";
        poke1_type2 <= "11111";
        poke1_stat_atk <= TO_UNSIGNED(13,7) ;
        poke1_stat_def <= TO_UNSIGNED(16,7) ;
            case atk is 
                when "00" =>
                    poke1_type_atk1 <="01010";
                    poke1_stat_atk1 <= TO_UNSIGNED(30,7);
                    stab1 <= '1';
                when "01" =>
                    poke1_type_atk1 <="00000";
                    poke1_stat_atk1 <= TO_UNSIGNED(33,7);
                    stab1 <= '0';
                when "10" =>
                    poke1_type_atk1 <="01010";
                    poke1_stat_atk1 <= TO_UNSIGNED(24,7);
                    stab1 <= '1';
                when "11" =>
                    poke1_type_atk1 <="00010";
                    poke1_stat_atk1 <= TO_UNSIGNED(30,7);
                    stab1 <= '0';
                when others =>
                    poke1_type_atk1 <="01010";
                    poke1_stat_atk1 <= TO_UNSIGNED(30,7);
                    stab1 <= '1';
            end case;
    when "10" =>
        poke1_type1 <= "00010";
        poke1_type2 <= "11111";
        poke1_stat_atk <= TO_UNSIGNED(12,7) ;
        poke1_stat_def <= TO_UNSIGNED(10,7) ;
            case atk is 
                when "00" =>
                    poke1_type_atk1 <="00101";
                    poke1_stat_atk1 <= TO_UNSIGNED(36,7);
                    stab1 <= '0';
                when "01" =>
                    poke1_type_atk1 <="01001";
                    poke1_stat_atk1 <= TO_UNSIGNED(24,7);
                    stab1 <= '0';
                when "10" =>
                    poke1_type_atk1 <="00000";
                    poke1_stat_atk1 <= TO_UNSIGNED(33,7);
                    stab1 <= '0';
                when "11" =>
                    poke1_type_atk1 <="00010";
                    poke1_stat_atk1 <= TO_UNSIGNED(45,7);
                    stab1 <= '1';
                when others =>
                    poke1_type_atk1 <="00101";
                    poke1_stat_atk1 <= TO_UNSIGNED(36,7);
                    stab1 <= '0';
            end case;
    when "11" =>
        poke1_type1 <= "01101";
        poke1_type2 <= "00111";
        poke1_stat_atk <= TO_UNSIGNED(13,7) ;
        poke1_stat_def <= TO_UNSIGNED(11,7) ;
            case atk is 
                when "00" =>
                    poke1_type_atk1 <="01101";
                    poke1_stat_atk1 <= TO_UNSIGNED(21,7);
                    stab1 <= '1';
                when "01" =>
                    poke1_type_atk1 <="00111";
                    poke1_stat_atk1 <= TO_UNSIGNED(36,7);
                    stab1 <= '1';
                when "10" =>
                    poke1_type_atk1 <="01111";
                    poke1_stat_atk1 <= TO_UNSIGNED(27,7);
                    stab1 <= '0';
                when "11" =>
                    poke1_type_atk1 <="00110";
                    poke1_stat_atk1 <= TO_UNSIGNED(42,7);
                    stab1 <= '0';
                when others =>
                    poke1_type_atk1 <="01101";
                    poke1_stat_atk1 <= TO_UNSIGNED(21,7);
                    stab1 <= '1';
            end case;
    when others =>
        poke1_type1 <= "00011";
        poke1_type2 <= "01000";
        poke1_stat_atk <= TO_UNSIGNED(12,7) ;
        poke1_stat_def <= TO_UNSIGNED(20,7) ;
            case atk is 
                when "00" =>
                    poke1_type_atk1 <="01000";
                    poke1_stat_atk1 <= TO_UNSIGNED(39,7);
                    stab1 <= '1';
                when "01" =>
                    poke1_type_atk1 <="00011";
                    poke1_stat_atk1 <= TO_UNSIGNED(19,7);
                    stab1 <= '1';
                when "10" =>
                    poke1_type_atk1 <="01111";
                    poke1_stat_atk1 <= TO_UNSIGNED(30,7);
                    stab1 <= '0';
                when "11" =>
                    poke1_type_atk1 <="00011";
                    poke1_stat_atk1 <= TO_UNSIGNED(42,7);
                    stab1 <= '1';
                when others =>
                    poke1_type_atk1 <="01000";
                    poke1_stat_atk1 <= TO_UNSIGNED(39,7);
                    stab1 <= '1';
            end case;
end case;
case poke2 is 
    when "00" =>
        poke2_type1 <= "00000";
        poke2_type2 <= "11111";
        poke2_stat_atk <= TO_UNSIGNED(7,7) ;
        poke2_stat_def <= TO_UNSIGNED(23,7) ;
            case atk is 
                when "00" =>
                    poke2_type_atk1 <="00000";
                    poke2_stat_atk1 <= TO_UNSIGNED(33,7);
                    stab2 <= '1';
                when "01" =>
                    poke2_type_atk1 <="01111";
                    poke2_stat_atk1 <= TO_UNSIGNED(36,7);
                    stab2 <= '0';
                when "10" =>
                    poke2_type_atk1 <="00000";
                    poke2_stat_atk1 <= TO_UNSIGNED(27,7);
                    stab2 <= '1';
                when "11" =>
                    poke2_type_atk1 <="01101";
                    poke2_stat_atk1 <= TO_UNSIGNED(39,7);
                    stab1 <= '0';
                when others =>
                    poke2_type_atk1 <="01000";
                    poke2_stat_atk1 <= TO_UNSIGNED(33,7);
                    stab2 <= '1';
            end case;
    when "01" =>
        poke2_type1 <= "01110";
        poke2_type2 <= "01001";
        poke2_stat_atk <= TO_UNSIGNED(18,7) ;
        poke2_stat_def <= TO_UNSIGNED(16,7) ;
            case atk is 
                when "00" =>
                    poke2_type_atk1 <="01001";
                    poke2_stat_atk1 <= TO_UNSIGNED(42,7);
                    stab2 <= '1';
                when "01" =>
                    poke2_type_atk1 <="00000";
                    poke2_stat_atk1 <= TO_UNSIGNED(39,7);
                    stab2 <= '0';
                when "10" =>
                    poke2_type_atk1 <="01110";
                    poke2_stat_atk1 <= TO_UNSIGNED(50,7);
                    stab2 <= '1';
                when "11" =>
                    poke2_type_atk1 <="01001";
                    poke2_stat_atk1 <= TO_UNSIGNED(30,7);
                    stab2 <= '1';
                when others =>
                    poke2_type_atk1 <="01001";
                    poke2_stat_atk1 <= TO_UNSIGNED(42,7);
                    stab2 <= '1';
            end case;
    when "10" =>
        poke2_type1 <= "00100";
        poke2_type2 <= "11111";
        poke2_stat_atk <= TO_UNSIGNED(13,7) ;
        poke2_stat_def <= TO_UNSIGNED(10,7) ;
            case atk is 
                when "00" =>
                    poke2_type_atk1 <="00100";
                    poke2_stat_atk1 <= TO_UNSIGNED(24,7);
                    stab2 <= '1';
                when "01" =>
                    poke2_type_atk1 <="10000";
                    poke2_stat_atk1 <= TO_UNSIGNED(36,7);
                    stab2 <= '0';
                when "10" =>
                    poke2_type_atk1 <="01100";
                    poke2_stat_atk1 <= TO_UNSIGNED(22,7);
                    stab2 <= '0';
                when "11" =>
                    poke2_type_atk1 <="01000";
                    poke2_stat_atk1 <= TO_UNSIGNED(39,7);
                    stab2 <= '0';
                when others =>
                    poke2_type_atk1 <="00100";
                    poke2_stat_atk1 <= TO_UNSIGNED(24,7);
                    stab2 <= '1';
            end case;
    when "11" =>
        poke2_type1 <= "00001";
        poke2_type2 <= "00110";
        poke2_stat_atk <= TO_UNSIGNED(15,7) ;
        poke2_stat_def <= TO_UNSIGNED(11,7) ;
            case atk is 
                when "00" =>
                    poke2_type_atk1 <="00000";
                    poke2_stat_atk1 <= TO_UNSIGNED(23,7);
                    stab2 <= '0';
                when "01" =>
                    poke2_type_atk1 <="00110";
                    poke2_stat_atk1 <= TO_UNSIGNED(36,7);
                    stab2 <= '1';
                when "10" =>
                    poke2_type_atk1 <="00001";
                    poke2_stat_atk1 <= TO_UNSIGNED(30,7);
                    stab2 <= '1';
                when "11" =>
                    poke2_type_atk1 <="00110";
                    poke2_stat_atk1 <= TO_UNSIGNED(40,7);
                    stab2 <= '1';
                when others =>
                    poke2_type_atk1 <="00000";
                    poke2_stat_atk1 <= TO_UNSIGNED(23,7);
                    stab2 <= '0';
            end case;
    when others =>
        poke2_type1 <= "00000";
        poke2_type2 <= "11111";
        poke2_stat_atk <= TO_UNSIGNED(7,7) ;
        poke2_stat_def <= TO_UNSIGNED(23,7) ;
            case atk is 
                when "00" =>
                    poke2_type_atk1 <="00000";
                    poke2_stat_atk1 <= TO_UNSIGNED(33,7);
                    stab2 <= '1';
                when "01" =>
                    poke2_type_atk1 <="01111";
                    poke2_stat_atk1 <= TO_UNSIGNED(36,7);
                    stab2 <= '0';
                when "10" =>
                    poke2_type_atk1 <="00000";
                    poke2_stat_atk1 <= TO_UNSIGNED(27,7);
                    stab2 <= '1';
                when "11" =>
                    poke2_type_atk1 <="01101";
                    poke2_stat_atk1 <= TO_UNSIGNED(39,7);
                    stab2 <= '0';
                when others =>
                    poke2_type_atk1 <="01000";
                    poke2_stat_atk1 <= TO_UNSIGNED(33,7);
                    stab2 <= '1';
            end case;
end case;
end process;

stab <= stab1 when player='0' else stab2;
atk_stat <= poke1_stat_atk  when player='0' else poke2_stat_atk;
def_stat <= poke2_stat_def when player = '0' else poke1_stat_def;
used_atk_stat  <= poke1_stat_atk1  when player = '0' else poke2_stat_atk1;
used_atk_type  <= poke1_type_atk1 when player = '0' else poke2_type_atk1;
def_type1 <= poke2_type1 when player = '0' else poke1_type1;
def_type2 <= poke2_type2 when player = '0' else poke1_type2;

end Behavioral;
