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
        hit_out         : out    vl_logic;
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
        ram8            : out    vl_logic_vector;
        ram9            : out    vl_logic_vector;
        ram10           : out    vl_logic_vector;
        ram11           : out    vl_logic_vector;
        ram12           : out    vl_logic_vector;
        ram13           : out    vl_logic_vector;
        ram14           : out    vl_logic_vector;
        ram15           : out    vl_logic_vector;
        curr_LRU        : out    vl_logic_vector(1 downto 0);
        cache_hit       : out    vl_logic_vector(1 downto 0);
        target_rw_out   : out    vl_logic;
        c_dataIN_out    : out    vl_logic_vector;
        state           : out    vl_logic_vector(3 downto 0);
        ram_data_in_monitor: out    vl_logic_vector;
        ram_addr_in_monitor: out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of d_width : constant is 1;
    attribute mti_svvh_generic_type of a_width : constant is 1;
    attribute mti_svvh_generic_type of n : constant is 1;
end cache;
