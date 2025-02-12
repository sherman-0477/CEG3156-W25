library ieee;
use ieee.std_logic_1164.all;

--entity
entity register8bit is
	port (
		reset, load : in STD_LOGIC;
		clk : in STD_LOGIC;
		input : in STD_LOGIC_VECTOR(7 downto 0);
		output : out STD_LOGIC_VECTOR(7 downto 0)
	);
end register8bit;

--architecture
architecture Behaviour of register8bit is
	signal int_value : STD_LOGIC_VECTOR (7 downto 0);
	component DFF_Enable
		port (
			reset : in STD_LOGIC;
			d, enable, clk : in STD_LOGIC;
			q : out STD_LOGIC
		);
	end component;

-- D flip-flops for each bit
-- Only output values if load is 1	
begin
	b7 : DFF_Enable
	port map(
		d => input(7) and load, 
		reset => reset, 
		enable => load, 
		clk => clk, 
		q => int_value(7)
	);

	b6 : DFF_Enable
	port map(
		d => input(6) and load, 
		reset => reset, 
		enable => load, 
		clk => clk, 
		q => int_value(6)
	);

	b5 : DFF_Enable
	port map(
		d => input(5) and load, 
		reset => reset, 
		enable => load, 
		clk => clk, 
		q => int_value(5)
	);

	b4 : DFF_Enable
	port map(
		d => input(4) and load, 
		reset => reset, 
		enable => load, 
		clk => clk, 
		q => int_value(4)
	);

	b3 : DFF_Enable
	port map(
		d => input(3) and load, 
		reset => reset, 
		enable => load, 
		clk => clk, 
		q => int_value(3)
	);

	b2 : DFF_Enable
	port map(
		d => input(2) and load, 
		reset => reset, 
		enable => load, 
		clk => clk, 
		q => int_value(2)
	);

	b1 : DFF_Enable
	port map(
		d => input(1) and load, 
		reset => reset, 
		enable => load, 
		clk => clk, 
		q => int_value(1)
	);

	b0 : DFF_Enable
	port map(
		d => input(0) and load, 
		reset => reset, 
		enable => load, 
		clk => clk, 
		q => int_value(0)
	);

	output <= int_value;
end Behaviour;