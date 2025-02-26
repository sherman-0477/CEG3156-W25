library ieee;
use ieee.std_logic_1164.all;

--entity
entity register8bit is
	port (
		enable : in STD_LOGIC;
		reset : in STD_LOGIC;
		clk : in STD_LOGIC;
		input : in STD_LOGIC_VECTOR(7 downto 0);
		output : out STD_LOGIC_VECTOR(7 downto 0)
	);
end register8bit;

--rewrote this part for 3156
architecture rtl of register8bit is
	signal int_q : std_LOGIC_VECTOR(7 downto 0);
	
	component enARdFF_2
		port(
		i_resetBar	: IN	STD_LOGIC;
		i_d		: IN	STD_LOGIC;
		i_enable	: IN	STD_LOGIC;
		i_clock		: IN	STD_LOGIC;
		o_q, o_qBar	: OUT	STD_LOGIC
		);
	end component;
	
	begin
	--tried using generate for funsies
	registerGenerate: for i in 0 to 7 generate
	o_P : enARdFF_2
		port map(
			i_resetBar => reset,
			i_d => input(i),
			i_enable => enable,
			i_clock => cld,
			o_q => output(i),
			o_qBar => open -- leave it open for now 
		);
	end generate o_P;			 
	END rtl;
		