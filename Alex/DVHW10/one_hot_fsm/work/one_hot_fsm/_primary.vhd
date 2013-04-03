library verilog;
use verilog.vl_types.all;
entity one_hot_fsm is
    generic(
        a               : vl_logic_vector(0 to 6) := (Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        b               : vl_logic_vector(0 to 6) := (Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0);
        c               : vl_logic_vector(0 to 6) := (Hi0, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0);
        d               : vl_logic_vector(0 to 6) := (Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi0);
        e               : vl_logic_vector(0 to 6) := (Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi0);
        f               : vl_logic_vector(0 to 6) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0);
        g               : vl_logic_vector(0 to 6) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1)
    );
    port(
        clk             : in     vl_logic;
        clr             : in     vl_logic;
        x               : in     vl_logic_vector(1 downto 0);
        start           : in     vl_logic;
        yp              : out    vl_logic_vector(6 downto 0);
        cp              : out    vl_logic_vector(4 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of a : constant is 1;
    attribute mti_svvh_generic_type of b : constant is 1;
    attribute mti_svvh_generic_type of c : constant is 1;
    attribute mti_svvh_generic_type of d : constant is 1;
    attribute mti_svvh_generic_type of e : constant is 1;
    attribute mti_svvh_generic_type of f : constant is 1;
    attribute mti_svvh_generic_type of g : constant is 1;
end one_hot_fsm;
