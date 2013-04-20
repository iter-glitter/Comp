library verilog;
use verilog.vl_types.all;
entity MHVPIS is
    port(
        clk             : in     vl_logic;
        itr_clr         : in     vl_logic;
        itr_in          : in     vl_logic_vector(3 downto 0);
        mask_in         : in     vl_logic_vector(3 downto 0);
        itr_en          : in     vl_logic;
        i_pending       : out    vl_logic;
        PC_out          : out    vl_logic_vector(7 downto 0)
    );
end MHVPIS;
