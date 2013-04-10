library verilog;
use verilog.vl_types.all;
entity mem_test is
    port(
        clk             : in     vl_logic;
        clr             : in     vl_logic;
        rw              : in     vl_logic;
        enab            : in     vl_logic;
        state           : out    vl_logic_vector(3 downto 0);
        data_out        : out    vl_logic_vector(7 downto 0);
        hit             : out    vl_logic;
        addr0           : out    vl_logic_vector(7 downto 0);
        addr1           : out    vl_logic_vector(7 downto 0);
        addr2           : out    vl_logic_vector(7 downto 0);
        addr3           : out    vl_logic_vector(7 downto 0);
        data0           : out    vl_logic_vector(7 downto 0);
        data1           : out    vl_logic_vector(7 downto 0);
        data2           : out    vl_logic_vector(7 downto 0);
        data3           : out    vl_logic_vector(7 downto 0);
        ram0            : out    vl_logic_vector(7 downto 0);
        ram1            : out    vl_logic_vector(7 downto 0);
        ram2            : out    vl_logic_vector(7 downto 0);
        ram3            : out    vl_logic_vector(7 downto 0);
        ram4            : out    vl_logic_vector(7 downto 0);
        ram5            : out    vl_logic_vector(7 downto 0);
        ram6            : out    vl_logic_vector(7 downto 0);
        ram7            : out    vl_logic_vector(7 downto 0);
        cache_addr      : out    vl_logic_vector(7 downto 0);
        cache_data      : out    vl_logic_vector(7 downto 0);
        i_out           : out    vl_logic_vector(31 downto 0);
        cache_clr       : out    vl_logic;
        cache_enab      : out    vl_logic;
        cache_rw        : out    vl_logic;
        cache_lru       : out    vl_logic_vector(1 downto 0);
        cache_hit       : out    vl_logic_vector(1 downto 0)
    );
end mem_test;
