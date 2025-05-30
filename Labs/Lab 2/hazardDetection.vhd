library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hazardDetection is
port(
	ID_EX_MemRead : in std_logic;
	ID_EX_RegisterRt, IF_ID_RegisterRs, IF_ID_RegisterRt : in std_logic_vector(2 downto 0);
	Hazard_isDetected : out std_logic
);
end entity;

architecture rtl of hazardDetection is
begin
	Hazard_isDetected <= '1' when (ID_EX_MemRead = '1' and (ID_EX_RegisterRt = IF_ID_RegisterRs)) or (ID_EX_RegisterRt = IF_ID_RegisterRt)
								else '0';
end architecture;