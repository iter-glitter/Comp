library verilog;
use verilog.vl_types.all;
entity cache is
    generic(
        d_width         : integer := 8;
        a_width         : integer := 8;
        n               : integer := 4
    );
    port(
        clk             : in     vl_logic;
        clr             : in     vl_logic;
        enab            : in     vl_logic;
        rw              : in     vl_logic;
        Addr            : in     vl_logic_vector;
        data_in         : in     vl_logic_vector;
        data_out        : out    vl_logic_vector;
        hit             : out    vl_logic;
        addr0           : out    vl_logic_vector;
        addr1           : out    vl_logic_vector;
        addr2           : out    vl_logic_vector;
        addr3           : out    vl_logic_vector;
        data0           : out    vl_logic_vector;
        data1           : out    vl_logic_vector;
        data2           : out    vl_logic_vector;
        data3           : out    vl_logic_vector;
        ram0            : out    vl_logic_vector;
        ram1            : out    vl_logic_vector;
        ram2            : out    vl_logic_vector;
        ram3            : out    vl_logic_vector;
        ram4            : out    vl_logic_vector;
        ram5            : out    vl_logic_vector;
        ram6            : out    vl_logic_vector;
        ram7            : out    vl_logic_vector;
        state           : out    vl_logic_vector(3 downto 0);
        curr_LRU        : out    vl_logic_vector(1 downto 0);
        cache_hit       : out    vl_logic_vector(1 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of d_width : constant is 1;
    attribute mti_svvh_generic_type of a_width : constant is 1;
    attribute mti_svvh_generic_type of n : constant is 1;
end cache;
