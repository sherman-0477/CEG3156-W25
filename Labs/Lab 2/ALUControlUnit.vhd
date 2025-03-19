library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALUControlUnit is
	port(
		i_Funct : in std_logic_vector(5 downto 0);
		i_ALUOp : in std_logic_vector(1 downto 0);
		o_Operation : out std_logic_vector(2 downto 0)
	);
end ALUControlUnit;

architecture rtl of ALUControlUnit is
	signal ALUOp0, ALUOp1, F0, F1, F2, F3, Operation0, Operation1, Operation2 : std_logic;
	
	begin
	ALUOp1 <= i_ALUOp(1);
	ALUOp0 <= i_ALUOp(0);
	F0 <= i_Funct(0);
	F1 <= i_Funct(1);
	F2 <= i_Funct(2);
	F3 <= i_Funct(3);
	--F4 and F4 aren't used
	
	Operation2 <= ALUOp0 or (ALUOp1 and F1);
	Operation1 <= (not ALUOp1) or (not F2);
	Operation0 <= ALUOp1 and (F3 or F0);
	
	o_Operation <= Operation2 & Operation1 & Operation0;

end rtl;
	