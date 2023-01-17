----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/26/2022 08:35:14 PM
-- Design Name: 
-- Module Name: clock_enable - Behavioral
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

entity clock_enable is
    Port (clk : in std_logic;
         rst : in std_logic;
         ce : out std_logic);
end clock_enable;

architecture Behavioral of clock_enable is
    signal cmt : unsigned(21 downto 0);
begin

    process(rst, clk)
    begin
        if rst = '1' then
            cmt <= to_unsigned(0, 22);
        elsif rising_edge(clk) then
            cmt <= cmt + to_unsigned(1, 22);
        end if;
    end process;

    ce <= '1' when cmt = to_unsigned(0, 22) else '0';

end Behavioral;
