library verilog;
use verilog.vl_types.all;
entity ld_st_shift_nbit is
    generic(
        n               : integer := 4
    );
    port(
        clk             : in     vl_logic;
        clr             : in     vl_logic;
        set             : in     vl_logic;
        ctrl            : in     vl_logic_vector(1 downto 0);
        ls              : in     vl_logic;
        rs              : in     vl_logic;
        reg_in          : in     vl_logic_vector;
        reg_out         : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of n : constant is 1;
end ld_st_shift_nbit;
