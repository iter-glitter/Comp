library verilog;
use verilog.vl_types.all;
entity dff_syn_low_clr_set is
    port(
        clk             : in     vl_logic;
        d               : in     vl_logic;
        set             : in     vl_logic;
        clr             : in     vl_logic;
        q               : out    vl_logic;
        q_cmp           : out    vl_logic
    );
end dff_syn_low_clr_set;
