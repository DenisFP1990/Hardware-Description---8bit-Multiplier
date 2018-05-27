library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Multiplier_FSM is
  port( rst      : in std_logic;
        clk      : in std_logic;
        number_A : in std_logic_vector(7 downto 0);
        number_B : in std_logic_vector(7 downto 0);
        start    : in std_logic;
        result   : out std_logic_vector(15 downto 0);
        end_mult : out std_logic);
end Multiplier_FSM;

architecture Behavioral of Multiplier_FSM is
-- Auxiliary Signal Definition
  type state is(reset,idle,load,inc,sum,shift,compare,finish);
  signal present_state,next_state : state;
  signal aux_A : std_logic_vector(15 downto 0);
  signal aux_B : std_logic_vector(7 downto 0);
  signal aux_sum : unsigned(15 downto 0);
  signal aux_result : unsigned(15 downto 0);
  signal i : unsigned(3 downto 0);
  signal aux_en : std_logic;
  -- Begin Architecture
  begin
    result <= std_logic_vector(aux_result);
    end_mult <= aux_en;
    -- Moore State Machine with 3 blocks
    -- Block F Programming
    blockF : process(present_state,start,aux_B,i)
    begin
      case (present_state) is
        when reset   => next_state <= idle;
        when idle    => if(start = '1') then
                          next_state <= load;
                        else
                          next_state <= idle;
                        end if;
        when load    => if(aux_B(0) = '0') then
                          next_state <= inc;
                        elsif(aux_B(0) = '1') then
                          next_state <= sum;
                        else
                          next_state <= load;
                        end if;
        when inc     => next_state <= shift;
        when sum     => next_state <= shift;
        when shift   => next_state <= compare;
        when compare => if(aux_B(0)='0' and i<8) then
                          next_state <= inc;
                        elsif(aux_B(0)='1' and i<8) then
                          next_state <= sum;
                        elsif(i >= 8) then
                          next_state <= finish;
                        else
                          next_state <= compare;
                        end if;
        when finish  => next_state <= idle;
        when others  => next_state <= idle;
      end case;
    end process blockF;
    -- Block M Programmig
    blockM : process(clk,rst)
    begin
      if(rst = '1') then
        present_state <= reset;
      elsif(clk'event and clk='1') then
        present_state <= next_state;
      end if;
    end process blockM;
    -- Block G Programming
    blockG : process(present_state,clk)    
    begin
      if(clk'event and clk='1') then
        case (present_state) is
          when reset   => aux_sum <= (others => '0');
                          aux_result <= (others => '0');
                          aux_A <= (others => '0');
                          aux_B <= (others => '0');
                          i <= (others => '0');
                          aux_en <= '0';
          when idle    => aux_sum <= (others => '0');
                          i <= (others => '0');
                          aux_en <= '0';
          when load    => aux_A <= "00000000" & number_A;
                          aux_B <= number_B;
          when inc     => aux_sum <= aux_sum;
                          i <= i+1;
          when sum     => aux_sum <= aux_sum + unsigned(aux_A);
                          i <= i+1;
          when shift   => aux_A <= aux_A(14 downto 0) & aux_A(15);
                          aux_B <= aux_B(0) & aux_B(7 downto 1);
          when compare => aux_A <= aux_A;
                          aux_B <= aux_B;
          when finish  => aux_result <= aux_sum;
                          aux_en <= '1';
          when others  => aux_sum <= (others => '0');
                          aux_result <= (others => '0');
                          aux_A <= (others => '0');
                          aux_B <= (others => '0');
                          i <= (others => '0');
                          aux_en <= '0';
        end case;
      end if;
    end process blockG;
end Behavioral;