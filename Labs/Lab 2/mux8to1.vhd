library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux8to1 is
port(
	A, B, C, D, E, F, G, H : in std_logic;
	Sel : in std_logic_vector(2 downto 0);
	O : out std_logic
	);
end mux8to1;

architecture rtl of mux8to1 is
begin
	O <= (A and not Sel(2) and not Sel(1) and not Sel(0)) or
		  (B and not Sel(2) and not Sel(1) and Sel(0)) or
		  (C and not Sel(2) and Sel(1) and not Sel(0)) or
		  (D and not Sel(2) and Sel(1) and(0)) or
		  (E and Sel(2) and not Sel(1) and not Sel(0)) or
		  (F and Sel(2) and not Sel(1) and Sel(0)) or
		  (G and Sel(2) and Sel(1) and not Sel(0)) or
		  (H and Sel(2) and Sel(1) and Sel(0));
end rtl;