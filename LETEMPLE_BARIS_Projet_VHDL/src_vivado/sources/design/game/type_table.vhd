----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/06/2023 05:33:04 PM
-- Design Name: 
-- Module Name: type_table - Behavioral
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

entity type_table is
    Port (  atk_type : in std_logic_vector  (4 downto 0);
            def_type : in std_logic_vector  (4 downto 0);
            type_mult : out std_logic_vector (1 downto 0) );
end type_table;

architecture Behavioral of type_table is

begin

process(atk_type, def_type)
begin
case atk_type is
    when "00000" => --normal
        case def_type is 
            when "01100" =>
                type_mult <= "10";
            when "10000" =>
                type_mult <= "10";
            when "01101" =>
                type_mult <= "11";
            when others =>
                type_mult <= "00";
        end case;
    when "00001" => --feu
        case def_type is 
            when "00001" =>
                type_mult <= "10";
            when "00010" =>
                type_mult <= "10";
            when "00011" =>
                type_mult <= "01";
            when "00101" =>
                type_mult <= "01";
            when "01011" =>
                type_mult <= "01";
            when "01100" =>
                type_mult <= "10";                
            when "01110" =>
                type_mult <= "10";
            when "10000" =>
                type_mult <= "01";
            when others =>
                type_mult <= "00";
        end case; 
    when "00010" => --eau 
        case def_type is 
            when "00001" =>
                type_mult <= "01";
            when "00010" =>
                type_mult <= "10";
            when "00011" =>
                type_mult <= "10";
            when "01000" =>
                type_mult <= "01";
            when "01100" =>
                type_mult <= "01";              
            when "01110" =>
                type_mult <= "10";
            when others =>
                type_mult <= "00";
        end case;
    when "00011" => --plante
        case def_type is 
            when "00001" =>
                type_mult <= "10";
            when "00010" =>
                type_mult <= "01";
            when "00011" =>
                type_mult <= "10";
            when "00111" =>
                type_mult <= "10";
            when "01000" =>
                type_mult <= "01";
            when "01001" =>
                type_mult <= "10";     
            when "01011" =>
                type_mult <= "10";               
            when "01100" =>
                type_mult <= "01";                
            when "01110" =>
                type_mult <= "10";
            when "10000" =>
                type_mult <= "10";
            when others =>
                type_mult <= "00";
        end case; 
    
    when "00100" => --elec
        case def_type is 
            when "00010" =>
                type_mult <= "01";
            when "00011" =>
                type_mult <= "10";
            when "00100" =>
                type_mult <= "10";
            when "01000" =>
                type_mult <= "11";
            when "01001" =>
                type_mult <= "01";              
            when "01110" =>
                type_mult <= "10";
            when others =>
                type_mult <= "00";
        end case; 
    
    when "00101" => --ice  
        
        case def_type is 
            when "00001" =>
                type_mult <= "10";
            when "00010" =>
                type_mult <= "10";
            when "00011" =>
                type_mult <= "01";
            when "00101" =>
                type_mult <= "10";
            when "01000" =>
                type_mult <= "01";
            when "01001" =>
                type_mult <= "01";              
            when "01110" =>
                type_mult <= "01";
            when "10000" =>
                type_mult <= "10";
            when others =>
                type_mult <= "00";
        end case; 
    
    when "00110" => --combat 
        
        case def_type is 
            when "00000" =>
                type_mult <= "01";
            when "00101" =>
                type_mult <= "01";
            when "00111" =>
                type_mult <= "10";
            when "01001" =>
                type_mult <= "10";   
            when "01010" =>
                type_mult <= "10";  
            when "01011" =>
                type_mult <= "10";             
            when "01100" =>
                type_mult <= "01";             
            when "01101" =>
                type_mult <= "11";
            when "01111" =>
                type_mult <= "01";
            when "10000" =>
                type_mult <= "01";
            when others =>
                type_mult <= "00";
        end case; 
    
    when "00111" => --poison 
        
        case def_type is 
            when "00011" =>
                type_mult <= "01";
            when "00111" =>
                type_mult <= "10";
            when "01000" =>
                type_mult <= "10";   
            when "01100" =>
                type_mult <= "10";  
            when "01101" =>
                type_mult <= "10";
            when "10000" =>
                type_mult <= "11";
            when others =>
                type_mult <= "00";
        end case; 
    
    when "01000" => --sol  
        case def_type is 
            when "00010" =>
                type_mult <= "01";
            when "00011" =>
                type_mult <= "10";  
            when "00100" =>
                type_mult <= "01";        
            when "00111" =>
                type_mult <= "01";
            when "01001" =>
                type_mult <= "11";   
            when "01011" =>
                type_mult <= "10";  
            when "01100" =>
                type_mult <= "01";
            when "10000" =>
                type_mult <= "01";
            when others =>
                type_mult <= "00";
        end case; 
     
    when "01001" => --vol    
        case def_type is 
            when "00011" =>
                type_mult <= "01";  
            when "00100" =>
                type_mult <= "10";        
            when "00110" =>
                type_mult <= "01";   
            when "01011" =>
                type_mult <= "01";  
            when "01100" =>
                type_mult <= "10";
            when "10000" =>
                type_mult <= "10";
            when others =>
                type_mult <= "00";
        end case; 
     
    
    when "01010" => --psy
        case def_type is       
            when "00110" =>
                type_mult <= "01";   
            when "00111" =>
                type_mult <= "01";  
            when "01010" =>
                type_mult <= "10";  
            when "01111" =>
                type_mult <= "10";
            when "10000" =>
                type_mult <= "10";
            when others =>
                type_mult <= "00";
        end case; 
    
    when "01011" => --insect  
        
        case def_type is 
            when "00001" =>
                type_mult <= "10";
            when "00011" =>
                type_mult <= "01";
            when "00110" =>
                type_mult <= "10";
            when "00111" =>
                type_mult <= "10";
            when "01001" =>
                type_mult <= "10";              
            when "01010" =>
                type_mult <= "01";
            when "01101" =>
                type_mult <= "10";
            when "01111" =>
                type_mult <= "01";
            when "10000" =>
                type_mult <= "10";
            when others =>
                type_mult <= "00";
        end case; 
    
    when "01100" => --roc  
        
        case def_type is 
            when "00001" =>
                type_mult <= "01";
            when "00101" =>
                type_mult <= "01";
            when "00110" =>
                type_mult <= "10";
            when "01000" =>
                type_mult <= "10";
            when "01001" =>
                type_mult <= "01";              
            when "01011" =>
                type_mult <= "01";
            when "10000" =>
                type_mult <= "10";
            when others =>
                type_mult <= "00";
        end case; 
    
    when "01101" => --spectre
        
        case def_type is 
            when "00000" =>
                type_mult <= "11"; 
            when "01010" =>
                type_mult <= "01";         
            when "01101" =>
                type_mult <= "01";
            when "01111" =>
                type_mult <= "10";
            when "10000" =>
                type_mult <= "10";
            when others =>
                type_mult <= "00";
        end case; 
    
    when "01110" => --dragon
        
        case def_type is 
            when "01110" =>
                type_mult <= "01";
            when "10000" =>
                type_mult <= "10";
            when others =>
                type_mult <= "00";
        end case; 
    
    when "01111" => --dark 
        
        case def_type is 
            when "00110" =>
                type_mult <= "10"; 
            when "01010" =>
                type_mult <= "01";         
            when "01101" =>
                type_mult <= "01";
            when "01111" =>
                type_mult <= "10";
            when "10000" =>
                type_mult <= "10";
            when others =>
                type_mult <= "00";
        end case; 
    
    when "10000" => --acier
        
        case def_type is 
            when "00001" =>
                type_mult <= "10";
            when "00010" =>
                type_mult <= "10";
            when "00101" =>
                type_mult <= "01";            
            when "01100" =>
                type_mult <= "01";
            when "10000" =>
                type_mult <= "10";
            when others =>
                type_mult <= "00";
        end case; 
    
    when others =>   
        type_mult <= "00";
end case;  

end process;              
end Behavioral;
