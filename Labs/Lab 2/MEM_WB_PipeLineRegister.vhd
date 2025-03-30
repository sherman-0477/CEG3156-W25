LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY MEM_WB_PipeLineRegister IS
    PORT (
        clk            : IN  STD_LOGIC;
        resetBar       : IN  STD_LOGIC;
        enable         : IN  STD_LOGIC;

        -- Data inputs
        mem_data_in    : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        alu_result_in  : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        dest_reg_in    : IN STD_LOGIC_VECTOR(4 DOWNTO 0);

        -- Control inputs
        RegWrite_in    : IN STD_LOGIC;
        MemToReg_in    : IN STD_LOGIC;

        -- Data outputs
        mem_data_out   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        alu_result_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        dest_reg_out   : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);

        -- Control outputs
        RegWrite_out   : OUT STD_LOGIC;
        MemToReg_out   : OUT STD_LOGIC
    );
END MEM_WB_PipeLineRegister;

ARCHITECTURE structural OF MEM_WB_PipeLineRegister IS

    COMPONENT eightbitregister
        PORT (
            i_resetBar, i_en : IN STD_LOGIC;
            i_clock          : IN STD_LOGIC;
            i_Value          : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            o_Value          : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT fivebitregister
        PORT (
            i_resetBar, i_en : IN STD_LOGIC;
            i_clock          : IN STD_LOGIC;
            i_Value          : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
            o_Value          : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT enARdFF_2
        PORT (
            i_resetBar : IN STD_LOGIC;
            i_d        : IN STD_LOGIC;
            i_enable   : IN STD_LOGIC;
            i_clock    : IN STD_LOGIC;
            o_q        : OUT STD_LOGIC;
            o_qB       : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL dummy : STD_LOGIC;

BEGIN

    -- Data registers
    reg_mem_data:    eightbitregister PORT MAP (resetBar, enable, clk, mem_data_in, mem_data_out);
    reg_alu_result:  eightbitregister PORT MAP (resetBar, enable, clk, alu_result_in, alu_result_out);
    reg_dest_reg:    fivebitregister  PORT MAP (resetBar, enable, clk, dest_reg_in, dest_reg_out);

    -- Control signals
    reg_regwrite:    enARdFF_2 PORT MAP (resetBar, RegWrite_in, enable, clk, RegWrite_out, dummy);
    reg_memtoreg:    enARdFF_2 PORT MAP (resetBar, MemToReg_in, enable, clk, MemToReg_out, dummy);

END structural;
