--Same as 3 bit comparator but just copy pasted over and over again.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity eightBitComparator is 
port(
	A, B : in std_logic_vector(7 downto 0);
	o_GT, o_LT, o_EQ			: OUT	STD_LOGIC);
end eightBitComparator;

architecture rtl of eightBitComparator is
SIGNAL int_GT, int_LT : std_LOGIC_vector(7 downto 0);

	COMPONENT oneBitComparator
	PORT(
		i_GTPrevious, i_LTPrevious	: IN	STD_LOGIC;
		i_Ai, i_Bi			: IN	STD_LOGIC;
		o_GT, o_LT			: OUT	STD_LOGIC);
	END COMPONENT;

begin
	comp7: oneBitComparator
	port map(
		i_GTPrevious => '0',
		i_LTPrevious => '0',
		i_Ai => A(7),
		i_Bi => B(7),
		o_GT => int_GT(7),
		o_LT => int_LT(7)
	);
	
	comparatorGenerate: for i in 6 downto 0 generate
	oneBitComparator_i: oneBitComparator
	port map(
		i_GTPrevious => int_GT(i+1),
		i_LTPrevious => int_LT(i+1),
		i_Ai => A(i),
		i_Bi => B(i),
		o_GT => int_GT(i),
		o_LT => int_LT(i)
	);
	end generate comparatorGenerate;
	
	o_GT <= int_GT(0);
   o_LT <= int_LT(0);
   o_EQ <= NOT (o_GT OR o_LT);
	
end rtl;
