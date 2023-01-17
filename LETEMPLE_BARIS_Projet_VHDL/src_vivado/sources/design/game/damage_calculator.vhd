----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/02/2022 03:19:28 PM
-- Design Name: 
-- Module Name: damage_calculator - Behavioral
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

entity damage_calculator is
    Port ( stage : in std_logic_vector (3 downto 0);
           stab : in std_logic;
           atk_stat : in unsigned (6 downto 0);
           def_stat :in unsigned (6 downto 0);
           used_atk_stat :in unsigned (6 downto 0);
           type1_mult : in std_logic_vector (1 downto 0);
           type2_mult : in std_logic_vector (1 downto 0);
           damage : out unsigned (6 downto 0)
            );
end damage_calculator;

architecture Behavioral of damage_calculator is

signal damage_temp1,damage_temp2,damage_temp3,damage_temp4  : unsigned (6 downto 0);

begin

process(stage,used_atk_stat ,atk_stat,def_stat ,type1_mult ,type2_mult,damage_temp1,damage_temp2,damage_temp3,damage_temp4 )
begin

if stage = "0100" then
    damage_temp1 <= used_atk_stat + atk_stat - def_stat;
   if stab ='1' then
        damage_temp2 <= damage_temp1 + shift_right (damage_temp1,1) ; 
   else
        damage_temp2 <= damage_temp1 ;
   end if;
   
    if type1_mult = "01" then
        damage_temp3 <= shift_left (damage_temp2,1); 
    elsif type1_mult ="10" then
        damage_temp3 <= shift_right (damage_temp2,1);
    elsif type1_mult ="11" then
        damage_temp3 <= to_unsigned (0,7);
     else
        damage_temp3 <= damage_temp2 ;
    end if;
    if type2_mult = "01" then
        damage_temp4 <= shift_left (damage_temp3,1); 
    elsif type2_mult ="10" then
        damage_temp4 <= shift_right (damage_temp3,1);
    elsif type1_mult ="11" then
        damage_temp4 <= to_unsigned (0,7);
     else
        damage_temp4 <= damage_temp3 ;
    end if;
else
    damage_temp4 <= to_unsigned (0,7);
end if;

end process;


damage <= damage_temp4;

end Behavioral;
