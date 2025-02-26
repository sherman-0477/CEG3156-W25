-- the name of this file is probably misleading
-- its a 32 bit register that shifts left twice

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lsh2bitReg_32 is
port(
	i_A : in std_logic_vector(31 downto 0);
	o_Shift : out std_logic_vector(31 downto 0)
);
end lsh2bitReg_32;