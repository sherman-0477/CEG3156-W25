library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity singleCycleProc is
	port(
		ValueSelect : in std_logic_vector(2 downto 0);
		GClock, GReset : in std_logic;
		MuxOut : out std_logic_vector(7 downto 0);
		InstructionOut : out std_logic_vector(31 downto 0);
		BranchOut, ZeroOut, MemWriteOut, RegWriteOut : out std_logic
	);
end singleCycleProc;

architecture rtl of singleCycleProc is
	component controlUnit is
	port(i_Op : in std_logic_vector(5 downto 0);
			o_RegDst, o_ALUSrc, o_MemtoReg, o_RegWrite, o_MemRead, o_MemWrite, o_Branch, o_ALUOp0, o_ALUOp1, o_jump : out std_logic
			);
	end component;
	
	component ALU is
	port(
		Operand1, Operand2 : in std_logic_vector(7 downto 0);
		OpSel : in std_logic_vector(2 downto 0);
		OpRes : out std_logic_vector(7 downto 0);
		Zero, Overflow : out std_logic
		);
	end component;
	
	component mux8_2to1 is
	port(
		A_8bit, B_8bit : in std_logic_vector(7 downto 0);
		Sel_8bit : in std_logic_vector;
		O_8bit : out std_logic_vector(7 downto 0)
	);
	end component;
	
	component ALUControlUnit is
	port(
		i_Funct : in std_logic_vector(5 downto 0);
		i_ALUOp : in std_logic_vector(1 downto 0);
		o_Operation : out std_logic_vector(2 downto 0)
	);
	end component;
		
