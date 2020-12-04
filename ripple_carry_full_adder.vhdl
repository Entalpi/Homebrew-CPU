library ieee;
use ieee.std_logic_1164.all;

-- Full adder
entity FULL_ADDER is
  port (a, b, c: in std_logic;
        sum, carry: out std_logic);
end FULL_ADDER;

architecture FULL_ADDER_BEHAV of FULL_ADDER is
begin
  sum <= (a xor b) xor c;
  carry <= (a and b) or (c and (a xor b));
end FULL_ADDER_BEHAV;

-----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

-- 4-bit adder
entity FOURBITADDER is
  port (a, b, c: in std_logic_vector(3 downto 0);
        Cin: in std_logic;
        sum: out std_logic_vector(3 downto 0);
        Cout: out std_logic);
end FOURBITADDER;

architecture FOURBITADDER_STRUCTURE of FOURBITADDER is
  signal cs: std_logic_vector(4 downto 0); -- Internal carry signals
  component FULL_ADDER
    port (a, b, c: in std_logic;
          sum, carry: out std_logic);
  end component;
begin
  FA0: FULL_ADDER
    port map(a(0), b(0), Cin, sum(0), cs(1));
  FA1: FULL_ADDER
    port map(a(1), b(1), cs(1), sum(1), cs(2));
  FA2: FULL_ADDER
    port map(a(2), b(2), cs(2), sum(2), cs(3));
  FA3: FULL_ADDER
    port map(a(3), b(3), cs(3), sum(3), cs(4));
  Cout <= cs(4);
end FOURBITADDER_STRUCTURE;
