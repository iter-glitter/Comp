library verilog;
use verilog.vl_types.all;
entity stack is
    generic(
        width           : integer := 8;
        depth           : integer := 3
    );
    port(
        en              : in     vl_logic;
        clr             : in     vl_logic;
        clk             : in     vl_logic;
        con             : in     vl_logic_vector(1 downto 0);
        data_in         : in     vl_logic_vector;
        data_out        : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of width : constant is 1;
    attribute mti_svvh_generic_type of depth : constant is 1;
end stack;
