library ieee;
use iee.std_logic_1161.all;

entity mux4_to_1 is
    port (I0,I1,I2,I3: in std_logic_vector(7 downto 0);
        SEL: in std_logic_vector(1 downto 0);
        OUT1: out std_logic_vector(7 downto 0));
end mux4_to_1;
