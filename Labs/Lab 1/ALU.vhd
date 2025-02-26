library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
port(
	A, B : in std_logic_vector(7 downto 0);
	ALUOp : in std_logic_vector(2 downto 0);
	ALUResult : out std_logic_vector(7 downto 0);
	Zero : out std_logic
);
end ALU;

architecture rtl of ALU  is