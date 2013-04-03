library verilog;
use verilog.vl_types.all;
entity n_bit_alu_generate is
    generic(
        n               : integer := 4
    );
    port(
        a               : in     vl_logic_vector;
        b               : in     vl_logic_vector;
        c_in            : in     vl_logic;
        c               : in     vl_logic_vector(2 downto 0);
        c_out           : out    vl_logic;
        f_out           : out    vl_logic_vector;
        V               : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of n : constant is 1;
end n_bit_alu_generate;
