----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/28/2022 04:23:17 PM
-- Design Name: 
-- Module Name: Counter 16000 - Behavioral
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

entity counter_display is
  Port (clk : in std_logic;
        rst : in std_logic;
        addr_out : out std_logic_vector(15 downto 0);
        val_x : out std_logic_vector(8 downto 0);
        val_y : out std_logic_vector(8 downto 0));
end counter_display;

architecture Behavioral of counter_display is

signal cmt : unsigned(15 downto 0);
signal cmt_val_x : unsigned(8 downto 0);
signal cmt_val_y : unsigned(8 downto 0);
begin

process(rst, clk)
begin
    if rising_edge(clk) then
        if rst = '1' then
            cmt <= to_unsigned(0, 16);
            cmt_val_x <= to_unsigned(0, 9);
            cmt_val_y <= to_unsigned(0, 9);
        elsif cmt = to_unsigned(40960,16) then
            cmt <= to_unsigned(0, 16);
            cmt_val_x <= to_unsigned(0, 9);
            cmt_val_y <= to_unsigned(0, 9);
        else 
            cmt <= cmt + to_unsigned(1, 16);
            cmt_val_x <= cmt_val_x + to_unsigned(1, 9);
            if cmt_val_x = to_unsigned(255, 9) then
                cmt_val_x <= to_unsigned(0, 9);
                cmt_val_y <= cmt_val_y + to_unsigned(1, 9);
            end if;
        end if;
    end if;
end process;

addr_out <= std_logic_vector(cmt);
val_x <= std_logic_vector(cmt_val_x);
val_y <= std_logic_vector(cmt_val_y);

end Behavioral;
