----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/09/2022 02:21:29 PM
-- Design Name: 
-- Module Name: life_register - Behavioral
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

entity life_register is
  Port (    clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            base_life : in unsigned (6 downto 0);
            enable : in std_logic;
            damage : in unsigned (6 downto 0);
            dead : out std_logic ;
            life : out unsigned (6 downto 0));
end life_register;

architecture Behavioral of life_register is

signal life_temp : unsigned (6 downto 0);

begin

process(clk,rst)
begin
    if(rising_edge(clk)) then
        if(rst = '1') then 
            life_temp <= base_life ;
            dead <= '0';
        elsif enable = '1' then
            if damage >= life_temp then
                life_temp <= TO_UNSIGNED(0,7);
                dead <= '1';
            else
                life_temp <= life_temp - damage;
            end if;
        else
            life_temp <= life_temp;
        end if;
    end if;    
    
end process;

life <= life_temp;

end Behavioral;
