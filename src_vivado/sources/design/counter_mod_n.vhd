----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/13/2022 03:36:09 PM
-- Design Name: 
-- Module Name: counter_mod_n - Behavioral
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

entity counter_mod_n_enable is
    generic (n_bits : integer;
            n_mod : integer);
    Port (clk : in std_logic;
         rst : in std_logic;
         enable : in std_logic;
         output : out std_logic_vector(n_bits - 1 downto 0));
end counter_mod_n_enable;

architecture Behavioral of counter_mod_n_enable is

    signal count : unsigned(n_bits - 1 downto 0);
    
begin

    process(rst, clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                count <= to_unsigned(0, n_bits);
            else
                if enable = '1' then
                    if count = to_unsigned(n_mod - 1, n_bits) then
                        count <= to_unsigned(0, n_bits);
                    else
                        count <= count + to_unsigned(1, n_bits);
                    end if;
                end if;
            end if;
        end if;
    end process;

    output <= std_logic_vector(count);
end Behavioral;
