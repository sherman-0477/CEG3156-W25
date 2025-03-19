LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Decoder_3x8 IS
      PORT (
            i_Input : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            o_Output : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
END;

ARCHITECTURE struct OF Decoder_3x8 IS
      SIGNAL int_sig : STD_LOGIC_VECTOR (7 DOWNTO 0);

BEGIN
      int_sig(0) <= NOT(i_Input(2)) AND NOT(i_Input(1)) AND NOT(i_Input(0));
      int_sig(1) <= NOT(i_Input(2)) AND NOT(i_Input(1)) AND i_Input(0);
      int_sig(2) <= NOT(i_Input(2)) AND i_Input(1) AND NOT(i_Input(0));
      int_sig(3) <= NOT(i_Input(2)) AND i_Input(1) AND i_Input(0);
      int_sig(4) <= i_Input(2) AND NOT(i_Input(1)) AND NOT(i_Input(0));
      int_sig(5) <= i_Input(2) AND NOT(i_Input(1)) AND i_Input(0);
      int_sig(6) <= i_Input(2) AND i_Input(1) AND NOT(i_Input(0));
      int_sig(7) <= i_Input(2) AND i_Input(1) AND i_Input(0);

      o_Output <= int_sig;
END struct;