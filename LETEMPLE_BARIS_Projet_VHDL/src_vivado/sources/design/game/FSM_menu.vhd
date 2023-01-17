--------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/22/2022 03:16:53 PM
-- Design Name: 
-- Module Name: fsm_MP3 - Behavioral
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

entity fsm_menu is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           position : in std_logic_vector(1 downto 0) ;
           fwd : in STD_LOGIC;
           bwd : in STD_LOGIC;
           dead : in std_logic ;
           player : out STD_LOGIC;
           stage : out std_logic_vector (3 downto 0);
           poke1 : out std_logic_vector (1 downto 0);
           poke2 : out std_logic_vector (1 downto 0);
           atk : out std_logic_vector (1 downto 0));
end fsm_menu;

architecture bhv of fsm_menu is

    type states is (init,menu,attack_menu, attack_text , attack_efficiency,damage_calcul,life_calcul, pokemon_menu ,pokemon_switch,dead_test,bag,run, switch);
    signal current_state, next_state : states;
    signal player_id,newturn,enable : std_logic;
    signal cnt : unsigned(2 downto 0);
    
begin

process(clk,rst)
begin
    if(rising_edge(clk)) then
        if(rst = '1') then 
            current_state <= init;
        else
            current_state <= next_state;   
            if enable = '1' then
                cnt <=cnt + TO_UNSIGNED (1,3);
            else   
                cnt <=TO_UNSIGNED (0,3);
            end if;
        end if;
    end if;
end process;

process (current_state, fwd, bwd,dead,position,cnt,newturn)
begin
    case current_state is
        when init =>
            if(fwd = '1') then
                next_state <= menu;
            else
                next_state <= init;
            end if;
        when menu =>
            enable <= '0';
            newturn <= '0';
            if(fwd = '1') then
                case position is
                    when "00" =>
                        next_state <= attack_menu;
                    when "01" =>
                        next_state <= bag;
                    when "10" =>
                        next_state <= pokemon_menu;
                    when "11" =>
                        next_state <= run;
                    when others =>
                        next_state <= menu;
                end case;        
            else
                next_state <= menu;
            end if;
        when attack_menu =>
            if(fwd = '1') then
                next_state <= attack_text;       
            elsif(bwd = '1') then
                next_state <= menu;
            else
                next_state <= attack_menu;
            end if;
        when attack_text  =>
            if(fwd = '1') then
                next_state <= damage_calcul ;
            else
                next_state <= attack_text;
            end if;
        when damage_calcul =>
            next_state <= life_calcul;
        when life_calcul =>
            next_state <= attack_efficiency;
        when attack_efficiency =>
            if(fwd = '1') then
                next_state <= switch;
            else
                next_state <= attack_efficiency;
            end if;
        when pokemon_menu  =>
            enable <= '0';
            if(fwd = '1') then
                next_state <= pokemon_switch ;
            elsif(dead = '1') then
                next_state <= pokemon_menu ; 
            elsif(bwd = '1') then
                next_state <= menu; 
            else
                next_state <= pokemon_menu ;
            end if;        
        when pokemon_switch  =>
            if(fwd = '1') then
                next_state <= dead_test;     
            else
                next_state <= pokemon_switch;
            end if;
        when dead_test =>
            enable <= '1';
            if cnt = to_unsigned(3, 3) then
                if dead = '1' then
                    next_state <= pokemon_menu;
                elsif newturn = '1' then
                    next_state <= menu;   
                else
                    next_state <= switch;   
                end if;   
            else
                next_state <= dead_test;    
            end if;
        when bag  =>
            if(fwd = '1') then
                next_state <= menu;
            else
                next_state <= bag;
            end if;
        when run =>
            if(fwd = '1') then
                next_state <= menu;
            else
                next_state <= run;
            end if;
        when switch =>
                enable <= '0';
                if(dead='1') then
                    next_state <= pokemon_menu;
                    newturn <= '1';
                else
                    next_state <= menu;
                    newturn <= '1';
                end if;
       when others =>
            next_state <= init;
   end case;
end process;


process (current_state)
begin
    case current_state is
        when init => 
            stage  <= "0000";
            poke1 <= "00";
            poke2 <= "00";
            player_id <= '0';
            atk <= "00";         
        when menu => 
            stage  <= "0001";            
        when attack_menu => 
            stage  <= "0010";    
        when attack_text =>
            stage  <= "0011";
            case position is
                when "00" =>
                    atk <= "00";
                when "01" =>
                    atk <= "01";
                when "10" =>
                    atk <= "10";
                when "11" =>
                    atk <= "11";
                when others =>
                    atk <= "00"; 
            end case;         
        when damage_calcul  => 
            stage  <= "0100";           
        when life_calcul => 
            stage  <= "0100";          
        when attack_efficiency => 
            stage  <= "0110";
        when pokemon_menu => 
            stage  <= "0111";
        when pokemon_switch=> 
            stage  <= "1000";
            if player_id='0'then
                case position is
                    when "00" =>
                        poke1 <= "00";
                    when "01" =>
                        poke1 <= "01";
                    when "10" =>
                        poke1 <= "10";
                    when "11" =>
                        poke1 <= "11";
                    when others =>
                        poke1 <= "00"; 
                end case;  
            else
                case position is
                    when "00" =>
                        poke2 <= "00";
                    when "01" =>
                        poke2 <= "01";
                    when "10" =>
                        poke2 <= "10";
                    when "11" =>
                        poke2 <= "11";
                    when others =>
                        poke2 <= "00"; 
                end case;  
            end if;
        when dead_test =>
            stage <= "1000";
        when bag  => 
            stage  <= "1001";
        when run => 
            stage  <= "1010";
        when switch =>
            player_id <= not(player_id); 
            stage  <= "1011";        
   end case;
end process;

player <= player_id;

end bhv;
