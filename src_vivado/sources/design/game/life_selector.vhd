----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/06/2023 02:58:38 PM
-- Design Name: 
-- Module Name: life_selector - Behavioral
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

entity life_selector is
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
end life_selector;

architecture Behavioral of life_selector is

begin

process(clk,rst)
begin
    if(rising_edge(clk)) then
        if(rst = '1') then 
            life_poke1  <= life_poke1_00  ;
            life_poke2  <= life_poke2_00  ;
        else
            case poke1 is
                when "00" =>
                    life_poke1  <= life_poke1_00  ;
                when "01" =>
                    life_poke1  <= life_poke1_01  ;
                when "10" =>
                    life_poke1  <= life_poke1_10  ;
                when "11" =>
                    life_poke1  <= life_poke1_11  ;
                when others =>
                    life_poke1  <= life_poke1_00  ;
           end case;
            case poke2 is
                when "00" =>
                    life_poke2  <= life_poke2_00  ;
                when "01" =>
                    life_poke2  <= life_poke2_01  ;
                when "10" =>
                    life_poke2  <= life_poke2_10  ;
                when "11" =>
                    life_poke2  <= life_poke2_11  ;
                when others =>
                    life_poke2  <= life_poke2_00  ;
           end case;
        end if;
    end if;    
    
end process;


end Behavioral;
