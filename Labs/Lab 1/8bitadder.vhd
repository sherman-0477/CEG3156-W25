library ieee;
use ieee.std_logic_1164.all;

entity adder8bit is
	port(
		i_Ai, i_Bi : in std_logic_vector(7 downto 0);
		i_CarryIn : in std_logic;
		o_CarryOut : out std_logic;
		o_Sum : out std_logic_vector(7 downto 0)
		);
end adder8bit;

architecture rtl of adder8bit is
	signal int_Carry : std_logic_vector(8 downto 0);
	
	component onebitadder is
	port(
		i_CarryIn : in std_logic;
		i_Ai, i_Bi : in std_logic;
		o_Sum, o_CarryOut : out std_logic
	);
	end component;
	
	begin
	
	int_Carry(0) <= i_CarryIn;
	eightBitAdderGenerator:for i in 0 to 7 generate
		adder_i: onebitadder port map(
			i_Ai => i_Ai(i),
			i_Bi => i_Bi(i),
			i_CarryIn => int_Carry(i),
			o_Sum => o_Sum(i),
			o_CarryOut => int_Carry(i+1)
		);
	end generate eightBitAdderGenerator;
	
	o_CarryOut <= int_Carry(8);
end rtl;