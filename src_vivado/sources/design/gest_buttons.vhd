----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/08/2023 01:39:18 PM
-- Design Name: 
-- Module Name: gest_buttons - Behavioral
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

entity gest_buttons is
    Port (rst : in std_logic;
         clk : in std_logic;
         X : in std_logic_vector(9 downto 0);
         Y : in std_logic_vector(9 downto 0);
         btn1 : in std_logic;
         btn2 : in std_logic;
         up : out std_logic;
         down : out std_logic;
         left : out std_logic;
         right : out std_logic;
         fwd : out std_logic;
         bwd : out std_logic);
end gest_buttons;

architecture Behavioral of gest_buttons is
    type states_btn is (init, state_up, state_down);
    signal b1_current, b1_next, b2_current, b2_next : states_btn;
    signal up_out, down_out, left_out, right_out : std_logic;
begin
    up    <= '1' when unsigned(X) > to_unsigned(800, 10) else '0';
    down  <= '1' when unsigned(X) < to_unsigned(200, 10) else '0';
    left  <= '1' when unsigned(Y) > to_unsigned(800, 10) else '0';
    right <= '1' when unsigned(Y) < to_unsigned(200, 10) else '0';

    process(rst, clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                b1_current <= init;
                b2_current <= init;
            else
                b1_current <= b1_next;
                b2_current <= b2_next;
                
            end if;
        end if;
    end process;

    fwd <= '1' when b1_current = state_up else '0';
    bwd <= '1' when b2_current = state_up else '0';

    process(b1_current, b2_current, btn1, btn2)
    begin
        case b1_current is
            when init =>
                if btn1 = '1' then
                    b1_next <= state_up;
                else
                    b1_next <= init;
                end if;
            when state_up =>
                b1_next <= state_down;
            when state_down =>
                if btn1 = '0' then
                    b1_next <= init;
                else
                    b1_next <= state_down;
                end if;
        end case;
        case b2_current is
            when init =>
                if btn2 = '1' then
                    b2_next <= state_up;
                else
                    b2_next <= init;
                end if;
            when state_up =>
                b2_next <= state_down;
            when state_down =>
                if btn2 = '0' then
                    b2_next <= init;
                else
                    b2_next <= state_down;
                end if;
        end case;
    end process;
end Behavioral;
