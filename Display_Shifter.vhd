library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Display_Shifter is
  port( rst     : in std_logic;
        clk     : in std_logic;
        Number0 : in std_logic_vector(3 downto 0);
        Number1 : in std_logic_vector(3 downto 0);
        Number2 : in std_logic_vector(3 downto 0);
        Number3 : in std_logic_vector(3 downto 0);
        Number4 : in std_logic_vector(3 downto 0);
        Number5 : in std_logic_vector(3 downto 0);
        Number6 : in std_logic_vector(3 downto 0);
        Number7 : in std_logic_vector(3 downto 0);
        dot_in  : in std_logic_vector(7 downto 0);
        Display : out std_logic_vector(6 downto 0);
        dot_out : out std_logic;
        Disp_En : out std_logic_vector(7 downto 0));
end Display_Shifter;

architecture Behavioral of Display_Shifter is
  -- COMPONENTS
  component AN_Generator is
    port (clk_in  : in std_logic;
          rst     : in std_logic;
          AN      : out std_logic_vector(7 downto 0));
  end component;
  component Decoder_7S is
    port ( data    : in std_logic_vector(3 downto 0);
           dot_in  : in std_logic;
           BCD     : out std_logic_vector(6 downto 0);
           dot_out : out std_logic);
  end component;
  component Data_Controller is
    port (Data0    : in std_logic_vector(3 downto 0);
          Data1    : in std_logic_vector(3 downto 0);
          Data2    : in std_logic_vector(3 downto 0);
          Data3    : in std_logic_vector(3 downto 0);
          Data4    : in std_logic_vector(3 downto 0);
          Data5    : in std_logic_vector(3 downto 0);
          Data6    : in std_logic_vector(3 downto 0);
          Data7    : in std_logic_vector(3 downto 0);
          In_dot   : in std_logic_vector(7 downto 0);
          Data_Sel : in std_logic_vector(7 downto 0);
          Data_Out : out std_logic_vector(3 downto 0);
          Out_dot  : out std_logic);
  end component;
  -- SIGNALS
  signal AN_aux : std_logic_vector(7 downto 0);
  signal data_aux : std_logic_vector(3 downto 0);
  signal dot_aux : std_logic;
  begin
    ENABLE_SHIFTER : AN_Generator
      port map( clk_in => clk,
                rst => rst,
                AN => AN_aux);
    CONTROLLER : Data_Controller
      port map( Data0 => Number0,
                Data1 => Number1,
                Data2 => Number2,
                Data3 => Number3,
                Data4 => Number4,
                Data5 => Number5,
                Data6 => Number6,
                Data7 => Number7,
                In_dot => dot_in,
                Data_Sel => AN_aux,
                Data_Out => data_aux,
                Out_dot => dot_aux);
    DECODER : Decoder_7S
      port map( data => data_aux,
                dot_in => dot_aux,
                BCD => Display,
                dot_out => dot_out);
    Disp_En <= AN_aux;
end Behavioral;