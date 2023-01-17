----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/09/2022 04:53:23 PM
-- Design Name: 
-- Module Name: one_dead_tester - Behavioral
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

entity one_dead_tester is
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
end one_dead_tester;

architecture Behavioral of one_dead_tester is

signal dead1: std_logic;
signal dead2 : std_logic;

begin

process(clk,rst)
begin
   if(rising_edge(clk)) then
        if(rst = '1') then 
            dead1 <='0';
            dead2 <='0';
        else
            case poke1 is
                when "00" =>
                    if dead1_00 = '1' then
                        dead1 <= '1';
                    else
                        dead1 <= '0';
                    end if;
                when "01" =>
                    if dead1_01 = '1' then
                        dead1 <= '1';
                    else
                        dead1 <= '0';
                    end if;
                when "10" =>
                    if dead1_10 = '1' then
                        dead1 <= '1';
                    else
                        dead1 <= '0';
                    end if;
                when "11" =>
                    if dead1_11 = '1' then
                        dead1 <= '1';
                    else
                        dead1 <= '0';
                    end if;
                when others =>
                    if dead1_00 = '1' then
                        dead1 <= '1';
                    else
                        dead1 <= '0';
                    end if;
            end case;
            case poke2 is
                when "00" =>
                    if dead2_00 = '1' then
                        dead2 <= '1';
                    else
                        dead2 <= '0';
                    end if;
                when "01" =>
                    if dead2_01 = '1' then
                        dead2 <= '1';
                    else
                        dead2 <= '0';
                    end if;
                when "10" =>
                    if dead2_10 = '1' then
                        dead2 <= '1';
                    else
                        dead2 <= '0';
                    end if;
                when "11" =>
                    if dead2_11 = '1' then
                        dead2 <= '1';
                    else
                        dead2 <= '0';
                    end if;
                when others  =>
                    if dead1_00 = '1' then
                        dead1 <= '1';
                    else
                        dead1 <= '0';
                    end if;
            end case;
        end if;
    end if;

end process;

dead <= '1' when dead1 ='1' or dead2 = '1' else '0';

end Behavioral;
