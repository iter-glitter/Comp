library verilog;
use verilog.vl_types.all;
entity ld_st_reg is
    generic(
        n               : integer := 4
    );
    port(
        \in\            : in     vl_logic_vector;
        set             : in     vl_logic;
        clr             : in     vl_logic;
        clk             : in     vl_logic;
        \out\           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of n : constant is 1;
end ld_st_reg;
