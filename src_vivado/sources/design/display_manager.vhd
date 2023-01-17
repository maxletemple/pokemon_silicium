----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/13/2022 03:56:07 PM
-- Design Name: 
-- Module Name: display_manager - Behavioral
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

entity display_manager is
    Port (clk : in std_logic;
         rst : in std_logic;
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
         addr_display : out std_logic_vector(15 downto 0);
         data_display : out std_logic_vector(7 downto 0));
end display_manager;

architecture Behavioral of display_manager is

    component gest_display is
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
end component;

    component display_pokemon is
        Port (rst : in std_logic;
             clk : in std_logic;
             type_selector : in std_logic_vector(2 downto 0);
             addr_start : in std_logic_vector(15 downto 0);
             addr_rom_pokemon : in std_logic_vector(17 downto 0);
             data_out_pokemon : out std_logic_vector(7 downto 0);
             addr_out_pokemon : out std_logic_vector(15 downto 0);
             done : out std_logic);
    end component;

    component display_arena is
        Port (rst : in std_logic;
             clk : in std_logic;
             type_selector : in std_logic_vector(2 downto 0);
             data_out_arena : out std_logic_vector(7 downto 0);
             addr_out_arena : out std_logic_vector(15 downto 0);
             done : out std_logic );
    end component;

    component display_letter is
        Port (rst : in std_logic;
             clk : in std_logic;
             enable : in std_logic;
             addr_letter : in std_logic_vector(6 downto 0);
             addr_start : in std_logic_vector(15 downto 0);
             data_out_letter : out std_logic_vector(7 downto 0);
             addr_out_letter : out std_logic_vector(15 downto 0);
             done : out std_logic);
    end component;

    component display_sentence is
        Port (rst : in std_logic;
             clk : in std_logic;
             type_selector : in std_logic_vector(2 downto 0);
             addr_start_sentence : in std_logic_vector(15 downto 0);
             addr_rom_sentence : in std_logic_vector(9 downto 0);
             size_sentence : in std_logic_vector(7 downto 0);
             letter_done : in std_logic;
             addr_start_letter : out std_logic_vector(15 downto 0);
             addr_rom_letter : out std_logic_vector(6 downto 0);
             enable_letter : out std_logic;
             done : out std_logic);
    end component;

    component display_life is
        Port (clk : in std_logic;
             rst : in std_logic;
             type_selector : in std_logic_vector(2 downto 0);
             addr_start : in std_logic_vector(15 downto 0);
             life : in std_logic_vector(6 downto 0);
             addr_out_life : out std_logic_vector(15 downto 0);
             data_out_life : out std_logic_vector(7 downto 0);
             done : out std_logic);
    end component;
    
    component clock_enable is
        Port (clk : in std_logic;
              rst : in std_logic;
              ce : out std_logic);
    end component;

    signal ce : std_logic;

    signal type_selector : std_logic_vector(2 downto 0);
    signal addr_start : std_logic_vector(15 downto 0);
    signal addr_rom_pokemon : std_logic_vector(17 downto 0);
    signal data_out_pokemon : std_logic_vector(7 downto 0);
    signal addr_out_pokemon : std_logic_vector(15 downto 0);
    signal data_out_arena : std_logic_vector(7 downto 0);
    signal addr_out_arena : std_logic_vector(15 downto 0);
    signal addr_rom_sentence : std_logic_vector(9 downto 0);
    signal size_sentence : std_logic_vector(7 downto 0);
    signal addr_start_letter : std_logic_vector(15 downto 0);
    signal addr_rom_letter : std_logic_vector(6 downto 0);
    signal data_out_letter : std_logic_vector(7 downto 0);
    signal addr_out_letter : std_logic_vector(15 downto 0);
    signal addr_out_life :  std_logic_vector(15 downto 0);
    signal data_out_life :  std_logic_vector(7 downto 0);
    signal pokemon_done : std_logic;
    signal arena_done : std_logic;
    signal letter_done : std_logic;
    signal sentence_done : std_logic;
    signal life_done : std_logic;
    signal enable_letter : std_logic;
    
    
    signal life : std_logic_vector(6 downto 0);

    signal addr_display_0 : std_logic_vector(15 downto 0);
begin
    
    iclock_enable : clock_enable port map(rst => rst, clk => clk, ce => ce);
    igest_diplay : gest_display port map(rst => rst, clk => clk, cursor => cursor, addr_line_1 => addr_line_1, addr_line_2 => addr_line_2, addr_line_3 => addr_line_3, addr_choice_1 => addr_choice_1, addr_choice_2 => addr_choice_2, addr_choice_3 => addr_choice_3, addr_choice_4 => addr_choice_4, size_line_1 => size_line_1, size_line_2 => size_line_2, size_line_3 => size_line_3, life => life, life_ally => life_ally, life_enemy => life_enemy, addr_ally => addr_ally, addr_enemy => addr_enemy, pokemon_done => pokemon_done, arena_done => arena_done, sentence_done => sentence_done, life_done => life_done, clock_enable => ce, type_selector => type_selector, addr_start => addr_start, addr_rom_pokemon => addr_rom_pokemon, addr_rom_sentence => addr_rom_sentence, size_sentence => size_sentence);
    idisplay_pokemon : display_pokemon port map(rst => rst, clk => clk, type_selector => type_selector, addr_start => addr_start, addr_rom_pokemon => addr_rom_pokemon, data_out_pokemon => data_out_pokemon, addr_out_pokemon => addr_out_pokemon, done => pokemon_done);
    idisplay_arena : display_arena port map(rst => rst, clk => clk, type_selector => type_selector, data_out_arena => data_out_arena, addr_out_arena => addr_out_arena, done => arena_done);
    idisplay_letter : display_letter port map(rst => rst, clk => clk, enable => enable_letter, addr_letter => addr_rom_letter, addr_start => addr_start_letter, data_out_letter => data_out_letter, addr_out_letter => addr_out_letter, done => letter_done);
    idisplay_sentence : display_sentence port map(rst => rst, clk => clk, type_selector => type_selector, addr_start_sentence => addr_start, addr_rom_sentence => addr_rom_sentence, size_sentence => size_sentence, letter_done => letter_done, addr_start_letter => addr_start_letter, addr_rom_letter => addr_rom_letter, enable_letter => enable_letter, done => sentence_done);
    idisplay_life : display_life port map(rst => rst, clk => clk, type_selector => type_selector, addr_start => addr_start, life => life, addr_out_life => addr_out_life, data_out_life => data_out_life, done => life_done);
    
addr_display <= addr_display_0 when (unsigned(addr_display_0) < to_unsigned(40961, 16)) else std_logic_vector(to_unsigned(40960, 16));

data_display <= data_out_life    when type_selector = "100" else
                data_out_letter  when type_selector = "011" else
                data_out_arena   when type_selector = "010" else
                data_out_pokemon when type_selector = "001" else
                "00000000";
addr_display_0 <= addr_out_life    when type_selector = "100" else
                addr_out_letter  when type_selector = "011" else
                addr_out_arena   when type_selector = "010" else
                addr_out_pokemon when type_selector = "001" else
                "0000000000000000";

    --    component counter_mod_n_enable is
    --        generic (n_bits : integer;
    --                n_mod : integer);
    --        Port (clk : in std_logic;
    --             rst : in std_logic;
    --             enable : in std_logic;
    --             output : out std_logic_vector(n_bits - 1 downto 0));
    --    end component;

    --    component rom_pokemons IS
    --        PORT (
    --            CLOCK          : IN  STD_LOGIC;
    --            ADDR_R         : IN  STD_LOGIC_VECTOR(17 DOWNTO 0);
    --            DATA_OUT       : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    --        );
    --    END component;

    --    component rom_arenas IS
    --        PORT (
    --            CLOCK          : IN  STD_LOGIC;
    --            ADDR_R         : IN  STD_LOGIC_VECTOR(17 DOWNTO 0);
    --            DATA_OUT       : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    --        );
    --    END component;

    --    component counter_display is
    --        Port (clk : in std_logic;
    --             rst : in std_logic;
    --             addr_out : out std_logic_vector(15 downto 0);
    --             val_x : out std_logic_vector(8 downto 0);
    --             val_y : out std_logic_vector(8 downto 0));
    --    end component;

    --    signal enable_ally : std_logic;
    --    signal addr_ally : std_logic_vector(17 downto 0);

    --    signal enable_enemy : std_logic;
    --    signal addr_enemy : std_logic_vector(17 downto 0);

    --    signal data_rom_pokemon : std_logic_vector(7 downto 0);
    --    signal addr_rom_pokemon : unsigned(17 downto 0);
    --    signal data_rom_arena : std_logic_vector(7 downto 0);
    --    signal addr_rom_arena : unsigned(17 downto 0);
    --    signal data_interface : std_logic_vector(7 downto 0);

    --    signal val_x, val_y : std_logic_vector(8 downto 0);
    --    signal addr_out : std_logic_vector(15 downto 0);
    --    signal data_out : std_logic_vector(7 downto 0);

    --    constant addr_back : unsigned(17 downto 0) := to_unsigned(0, 18);
    --    constant addr_pika : unsigned(17 downto 0) := to_unsigned(26988, 18);
    --    constant addr_tiplouf : unsigned(17 downto 0):= to_unsigned(13896, 18);

    --begin
    --irom_pokemons : rom_pokemons port map(CLOCK => clk, ADDR_R => std_logic_vector(addr_rom_pokemon), DATA_OUT => data_rom_pokemon);
    --irom_arenas : rom_arenas port map(CLOCK => clk, ADDR_R => std_logic_vector(addr_rom_arena), DATA_OUT => data_rom_arena);
    --icmt_ally : counter_mod_n_enable generic map(n_bits => 18, n_mod => 4900)
    --                                 port map(clk => clk, rst => rst, enable => enable_ally, output => addr_ally);
    --icmt_enemy : counter_mod_n_enable generic map(n_bits => 18, n_mod => 4096)
    --                                 port map(clk => clk, rst => rst, enable => enable_enemy, output => addr_enemy);
    --icounter_display : counter_display port map(clk => clk, rst => rst, addr_out => addr_out, val_x => val_x, val_y => val_y);

    --process(rst, clk)
    --begin
    --    if rising_edge(clk) then
    --        if rst = '1' then
    --            enable_ally <= '0';
    --            enable_enemy <= '0';
    --        else
    --            if unsigned(val_x) < 80 and unsigned(val_x) >= 10 and unsigned(val_y) >= 40 and unsigned(val_y) < 110 then
    --                addr_rom_pokemon <= addr_pika + unsigned(addr_ally);
    --                enable_ally <= '1';
    --                enable_enemy <= '0';
    --            elsif unsigned(val_x) < 246 and unsigned(val_x) >= 182 and unsigned(val_y) >= 10 and unsigned(val_y) < 74 then
    --                addr_rom_pokemon <= addr_tiplouf + unsigned(addr_enemy);
    --                enable_enemy <= '1';
    --                enable_ally <= '0';
    --            else
    --                enable_ally <= '0';
    --                enable_enemy <= '0';
    --                addr_rom_pokemon <= addr_pika;
    --            end if;

    --            addr_rom_arena <= to_unsigned(0, 18);

    --            if unsigned(val_y) >= 110 then
    --                data_interface <= "11111111";
    --            else
    --                data_interface <= "00000000";
    --            end if;

    --            if unsigned(data_rom_pokemon) = to_unsigned(28, 8) then
    --                data_out <= data_rom_arena;
    --            elsif data_interface = "11111111" then
    --                data_out <= data_interface;
    --            else
    --                data_out <= data_rom_pokemon;
    --            end if;
    --        end if;
    --    end if;
    --end process;

    --    data_display <= data_out;
    --    addr_display <= addr_out;
end Behavioral;