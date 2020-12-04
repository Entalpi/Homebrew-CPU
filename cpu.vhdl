library ieee;
use iee.std_logic_1164.all;

-- Global type declarations
generic (N: integer := 16);

type op_code_t is (ADD = "0001 0000",
                   SUB = "0010 0000");

type word_t is std_logic_vector(N-1 downto 0);

entity CPU is
  port ();
end CPU;

architecture CPU_BEHAV of CPU is
  variable PC: integer -- temp
begin

end CPU_BEHAV;
