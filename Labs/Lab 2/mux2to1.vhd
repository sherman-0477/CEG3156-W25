library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux2to1 is
port(
	A, B : in std_logic;
	Sel : in std_logic;
	O : out std_logic
	);
end mux2to1;

architecture rtl of mux2to1 is
begin
	O <= (A and not Sel) or (B and Sel);
end rtl;