library ieee;
use ieee.std_logic_1164.all;

-- Entity
entity lshregister8bit is
	port (
		clk, reset, lsh : in STD_LOGIC;
		input : in STD_LOGIC_VECTOR(7 downto 0);
		output : out STD_LOGIC_VECTOR(7 downto 0)
	);
end lshregister8bit;

-- Architecture
architecture rtl of lshregister8bit is 
	-- Internal signal for values
	signal int_value: STD_LOGIC_VECTOR(7 downto 0);
	
	--D FF with enable component
	component DFF_Enable
		port (
			clk : in STD_LOGIC;
			d : in STD_LOGIC;
			q : out STD_LOGIC
		);
	end component;
	
	begin
    
	 -- D flip-flops for each bit
	 -- if lsh is enabled and bit to right is enabled, set to 1
	 -- if lsh is disabled keep current bit the same value
	 
    -- Bit 7
    b7: DFF_Enable
        port map(
            d => (lsh and int_value(6)) or (not lsh and int_value(7)),
            clk => clk,
            q => int_value(7)
        );

    -- Bit 6
    b6: DFF_Enable
        port map(
            d => (lsh and int_value(5)) or (not lsh and int_value(6)),
            clk => clk,
            q => int_value(6)
        );

    -- Bit 5
    b5: DFF_Enable
        port map(
            d => (lsh and int_value(4)) or (not lsh and int_value(5)),
            clk => clk,
            q => int_value(5)
        );

    -- Bit 4
    b4: DFF_Enable
        port map(
            d => (lsh and int_value(3)) or (not lsh and int_value(4)),
            clk => clk,
            q => int_value(4)
        );

    -- Bit 3
    b3: DFF_Enable
        port map(
            d => (lsh and int_value(2)) or (not lsh and int_value(3)),
            clk => clk,
            q => int_value(3)
        );

    -- Bit 2
    b2: DFF_Enable
        port map(
            d => (lsh and int_value(1)) or (not lsh and int_value(2)),
            clk => clk,
            q => int_value(2)
        );

    -- Bit 1
    b1: DFF_Enable
        port map(
            d => (lsh and int_value(0)) or (not lsh and int_value(1)),
            clk => clk,
            q => int_value(1)
        );

    -- Bit 0 
    b0: DFF_Enable
        port map(
            d => input(0) and not(lsh),
            clk => clk,
            q => int_value(0)
        );

    -- Output assignment
    output <= int_value;

end rtl;
	
	
	
	
		