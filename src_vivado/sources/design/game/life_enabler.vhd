----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/09/2022 04:04:25 PM
-- Design Name: 
-- Module Name: life_enabler - Behavioral
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

entity life_enabler is
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
end life_enabler;

architecture Behavioral of life_enabler is
 type states is (init, high, low);
    signal current_state, next_state : states;
begin

process(clk)
begin
    if(rising_edge(clk)) then
        if(rst = '1') then 
            current_state <= init;
        else
            current_state <= next_state;
        end if;
    end if;
end process;

process(current_state, stage)
begin
    case current_state is
        when init =>
            if (stage = "0100") then
                next_state <= high;
            else
                next_state <= init;
            end if;
        when high =>
            next_state <= low;
        when low =>
            if(stage = "0001") then
                next_state <= init;
            else
                next_state <= low;
            end if;
        when others =>
            next_state <= init;
    end case;
end process;

process(current_state,player,poke1,poke2)
begin
    if (current_state = high) then
        if player = '0'then
            case poke2 is
                when "00" =>
                    enable2_00 <= '1';
                when "01" =>
                    enable2_01 <= '1';
                when "10" =>
                    enable2_10 <= '1';
                when "11" =>
                    enable2_11 <= '1';
                when others =>
                    enable2_00 <= '1';
            end case;            
        else
            case poke1 is
                when "00" =>
                    enable1_00 <= '1';
                when "01" =>
                    enable1_01 <= '1';
                when "10" =>
                    enable1_10 <= '1';
                when "11" =>
                    enable1_11 <= '1';
                when others =>
                    enable1_00 <= '1';
            end case;   
        end if;
    else
        enable1_00 <= '0';
        enable1_01 <= '0';
        enable1_10 <= '0';
        enable1_11 <= '0';
        enable2_00 <= '0';
        enable2_01 <= '0';
        enable2_10 <= '0';
        enable2_11 <= '0';
    end if;
end process;

end Behavioral;
