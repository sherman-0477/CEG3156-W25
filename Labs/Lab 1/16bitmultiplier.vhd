library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity multiplier16bit is
	port(
		i_A, i_B : in std_logic_vector(7 downto 0);
		o_P : out std_logic_vector(15 downto 0)
	);
end multiplier16bit;

architecture rtl of multiplier16bit is
begin
	o_P <= std_logic_vector(unsigned(i_A) * unsigned(i_B));
end rtl;