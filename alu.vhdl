library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Global type declarations
generic (N: integer := 16);

type op_code_t is (ADD = "0001 0000",
                   SUB = "0010 0000");

type word_t is std_logic_vector(N-1 downto 0);

entity ALU is
  port (op: in std_logic_vector(3 downto 0);
        A, B: in word_t;
        rst, clk: in std_logic;
        C: out word_t);
end ALU;

architecture ALU_BEHAV of ALU is
begin
  process(op, A, B, clk)
  begin
    if (rising_edge(clk))
      case op is
        when ADD => C <= std_logic_vector(signed(A) + signed(B));
        when SUB => C <= std_logic_vector(signed(A) - signed(B));
        others => null;
      end case;
    end if;

    -- Overflow flags etc

  end process;
end ALU_BEHAV;
