----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/26/2022 03:43:21 PM
-- Design Name: 
-- Module Name: display_life - Behavioral
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

entity display_life is
    Port (clk : in std_logic;
         rst : in std_logic;
         type_selector : in std_logic_vector(2 downto 0);
         addr_start : in std_logic_vector(15 downto 0);
         life : in std_logic_vector(6 downto 0);
         addr_out_life : out std_logic_vector(15 downto 0);
         data_out_life : out std_logic_vector(7 downto 0);
         done : out std_logic);
end display_life;

architecture Behavioral of display_life is

    component rom_life IS
        port (
            CLOCK          : IN  STD_LOGIC;
            ADDR_R         : IN  STD_LOGIC_VECTOR(17 DOWNTO 0);
            DATA_OUT       : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    end component;

    type state_display_type is (init, counter_sprite, end_col, end_sprite, counter_life, next_line, end_all);
    signal scurrent, snext : state_display_type;

    signal addr_rom : std_logic_vector(17 downto 0);
    signal data_rom : std_logic_vector(7 downto 0);
    signal cmt_addr_rom : unsigned(17 downto 0);
    signal cmt_addr_disp : unsigned(15 downto 0);
    signal cmt_x : unsigned(7 downto 0);
    signal cmt_y : unsigned(7 downto 0);
    signal cmt_life : unsigned(6 downto 0);
    signal cmt_line : unsigned(1 downto 0);
    signal enable_x, enable_y, restart_x, restart_y, restart_disp, next_line_disp, restart_rom , restart_life, restart_to_life, enable_life, restart_line, enable_line: std_logic;
begin
    irom_life : rom_life port map(CLOCK => clk, ADDR_R => addr_rom, DATA_OUT => data_rom);
    addr_rom <= std_logic_vector(cmt_addr_rom);

    addr_out_life <= "1010000000000000" when data_rom = "00011100" and scurrent /= counter_life  else
                     std_logic_vector(unsigned(addr_start) + cmt_addr_disp);
    data_out_life <= data_rom when scurrent = counter_sprite or scurrent = end_col else
 "11100000";
    process(rst, clk)
    begin
        if rst = '1' then
            scurrent <= init;
            cmt_addr_rom <= to_unsigned(0, 18);
        elsif rising_edge(clk) then
            scurrent <= snext;

            if restart_x = '1' then
                cmt_x <= to_unsigned(0, 8);
            elsif enable_x = '1' then
                cmt_x <= cmt_x + to_unsigned(1, 8);
            else
                cmt_x <= cmt_x;
            end if;

            if restart_y = '1' then
                cmt_y <= to_unsigned(0, 8);
            elsif enable_y = '1' then
                cmt_y <= cmt_y + to_unsigned(1, 8);
            else
                cmt_y <= cmt_y;
            end if;

            if restart_disp = '1' then
                cmt_addr_disp <= to_unsigned(0, 16);
            elsif restart_to_life = '1' then
                cmt_addr_disp <= to_unsigned(3101, 16);
            elsif next_line_disp = '1' then
                if scurrent = end_col then
                    cmt_addr_disp <= cmt_addr_disp + to_unsigned(124, 16);
                else
                    cmt_addr_disp <= cmt_addr_disp + to_unsigned(255, 16) - resize(unsigned(life), 16);
                end if;
            else
                cmt_addr_disp <= cmt_addr_disp + to_unsigned(1, 16);
            end if;

            if restart_rom = '1' then
                cmt_addr_rom <= to_unsigned(0, 18);
            else
                cmt_addr_rom <= cmt_addr_rom + to_unsigned(1, 18);
            end if;

            if restart_life = '1' then
                cmt_life <= to_unsigned(0, 7);
            elsif enable_life = '1' then
                cmt_life <= cmt_life + to_unsigned(1, 7);
            else
                cmt_life <= cmt_life;
            end if;

            if restart_line = '1' then
                cmt_line <= to_unsigned(0, 2);
            elsif enable_line = '1' then
                cmt_line <= cmt_line + to_unsigned(1, 2);
            end if;

        end if;
    end process;

    process(scurrent, cmt_x, cmt_y, cmt_life, cmt_line, type_selector, life)
    begin
        case scurrent is
            when init =>
                if type_selector = "100" then
                    snext <= counter_sprite;
                else
                    snext <= init;
                end if;
            when counter_sprite =>
                if cmt_x = to_unsigned(131, 8) then
                    if cmt_y = to_unsigned(17, 8) then
                        snext <= end_sprite;
                    else
                        snext <= end_col;
                    end if;
                else
                    snext <= counter_sprite;
                end if;
            when end_col =>
                snext <= counter_sprite;
            when end_sprite =>
                snext <= counter_life;
            when counter_life =>
                if cmt_life = unsigned(life) then
                    if cmt_line = to_unsigned(3, 2) then
                        snext <= end_all;
                    else
                        snext <= next_line;
                    end if;
                else
                    snext <= counter_life;
                end if;
            when next_line =>
                snext <= counter_life;
            when end_all =>
                snext <= init;
        end case;
    end process;
    process(scurrent)
    begin
        case scurrent is
            when init =>
                enable_x <= '0';
                enable_y <= '0';
                restart_x <= '1';
                restart_y <= '1';
                next_line_disp <= '0';
                restart_disp <= '1';
                done <= '0';
                restart_rom <= '1';
                restart_line <= '1';
                enable_line <= '0';
                restart_life <= '1';
                enable_life <= '0';
                restart_to_life <= '0';
            when counter_sprite =>
                enable_x <= '1';
                enable_y <= '0';
                restart_x <= '0';
                restart_y <= '0';
                next_line_disp <= '0';
                restart_disp <= '0';
                done <= '0';
                restart_rom <= '0';
                restart_line <= '0';
                enable_line <= '0';
                restart_life <= '0';
                enable_life <= '0';
                restart_to_life <= '0';
            when end_col =>
                enable_x <= '0';
                enable_y <= '1';
                restart_x <= '1';
                restart_y <= '0';
                next_line_disp <= '1';
                restart_disp <= '0';
                done <= '0';
                restart_rom <= '0';
                restart_line <= '0';
                enable_line <= '0';
                restart_life <= '0';
                enable_life <= '0';
                restart_to_life <= '0';
            when end_sprite =>
                enable_x <= '0';
                enable_y <= '0';
                restart_x <= '0';
                restart_y <= '0';
                next_line_disp <= '0';
                restart_disp <= '0';
                done <= '0';
                restart_rom <= '0';
                restart_line <= '0';
                enable_line <= '0';
                restart_life <= '0';
                enable_life <= '0';
                restart_to_life <= '1';
            when counter_life =>
                enable_x <= '0';
                enable_y <= '0';
                restart_x <= '0';
                restart_y <= '0';
                next_line_disp <= '0';
                restart_disp <= '0';
                done <= '0';
                restart_rom <= '0';
                restart_line <= '0';
                enable_line <= '0';
                restart_life <= '0';
                enable_life <= '1';
                restart_to_life <= '0';
            when next_line =>
                enable_x <= '0';
                enable_y <= '0';
                restart_x <= '0';
                restart_y <= '0';
                next_line_disp <= '1';
                restart_disp <= '0';
                done <= '0';
                restart_rom <= '0';
                restart_line <= '0';
                enable_line <= '1';
                restart_life <= '1';
                enable_life <= '0';
                restart_to_life <= '0';
            when end_all =>
                enable_x <= '0';
                enable_y <= '0';
                restart_x <= '0';
                restart_y <= '0';
                next_line_disp <= '0';
                restart_disp <= '0';
                done <= '1';
                restart_rom <= '0';
                restart_line <= '0';
                enable_line <= '0';
                restart_life <= '0';
                enable_life <= '0';
                restart_to_life <= '0';
        end case;
    end process;
end Behavioral;
