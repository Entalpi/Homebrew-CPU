-- Register file
-- ALU
-- FPU
-- Pipeline?
-- Testbenches!

-----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM is
  port (addr: in natural range 0 to 255;
        clk: in std_logic;
        output: out std_logic_vector(7 downto 0));
end ROM;

architecture ROM_BEHAV of ROM is
  -- Build 2D array of the ROM
  subtype word_t is std_logic_vector(7 downto 0);
  type memory_t is array(255 downto 0) of word_t;

  function init_rom
    return memory_t is
    variable tmp: memory_t := (others => (others => '0'));
  begin
    for addr_pos in 0 to 255 loop
      -- Init with the addr itself
      tmp(addr_pos) := std_logic_vector(to_unsigned(addr_pos, 8));
    end loop;
    return tmp;
  end init_rom;

  -- ROM signal
  -- Quartus will create a mem. init fil (.mif) based on the default value
  signal rom: memory_t := init_rom;
begin

  process(clk)
  begin
    if (rising_edge(clk)) then
      output <= rom(addr);
    end if;
  end process;

end ROM_BEHAV;

-----------------------------------------------------------------------
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
