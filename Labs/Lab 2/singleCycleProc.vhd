library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity singleCycleProc is
	port(
		ValueSelect : in std_logic_vector(2 downto 0);
		GClock, GReset : in std_logic;
		MuxOut : out std_logic_vector(7 downto 0);
		InstructionOut : out std_logic_vector(31 downto 0);
		BranchOut, ZeroOut, MemWriteOut, RegWriteOut : out std_logic
	);
end singleCycleProc;

architecture rtl of singleCycleProc is

	component register8bit is
	port (
		in_en : in STD_LOGIC;
		in_resetbar : in STD_LOGIC;
		in_clk : in STD_LOGIC;
		in_Input : in STD_LOGIC_VECTOR(7 downto 0);
		o_Output : out STD_LOGIC_VECTOR(7 downto 0)
	);
	end component;

	component controlUnit is
	port(i_Op : in std_logic_vector(5 downto 0);
			o_RegDst, o_ALUSrc, o_MemtoReg, o_RegWrite, o_MemRead, o_MemWrite, o_Branch, o_ALUOp0, o_ALUOp1, o_jump : out std_logic
			);
	end component;
	
	component ALU is
	port(
		Operand1, Operand2 : in std_logic_vector(7 downto 0);
		OpSel : in std_logic_vector(2 downto 0);
		OpRes : out std_logic_vector(7 downto 0);
		Zero, Overflow : out std_logic
		);
	end component;
	
	component mux8_2to1 is
	port(
		A_8bit, B_8bit : in std_logic_vector(7 downto 0);
		Sel_8bit : in std_logic;
		O_8bit : out std_logic_vector(7 downto 0)
	);
	end component;
	
	component ALUControlUnit is
	port(
		i_Funct : in std_logic_vector(5 downto 0);
		i_ALUOp : in std_logic_vector(1 downto 0);
		o_Operation : out std_logic_vector(2 downto 0)
	);
	end component;
	
	component instrMem is
	port (
		address : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		clock : IN STD_LOGIC := '1';
		q : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
	end component;
	
	component dataMem is
	port(
		address : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		clock : IN STD_LOGIC := '1';
		data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		wren : IN STD_LOGIC;
		q : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
	end component;
	
	component RegisterFile_8x8 is
	port(
		in_Read1 : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
		in_Read2 : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
		in_Write_sel : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
		in_Write_Data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		in_Write_en : IN STD_LOGIC;
		in_clk, in_resetbar : IN STD_LOGIC;
		o_Data1 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		o_Data2 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
	end component;
	
	component signExtend16to32 is
	port (
		input16Bit : in std_logic_vector(15 downto 0);
		output32Bit : out std_logic_vector(31 downto 0)
	);
	end component;
	
	component MEM_WB_PipeLineRegister is
	port(
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
	end component;
	
	component IF_ID_PipeLineRegister IS
    PORT (
        clk        : IN  STD_LOGIC;
        resetBar   : IN  STD_LOGIC;
        enable     : IN  STD_LOGIC;
        instr_in   : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
        pc_in      : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
        instr_out  : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        pc_out     : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
	END component;
	
	component ID_EX_PipeLineRegister IS
    PORT (
        clk        : IN  STD_LOGIC;
        resetBar   : IN  STD_LOGIC;
        enable     : IN  STD_LOGIC;

        -- Data Inputs
        readData1_in   : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        readData2_in   : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        immediate_in   : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        rt_in          : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        rd_in          : IN STD_LOGIC_VECTOR(4 DOWNTO 0);

        -- Control Inputs
        ALUOp_in       : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        RegDst_in      : IN STD_LOGIC;
        ALUSrc_in      : IN STD_LOGIC;
        MemToReg_in    : IN STD_LOGIC;
        RegWrite_in    : IN STD_LOGIC;
        MemRead_in     : IN STD_LOGIC;
        MemWrite_in    : IN STD_LOGIC;

        -- Data Outputs
        readData1_out  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        readData2_out  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        immediate_out  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        rt_out         : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
        rd_out         : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);

        -- Control Outputs
        ALUOp_out      : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        RegDst_out     : OUT STD_LOGIC;
        ALUSrc_out     : OUT STD_LOGIC;
        MemToReg_out   : OUT STD_LOGIC;
        RegWrite_out   : OUT STD_LOGIC;
        MemRead_out    : OUT STD_LOGIC;
        MemWrite_out   : OUT STD_LOGIC
    );
	END component;
	
	component EX_MEM_PipeLineRegister IS
    PORT (
        clk          : IN  STD_LOGIC;
        resetBar     : IN  STD_LOGIC;
        enable       : IN  STD_LOGIC;

        -- Data inputs
        alu_result_in    : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        write_data_in    : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        dest_reg_in      : IN STD_LOGIC_VECTOR(4 DOWNTO 0);

        -- Control inputs
        MemRead_in       : IN STD_LOGIC;
        MemWrite_in      : IN STD_LOGIC;
        RegWrite_in      : IN STD_LOGIC;
        MemToReg_in      : IN STD_LOGIC;

        -- Data outputs
        alu_result_out   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        write_data_out   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        dest_reg_out     : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);

        -- Control outputs
        MemRead_out      : OUT STD_LOGIC;
        MemWrite_out     : OUT STD_LOGIC;
        RegWrite_out     : OUT STD_LOGIC;
        MemToReg_out     : OUT STD_LOGIC
    );
	END component;
	
	-- Reset signal
	signal int_reset : std_logic;
	
	-- PC Signal
	signal int_pcIncrement, int_instructionAdd : std_logic_vector(7 downto 0);
	signal int_pcIncrementExt, int_instructionAddExt : std_logic_vector(31 downto 0);
	
	-- Instruction Signals
	signal int_Instruction : std_LOGIC_VECTOR(31 downto 0);
	
	-- Register signals
	signal int_ReadData1, int_ReadData2 : std_logic_vector(7 downto 0);
	
	-- ALU signals
	signal int_ALUOperandA, int_ALUOperandB, int_ALUResult : std_logic_vector(7 downto 0);
	signal int_ALUOperation : std_logic_vector(2 downto 0);
	signal int_ALUOperationSelect : std_logic_vector(2 downto 0);
	
	-- Memory signals
	signal int_DataAddress, int_ReadDataMem, int_WriteData, int_InstructionAddressMem : std_logic_vector(7 downto 0);
	
	-- Control signals
	signal int_ALUOPControl : std_logic_vector(1 downto 0);
	signal int_RegDst, int_ALUSrc, int_MemToReg, int_RegWrite, int_MemRead, int_MemWrite, int_Branch : std_logic;
	
	-- Sign Extend signals
	signal int_SEinput : std_logic_vector(15 downto 0);
	signal int_SEoutput : std_logic_vector(31 downto 0);
	
	
	begin
	
	ProgramCounter : register8bit
	port map(
		in_en => '1',
		in_resetbar => GReset,
		in_clk => GClock,
		in_Input => int_pcIncrement,
		o_Output => int_instructionAdd
	);
	
	signExtend : signExtend16to32
	port map(
		input16Bit => "00000000" & int_instructionAdd,
		output32Bit => int_instructionAddExt
	);
	
	DataMemory : dataMem
	port map(
		address => int_instructionAdd,
		clock => GClock,
		data => int_WriteData,
		wren => int_MemWrite,
		q => int_ReadDataMem
	);

	RegFile : RegisterFile_8x8 
	port map(
		in_Read1 => int_Instruction(23 downto 21),
		in_Read2 => int_Instruction(18 downto 16),
		in_Write_sel => ValueSelect,
		in_Write_Data => int_pcIncrement,
		in_Write_en => '1',
		in_clk => GClock,
		in_resetbar => GReset,
		o_Data1 => int_ReadData1,
		o_Data2 => int_ReadData2
	);

	MemoryInstruction : instrMem
	port map(
		address => int_instructionAdd,
		clock => GClock,
		q => int_Instruction
	);
	
	RegDstMux : mux8_2to1
	port map(
		A_8bit => "000" & int_Instruction(20 downto 16),
		B_8bit => "000" & int_Instruction(15 downto 11),
		Sel_8bit => int_RegDst,
		O_8bit => int_WriteData
	);
	
	
	RegisterALU : ALU
	port map(
		Operand1 => int_ReadData1, 
		Operand2 => int_ReadData2,
		OpSel => int_ALUOperation,
		OpRes => int_ALUResult,
		Zero => ZeroOut, 
		Overflow => open
	);
	
	ALUOpMux : mux8_2to1
	port map(
		A_8bit => int_ReadData2,
		B_8bit => int_InstructionAdd,
		Sel_8bit => int_ALUSrc,
		O_8bit => int_ALUOperandB
	);

	CPUControlUnit : controlUnit
	port map(
		i_Op => int_Instruction(31 downto 26),
		o_RegDst => int_RegDst, 
		o_ALUSrc => int_ALUSrc, 
		o_MemtoReg => int_MemToReg, 
		o_RegWrite => int_RegWrite, 
		o_MemRead => int_MemRead, 
		o_MemWrite => int_MemWrite, 
		o_Branch => int_Branch, 
		o_ALUOp0 => int_ALUOPControl(0), 
		o_ALUOp1 => int_ALUOPControl(1), 
		o_jump => open
		);
	
	RegisterALUControlUnit : ALUControlUnit
	port map(
		i_Funct => int_instructionAdd(5 downto 0),
		i_ALUOp => int_ALUOPControl,
		o_Operation => int_ALUOperation
	);
	
end rtl;