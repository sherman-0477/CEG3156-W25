library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux32_2to1 is
port(
	A_32bit, B_32bit : in std_logic_vector(31 downto 0);
	Sel_32bit : in std_logic;
	O_32bit : out std_logic_vector(31 downto 0)
	);
end mux32_2to1;

architecture rtl of mux32_2to1 is

	component mux2to1 is
	port(
		A, B : in std_logic;
		Sel : in std_logic;
		O : out std_logic
	);
	end component;
	
	begin
		mux32BitGenerate: for i in 0 to 31 generate
			mux_i: mux2to1
			port map(
				A => A_32bit(i),
				B => B_32bit(i),
				Sel => Sel_32bit,
				O => O_32bit(i)
			);
		end generate mux32BitGenerate;
end rtl;