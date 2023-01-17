----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/06/2022 11:01:12 PM
-- Design Name: 
-- Module Name: display_arena - Behavioral
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

entity display_arena is
  Port (rst : in std_logic;
        clk : in std_logic;
        type_selector : in std_logic_vector(2 downto 0);
        data_out_arena : out std_logic_vector(7 downto 0);
        addr_out_arena : out std_logic_vector(15 downto 0);
        done : out std_logic );
end display_arena;

architecture Behavioral of display_arena is

component rom_arenas IS
    port (
          CLOCK          : IN  STD_LOGIC;
          ADDR_R         : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
          DATA_OUT       : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
          );
    end component;

type state_display_type is (init, counter, end_count);
signal scurrent, snext : state_display_type;

signal cmt : unsigned(15 downto 0);
signal enable_cmt, restart_cmt : std_logic;

signal data_out : std_logic_vector(7 downto 0);

begin

data_out_arena <= data_out when cmt <= to_unsigned(28160, 15) else
                  "00000000" when cmt <= to_unsigned(28672, 15) or (cmt mod 256) = to_unsigned(127, 15) or (cmt mod 256) = to_unsigned(128, 15) else
                  "11111111";

irom_arenas : rom_arenas port map(CLOCK => clk, ADDR_R => std_logic_vector(cmt), DATA_OUT => data_out);



process(rst, clk)
begin
    if rst = '1' then
        cmt <= to_unsigned(0, 16);
        scurrent <= init;
    elsif rising_edge(clk) then
        scurrent <= snext;
        
        if restart_cmt = '1' then
            cmt <= to_unsigned(0, 16);
        elsif enable_cmt = '1' then
            cmt <= cmt + to_unsigned(1, 16);
        else
            cmt <= cmt;
        end if;
    end if;
end process;

process(scurrent, type_selector, cmt)
begin
    case scurrent is
        when init =>
            if type_selector = "010" then
                snext <= counter;
            else
                snext <= init;
            end if;
        when counter =>
            if cmt = to_unsigned(40959, 16) then
                snext <= end_count;
            else
                snext <= counter;
            end if;
        when end_count =>
            snext <= init;
    end case;
end process;

process(scurrent)
begin
    case scurrent is
        when init =>
            done <= '0';
            restart_cmt <= '1';
            enable_cmt <= '0';
        when counter =>
            done <= '0';
            restart_cmt <= '0';
            enable_cmt <= '1';
        when end_count =>
            done <= '1';
            restart_cmt <= '1';
            enable_cmt <= '0';
    end case;
end process;

addr_out_arena <= std_logic_vector(cmt);

end Behavioral;