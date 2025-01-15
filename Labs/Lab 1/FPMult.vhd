library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FPMult is
	port(
	signA, signB, GClock, GReset : in std_logic;
	MantissaA : in std_logic_vector(7 downto 0);
	MantissaB : in std_logic_vector(7 downto 0);
	ExponentA : in std_logic_vector(6 downto 0);
	ExponentB : in std_logic_vector(6 downto 0);
	signOut, Overflow : out std_logic;
	MantissaOut : out std_logic_vector(7 downto 0);
	ExponentOut : out std_logic_vector(6 downto 0);
	)
end FPMult;

architecture rtl of FPMult is
	-- Need internal signals for sign, exponent, and mantissa result
	signal signRes : std_logic;
	signal expRes : std_logic_vector(6 downto 0);
	signal mantissaRes : std_logic_vector(7 downto 0);
	signal mantissaNormal : std_logic_vector(7 downto 0);
	signal overflowFlag : std_logic;

	begin
		process(GClock, GReset)
		begin
			if(GReset = '1') then
				signRes <= '0';
				expRes <= (others => '0');
				mantissaRes <= (others => '0');
				mantissaNormal <= (others => '0');
				overflowFlag <= '0';
			end if;
			elsif RISING_EDGE(GClock) then
				signRes <= signA XOR signB;
				expRes <= std_logic_vector((signed(ExponentA)+signed(ExponentB))-127);
				mantissaRes <= std_logic_vector(unsigned(MantissaA)*unsigned(MantissaB));
				
	