----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/07/2023 01:53:18 PM
-- Design Name: 
-- Module Name: game_display_interface - Behavioral
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

entity game_display_interface is
    Port (stage : in std_logic_vector(3 downto 0);
         atk : in std_logic_vector(1 downto 0);
         poke0 : in std_logic_vector(1 downto 0);
         poke1 : in std_logic_vector(1 downto 0);
         player : in std_logic;
         pos_cursor : in std_logic_vector(1 downto 0);
         efficiency : in std_logic_vector(1 downto 0);
         life_poke1 : in std_logic_vector(6 downto 0);
         life_poke2 : in std_logic_vector(6 downto 0);
         addr_line_1 : out std_logic_vector(9 downto 0);
         addr_line_2 : out std_logic_vector(9 downto 0);
         addr_line_3 : out std_logic_vector(9 downto 0);
         addr_choice_1 : out std_logic_vector(9 downto 0);
         addr_choice_2 : out std_logic_vector(9 downto 0);
         addr_choice_3 : out std_logic_vector(9 downto 0);
         addr_choice_4 : out std_logic_vector(9 downto 0);
         size_line_1 : out std_logic_vector(7 downto 0);
         size_line_2 : out std_logic_vector(7 downto 0);
         size_line_3 : out std_logic_vector(7 downto 0);
         life_ally : out std_logic_vector(6 downto 0);
         life_enemy : out std_logic_vector(6 downto 0);
         addr_ally : out std_logic_vector(17 downto 0);
         addr_enemy : out std_logic_vector(17 downto 0);
         cursor : out std_logic_vector(1 downto 0));
end game_display_interface;

architecture Behavioral of game_display_interface is

begin

    life_ally <= life_poke1 when player = '0' else life_poke2;
    life_enemy <= life_poke2 when player = '0' else life_poke1;
    cursor <= pos_cursor;
    process(stage, atk, poke0, poke1, player, pos_cursor, efficiency)
    begin
        case stage is
            when "0000" => -- Menu
                addr_line_1 <= std_logic_vector(to_unsigned(492, 10));
                addr_line_2 <= std_logic_vector(to_unsigned(506, 10));
                addr_line_3 <= std_logic_vector(to_unsigned(0, 10));
                size_line_1 <= std_logic_vector(to_unsigned(14, 8));
                size_line_2 <= std_logic_vector(to_unsigned(16, 8));
                size_line_3 <= std_logic_vector(to_unsigned(2, 8));
                addr_choice_1 <= std_logic_vector(to_unsigned(400, 10));
                addr_choice_2 <= std_logic_vector(to_unsigned(409, 10));
                addr_choice_3 <= std_logic_vector(to_unsigned(418, 10));
                addr_choice_4 <= std_logic_vector(to_unsigned(427, 10));
            when "0001" => -- Choix menu
                addr_line_1 <= std_logic_vector(to_unsigned(0, 10));
                addr_line_2 <= std_logic_vector(to_unsigned(522, 10));
                addr_line_3 <= std_logic_vector(to_unsigned(0, 10));
                size_line_1 <= std_logic_vector(to_unsigned(2, 8));
                size_line_2 <= std_logic_vector(to_unsigned(10, 8));
                size_line_3 <= std_logic_vector(to_unsigned(2, 8));
                addr_choice_1 <= std_logic_vector(to_unsigned(400, 10));
                addr_choice_2 <= std_logic_vector(to_unsigned(409, 10));
                addr_choice_3 <= std_logic_vector(to_unsigned(418, 10));
                addr_choice_4 <= std_logic_vector(to_unsigned(427, 10));
            when "0010" => -- Choix Attaque
                addr_line_1 <= std_logic_vector(to_unsigned(0, 10));
                addr_line_2 <= std_logic_vector(to_unsigned(522, 10));
                addr_line_3 <= std_logic_vector(to_unsigned(400, 10));
                size_line_1 <= std_logic_vector(to_unsigned(2, 8));
                size_line_2 <= std_logic_vector(to_unsigned(10, 8));
                size_line_3 <= std_logic_vector(to_unsigned(9, 8));
                if player = '0' then
                    case poke0 is
                        when "00" =>
                            addr_choice_1 <= std_logic_vector(to_unsigned(256, 10)); --Séisme
                            addr_choice_2 <= std_logic_vector(to_unsigned(265, 10)); --Chanvre
                            addr_choice_3 <= std_logic_vector(to_unsigned(274, 10)); --Morsure
                            addr_choice_4 <= std_logic_vector(to_unsigned(283, 10)); --Tapotige
                        when "01" =>
                            addr_choice_1 <= std_logic_vector(to_unsigned(328, 10)); --Psyko
                            addr_choice_2 <= std_logic_vector(to_unsigned(337, 10)); --Entrave
                            addr_choice_3 <= std_logic_vector(to_unsigned(346, 10)); --Doudou
                            addr_choice_4 <= std_logic_vector(to_unsigned(355, 10)); --Brume
                        when "10" =>
                            addr_choice_1 <= std_logic_vector(to_unsigned(148, 10)); --Picard
                            addr_choice_2 <= std_logic_vector(to_unsigned(157, 10)); --Picpic
                            addr_choice_3 <= std_logic_vector(to_unsigned(166, 10)); --Charge
                            addr_choice_4 <= std_logic_vector(to_unsigned(175, 10)); --Surf
                        when "11" =>
                            addr_choice_1 <= std_logic_vector(to_unsigned(112, 10)); --Bombre
                            addr_choice_2 <= std_logic_vector(to_unsigned(121, 10)); --Gaz Tox
                            addr_choice_3 <= std_logic_vector(to_unsigned(130, 10)); --Larcin
                            addr_choice_4 <= std_logic_vector(to_unsigned(139, 10)); --Impacte
                        when others =>
                            null;
                    end case;
                else
                    case poke1 is
                        when "00" =>
                            addr_choice_1 <= std_logic_vector(to_unsigned(364, 10)); --Charge
                            addr_choice_2 <= std_logic_vector(to_unsigned(373, 10)); --Balombre
                            addr_choice_3 <= std_logic_vector(to_unsigned(382, 10)); --Gifle
                            addr_choice_4 <= std_logic_vector(to_unsigned(391, 10)); --Cochmar
                        when "01" =>
                            addr_choice_1 <= std_logic_vector(to_unsigned(292, 10)); --Ouragan
                            addr_choice_2 <= std_logic_vector(to_unsigned(301, 10)); --Colère
                            addr_choice_3 <= std_logic_vector(to_unsigned(310, 10)); --Dracorage
                            addr_choice_4 <= std_logic_vector(to_unsigned(319, 10)); --Vol
                        when "10" =>
                            addr_choice_1 <= std_logic_vector(to_unsigned(184, 10)); --Eclair
                            addr_choice_2 <= std_logic_vector(to_unsigned(193, 10)); --Kedfer
                            addr_choice_3 <= std_logic_vector(to_unsigned(202, 10)); --Eclatroc
                            addr_choice_4 <= std_logic_vector(to_unsigned(211, 10)); --Tunnel
                        when "11" =>
                            addr_choice_1 <= std_logic_vector(to_unsigned(220, 10)); --Griffe
                            addr_choice_2 <= std_logic_vector(to_unsigned(229, 10)); --High Kik
                            addr_choice_3 <= std_logic_vector(to_unsigned(238, 10)); --Molotov
                            addr_choice_4 <= std_logic_vector(to_unsigned(247, 10)); --Vendetta
                        when others =>
                            null;
                    end case;
                end if;
            when "0011" | "0100" | "0101" => -- Attaque

                if player = '0' then
                    case poke0 is
                        when "00" =>
                            addr_line_1 <= std_logic_vector(to_unsigned(72, 10)); --Torterra
                            case atk is
                                when "00" =>
                                    addr_line_3 <= std_logic_vector(to_unsigned(256, 10)); --Séisme
                                when "01" =>
                                    addr_line_3 <= std_logic_vector(to_unsigned(265, 10)); --Chanvre
                                when "10" =>
                                    addr_line_3 <= std_logic_vector(to_unsigned(274, 10)); --Morsure
                                when "11" =>
                                    addr_line_3 <= std_logic_vector(to_unsigned(283, 10)); --Tapotige
                                when others =>
                                    null;
                            end case;
                        when "01" =>
                            addr_line_1 <= std_logic_vector(to_unsigned(92, 10)); --Mew
                            case atk is
                                when "00" =>
                                    addr_line_3 <= std_logic_vector(to_unsigned(328, 10)); --Psyko
                                when "01" =>
                                    addr_line_3 <= std_logic_vector(to_unsigned(337, 10)); --Entrave
                                when "10" =>
                                    addr_line_3 <= std_logic_vector(to_unsigned(346, 10)); --Doudou
                                when "11" =>
                                    addr_line_3 <= std_logic_vector(to_unsigned(355, 10)); --Brume
                                when others =>
                                    null;
                            end case;
                        when "10" =>
                            addr_line_1 <= std_logic_vector(to_unsigned(42, 10)); --Tiplouf
                            case atk is
                                when "00" =>
                                    addr_line_3 <= std_logic_vector(to_unsigned(148, 10)); --Picard
                                when "01" =>
                                    addr_line_3 <= std_logic_vector(to_unsigned(157, 10)); --Picpic
                                when "10" =>
                                    addr_line_3 <= std_logic_vector(to_unsigned(166, 10)); --Charge
                                when "11" =>
                                    addr_line_3 <= std_logic_vector(to_unsigned(175, 10)); --Surf
                                when others =>
                                    null;
                            end case;
                        when "11" =>
                            addr_line_1 <= std_logic_vector(to_unsigned(32, 10)); -- Ectoplasma
                            case atk is
                                when "00" =>
                                    addr_line_3 <= std_logic_vector(to_unsigned(112, 10)); --Bombre
                                when "01" =>
                                    addr_line_3 <= std_logic_vector(to_unsigned(121, 10)); --Gaz Tox
                                when "10" =>
                                    addr_line_3 <= std_logic_vector(to_unsigned(130, 10)); --Larcin
                                when "11" =>
                                    addr_line_3 <= std_logic_vector(to_unsigned(139, 10)); --Impacte
                                when others =>
                                    null;
                            end case;
                        when others =>
                            null;
                    end case;
                else
                    case poke1 is
                        when "00" =>
                            addr_line_1 <= std_logic_vector(to_unsigned(102, 10)); --Ronflex
                            case atk is
                                when "00" =>
                                    addr_line_3 <= std_logic_vector(to_unsigned(364, 10)); --Charge
                                when "01" =>
                                    addr_line_3 <= std_logic_vector(to_unsigned(373, 10)); --Balombre
                                when "10" =>
                                    addr_line_3 <= std_logic_vector(to_unsigned(382, 10)); --Gifle
                                when "11" =>
                                    addr_line_3 <= std_logic_vector(to_unsigned(391, 10)); --Cochmar
                                when others =>
                                    null;
                            end case;
                        when "01" =>
                            addr_line_1 <= std_logic_vector(to_unsigned(82, 10)); --Rayquaza
                            case atk is
                                when "00" =>
                                    addr_line_3 <= std_logic_vector(to_unsigned(292, 10)); --Ouragan
                                when "01" =>
                                    addr_line_3 <= std_logic_vector(to_unsigned(301, 10)); --Colère
                                when "10" =>
                                    addr_line_3 <= std_logic_vector(to_unsigned(310, 10)); --Dracorage
                                when "11" =>
                                    addr_line_3 <= std_logic_vector(to_unsigned(319, 10)); --Vol
                                when others =>
                                    null;
                            end case;
                        when "10" =>
                            addr_line_1 <= std_logic_vector(to_unsigned(42, 10)); --Pikachu
                            case atk is
                                when "00" =>
                                    addr_line_3 <= std_logic_vector(to_unsigned(184, 10)); --Eclair
                                when "01" =>
                                    addr_line_3 <= std_logic_vector(to_unsigned(193, 10)); --Kedfer
                                when "10" =>
                                    addr_line_3 <= std_logic_vector(to_unsigned(202, 10)); --Eclatroc
                                when "11" =>
                                    addr_line_3 <= std_logic_vector(to_unsigned(211, 10)); --Tunnel
                                when others =>
                                    null;
                            end case;
                        when "11" =>
                            addr_line_1 <= std_logic_vector(to_unsigned(42, 10)); -- Braségali
                            case atk is
                                when "00" =>
                                    addr_line_3 <= std_logic_vector(to_unsigned(220, 10)); --Griffe
                                when "01" =>
                                    addr_line_3 <= std_logic_vector(to_unsigned(229, 10)); --High Kik
                                when "10" =>
                                    addr_line_3 <= std_logic_vector(to_unsigned(238, 10)); --Molotov
                                when "11" =>
                                    addr_line_3 <= std_logic_vector(to_unsigned(247, 10)); --Vendetta
                                when others =>
                                    null;
                            end case;
                        when others =>
                            null;
                    end case;
                end if;
                if player = '0' then
                    case poke0 is
                        when "00" =>
                            addr_choice_1 <= std_logic_vector(to_unsigned(256, 10)); --Séisme
                            addr_choice_2 <= std_logic_vector(to_unsigned(265, 10)); --Chanvre
                            addr_choice_3 <= std_logic_vector(to_unsigned(274, 10)); --Morsure
                            addr_choice_4 <= std_logic_vector(to_unsigned(283, 10)); --Tapotige
                        when "01" =>
                            addr_choice_1 <= std_logic_vector(to_unsigned(328, 10)); --Psyko
                            addr_choice_2 <= std_logic_vector(to_unsigned(337, 10)); --Entrave
                            addr_choice_3 <= std_logic_vector(to_unsigned(346, 10)); --Doudou
                            addr_choice_4 <= std_logic_vector(to_unsigned(355, 10)); --Brume
                        when "10" =>
                            addr_choice_1 <= std_logic_vector(to_unsigned(148, 10)); --Picard
                            addr_choice_2 <= std_logic_vector(to_unsigned(157, 10)); --Picpic
                            addr_choice_3 <= std_logic_vector(to_unsigned(166, 10)); --Charge
                            addr_choice_4 <= std_logic_vector(to_unsigned(175, 10)); --Surf
                        when "11" =>
                            addr_choice_1 <= std_logic_vector(to_unsigned(112, 10)); --Bombre
                            addr_choice_2 <= std_logic_vector(to_unsigned(121, 10)); --Gaz Tox
                            addr_choice_3 <= std_logic_vector(to_unsigned(130, 10)); --Larcin
                            addr_choice_4 <= std_logic_vector(to_unsigned(139, 10)); --Impacte
                        when others =>
                            null;
                    end case;
                else
                    case poke1 is
                        when "00" =>
                            addr_choice_1 <= std_logic_vector(to_unsigned(364, 10)); --Charge
                            addr_choice_2 <= std_logic_vector(to_unsigned(373, 10)); --Balombre
                            addr_choice_3 <= std_logic_vector(to_unsigned(382, 10)); --Gifle
                            addr_choice_4 <= std_logic_vector(to_unsigned(391, 10)); --Cochmar
                        when "01" =>
                            addr_choice_1 <= std_logic_vector(to_unsigned(292, 10)); --Ouragan
                            addr_choice_2 <= std_logic_vector(to_unsigned(301, 10)); --Colère
                            addr_choice_3 <= std_logic_vector(to_unsigned(310, 10)); --Dracorage
                            addr_choice_4 <= std_logic_vector(to_unsigned(319, 10)); --Vol
                        when "10" =>
                            addr_choice_1 <= std_logic_vector(to_unsigned(184, 10)); --Eclair
                            addr_choice_2 <= std_logic_vector(to_unsigned(193, 10)); --Kedfer
                            addr_choice_3 <= std_logic_vector(to_unsigned(202, 10)); --Eclatroc
                            addr_choice_4 <= std_logic_vector(to_unsigned(211, 10)); --Tunnel
                        when "11" =>
                            addr_choice_1 <= std_logic_vector(to_unsigned(220, 10)); --Griffe
                            addr_choice_2 <= std_logic_vector(to_unsigned(229, 10)); --High Kik
                            addr_choice_3 <= std_logic_vector(to_unsigned(238, 10)); --Molotov
                            addr_choice_4 <= std_logic_vector(to_unsigned(247, 10)); --Vendetta
                        when others =>
                            null;
                    end case;
                end if;

                addr_line_2 <= std_logic_vector(to_unsigned(400, 10));
                size_line_1 <= std_logic_vector(to_unsigned(10, 8));
                size_line_2 <= std_logic_vector(to_unsigned(9, 8));
                size_line_3 <= std_logic_vector(to_unsigned(9, 8));
            when "0110" => -- Affichage efficacité attaque
                addr_line_1 <= std_logic_vector(to_unsigned(0, 10));
                addr_line_3 <= std_logic_vector(to_unsigned(0, 10));
                size_line_1 <= std_logic_vector(to_unsigned(2, 8));
                size_line_3 <= std_logic_vector(to_unsigned(2, 8));

                case efficiency is
                    when "00" =>
                        addr_line_2 <= std_logic_vector(to_unsigned(476, 10));
                        size_line_2 <= std_logic_vector(to_unsigned(16, 8));
                    when "01" =>
                        addr_line_2 <= std_logic_vector(to_unsigned(436, 10));
                        size_line_2 <= std_logic_vector(to_unsigned(25, 8));
                    when "10" =>
                        addr_line_2 <= std_logic_vector(to_unsigned(450, 10));
                        size_line_2 <= std_logic_vector(to_unsigned(14, 8));
                    when others =>
                        addr_line_2 <= std_logic_vector(to_unsigned(476, 10));
                        size_line_2 <= std_logic_vector(to_unsigned(16, 8));

                end case;

                if player = '0' then
                    case poke0 is
                        when "00" =>
                            addr_choice_1 <= std_logic_vector(to_unsigned(256, 10)); --Séisme
                            addr_choice_2 <= std_logic_vector(to_unsigned(265, 10)); --Chanvre
                            addr_choice_3 <= std_logic_vector(to_unsigned(274, 10)); --Morsure
                            addr_choice_4 <= std_logic_vector(to_unsigned(283, 10)); --Tapotige
                        when "01" =>
                            addr_choice_1 <= std_logic_vector(to_unsigned(328, 10)); --Psyko
                            addr_choice_2 <= std_logic_vector(to_unsigned(337, 10)); --Entrave
                            addr_choice_3 <= std_logic_vector(to_unsigned(346, 10)); --Doudou
                            addr_choice_4 <= std_logic_vector(to_unsigned(355, 10)); --Brume
                        when "10" =>
                            addr_choice_1 <= std_logic_vector(to_unsigned(148, 10)); --Picard
                            addr_choice_2 <= std_logic_vector(to_unsigned(157, 10)); --Picpic
                            addr_choice_3 <= std_logic_vector(to_unsigned(166, 10)); --Charge
                            addr_choice_4 <= std_logic_vector(to_unsigned(175, 10)); --Surf
                        when "11" =>
                            addr_choice_1 <= std_logic_vector(to_unsigned(112, 10)); --Bombre
                            addr_choice_2 <= std_logic_vector(to_unsigned(121, 10)); --Gaz Tox
                            addr_choice_3 <= std_logic_vector(to_unsigned(130, 10)); --Larcin
                            addr_choice_4 <= std_logic_vector(to_unsigned(139, 10)); --Impacte
                        when others =>
                            null;
                    end case;
                else
                    case poke1 is
                        when "00" =>
                            addr_choice_1 <= std_logic_vector(to_unsigned(364, 10)); --Charge
                            addr_choice_2 <= std_logic_vector(to_unsigned(373, 10)); --Balombre
                            addr_choice_3 <= std_logic_vector(to_unsigned(382, 10)); --Gifle
                            addr_choice_4 <= std_logic_vector(to_unsigned(391, 10)); --Cochmar
                        when "01" =>
                            addr_choice_1 <= std_logic_vector(to_unsigned(292, 10)); --Ouragan
                            addr_choice_2 <= std_logic_vector(to_unsigned(301, 10)); --Colère
                            addr_choice_3 <= std_logic_vector(to_unsigned(310, 10)); --Dracorage
                            addr_choice_4 <= std_logic_vector(to_unsigned(319, 10)); --Vol
                        when "10" =>
                            addr_choice_1 <= std_logic_vector(to_unsigned(184, 10)); --Eclair
                            addr_choice_2 <= std_logic_vector(to_unsigned(193, 10)); --Kedfer
                            addr_choice_3 <= std_logic_vector(to_unsigned(202, 10)); --Eclatroc
                            addr_choice_4 <= std_logic_vector(to_unsigned(211, 10)); --Tunnel
                        when "11" =>
                            addr_choice_1 <= std_logic_vector(to_unsigned(220, 10)); --Griffe
                            addr_choice_2 <= std_logic_vector(to_unsigned(229, 10)); --High Kik
                            addr_choice_3 <= std_logic_vector(to_unsigned(238, 10)); --Molotov
                            addr_choice_4 <= std_logic_vector(to_unsigned(247, 10)); --Vendetta
                        when others =>
                            null;
                    end case;
                end if;
            when "0111" | "1000" => -- Choix Pokémon
                addr_line_1 <= std_logic_vector(to_unsigned(0, 10));
                addr_line_2 <= std_logic_vector(to_unsigned(522, 10));
                addr_line_3 <= std_logic_vector(to_unsigned(0, 10));
                size_line_1 <= std_logic_vector(to_unsigned(2, 8));
                size_line_2 <= std_logic_vector(to_unsigned(10, 8));
                size_line_3 <= std_logic_vector(to_unsigned(2, 8));

                if player = '0' then
                    addr_choice_1 <= std_logic_vector(to_unsigned(72, 10)); --Torterra
                    addr_choice_2 <= std_logic_vector(to_unsigned(92, 10)); --Mew
                    addr_choice_3 <= std_logic_vector(to_unsigned(42, 10)); --Tiplouf
                    addr_choice_4 <= std_logic_vector(to_unsigned(32, 10)); --Ectoplasma
                else
                    addr_choice_1 <= std_logic_vector(to_unsigned(102, 10)); --Ronflex
                    addr_choice_2 <= std_logic_vector(to_unsigned(82, 10)); --Rayquaza
                    addr_choice_3 <= std_logic_vector(to_unsigned(52, 10)); --Pikachu
                    addr_choice_4 <= std_logic_vector(to_unsigned(62, 10)); --Braségali
                end if;
            when "1001" => -- Sac
                addr_line_1 <= std_logic_vector(to_unsigned(0, 10));
                addr_line_2 <= std_logic_vector(to_unsigned(532, 10));
                addr_line_3 <= std_logic_vector(to_unsigned(0, 10));
                size_line_1 <= std_logic_vector(to_unsigned(2, 8));
                size_line_2 <= std_logic_vector(to_unsigned(14, 8));
                size_line_3 <= std_logic_vector(to_unsigned(2, 8));
                addr_choice_1 <= std_logic_vector(to_unsigned(400, 10));
                addr_choice_2 <= std_logic_vector(to_unsigned(409, 10));
                addr_choice_3 <= std_logic_vector(to_unsigned(418, 10));
                addr_choice_4 <= std_logic_vector(to_unsigned(427, 10));
            when "1010" => -- Fuite
                addr_line_1 <= std_logic_vector(to_unsigned(546, 10));
                addr_line_2 <= std_logic_vector(to_unsigned(560, 10));
                addr_line_3 <= std_logic_vector(to_unsigned(0, 10));
                size_line_1 <= std_logic_vector(to_unsigned(14, 8));
                size_line_2 <= std_logic_vector(to_unsigned(16, 8));
                size_line_3 <= std_logic_vector(to_unsigned(2, 8));
                addr_choice_1 <= std_logic_vector(to_unsigned(400, 10));
                addr_choice_2 <= std_logic_vector(to_unsigned(409, 10));
                addr_choice_3 <= std_logic_vector(to_unsigned(418, 10));
                addr_choice_4 <= std_logic_vector(to_unsigned(427, 10));
            when others =>
                addr_line_1 <= std_logic_vector(to_unsigned(492, 10));
                addr_line_2 <= std_logic_vector(to_unsigned(586, 10));
                addr_line_3 <= std_logic_vector(to_unsigned(0, 10));
                size_line_1 <= std_logic_vector(to_unsigned(14, 8));
                size_line_2 <= std_logic_vector(to_unsigned(16, 8));
                size_line_3 <= std_logic_vector(to_unsigned(2, 8));
                addr_choice_1 <= std_logic_vector(to_unsigned(368, 10));
                addr_choice_2 <= std_logic_vector(to_unsigned(377, 10));
                addr_choice_3 <= std_logic_vector(to_unsigned(386, 10));
                addr_choice_4 <= std_logic_vector(to_unsigned(395, 10));
        end case;
    end process;

    process(player, poke0, poke1)
    begin
        if player = '0' then
            case poke0 is
                when "00" =>
                    addr_ally <= std_logic_vector(to_unsigned(24576, 18)); --Torterra
                when "01" =>
                    addr_ally <= std_logic_vector(to_unsigned(8192, 18));  --Mew
                when "10" =>
                    addr_ally <= std_logic_vector(to_unsigned(57344, 18)); --Tiplouf
                when "11" =>
                    addr_ally <= std_logic_vector(to_unsigned(49152, 18)); --Ectoplasma
                when others =>
                    null;
            end case;
            case poke1 is
                when "00" =>
                    addr_enemy <= std_logic_vector(to_unsigned(4096, 18)); --Ronflex
                when "01" =>
                    addr_enemy <= std_logic_vector(to_unsigned(20480, 18)); --Rayquaza
                when "10" =>
                    addr_enemy <= std_logic_vector(to_unsigned(45056, 18)); --Pikachu
                when "11" =>
                    addr_enemy <= std_logic_vector(to_unsigned(36864, 18)); --Braségali
                when others =>
                    null;
            end case;
        else
            case poke0 is
                when "00" =>
                    addr_enemy <= std_logic_vector(to_unsigned(28672, 18)); --Torterra
                when "01" =>
                    addr_enemy <= std_logic_vector(to_unsigned(12288, 18));  --Mew
                when "10" =>
                    addr_enemy <= std_logic_vector(to_unsigned(61440, 18)); --Tiplouf
                when "11" =>
                    addr_enemy <= std_logic_vector(to_unsigned(53248, 18)); --Ectoplasma
                when others =>
                    null;
            end case;
            case poke1 is
                when "00" =>
                    addr_ally <= std_logic_vector(to_unsigned(0, 18));     --Ronflex
                when "01" =>
                    addr_ally <= std_logic_vector(to_unsigned(16384, 18)); --Rayquaza
                when "10" =>
                    addr_ally <= std_logic_vector(to_unsigned(40960, 18)); --Pikachu
                when "11" =>
                    addr_ally <= std_logic_vector(to_unsigned(32768, 18)); --Braségali
                when others =>
                    null;
            end case;
        end if;
    end process;
end Behavioral;
