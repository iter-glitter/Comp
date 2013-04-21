library verilog;
use verilog.vl_types.all;
entity LdStr_shifter is
    generic(
        n               : integer := 8
    );
    port(
        Reg_in          : in     vl_logic_vector;
        clr             : in     vl_logic;
        set             : in     vl_logic;
        clk             : in     vl_logic;
        Ls              : in     vl_logic;
        Rs              : in     vl_logic;
        ctrl            : in     vl_logic_vector(1 downto 0);
        num_shift       : in     vl_logic_vector(2 downto 0);
        Reg_out         : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of n : constant is 1;
end LdStr_shifter;
