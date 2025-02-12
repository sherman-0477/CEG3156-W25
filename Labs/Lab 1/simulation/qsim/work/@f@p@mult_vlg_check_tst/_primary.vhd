library verilog;
use verilog.vl_types.all;
entity FPMult_vlg_check_tst is
    port(
        ExponentOut     : in     vl_logic_vector(6 downto 0);
        MantissaOut     : in     vl_logic_vector(7 downto 0);
        Overflow        : in     vl_logic;
        signOut         : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end FPMult_vlg_check_tst;
