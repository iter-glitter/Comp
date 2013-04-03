library verilog;
use verilog.vl_types.all;
entity nbit_pc is
    generic(
        n               : integer := 4;
        inc             : integer := 2
    );
    port(
        clk             : in     vl_logic;
        clr             : in     vl_logic;
        ctrl            : in     vl_logic_vector(1 downto 0);
        pc_in           : in     vl_logic_vector;
        pc_out          : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of n : constant is 1;
    attribute mti_svvh_generic_type of inc : constant is 1;
end nbit_pc;
