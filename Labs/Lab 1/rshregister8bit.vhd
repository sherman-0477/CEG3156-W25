library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entity 
entity rshregister8bit is
    port (
		clk, reset, lsh : in STD_LOGIC;
		input : in STD_LOGIC_VECTOR(7 downto 0);
		output : out STD_LOGIC_VECTOR(7 downto 0)
	);
end rshregister8bit;

-- Architecture 
architecture rtl of rshregister8bit is
    -- Internal signal to store shifted values
    signal int_value: std_logic_vector (7 downto 0);

    component DFF_Enable
        Port (
            clk : in  std_logic;  -- Clock input
            d   : in  std_logic;  -- Data input
            q   : out std_logic   -- Output
        );
    end component;

begin
    -- D flip-flops for each bit
	 -- if rsh is enabled and bit to left is enabled, set to 1
	 -- if rsh is disabled keep current bit the same value
    -- Bit 7 (MSB)
    b7: DFF_Enable
        port map(
            d => (lsh and int_value(6)) or (not lsh and input(7)),
            clk => clk,
            q => int_value(7)
        );

    -- Bit 6
    b6: DFF_Enable
        port map(
            d => (lsh and int_value(5)) or (not lsh and input(6)),
            clk => clk,
            q => int_value(6)
        );

    -- Bit 5
    b5: DFF_Enable
        port map(
            d => (lsh and int_value(4)) or (not lsh and input(5)),
            clk => clk,
            q => int_value(5)
        );

    -- Bit 4
    b4: DFF_Enable
        port map(
            d => (lsh and int_value(3)) or (not lsh and input(4)),
            clk => clk,
            q => int_value(4)
        );

    -- Bit 3
    b3: DFF_Enable
        port map(
            d => (lsh and int_value(2)) or (not lsh and input(3)),
            clk => clk,
            q => int_value(3)
        );

    -- Bit 2
    b2: DFF_Enable
        port map(
            d => (lsh and int_value(1)) or (not lsh and input(2)),
            clk => clk,
            q => int_value(2)
        );

    -- Bit 1
    b1: DFF_Enable
        port map(
            d => (lsh and int_value(0)) or (not lsh and input(1)),
            clk => clk,
            q => int_value(1)
        );

    -- Bit 0
    b0: DFF_Enable
        port map(
            d => (not lsh and input(0)), 
            clk => clk,
            q => int_value(0)
        );

    output <= int_value;

end rtl;
