----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/28/2022 04:34:27 PM
-- Design Name: 
-- Module Name: Top - Behavioral
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

entity Top is
    Port (clk          : in  std_logic;
         rst        : in  std_logic;
         MISO : in std_logic;
         VGA_hs       : out std_logic;   -- horizontal vga syncr.
         VGA_vs       : out std_logic;   -- vertical vga syncr.
         VGA_red      : out std_logic_vector(3 downto 0);   -- red output
         VGA_green    : out std_logic_vector(3 downto 0);   -- green output
         VGA_blue     : out std_logic_vector(3 downto 0);   -- blue output
         MOSI : out std_logic;
         SS : out std_logic;
         SCLK : out std_logic;
         led : out std_logic_vector(15 downto 0)
        );
end Top;

architecture Behavioral of Top is

    component VGA_bitmap_256x160 is
        generic(bit_per_pixel : integer range 1 to 12:=1;    -- number of bits per pixel
                grayscale     : boolean := false);           -- should data be displayed in grayscale
        port(clk          : in  std_logic;
             reset        : in  std_logic;
             VGA_hs       : out std_logic;   -- horizontal vga syncr.
             VGA_vs       : out std_logic;   -- vertical vga syncr.
             VGA_red      : out std_logic_vector(3 downto 0);   -- red output
             VGA_green    : out std_logic_vector(3 downto 0);   -- green output
             VGA_blue     : out std_logic_vector(3 downto 0);   -- blue output

             ADDR         : in  std_logic_vector(15 downto 0);
             data_in      : in  std_logic_vector(bit_per_pixel - 1 downto 0);
             data_write   : in  std_logic;
             data_out     : out std_logic_vector(bit_per_pixel - 1 downto 0));
    end component;
    
    component game_logic_top is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           left : in STD_LOGIC;
           up : in STD_LOGIC;
           down : in STD_LOGIC;
           right : in STD_LOGIC;
           fwd : in STD_LOGIC;
           bwd : in STD_LOGIC;
           player : out STD_LOGIC;
           stage : out std_logic_vector (3 downto 0);
           poke1 : out std_logic_vector (1 downto 0);
           poke2 : out std_logic_vector (1 downto 0);
           position : out std_logic_vector(1 downto 0);
           atk : out std_logic_vector (1 downto 0);
           efficiency : out std_logic_vector (1 downto 0);
           life_poke1 : out unsigned (6 downto 0);
           life_poke2 : out unsigned (6 downto 0));
end component;

    component display_manager is
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
end component;

    component PmodJSTK is
        Port ( CLK : in  STD_LOGIC;
             RST : in  STD_LOGIC;
             sndRec : in  STD_LOGIC;
             DIN : in  STD_LOGIC_VECTOR (7 downto 0);
             MISO : in  STD_LOGIC;
             SS : out  STD_LOGIC;
             SCLK : out  STD_LOGIC;
             MOSI : out  STD_LOGIC;
             DOUT : inout  STD_LOGIC_VECTOR (39 downto 0));
    end component;

    component ClkDiv is
        Port ( CLK : in  STD_LOGIC;				-- 100MHz onboard clock
             RST : in  STD_LOGIC;				-- Reset
             CLKOUT : inout  STD_LOGIC);		-- New clock output
    end component;

    component game_display_interface is
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
    end component;

    component gest_buttons is
        Port (rst : in std_logic;
             clk : in std_logic;
             X : in std_logic_vector(9 downto 0);
             Y : in std_logic_vector(9 downto 0);
             btn1 : in std_logic;
             btn2 : in std_logic;
             up : out std_logic;
             down : out std_logic;
             left : out std_logic;
             right : out std_logic;
             fwd : out std_logic;
             bwd : out std_logic);
    end component;

    signal addr_display : std_logic_vector(15 downto 0);
    signal data_display : std_logic_vector(7 downto 0);
    signal data_write : std_logic := '1';

    signal stage : std_logic_vector(3 downto 0);
    signal atk : std_logic_vector(1 downto 0);
    signal poke0 : std_logic_vector(1 downto 0);
    signal poke1 : std_logic_vector(1 downto 0);
    signal player : std_logic;
    signal pos_cursor : std_logic_vector(1 downto 0);
    signal efficiency : std_logic_vector(1 downto 0);
    signal life_poke1 : unsigned(6 downto 0);
    signal life_poke2 : unsigned(6 downto 0);
    signal addr_line_1 : std_logic_vector(9 downto 0);
    signal addr_line_2 : std_logic_vector(9 downto 0);
    signal addr_line_3 : std_logic_vector(9 downto 0);
    signal addr_choice_1 : std_logic_vector(9 downto 0);
    signal addr_choice_2 : std_logic_vector(9 downto 0);
    signal addr_choice_3 : std_logic_vector(9 downto 0);
    signal addr_choice_4 : std_logic_vector(9 downto 0);
    signal size_line_1 : std_logic_vector(7 downto 0);
    signal size_line_2 : std_logic_vector(7 downto 0);
    signal size_line_3 : std_logic_vector(7 downto 0);
    signal life_ally : std_logic_vector(6 downto 0);
    signal life_enemy : std_logic_vector(6 downto 0);
    signal addr_ally : std_logic_vector(17 downto 0);
    signal addr_enemy : std_logic_vector(17 downto 0);
    signal cursor : std_logic_vector(1 downto 0);

    signal DIN : std_logic_vector(7 downto 0);
    signal sndRec : std_logic;
    signal data_joystick : std_logic_vector(39 downto 0);
    signal btn1, btn2 : std_logic;
    signal up, down, left, right, fwd, bwd : std_logic;
    

begin
    bitmap : VGA_bitmap_256x160 generic map( bit_per_pixel => 8) port map(clk => clk, reset => rst ,VGA_hs => VGA_hs ,VGA_vs => VGA_vs ,VGA_red => VGA_red, VGA_blue => VGA_blue , VGA_green => VGA_green, addr => addr_display, data_in => data_display , data_write => data_write);
    idisplay_manager : display_manager port map(clk => clk, rst => rst, cursor => cursor, addr_line_1 => addr_line_1, addr_line_2 => addr_line_2, addr_line_3 => addr_line_3, addr_choice_1 => addr_choice_1, addr_choice_2 => addr_choice_2, addr_choice_3 => addr_choice_3, addr_choice_4 => addr_choice_4, size_line_1 => size_line_1, size_line_2 => size_line_2, size_line_3 => size_line_3, life_ally => life_ally, life_enemy => life_enemy, addr_ally => addr_ally, addr_enemy => addr_enemy, addr_display => addr_display, data_display => data_display);
    igame_display_interface : game_display_interface port map(stage => stage, atk => atk, poke0 => poke0, poke1 => poke1, player => player, pos_cursor => pos_cursor, efficiency => efficiency, life_poke1 => std_logic_vector(life_poke1), life_poke2 => std_logic_vector(life_poke2), addr_line_1 => addr_line_1, addr_line_2 => addr_line_2, addr_line_3 => addr_line_3, addr_choice_1 => addr_choice_1, addr_choice_2 => addr_choice_2, addr_choice_3 => addr_choice_3, addr_choice_4 => addr_choice_4, size_line_1 => size_line_1, size_line_2 => size_line_2, size_line_3 => size_line_3, life_ally => life_ally, life_enemy => life_enemy, addr_ally => addr_ally, addr_enemy => addr_enemy, cursor => cursor);
    iclkdiv_5Hz : ClkDiv port map(CLK => clk, RST => rst, CLKOUT => sndRec);
    iPmodjSTK : PmodJSTK port map(CLK => clk, RST => rst, sndRec => sndRec, DIN => DIN, MISO => MISO, SS => SS, SCLK => SCLK, MOSI => MOSI, DOUT => data_joystick );
    igest_buttons : gest_buttons port map(rst => rst, clk => clk, X => data_joystick(25 downto 24) & data_joystick(39 downto 32) , Y => data_joystick(9 downto 8) & data_joystick(23 downto 16), btn1 => btn1, btn2 => btn2, up => up, down => down, left => left, right => right, fwd => fwd, bwd => bwd);
    igame_logic : game_logic_top port map(clk => clk, rst => rst, left => left, up => up, down => down, right => right, fwd => fwd, bwd => bwd, player => player, stage => stage, poke2 => poke1, poke1 => poke0, position => pos_cursor, atk => atk, efficiency => efficiency, life_poke1 => life_poke1, life_poke2 => life_poke2);
    
    btn1 <= data_joystick(1);
    btn2 <= data_joystick(2);
    DIN <= "100000" & btn2 & btn1;
    
    led(3 downto 0) <= stage;
    led(6 downto 5) <= efficiency;
    led(15) <= not(player);
end Behavioral;
