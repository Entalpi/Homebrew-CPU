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
