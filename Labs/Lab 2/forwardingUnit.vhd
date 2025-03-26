library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity forwardingUnit is
port(
	EX_MEM_RegWrite, MEM_WB_RegWrite : in std_logic;
	EX_MEM_Rd, ID_EX_Rs, ID_EX_Rt, MEM_WB_Rd : in std_logic_vector(2 downto 0);
	ForwardA, ForwardB : out std_logic_vector(1 downto 0)
);
end entity;

architecture rtl of forwardingUnit is
begin
	ForwardA <= "10" when (EX_MEM_RegWrite = '1' and ((EX_MEM_Rd /= "000") and (EX_MEM_Rd = ID_EX_Rs))) else
					"01" when (MEM_WB_RegWrite = '1' and ((MEM_WB_Rd /= "000") and (MEM_WB_Rd = ID_EX_Rs))) else
					"00";
					
	ForwardB <= "10" when (EX_MEM_RegWrite = '1' and ((EX_MEM_Rd /= "000") and (EX_MEM_Rd = ID_EX_Rt))) else
					"01" when (MEM_WB_RegWrite = '1' and ((MEM_WB_Rd /= "000") and MEM_WB_Rd = ID_EX_Rt)) else
					"00";
					
end architecture;