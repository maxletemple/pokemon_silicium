----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/12/2022 04:36:07 PM
-- Design Name: 
-- Module Name: display_sentence - Behavioral
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

entity display_sentence is
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
end display_sentence;

architecture Behavioral of display_sentence is

component ROM_sentences is
  Port (clk : in std_logic;
        addr_r : in std_logic_vector(9 downto 0);
        data_out : out std_logic_vector(6 downto 0));
end component;

type state_display_type is (init, start_counter, counter, display_letter, wait_display_letter, end_sentence);
signal scurrent, snext : state_display_type;

signal addr_rom_current : unsigned(9 downto 0);
signal cmt_sentence : unsigned(9 downto 0);
signal cmt_addr_start_letter : unsigned(15 downto 0);


signal enable_cmt_sentence, rst_cmt_sentence, enable_cmt_addr_start_letter, rst_cmt_addr_start_letter : std_logic;

begin

irom_sentences : ROM_sentences port map(clk => clk, addr_r => std_logic_vector(addr_rom_current), data_out => addr_rom_letter); 

addr_start_letter <= std_logic_vector(cmt_addr_start_letter + unsigned(addr_start_sentence));
addr_rom_current <= unsigned(addr_rom_sentence) + cmt_sentence;


process(rst, clk)
begin
    if rst = '1' then
        scurrent <= init;
    elsif rising_edge(clk) then
        scurrent <= snext;
        
        if rst_cmt_addr_start_letter = '1' then
            cmt_addr_start_letter <= to_unsigned(0, 16);
        elsif enable_cmt_addr_start_letter = '1' then
            cmt_addr_start_letter <= cmt_addr_start_letter + to_unsigned(5, 16);
        else
            cmt_addr_start_letter <= cmt_addr_start_letter;
        end if;
        
        if rst_cmt_sentence = '1' then
            cmt_sentence <= to_unsigned(0, 10);
        elsif enable_cmt_sentence = '1' then
            cmt_sentence <= cmt_sentence + to_unsigned(1, 10);
        else
            cmt_sentence <= cmt_sentence;
        end if;
    end if;
end process;

process(scurrent, type_selector, cmt_sentence, size_sentence, letter_done)
begin
    case scurrent is
        when init =>
            if type_selector = "011" then
                snext <= start_counter;
            else
                snext <= init;
            end if;
        when start_counter =>
            snext <= display_letter;
        when counter =>
            if cmt_sentence = unsigned(size_sentence) - to_unsigned(1, 8) then
                snext <= end_sentence;
            else
                snext <= display_letter;
            end if;
        when display_letter =>
            snext <= wait_display_letter;
        when wait_display_letter =>
            if letter_done = '1' then
                snext <= counter;
            else
                snext <= wait_display_letter;
            end if;
        when end_sentence =>
            snext <= init;
    end case;
end process;

process(scurrent)
begin
    case scurrent is
        when init =>
            done <= '0';
            enable_cmt_sentence <= '0';
            enable_cmt_addr_start_letter <= '0';
            rst_cmt_sentence <= '1';
            rst_cmt_addr_start_letter <= '1';
            enable_letter <= '0';
        when start_counter =>
            done <= '0';
            enable_cmt_sentence <= '0';
            enable_cmt_addr_start_letter <= '0';
            rst_cmt_sentence <= '0';
            rst_cmt_addr_start_letter <= '0';
            enable_letter <= '0';
        when counter =>
            done <= '0';
            enable_cmt_sentence <= '1';
            enable_cmt_addr_start_letter <= '1';
            rst_cmt_sentence <= '0';
            rst_cmt_addr_start_letter <= '0';
            enable_letter <= '0';
        when display_letter =>
            done <= '0';
            enable_cmt_sentence <= '0';
            enable_cmt_addr_start_letter <= '0';
            rst_cmt_sentence <= '0';
            rst_cmt_addr_start_letter <= '0';
            enable_letter <= '1';
        when wait_display_letter =>
            done <= '0';
            enable_cmt_sentence <= '0';
            enable_cmt_addr_start_letter <= '0';
            rst_cmt_sentence <= '0';
            rst_cmt_addr_start_letter <= '0';
            enable_letter <= '0';
        when end_sentence =>
            done <= '1';
            enable_cmt_sentence <= '0';
            enable_cmt_addr_start_letter <= '0';
            rst_cmt_sentence <= '0';
            rst_cmt_addr_start_letter <= '0';
            enable_letter <= '0';
    end case;
end process;

end Behavioral;
