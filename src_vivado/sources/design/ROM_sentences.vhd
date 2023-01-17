----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/12/2022 04:37:18 PM
-- Design Name: 
-- Module Name: ROM_sentences - Behavioral
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

entity ROM_sentences is
  Port (clk : in std_logic;
        addr_r : in std_logic_vector(9 downto 0);
        data_out : out std_logic_vector(6 downto 0));
end ROM_sentences;

architecture Behavioral of ROM_sentences is

 type rom_type is array(0 to 577) of unsigned(6 downto 0); 
 signal rom : rom_type := (to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), 
to_unsigned(4, 7),to_unsigned(28, 7),to_unsigned(45, 7),to_unsigned(40, 7),to_unsigned(41, 7),to_unsigned(37, 7),to_unsigned(26, 7),to_unsigned(44, 7),to_unsigned(38, 7),to_unsigned(26, 7),
to_unsigned(19, 7),to_unsigned(34, 7),to_unsigned(41, 7),to_unsigned(37, 7),to_unsigned(40, 7),to_unsigned(46, 7),to_unsigned(31, 7),to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), 
to_unsigned(15, 7),to_unsigned(34, 7),to_unsigned(36, 7),to_unsigned(26, 7),to_unsigned(28, 7),to_unsigned(33, 7),to_unsigned(46, 7),to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), 
to_unsigned(1, 7),to_unsigned(43, 7),to_unsigned(26, 7),to_unsigned(44, 7),to_unsigned(66, 7), to_unsigned(32, 7),to_unsigned(26, 7),to_unsigned(37, 7),to_unsigned(34, 7),to_unsigned(69, 7), 
to_unsigned(19, 7),to_unsigned(40, 7),to_unsigned(43, 7),to_unsigned(45, 7),to_unsigned(30, 7),to_unsigned(43, 7),to_unsigned(43, 7),to_unsigned(26, 7),to_unsigned(69, 7), to_unsigned(69, 7), 
to_unsigned(17, 7),to_unsigned(26, 7),to_unsigned(50, 7),to_unsigned(42, 7),to_unsigned(46, 7),to_unsigned(26, 7),to_unsigned(51, 7),to_unsigned(26, 7),to_unsigned(69, 7), to_unsigned(69, 7), 
to_unsigned(12, 7),to_unsigned(30, 7),to_unsigned(48, 7),to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), 
to_unsigned(17, 7),to_unsigned(40, 7),to_unsigned(39, 7),to_unsigned(31, 7),to_unsigned(37, 7),to_unsigned(30, 7),to_unsigned(49, 7),to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), 
to_unsigned(1, 7),to_unsigned(40, 7),to_unsigned(38, 7),to_unsigned(27, 7),to_unsigned(43, 7),to_unsigned(30, 7),to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), 
to_unsigned(6, 7),to_unsigned(26, 7),to_unsigned(51, 7),to_unsigned(69, 7), to_unsigned(19, 7),to_unsigned(40, 7),to_unsigned(49, 7),to_unsigned(69, 7), to_unsigned(69, 7), 
to_unsigned(11, 7),to_unsigned(26, 7),to_unsigned(43, 7),to_unsigned(28, 7),to_unsigned(34, 7),to_unsigned(39, 7),to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), 
to_unsigned(8, 7),to_unsigned(38, 7),to_unsigned(41, 7),to_unsigned(26, 7),to_unsigned(28, 7),to_unsigned(45, 7),to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), 
to_unsigned(15, 7),to_unsigned(34, 7),to_unsigned(28, 7),to_unsigned(26, 7),to_unsigned(43, 7),to_unsigned(29, 7),to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), 
to_unsigned(15, 7),to_unsigned(34, 7),to_unsigned(28, 7),to_unsigned(41, 7),to_unsigned(34, 7),to_unsigned(28, 7),to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), 
to_unsigned(2, 7),to_unsigned(33, 7),to_unsigned(26, 7),to_unsigned(43, 7),to_unsigned(32, 7),to_unsigned(30, 7),to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), 
to_unsigned(18, 7),to_unsigned(46, 7),to_unsigned(43, 7),to_unsigned(31, 7),to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), 
to_unsigned(4, 7),to_unsigned(28, 7),to_unsigned(37, 7),to_unsigned(26, 7),to_unsigned(34, 7),to_unsigned(43, 7),to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), 
to_unsigned(10, 7),to_unsigned(30, 7),to_unsigned(46, 7),to_unsigned(29, 7),to_unsigned(31, 7),to_unsigned(30, 7),to_unsigned(43, 7),to_unsigned(69, 7), to_unsigned(69, 7), 
to_unsigned(4, 7),to_unsigned(28, 7),to_unsigned(37, 7),to_unsigned(26, 7),to_unsigned(45, 7),to_unsigned(43, 7),to_unsigned(40, 7),to_unsigned(28, 7),to_unsigned(69, 7), 
to_unsigned(19, 7),to_unsigned(46, 7),to_unsigned(39, 7),to_unsigned(39, 7),to_unsigned(30, 7),to_unsigned(37, 7),to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), 
to_unsigned(6, 7),to_unsigned(43, 7),to_unsigned(34, 7),to_unsigned(31, 7),to_unsigned(31, 7),to_unsigned(30, 7),to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), 
to_unsigned(7, 7),to_unsigned(34, 7),to_unsigned(32, 7),to_unsigned(33, 7),to_unsigned(69, 7), to_unsigned(10, 7),to_unsigned(34, 7),to_unsigned(36, 7),to_unsigned(69, 7), 
to_unsigned(12, 7),to_unsigned(40, 7),to_unsigned(37, 7),to_unsigned(40, 7),to_unsigned(45, 7),to_unsigned(40, 7),to_unsigned(47, 7),to_unsigned(69, 7), to_unsigned(69, 7), 
to_unsigned(21, 7),to_unsigned(30, 7),to_unsigned(39, 7),to_unsigned(29, 7),to_unsigned(30, 7),to_unsigned(45, 7),to_unsigned(45, 7),to_unsigned(26, 7),to_unsigned(69, 7), 
to_unsigned(18, 7),to_unsigned(66, 7), to_unsigned(34, 7),to_unsigned(44, 7),to_unsigned(38, 7),to_unsigned(30, 7),to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), 
to_unsigned(2, 7),to_unsigned(33, 7),to_unsigned(26, 7),to_unsigned(39, 7),to_unsigned(47, 7),to_unsigned(43, 7),to_unsigned(30, 7),to_unsigned(69, 7), to_unsigned(69, 7), 
to_unsigned(12, 7),to_unsigned(40, 7),to_unsigned(43, 7),to_unsigned(44, 7),to_unsigned(46, 7),to_unsigned(43, 7),to_unsigned(30, 7),to_unsigned(69, 7), to_unsigned(69, 7), 
to_unsigned(19, 7),to_unsigned(26, 7),to_unsigned(41, 7),to_unsigned(40, 7),to_unsigned(45, 7),to_unsigned(34, 7),to_unsigned(32, 7),to_unsigned(30, 7),to_unsigned(69, 7), 
to_unsigned(14, 7),to_unsigned(46, 7),to_unsigned(43, 7),to_unsigned(26, 7),to_unsigned(32, 7),to_unsigned(26, 7),to_unsigned(39, 7),to_unsigned(69, 7), to_unsigned(69, 7), 
to_unsigned(2, 7),to_unsigned(40, 7),to_unsigned(37, 7),to_unsigned(65, 7), to_unsigned(43, 7),to_unsigned(30, 7),to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), 
to_unsigned(3, 7),to_unsigned(43, 7),to_unsigned(26, 7),to_unsigned(28, 7),to_unsigned(40, 7),to_unsigned(43, 7),to_unsigned(26, 7),to_unsigned(32, 7),to_unsigned(30, 7),
to_unsigned(21, 7),to_unsigned(40, 7),to_unsigned(37, 7),to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), 
to_unsigned(15, 7),to_unsigned(44, 7),to_unsigned(50, 7),to_unsigned(36, 7),to_unsigned(40, 7),to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), 
to_unsigned(4, 7),to_unsigned(39, 7),to_unsigned(45, 7),to_unsigned(43, 7),to_unsigned(26, 7),to_unsigned(47, 7),to_unsigned(30, 7),to_unsigned(69, 7), to_unsigned(69, 7), 
to_unsigned(3, 7),to_unsigned(40, 7),to_unsigned(46, 7),to_unsigned(29, 7),to_unsigned(40, 7),to_unsigned(46, 7),to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), 
to_unsigned(1, 7),to_unsigned(43, 7),to_unsigned(46, 7),to_unsigned(38, 7),to_unsigned(30, 7),to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), 
to_unsigned(2, 7),to_unsigned(33, 7),to_unsigned(26, 7),to_unsigned(43, 7),to_unsigned(32, 7),to_unsigned(30, 7),to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), 
to_unsigned(1, 7),to_unsigned(26, 7),to_unsigned(37, 7),to_unsigned(40, 7),to_unsigned(38, 7),to_unsigned(27, 7),to_unsigned(43, 7),to_unsigned(30, 7),to_unsigned(69, 7), 
to_unsigned(6, 7),to_unsigned(34, 7),to_unsigned(31, 7),to_unsigned(37, 7),to_unsigned(30, 7),to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), 
to_unsigned(2, 7),to_unsigned(40, 7),to_unsigned(28, 7),to_unsigned(33, 7),to_unsigned(38, 7),to_unsigned(26, 7),to_unsigned(43, 7),to_unsigned(69, 7), to_unsigned(69, 7), 
to_unsigned(0, 7),to_unsigned(45, 7),to_unsigned(45, 7),to_unsigned(26, 7),to_unsigned(42, 7),to_unsigned(46, 7),to_unsigned(30, 7),to_unsigned(69, 7), to_unsigned(69, 7), 
to_unsigned(14, 7),to_unsigned(27, 7),to_unsigned(35, 7),to_unsigned(30, 7),to_unsigned(45, 7),to_unsigned(44, 7),to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), 
to_unsigned(15, 7),to_unsigned(40, 7),to_unsigned(36, 7),to_unsigned(66, 7), to_unsigned(38, 7),to_unsigned(40, 7),to_unsigned(39, 7),to_unsigned(44, 7),to_unsigned(69, 7), 
to_unsigned(5, 7),to_unsigned(46, 7),to_unsigned(34, 7),to_unsigned(45, 7),to_unsigned(30, 7),to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), to_unsigned(69, 7), 
to_unsigned(2, 7),to_unsigned(67, 7), to_unsigned(30, 7),to_unsigned(44, 7),to_unsigned(45, 7),to_unsigned(69, 7), to_unsigned(30, 7),to_unsigned(31, 7),to_unsigned(31, 7),to_unsigned(34, 7),to_unsigned(28, 7),to_unsigned(26, 7),to_unsigned(28, 7),to_unsigned(30, 7),
to_unsigned(2, 7),to_unsigned(30, 7),to_unsigned(69, 7), to_unsigned(39, 7),to_unsigned(67, 7), to_unsigned(30, 7),to_unsigned(44, 7),to_unsigned(45, 7),to_unsigned(69, 7), to_unsigned(41, 7),to_unsigned(26, 7),to_unsigned(44, 7),to_unsigned(69, 7), to_unsigned(45, 7),to_unsigned(43, 7),to_unsigned(65, 7), to_unsigned(44, 7),to_unsigned(69, 7), to_unsigned(30, 7),to_unsigned(31, 7),to_unsigned(31, 7),to_unsigned(34, 7),to_unsigned(28, 7),to_unsigned(26, 7),to_unsigned(28, 7),to_unsigned(30, 7),
to_unsigned(0, 7),to_unsigned(45, 7),to_unsigned(45, 7),to_unsigned(26, 7),to_unsigned(42, 7),to_unsigned(46, 7),to_unsigned(30, 7),to_unsigned(69, 7), to_unsigned(28, 7),to_unsigned(40, 7),to_unsigned(43, 7),to_unsigned(43, 7),to_unsigned(30, 7),to_unsigned(28, 7),to_unsigned(45, 7),to_unsigned(30, 7),
to_unsigned(1, 7),to_unsigned(34, 7),to_unsigned(30, 7),to_unsigned(39, 7),to_unsigned(47, 7),to_unsigned(30, 7),to_unsigned(39, 7),to_unsigned(46, 7),to_unsigned(30, 7),to_unsigned(69, 7), to_unsigned(29, 7),to_unsigned(26, 7),to_unsigned(39, 7),to_unsigned(44, 7),
to_unsigned(41, 7),to_unsigned(40, 7),to_unsigned(36, 7),to_unsigned(66, 7), to_unsigned(38, 7),to_unsigned(40, 7),to_unsigned(39, 7),to_unsigned(69, 7), to_unsigned(44, 7),to_unsigned(34, 7),to_unsigned(37, 7),to_unsigned(34, 7),to_unsigned(28, 7),to_unsigned(34, 7),to_unsigned(46, 7),to_unsigned(38, 7),
to_unsigned(2, 7),to_unsigned(33, 7),to_unsigned(40, 7),to_unsigned(34, 7),to_unsigned(44, 7),to_unsigned(34, 7),to_unsigned(44, 7),to_unsigned(44, 7),to_unsigned(30, 7),to_unsigned(51, 7),
to_unsigned(15, 7),to_unsigned(26, 7),to_unsigned(44, 7),to_unsigned(69, 7), to_unsigned(34, 7),to_unsigned(38, 7),to_unsigned(41, 7),to_unsigned(37, 7),to_unsigned(66, 7), to_unsigned(38, 7),to_unsigned(30, 7),to_unsigned(39, 7),to_unsigned(45, 7),to_unsigned(66, 7), 
to_unsigned(14, 7),to_unsigned(39, 7),to_unsigned(69, 7), to_unsigned(39, 7),to_unsigned(30, 7),to_unsigned(69, 7), to_unsigned(31, 7),to_unsigned(46, 7),to_unsigned(34, 7),to_unsigned(45, 7),to_unsigned(69, 7), to_unsigned(41, 7),to_unsigned(26, 7),to_unsigned(44, 7),
to_unsigned(37, 7),to_unsigned(40, 7),to_unsigned(43, 7),to_unsigned(44, 7),to_unsigned(69, 7), to_unsigned(29, 7),to_unsigned(67, 7), to_unsigned(46, 7),to_unsigned(39, 7),to_unsigned(69, 7), to_unsigned(28, 7),to_unsigned(40, 7),to_unsigned(38, 7),to_unsigned(27, 7),to_unsigned(26, 7),to_unsigned(45, 7),
to_unsigned(68, 7),
to_unsigned(0, 7));
  -- QUELQUES PETITES MODIFICATIONS FAITES POUR AIDER VIVADO A FAIRE LES BONS
  -- CHOIX D'IMPLEMENTATION...
begin

process(clk)
begin
    if rising_edge(clk) then
        if unsigned(addr_r) < to_unsigned(578, 10) then
        data_out <= std_logic_vector(rom(to_integer(unsigned(addr_r))));
        end if;
    end if;
end process;


end Behavioral;
