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
		 ExponentOut : out std_logic_vector(6 downto 0)
    );
end FPMult;

architecture rtl of FPMult is
	-- You can combine sign and exponent together into 1 logic vector, then take the value at 7 to find out the sign
	-- Might need to rename these so it's less confusing
	signal int_signExpA, int_signExpB, int_mantA, int_mantB, int_signExpOut, int_expSumBiased, int_mantNormalized : std_logic_vector(7 downto 0);
	signal int_mantRes, int_mantResNormalised : std_logic_vector(15 downto 0);
	signal int_expSum, int_expSumBiasedShifted : std_logic_vector(7 downto 0);

	component register8bit is
	port(
		reset : in std_logic;
		clk : in std_logic;
		input : in std_logic_vector(7 downto 0);
		output : out std_logic_vector(7 downto 0)
	);
	end component;
	
	component adder8bit is
	port(
		i_Ai, i_Bi : in std_logic_vector(7 downto 0);
		i_CarryIn : in std_logic;
		o_CarryOut : out std_logic;
		o_Sum : out std_logic_vector(7 downto 0)
	);
	end component;
	
	component subtractor8bit is
	port(
		i_Ai, i_Bi : in std_logic_vector(7 downto 0);
		o_Diff : out std_logic_vector(7 downto 0)
	);
	end component;
	
	-- Might need bigger registers due to multiplication
	component rshregister8bit is
	port(
		clk, reset, lsh : in STD_LOGIC;
		input : in STD_LOGIC_VECTOR(7 downto 0);
		output : out STD_LOGIC_VECTOR(7 downto 0)
	);
	end component;
	
	component multiplier16bit is
	port(
		i_A, i_B : in std_logic_vector(7 downto 0);
		o_P : out std_logic_vector(15 downto 0)
	);
	end component;
	
	component oneBitComparator is
	PORT(
		i_GTPrevious, i_LTPrevious	: IN	STD_LOGIC;
		i_Ai, i_Bi			: IN	STD_LOGIC;
		o_GT, o_LT, o_EQ			: OUT	STD_LOGIC);
	END component;
	
	begin
	
		signAndExpA : register8bit
	port map(
		reset => GReset,
		clk => GClock,
		input(7) => signA,
		input(6 downto 0) => ExponentA,
		output => int_signExpA
	);
	
	signAndExpB : register8bit
	port map(
		reset => GReset,
		clk => GClock,
		input(7) => signB,
		input(6 downto 0) => ExponentB,
		output => int_signExpB
	);
	
	mantissaARegister : register8bit
	port map(
		reset => GReset,
		clk => GClock,
		input => MantissaA,
		output => int_mantA
	);
	
	mantissaBRegister : register8bit
	port map(
		reset => GReset,
		clk => GClock,
		input => MantissaB,
		output => int_mantB
	);
	
	-- Get 8 bit adder to add the exponents together
	expSum : adder8bit
	port map(
		i_Ai => "00111110", -- Hard coded to 62
		i_Bi => '0' & int_signExpB(6 downto 0),
		i_CarryIn => '0',
		o_CarryOut => open, -- No need for carry out
		o_Sum => int_expSum 
	);
	
	-- Subtract result with bias
	expBiased : subtractor8bit
	port map(
		i_Ai => int_expSum,
		i_Bi => "00111111",
		o_Diff => int_expSumBiased -- if MSB of expSum is 1 then there's oveflow
	);
	
	-- Multiply the mantissas
	mantResult : multiplier16bit
	port map(
		i_A => "00011111", -- Hard coded to 31
		i_B => int_mantB,
		o_P => int_mantRes
	);
	
	-- Normalise. I gave up on this part
	mantNormalise : process(GClock, GReset)
	begin
	if GReset = '1' then
		int_mantResNormalised <= int_mantRes;
		int_expSumBiasedShifted <= int_expSumBiased;
		
	elsif rising_edge(GClock) then
		int_mantResNormalised <= int_mantRes;
		int_expSumBiasedShifted <= int_expSumBiased;
		for i in 0 to 31 loop
			if int_mantRes(15) = '0' then
				int_mantResNormalised <= int_mantRes(14 downto 0) & '0';
				int_expSumBiasedShifted <= std_logic_vector(signed(int_expSumBiasedShifted) - 1);
			else
				exit;
			end if;
		end loop;
	end if;
	end process;
	
	
	-- Results
	signOut <= int_signExpA(7) xor int_signExpB(7);
	ExponentOut <= int_expSumBiasedShifted(6 downto 0);
	MantissaOut <= int_mantResNormalised(15 downto 8); --I guess it rounds it 
	Overflow <= int_expSumBiasedShifted(7); -- Overflow occurs when the MSB of the exponent is 1

end rtl;