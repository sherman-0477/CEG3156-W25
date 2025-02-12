library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity subtractor8bit is
	port(
		i_Ai, i_Bi : in std_logic_vector(7 downto 0);
		o_Diff : out std_logic_vector(7 downto 0)
	);
end subtractor8bit;

architecture rtl of subtractor8bit is
begin
	o_Diff <= std_logic_vector(signed(i_Ai) - signed(i_Bi));
end rtl;