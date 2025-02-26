library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux8_8to1 is
port(
	A_8bit, B_8bit, C_8bit, D_8bit, E_8bit, F_8bit, G_8bit, H_8bit : in std_logic_vector(7 downto 0);
	Sel_8bit : in std_logic_vector(2 downto 0);
	O_8bit : out std_logic_vector(7 downto 0)
	);
end mux8_8to1;

architecture rtl of mux8_8to1 is

	component mux8to1 is
	port(
		A, B, C, D, E, F, G , H : in std_logic;
		Sel : in std_logic_vector(2 downto 0);
		O : out std_logic
	);
	end component;
	
	begin
		mux8BitGenerate: for i in 0 to 7 generate
			mux_i: mux8to1
			port map(
				A => A_8bit(i),
				B => B_8bit(i),
				C => C_8bit(i),
				D => D_8bit(i),
				E => E_8bit(i),
				F => F_8bit(i),
				G => G_8bit(i),
				H => H_8bit(i),
				Sel => Sel_8bit,
				O => O_8bit(i)
			);
		end generate mux8BitGenerate;
end rtl;