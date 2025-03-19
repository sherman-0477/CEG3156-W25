library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controlUnit is
	port(
		i_Op : in std_logic_vector(5 downto 0);
		o_RegDst, o_ALUSrc, o_MemtoReg, o_RegWrite, o_MemRead, o_MemWrite, o_Branch, o_ALUOp0, o_ALUOp1, o_jump : out std_logic
		
	);
end entity;
	
architecture rtl of controlUnit is
	signal int_rtype, int_lw, int_sw, int_beq, int_jump : std_logic;
	begin
		int_rtype <= (not i_op(5)) and (not i_op(4)) and (not i_op(3)) and (not i_op(2)) and (not i_op(1)) and (not i_op(0));
		int_lw <= (i_op(5)) and (not i_op(4)) and (not i_op(3)) and (not i_op(2)) and (i_op(1)) and (i_op(0));
		int_sw <= (i_op(5)) and (not i_op(4)) and (i_op(3)) and (not i_op(2)) and (i_op(1)) and (i_op(0));
		int_beq <= (not i_op(5)) and (not i_op(4)) and (not i_op(3)) and (i_op(2)) and (not i_op(1)) and (not i_op(0));
		int_jump <= (not i_op(5)) and (not i_op(4)) and (not i_op(3)) and (not i_op(2)) and (i_op(1)) and (not i_op(0));
		
		o_regDst <= int_rtype;
		o_ALUSrc <= int_lw or int_sw;
		o_MemtoReg <= int_lw;
		o_RegWrite <= int_rtype or int_lw;
		o_MemRead <= int_lw;
		o_MemWrite <= int_sw;
		o_Branch <= int_beq;
		o_ALUOp1 <= int_rtype;
		o_ALUOp0 <= int_beq;
		o_jump <= int_jump;
		
end rtl;
	
	