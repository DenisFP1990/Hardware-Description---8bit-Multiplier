library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity AN_Generator is
  port (clk_in  : in std_logic;
        rst     : in std_logic;
        AN      : out std_logic_vector(7 downto 0));
end AN_Generator;

architecture Behavioral of AN_Generator is
  signal count_1K : unsigned(15 downto 0);
  signal count_AN : unsigned(3 downto 0);
  begin
    AN <= "11111110" when (count_AN=1) else
          "11111101" when (count_AN=2) else
          "11111011" when (count_AN=3) else
          "11110111" when (count_AN=4) else
          "11101111" when (count_AN=5) else
          "11011111" when (count_AN=6) else
          "10111111" when (count_AN=7) else
          "01111111" when (count_AN=8) else
          "11111111";
    divider : process(clk_in,rst)
    begin
      if(rst = '1') then
        count_1K <= (others => '0');
        count_AN <= (others => '0');
      elsif(clk_in'event and clk_in = '1') then
        if(count_1K < 100000) then
          count_1K <= count_1K + 1;
          if(count_1K = 50000) then
            if(count_AN < 9) then
              count_AN <= count_AN + 1;
            else
              count_AN <= "0001";
            end if;
          end if;
        else
          count_1K <= (others => '0');
        end if;
      end if;
    end process divider;
end Behavioral;