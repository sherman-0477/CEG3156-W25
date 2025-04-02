LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY twobitregister IS
    PORT (
        i_resetBar : IN  STD_LOGIC;
        i_en       : IN  STD_LOGIC;
        i_clock    : IN  STD_LOGIC;
        i_Value    : IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
        o_Value    : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
END twobitregister;

ARCHITECTURE structural OF twobitregister IS
	SIGNAL q_value, q_notvalue : STD_LOGIC_VECTOR(1 DOWNTO 0);

   COMPONENT enARdFF_2
			PORT (
					i_resetBar : IN STD_LOGIC;
					i_d : IN STD_LOGIC;
					i_enable : IN STD_LOGIC;
					i_clock : IN STD_LOGIC;
					o_q, o_qBar : OUT STD_LOGIC);
   END COMPONENT;


BEGIN

    b0 : enARdFF_2 PORT MAP(i_resetBar, i_Value(0), i_en, i_clock, q_value(0), q_notvalue(0));
    b1 : enARdFF_2 PORT MAP(i_resetBar, i_Value(1), i_en, i_clock, q_value(1), q_notvalue(1));

END structural;