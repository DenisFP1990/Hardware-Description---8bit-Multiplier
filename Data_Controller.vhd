library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Data_Controller is
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
end Data_Controller;

architecture Behavioral of Data_Controller is
  begin
    Data_Out <= Data0 when Data_sel = "11111110" else
                Data1 when Data_sel = "11111101" else
                Data2 when Data_sel = "11111011" else
                Data3 when Data_sel = "11110111" else
                Data4 when Data_sel = "11101111" else
                Data5 when Data_sel = "11011111" else
                Data6 when Data_sel = "10111111" else
                Data7 when Data_sel = "01111111" else
                "0000";
    Out_dot <= In_dot(0) when Data_sel = "11111110" else
               In_dot(1) when Data_sel = "11111101" else
               In_dot(2) when Data_sel = "11111011" else
               In_dot(3) when Data_sel = "11110111" else
               In_dot(4) when Data_sel = "11101111" else
               In_dot(5) when Data_sel = "11011111" else
               In_dot(6) when Data_sel = "10111111" else
               In_dot(7) when Data_sel = "01111111" else
               '1';
end Behavioral;