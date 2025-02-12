library ieee;
use ieee.std_logic_1164.all;

--entity
entity register8bit is
	port (
		reset : in STD_LOGIC;
		clk : in STD_LOGIC;
		input : in STD_LOGIC_VECTOR(7 downto 0);
		output : out STD_LOGIC_VECTOR(7 downto 0)
	);
end register8bit;

--rewrote this part for 3156
architecture rtl of register8bit is
	signal int_q : std_LOGIC_VECTOR(7 downto 0);
	
	component enardFF_2
		port(
		i_resetBar	: IN	STD_LOGIC;
		i_d		: IN	STD_LOGIC;
		i_enable	: IN	STD_LOGIC;
		i_clock		: IN	STD_LOGIC;
		o_q, o_qBar	: OUT	STD_LOGIC
		);
	end component;
	
	begin
	P0: enARdFF_2
    PORT MAP (i_resetBar => '1',
              i_d => input(0),
              i_enable => '1', 
              i_clock => clk,
              o_q => output(0));    

	P1: enARdFF_2
		 PORT MAP (i_resetBar => '1',
					  i_d => input(1),
					  i_enable => '1', 
					  i_clock => clk,
					  o_q => output(1));          
	P2: enARdFF_2
		 PORT MAP (i_resetBar => '1',
					  i_d => input(2),
					  i_enable => '1', 
					  i_clock => clk,
					  o_q => output(2));    

	P3: enARdFF_2
		 PORT MAP (i_resetBar => '1',
					  i_d => input(3),
					  i_enable => '1', 
					  i_clock => clk,
					  o_q => output(3));    

	P4: enARdFF_2
		 PORT MAP (i_resetBar => '1',
					  i_d => input(4),
					  i_enable => '1', 
					  i_clock => clk,
					  o_q => output(4));    

	P5: enARdFF_2
		 PORT MAP (i_resetBar => '1',
					  i_d => input(5),
					  i_enable => '1', 
					  i_clock => clk,
					  o_q => output(5));                  
					  
	P6: enARdFF_2
		 PORT MAP (i_resetBar => '1',
					  i_d => input(6),
					  i_enable => '1', 
					  i_clock => clk,
					  o_q => output(6));    

	P7: enARdFF_2
		 PORT MAP (i_resetBar => '1',
					  i_d => input(7),
					  i_enable => '1', 
					  i_clock => clk,
					  o_q => output(7));    

		 
	END rtl;
		