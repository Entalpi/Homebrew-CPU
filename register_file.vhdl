library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Address range of the register file
type addr_t is std_logic_vector(3 downto 0);

-- Word size of CPU
type word_t is std_logic_vector(15 downto 0);

entity RegisterFile is
  port (addrA, addrB: in addr_t;    -- Write (inA) or read (inA + inB) addresses in the RF
        WEn: in std_logic;          -- Write enabled high only inA is used
        clk: in std_logic;
        word: in word_t;            -- Word to store in RF
        outA, outB: out word_t);    -- Read pair output if WE is low
end RegisterFile;

architecture RegisterFile_Behav of RegisterFile is
  type memory_t is array(0 to 15) of word_t; -- Register file memory
  signal registers: memory_t;
begin
  process(clk)
    if (rising_edge(clk)) then
      if (WEn == '1') then
        memory(to_integer(unsigned(addrA))) <= word;
      else
        outA <= registers(to_integer(unsigned(addrA)));
        outB <= registers(to_integer(unsigned(addrB)));
      end if;
    end if;
  end process;
end RegisterFile_Behav
