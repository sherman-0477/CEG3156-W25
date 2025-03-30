LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY IF_ID_PipeLineRegister IS
    PORT (
        clk        : IN  STD_LOGIC;
        resetBar   : IN  STD_LOGIC;
        enable     : IN  STD_LOGIC;
        instr_in   : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
        pc_in      : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
        instr_out  : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        pc_out     : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END IF_ID_PipeLineRegister;

ARCHITECTURE structural OF IF_ID_PipeLineRegister IS

    COMPONENT thirtytwobitregister
        PORT (
            i_resetBar : IN STD_LOGIC;
            i_en       : IN STD_LOGIC;
            i_clock    : IN STD_LOGIC;
            i_Value    : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            o_Value    : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT eightbitregister
        PORT (
            i_resetBar : IN STD_LOGIC;
            i_en       : IN STD_LOGIC;
            i_clock    : IN STD_LOGIC;
            i_Value    : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            o_Value    : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;

BEGIN

    instr_reg_inst: thirtytwobitregister
        PORT MAP (
            i_resetBar => resetBar,
            i_en       => enable,
            i_clock    => clk,
            i_Value    => instr_in,
            o_Value    => instr_out
        );

    pc_reg_inst: eightbitregister
        PORT MAP (
            i_resetBar => resetBar,
            i_en       => enable,
            i_clock    => clk,
            i_Value    => pc_in,
            o_Value    => pc_out
        );

END structural;