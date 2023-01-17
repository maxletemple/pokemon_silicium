----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/06/2023 06:22:24 PM
-- Design Name: 
-- Module Name: efficiency_test - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity efficiency_test is
    Port (  type1_mult : in std_logic_vector  (1 downto 0);
            type2_mult : in std_logic_vector  (1 downto 0);
            efficiency : out std_logic_vector (1 downto 0) );
end efficiency_test;

architecture Behavioral of efficiency_test is

begin

process(type1_mult, type2_mult)

begin
case type1_mult is
    when "00" => --attaque normal
        case type2_mult is
            when "00" =>
                efficiency <= "00";
            when "01" =>
                efficiency <= "01";
            when "10" =>
                efficiency <= "10";
            when "11" =>
                efficiency <= "11";
            when others =>
                efficiency <= "00";
        end case;
    when "01" => -- tres efficace
        case type2_mult is
            when "00" =>
                efficiency <= "01";
            when "01" =>
                efficiency <= "01";
            when "10" =>
                efficiency <= "00";
            when "11" =>
                efficiency <= "11";
            when others =>
                efficiency <= "01";
        end case;
    when "10" => -- peu efficace
        case type2_mult is
            when "00" =>
                efficiency <= "10";
            when "01" =>
                efficiency <= "00";
            when "10" =>
                efficiency <= "10";
            when "11" =>
                efficiency <= "11";
            when others =>
                efficiency <= "10";
        end case;
    when "11" => -- pas affecté
        case type2_mult is
            when "00" =>
                efficiency <= "11";
            when "01" =>
                efficiency <= "11";
            when "10" =>
                efficiency <= "11";
            when "11" =>
                efficiency <= "11";
            when others =>
                efficiency <= "11";
        end case;
    when others =>
        efficiency <= "00";
end case;
end process;

end Behavioral;
