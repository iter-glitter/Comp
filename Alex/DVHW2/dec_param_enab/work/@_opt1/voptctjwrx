library verilog;
use verilog.vl_types.all;
entity dec_param_enab is
    generic(
        n               : integer := 3
    );
    port(
        inp             : in     vl_logic_vector;
        enab            : in     vl_logic;
        d               : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of n : constant is 1;
end dec_param_enab;
