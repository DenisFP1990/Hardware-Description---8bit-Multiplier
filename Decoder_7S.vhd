library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Decoder_7S is
  port ( data    : in std_logic_vector(3 downto 0);
         dot_in  : in std_logic;
         BCD     : out std_logic_vector(6 downto 0);
         dot_out : out std_logic);
end Decoder_7S;

architecture Behavioral of Decoder_7S is
begin
  dot_out <= not dot_in;                    -- Dot point
  BCD <= "0000001" when data = "0000" else  -- activated a,b,c,d,e,f  number 0
         "1001111" when data = "0001" else  -- activated b,c          number 1
         "0010010" when data = "0010" else  -- activated a,b,d,e,g    number 2
         "0000110" when data = "0011" else  -- activated a,b,c,d,g    number 3
         "1001100" when data = "0100" else  -- activated b,c,f,g      number 4
         "0100100" when data = "0101" else  -- activated a,c,d,f,g    number 5
         "0100000" when data = "0110" else  -- activated a,c,d,e,f,g  number 6
         "0001111" when data = "0111" else  -- activated a,b,c        number 7
         "0000000" when data = "1000" else  -- activated all          number 8
         "0001100" when data = "1001" else  -- activated a,b,c,f,g    number 9
         "0001000" when data = "1010" else  -- activated a,b,c,e,f,g  number 10=A
         "1100000" when data = "1011" else  -- activated c,d,e,f,g    number 11=B
         "0110001" when data = "1100" else  -- activated a,d,e,f      number 12=C
         "1000010" when data = "1101" else  -- activated b,c,d,e,g    number 13=D
         "0110000" when data = "1110" else  -- activated a,d,e,f,g    number 14=E
         "0111000" when data = "1111" else  -- activated a,e,f,g      number 15=F
         "1111111";
end Behavioral;