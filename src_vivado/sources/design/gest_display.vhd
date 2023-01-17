----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/02/2022 02:22:30 PM
-- Design Name: 
-- Module Name: gest_display - Behavioral
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

entity gest_display is
    Port (rst : in std_logic;
         clk : in std_logic;
         cursor : in std_logic_vector(1 downto 0);
         addr_line_1 : in std_logic_vector(9 downto 0);
         addr_line_2 : in std_logic_vector(9 downto 0);
         addr_line_3 : in std_logic_vector(9 downto 0);
         addr_choice_1 : in std_logic_vector(9 downto 0);
         addr_choice_2 : in std_logic_vector(9 downto 0);
         addr_choice_3 : in std_logic_vector(9 downto 0);
         addr_choice_4 : in std_logic_vector(9 downto 0);
         size_line_1 : in std_logic_vector(7 downto 0);
         size_line_2 : in std_logic_vector(7 downto 0);
         size_line_3 : in std_logic_vector(7 downto 0);
         life_ally : in std_logic_vector(6 downto 0);
         life_enemy : in std_logic_vector(6 downto 0);
         addr_ally : in std_logic_vector(17 downto 0);
         addr_enemy : in std_logic_vector(17 downto 0);
         pokemon_done : in std_logic;
         arena_done : in std_logic;
         sentence_done : in std_logic;
         life_done : in std_logic;
         clock_enable : in std_logic;
         life : out std_logic_vector(6 downto 0);
         type_selector : out std_logic_vector(2 downto 0);
         addr_start : out std_logic_vector(15 downto 0);
         addr_rom_pokemon : out std_logic_vector(17 downto 0);
         addr_rom_sentence : out std_logic_vector(9 downto 0);
         size_sentence : out std_logic_vector(7 downto 0));
end gest_display;

architecture Behavioral of gest_display is
    type state_display_type is (init, display_arena, wait_display_arena, display_ally, wait_display_ally, display_enemy, wait_display_enemy,
                                display_case1, wait_display_case1, display_case2, wait_display_case2, display_case3, wait_display_case3, display_case4, wait_display_case4,
                                display_life_ally, wait_display_life_ally, display_life_enemy, wait_display_life_enemy, display_line_1, wait_display_line_1, display_line_2, wait_display_line_2,
                                display_line_3, wait_display_line_3, display_cursor, wait_display_cursor);
    signal scurrent, snext : state_display_type;

    constant addr_pokemon_ally_start : std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned(46*256 + 20, 16));
    constant addr_pokemon_enemy_start : std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned(13*256 + 160, 16));
    constant addr_life_ally_start : std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned((110-18)*256 + 94, 16));
    constant addr_life_enemy_start : std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned((256 + 10), 16));

    constant addr_line_1_start : std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned(256*(112+9)+5, 16));
    constant addr_line_2_start : std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned(256*(112+19)+5, 16));
    constant addr_line_3_start : std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned(256*(112+29)+5, 16));
    constant addr_choice_1_start : std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned(256*(112+13)+130+5, 16));
    constant addr_choice_2_start : std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned(256*(112+13)+130+5*12, 16));
    constant addr_choice_3_start : std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned(256*(160-10-10)+130+5, 16));
    constant addr_choice_4_start : std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned(256*(160-10-10)+130+5*12, 16));
    constant addr_cursor_1_start : std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned(256*(112+13)+130, 16));
    constant addr_cursor_2_start : std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned(256*(112+13)+130+5*11, 16));
    constant addr_cursor_3_start : std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned(256*(160-10-10)+130, 16));
    constant addr_cursor_4_start : std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned(256*(160-10-10)+130+5*11, 16));

    constant addr_rom_cursor : std_logic_vector(9 downto 0) := std_logic_vector(to_unsigned(576, 10));

begin

    process(rst, clk)
    begin
        if rst = '1' then
            scurrent <= init;
        elsif rising_edge(clk) then
            scurrent <= snext;
        end if;
    end process;

    process(pokemon_done, arena_done, sentence_done, life_done, scurrent, clock_enable)
    begin
        case scurrent is
            when init =>
                if clock_enable = '1' then
                    snext <= display_arena;
                else
                    snext <= init;
                end if;
            when display_arena =>
                snext <= wait_display_arena;
            when wait_display_arena =>
                if arena_done = '1' then
                    snext <= display_ally;
                else
                    snext <= wait_display_arena;
                end if;
            when display_ally =>
                snext <= wait_display_ally;
            when wait_display_ally =>
                if pokemon_done = '1' then
                    snext <= display_enemy;
                else
                    snext <= wait_display_ally;
                end if;
            when display_enemy =>
                snext <= wait_display_enemy;
            when wait_display_enemy =>
                if pokemon_done = '1' then
                    snext <= display_case1;
                else
                    snext <= wait_display_enemy;
                end if;
            when display_case1 =>
                snext <= wait_display_case1;
            when wait_display_case1 =>
                if sentence_done = '1' then
                    snext <= display_case2;
                else
                    snext <= wait_display_case1;
                end if;
            when display_case2 =>
                snext <= wait_display_case2;
            when wait_display_case2 =>
                if sentence_done = '1' then
                    snext <= display_case3;
                else
                    snext <= wait_display_case2;
                end if;
            when display_case3 =>
                snext <= wait_display_case3;
            when wait_display_case3 =>
                if sentence_done = '1' then
                    snext <= display_case4;
                else
                    snext <= wait_display_case3;
                end if;
            when display_case4 =>
                snext <= wait_display_case4;
            when wait_display_case4 =>
                if sentence_done = '1' then
                    snext <= display_life_ally;
                else
                    snext <= wait_display_case4;
                end if;
            when display_life_ally =>
                snext <= wait_display_life_ally;
            when wait_display_life_ally =>
                if life_done = '1' then
                    snext <= display_life_enemy;
                else
                    snext <= wait_display_life_ally;
                end if;
            when display_life_enemy =>
                snext <= wait_display_life_enemy;
            when wait_display_life_enemy =>
                if life_done = '1' then
                    snext <= display_line_1;
                else
                    snext <= wait_display_life_enemy;
                end if;
            when display_line_1  =>
                snext <= wait_display_line_1;
            when wait_display_line_1 =>
                if sentence_done = '1' then
                    snext <= display_line_2;
                else
                    snext <= wait_display_line_1;
                end if;
            when display_line_2 =>
                snext <= wait_display_line_2;
            when wait_display_line_2 =>
                if sentence_done = '1' then
                    snext <= display_line_3;
                else
                    snext <= wait_display_line_2;
                end if;
            when display_line_3 =>
                snext <= wait_display_line_3;
            when wait_display_line_3 =>
                if sentence_done = '1' then
                    snext <= display_cursor;
                else
                    snext <= wait_display_line_3;
                end if;
            when display_cursor =>
                snext <= wait_display_cursor;
            when wait_display_cursor =>
                if sentence_done = '1' then
                    snext <= init;
                else
                    snext <= wait_display_cursor;
                end if;
        end case;
    end process;

    process(scurrent, addr_enemy, addr_choice_1, addr_choice_2, addr_choice_3, addr_choice_4, life_ally, life_enemy, size_line_1, addr_line_1, size_line_2, addr_line_2, size_line_3, addr_line_3, cursor)
    begin
        case scurrent is
            when init =>
                type_selector <= "000";
                addr_start <= std_logic_vector(to_unsigned(0, 16));
                addr_rom_sentence <= std_logic_vector(to_unsigned(0, 10));
                addr_rom_pokemon <= std_logic_vector(to_unsigned(0, 18));
                size_sentence <= std_logic_vector(to_unsigned(0, 8));
                life <= std_logic_vector(to_unsigned(0, 7));
            when display_arena | wait_display_arena =>
                type_selector <= "010";
                addr_start <= std_logic_vector(to_unsigned(0, 16));
                addr_rom_sentence <= std_logic_vector(to_unsigned(0, 10));
                addr_rom_pokemon <= std_logic_vector(to_unsigned(0, 18));
                size_sentence <= std_logic_vector(to_unsigned(0, 8));
                life <= std_logic_vector(to_unsigned(0, 7));
            when display_ally | wait_display_ally =>
                type_selector <= "001";
                addr_start <= addr_pokemon_ally_start;
                addr_rom_pokemon <= addr_ally;
                addr_rom_sentence <= std_logic_vector(to_unsigned(0, 10));
                size_sentence <= std_logic_vector(to_unsigned(0, 8));
                life <= std_logic_vector(to_unsigned(0, 7));
            when display_enemy | wait_display_enemy =>
                type_selector <= "001" ;
                addr_start <= addr_pokemon_enemy_start;
                addr_rom_pokemon <= addr_enemy;
                addr_rom_sentence <= std_logic_vector(to_unsigned(0, 10));
                size_sentence <= std_logic_vector(to_unsigned(0, 8));
                life <= std_logic_vector(to_unsigned(0, 7));
            when display_case1 | wait_display_case1 =>
                type_selector <= "011";
                addr_start <= addr_choice_1_start;
                size_sentence <= std_logic_vector(to_unsigned(9, 8));
                addr_rom_sentence <= addr_choice_1;
                addr_rom_pokemon <= std_logic_vector(to_unsigned(0, 18));
                life <= std_logic_vector(to_unsigned(0, 7));
            when display_case2 | wait_display_case2 =>
                type_selector <= "011";
                addr_start <= addr_choice_2_start;
                size_sentence <= std_logic_vector(to_unsigned(9, 8));
                addr_rom_pokemon <= std_logic_vector(to_unsigned(0, 18));
                addr_rom_sentence <= addr_choice_2;
                life <= std_logic_vector(to_unsigned(0, 7));
            when display_case3 | wait_display_case3 =>
                type_selector <= "011";
                addr_start <= addr_choice_3_start;
                size_sentence <= std_logic_vector(to_unsigned(9, 8));
                addr_rom_pokemon <= std_logic_vector(to_unsigned(0, 18));
                addr_rom_sentence <= addr_choice_3;
                life <= std_logic_vector(to_unsigned(0, 7));
            when display_case4 | wait_display_case4 =>
                type_selector <= "011";
                addr_start <= addr_choice_4_start;
                size_sentence <= std_logic_vector(to_unsigned(9, 8));
                addr_rom_pokemon <= std_logic_vector(to_unsigned(0, 18));
                addr_rom_sentence <= addr_choice_4;
                life <= std_logic_vector(to_unsigned(0, 7));
            when display_life_ally | wait_display_life_ally =>
                type_selector <= "100";
                addr_start <= addr_life_ally_start;
                life <= life_ally;
                addr_rom_sentence <= std_logic_vector(to_unsigned(0, 10));
                addr_rom_pokemon <= std_logic_vector(to_unsigned(0, 18));
                size_sentence <= std_logic_vector(to_unsigned(0, 8));
            when display_life_enemy | wait_display_life_enemy =>
                type_selector <= "100";
                addr_start <= addr_life_enemy_start;
                life <= life_enemy;
                addr_rom_sentence <= std_logic_vector(to_unsigned(0, 10));
                addr_rom_pokemon <= std_logic_vector(to_unsigned(0, 18));
                size_sentence <= std_logic_vector(to_unsigned(0, 8));
            when display_line_1 | wait_display_line_1 =>
                type_selector <= "011";
                addr_start <= addr_line_1_start;
                size_sentence <= size_line_1;
                addr_rom_sentence <= addr_line_1;
                addr_rom_pokemon <= std_logic_vector(to_unsigned(0, 18));
                life <= std_logic_vector(to_unsigned(0, 7));
            when display_line_2 | wait_display_line_2 =>
                type_selector <= "011";
                addr_start <= addr_line_2_start;
                size_sentence <= size_line_2;
                addr_rom_sentence <= addr_line_2;
                addr_rom_pokemon <= std_logic_vector(to_unsigned(0, 18));
                life <= std_logic_vector(to_unsigned(0, 7));
            when display_line_3 | wait_display_line_3 =>
                type_selector <= "011";
                addr_start <= addr_line_3_start;
                size_sentence <= size_line_3;
                addr_rom_sentence <= addr_line_3;
                addr_rom_pokemon <= std_logic_vector(to_unsigned(0, 18));
                life <= std_logic_vector(to_unsigned(0, 7));
            when display_cursor | wait_display_cursor =>
                type_selector <= "011";
                case cursor is
                    when "00" =>
                        addr_start <= addr_cursor_1_start;
                    when "01" =>
                        addr_start <= addr_cursor_2_start;
                    when "10" =>
                        addr_start <= addr_cursor_3_start;
                    when "11" =>
                        addr_start <= addr_cursor_4_start;
                    when others =>
                        addr_start <= addr_cursor_1_start;
                end case;
                addr_rom_sentence <= addr_rom_cursor;
                size_sentence <= std_logic_vector(to_unsigned(1, 8));
                addr_rom_pokemon <= std_logic_vector(to_unsigned(0, 18));
                life <= std_logic_vector(to_unsigned(0, 7));
        end case;
    end process;



end Behavioral;
