library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux8_2to1 is
port(
	A_8bit, B_8bit : in std_logic_vector(7 downto 0);
	Sel_8bit : in std_logic;
	O_8bit : out std_logic_vector(7 downto 0)
	);
end mux8_2to1;

architecture rtl of mux8_2to1 is

	component mux2to1 is
	port(
		A, B : in std_logic;
		Sel : in std_logic;
		O : out std_logic
	);
	end component;
	
	begin
		mux8BitGenerate: for i in 0 to 7 generate
			mux_i: mux2to1
			port map(
				A => A_8bit(i),
				B => B_8bit(i),
				Sel => Sel_8bit,
				O => O_8bit(i)
			);
		end generate mux8BitGenerate;
end rtl;