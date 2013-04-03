library verilog;
use verilog.vl_types.all;
entity reg_array_param is
    generic(
        m               : integer := 2;
        n               : integer := 4
    );
    port(
        clk             : in     vl_logic;
        clr             : in     vl_logic;
        wrt_enab        : in     vl_logic;
        d_in            : in     vl_logic_vector;
        radd            : in     vl_logic_vector;
        wadd            : in     vl_logic_vector;
        d_out           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of m : constant is 1;
    attribute mti_svvh_generic_type of n : constant is 1;
end reg_array_param;
