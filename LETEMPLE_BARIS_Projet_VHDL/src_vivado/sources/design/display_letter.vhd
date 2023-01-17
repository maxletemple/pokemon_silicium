----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/09/2022 02:57:50 PM
-- Design Name: 
-- Module Name: display_letter - Behavioral
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

entity display_letter is
    Port (rst : in std_logic;
         clk : in std_logic;
         enable : in std_logic;
         addr_letter : in std_logic_vector(6 downto 0);
         addr_start : in std_logic_vector(15 downto 0);
         data_out_letter : out std_logic_vector(7 downto 0);
         addr_out_letter : out std_logic_vector(15 downto 0);
         done : out std_logic);
end display_letter;

architecture Behavioral of display_letter is

    component rom_letters IS
        port (
            CLOCK          : IN  STD_LOGIC;
            ADDR_R         : IN  STD_LOGIC_VECTOR(6 DOWNTO 0);
            DATA_OUT       : OUT STD_LOGIC_VECTOR(39 DOWNTO 0)
        );
    end component;

    type state_display_type is (init, start, counter, end_col, end_all);
    signal scurrent, snext : state_display_type;
    
    signal data_rom : std_logic_vector(39 downto 0);
    
    signal cmt_vector : unsigned(5 downto 0);
    signal cmt_addr_disp : unsigned(15 downto 0);
    signal cmt_x : unsigned(5 downto 0);
    signal cmt_y : unsigned(5 downto 0);
    
    signal enable_x, enable_y, restart_x, restart_y, restart_disp, next_line_disp, restart_rom : std_logic;

begin

irom_letters : rom_letters port map (CLOCK => clk, ADDR_R => addr_letter, DATA_OUT => data_rom);

addr_out_letter <= "1010000000000000" when data_rom(39 - to_integer(cmt_vector)) = '0' or cmt_vector = to_unsigned(0, 6) else
                    std_logic_vector(unsigned(addr_start) + cmt_addr_disp);

data_out_letter <= "00000000";

process(rst, clk)
begin
    if rst = '1' then
        scurrent <= init;
        cmt_vector <= to_unsigned(0, 6);
    elsif rising_edge(clk) then
        scurrent <= snext;

        if restart_x = '1' then
            cmt_x <= to_unsigned(0, 6);
        elsif enable_x = '1' then
            cmt_x <= cmt_x + to_unsigned(1, 6);
        else
            cmt_x <= cmt_x;
        end if;

        if restart_y = '1' then
            cmt_y <= to_unsigned(0, 6);
        elsif enable_y = '1' then
            cmt_y <= cmt_y + to_unsigned(1, 6);
        else
            cmt_y <= cmt_y;
        end if;

        if restart_disp = '1' then
            cmt_addr_disp <= to_unsigned(0, 16);
        elsif next_line_disp = '1' then
            cmt_addr_disp <= cmt_addr_disp + to_unsigned(252, 16);
        else
            cmt_addr_disp <= cmt_addr_disp + to_unsigned(1, 16);
        end if;
        
        if restart_rom = '1' then
            cmt_vector <= to_unsigned(0, 6);
        else
            cmt_vector <= cmt_vector + to_unsigned(1, 6);
        end if;

    end if;
end process;

process(scurrent, cmt_x, cmt_y, enable)
begin
    case scurrent is
        when init =>
            if enable = '1' then
                snext <= counter;
            else
                snext <= init;
            end if;
        when start =>
            snext <= counter;
        when counter =>
            if cmt_x = to_unsigned(2, 6) and cmt_y = to_unsigned(7, 6) then
                snext <= end_all;
            elsif cmt_x = to_unsigned(3, 6) then
                snext <= end_col;
            else
                snext <= counter;
            end if;
        when end_col =>
                snext <= counter;
        when end_all =>
                snext <= init;
    end case;
end process;

process(scurrent)
begin
    case scurrent is
        when init | start=>
            enable_x <= '0';
            enable_y <= '0';
            restart_x <= '1';
            restart_y <= '1';
            next_line_disp <= '0';
            restart_disp <= '1';
            done <= '0';
            restart_rom <= '1';
        when counter =>
            enable_x <= '1';
            enable_y <= '0';
            restart_x <= '0';
            restart_y <= '0';
            next_line_disp <= '0';
            restart_disp <= '0';
            done <= '0';
            restart_rom <= '0';
        when end_col =>
            enable_x <= '0';
            enable_y <= '1';
            restart_x <= '1';
            restart_y <= '0';
            next_line_disp <= '1';
            restart_disp <= '0';
            done <= '0';
            restart_rom <= '0';
        when end_all =>
            enable_x <= '0';
            enable_y <= '0';
            restart_x <= '0';
            restart_y <= '0';
            next_line_disp <= '0';
            restart_disp <= '0';
            done <= '1';
            restart_rom <= '0';
    end case;
end process;

end Behavioral;
