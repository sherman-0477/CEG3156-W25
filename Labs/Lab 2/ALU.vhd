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
		A_8bit, B_8bit, C_8bit, D_8bit, E_8bit, F_8bit, G_8bit, H_8bit : in std_logic_vector(7 downto 0);
		Sel_8bit : in std_logic_vector(2 downto 0);
		O_8bit : out std_logic_vector(7 downto 0)
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
		A_8bit => (Operand1 and operand2),
		B_8bit => (Operand1 or Operand2),
		C_8bit => std_logic_vector(signed(Operand1) + signed(Operand2)),
		D_8bit => "00000000",
		E_8bit => "00000000",
		F_8bit => "00000000",
		G_8bit => std_logic_vector(signed(Operand1) - signed(Operand2)),
		H_8bit => "0000000" & int_SLTRes
	);
end rtl;
	
	
