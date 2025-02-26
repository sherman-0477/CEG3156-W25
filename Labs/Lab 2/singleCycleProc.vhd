library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity singleCycleProc is
	port(
		ValueSelect : in std_logic_vector(2 downto 0);
		GClock, GReset : in std_logic;
		MuxOut : out std_logic_vector(7 downto 0);
		InstructionOut : out std_logic_vector(31 downto 0);
		BranchOut, ZeroOut, MemWriteOut, RegWriteOut : out std_logic;
	);
end singleCycleProc;