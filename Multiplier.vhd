library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Multiplier is
  port( rst      : in std_logic;
        clk      : in std_logic;
        start    : in std_logic;
        Number_A : in std_logic_vector(3 downto 0);
        Number_B : in std_logic_vector(3 downto 0);
        Display  : out std_logic_vector(6 downto 0);
        dot_out  : out std_logic;
        Disp_En  : out std_logic_vector(7 downto 0);
        end_mult : out std_logic);
end Multiplier;

architecture Behavioral of Multiplier is
  -- COMPONENTS
  component Multiplier_FSM is
    port( rst      : in std_logic;
          clk      : in std_logic;
          number_A : in std_logic_vector(7 downto 0);
          number_B : in std_logic_vector(7 downto 0);
          start    : in std_logic;
          result   : out std_logic_vector(15 downto 0);
          end_mult : out std_logic);
  end component;
  component Display_Shifter is
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
  end component;
  -- SIGNALS
  signal aux_result : std_logic_vector(15 downto 0);
  signal aux_A : std_logic_vector(7 downto 0);
  signal aux_B : std_logic_vector(7 downto 0);
  begin
    aux_A <= "0000" & Number_A;
    aux_B <= "0000" & Number_B;
    FSM_MULT : Multiplier_FSM
      port map( rst => rst,
                clk => clk,
                number_A => aux_A,
                number_B => aux_B,
                start => start,
                result => aux_result,
                end_mult => end_mult);
    SHIFTER : Display_Shifter
      port map( rst => rst,
                clk => clk,
                Number0 => aux_result(3 downto 0),
                Number1 => aux_result(7 downto 4),
                Number2 => aux_result(11 downto 8),
                Number3 => aux_result(15 downto 12),
                Number4 => "0000",
                Number5 => "0000",
                Number6 => "0000",
                Number7 => "0000",
                dot_in => "00000000",
                Display => Display,
                dot_out => dot_out,
                Disp_En => Disp_En);
end Behavioral;