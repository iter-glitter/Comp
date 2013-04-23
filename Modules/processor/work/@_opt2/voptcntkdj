library verilog;
use verilog.vl_types.all;
entity iramFib is
    generic(
        d_width         : integer := 16;
        a_width         : integer := 8
    );
    port(
        clk             : in     vl_logic;
        clr             : in     vl_logic;
        enab            : in     vl_logic;
        rw              : in     vl_logic;
        Addr            : in     vl_logic_vector;
        data_out        : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of d_width : constant is 1;
    attribute mti_svvh_generic_type of a_width : constant is 1;
end iramFib;
