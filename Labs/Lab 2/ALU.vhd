library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is 
port(
	Operand1, Operand2 : in std_logic_vector(7 downto 0);
	OpSel : in std_logic_vector(2 downto 0);
	OpRes : out std_logic_vector(7 downto 0);
	Zero, Overflow : out std_logic
);
end ALU;

architecture rtl of ALU is
	signal int_Zero, int_SLTRes : std_logic;
	
	component mux8_8to1 is -- MUX for control input
	port(
		i_p0, i_p1, i_p2, i_p3, i_p4, i_p5, i_p6, i_p7 : in std_logic_vector(7 downto 0);
		i_SEL : in std_logic_vector(2 downto 0);
		o_MUX : out std_logic_vector(7 downto 0)
		);
	end component;
	
	component eightBitComparator is 
	port(
		A, B : in std_logic_vector(7 downto 0);
		o_GT, o_LT, o_EQ	: OUT	STD_LOGIC);
	end component;

begin

	SLTResult: eightBitComparator
	port map(
		A => Operand1,
		B => Operand2,
		o_GT => open,
		o_EQ => open,
		o_LT => int_SLTRes
	);
	
	ALUMUXSelect : mux8_8to1
	port map(
		i_p0 => (Operand1 and operand2),
		i_p1 => (Operand1 or Operand2),
		i_p2 => std_logic_vector(signed(Operand1) + signed(Operand2)),
		i_p3 => "00000000",
		i_p4 => "00000000",
		i_p5 => "00000000",
		i_p6 => std_logic_vector(signed(Operand1) - signed(Operand2)),
		i_p7 => "0000000" & int_SLTRes,
		o_MUX => OpRes,
		i_SEL => OpSel
	);
end rtl;
	
	
