----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/09/2022 02:48:18 PM
-- Design Name: 
-- Module Name: Input2Position - Behavioral
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

entity Input2Position is
  Port (   clk : in std_logic;
           rst : in std_logic;
           left : in STD_LOGIC;
           up : in STD_LOGIC;
           down : in STD_LOGIC;
           right : in STD_LOGIC;
           position : out std_logic_vector (1 downto 0));
end Input2Position;

architecture Behavioral of Input2Position is

type states is (topleft,topright,bottomleft,bottomright);
signal current_state, next_state : states;


begin
process(clk,rst)
begin
    if(rising_edge(clk)) then
        if(rst = '1') then 
            current_state <= topleft ;
        else
            current_state <= next_state;
        end if;
    end if;
end process;

process (current_state, left , up, down ,right)
begin
    case current_state is
        when topleft =>
            if(right = '1') then
                next_state <= topright ;
            elsif down ='1' then
                next_state <= bottomleft ;
            else
                next_state <= topleft;
            end if;
        when topright  =>
            if(left = '1') then
                next_state <= topleft ;
            elsif down ='1' then
                next_state <= bottomright ;
            else
                next_state <= topright;
            end if;
        when bottomleft  =>
            if(right = '1') then
                next_state <= bottomright ;
            elsif up ='1' then
                next_state <= topleft ;
            else
                next_state <= bottomleft;
            end if;
        when bottomright  =>
            if(left = '1') then
                next_state <= bottomleft ;
            elsif up ='1' then
                next_state <= topright ;
            else
                next_state <= bottomright ;
            end if;            
       when others =>
            next_state <= topleft ;
   end case;
end process;

process (current_state)
begin
    case current_state is
        when topleft =>
            position <= "00";
        when topright =>
            position <= "01";
        when bottomleft =>
            position <= "10";
        when bottomright =>
            position <= "11";
        when others =>     
            position <= "00";   
end case;
end process;

end Behavioral;
