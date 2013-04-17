library verilog;
use verilog.vl_types.all;
entity alu_nbit is
    generic(
        n               : integer := 4
    );
    port(
        in0             : in     vl_logic_vector;
        in1             : in     vl_logic_vector;
        c_in            : in     vl_logic;
        ctrl            : in     vl_logic_vector(2 downto 0);
        c_out           : out    vl_logic;
        alu_out         : out    vl_logic_vector;
        V               : out    vl_logic;
        Z               : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of n : constant is 1;
end alu_nbit;
