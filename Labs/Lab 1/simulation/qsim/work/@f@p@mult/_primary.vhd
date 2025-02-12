library verilog;
use verilog.vl_types.all;
entity FPMult is
    port(
        signA           : in     vl_logic;
        signB           : in     vl_logic;
        GClock          : in     vl_logic;
        GReset          : in     vl_logic;
        MantissaA       : in     vl_logic_vector(7 downto 0);
        MantissaB       : in     vl_logic_vector(7 downto 0);
        ExponentA       : in     vl_logic_vector(6 downto 0);
        ExponentB       : in     vl_logic_vector(6 downto 0);
        signOut         : out    vl_logic;
        Overflow        : out    vl_logic;
        MantissaOut     : out    vl_logic_vector(7 downto 0);
        ExponentOut     : out    vl_logic_vector(6 downto 0)
    );
end FPMult;
