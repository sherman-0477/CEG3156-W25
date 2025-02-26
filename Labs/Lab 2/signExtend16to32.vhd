library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity signExtend16to32 is
	port(
		input16Bit : in std_logic_vector(15 downto 0);
		output32Bit : out std_logic_vector(31 downto 0)
	);
end signExtend16to32;

architecture rtl of signExtend16to32 is
begin
	output32Bit <= (31 downto 16 => input16Bit(15)) & input16Bit;
end rtl;