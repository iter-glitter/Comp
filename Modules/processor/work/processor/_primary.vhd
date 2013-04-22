library verilog;
use verilog.vl_types.all;
entity processor is
    port(
        g_clk           : in     vl_logic;
        g_clr           : in     vl_logic;
        in_dev_hs       : in     vl_logic;
        out_dev_hs      : in     vl_logic;
        out_dev_ack     : in     vl_logic;
        in_dev_ack      : out    vl_logic;
        input_bus       : in     vl_logic_vector(7 downto 0);
        output_bus      : out    vl_logic_vector(7 downto 0);
        mem0            : out    vl_logic_vector(7 downto 0);
        mem1            : out    vl_logic_vector(7 downto 0);
        mem2            : out    vl_logic_vector(7 downto 0);
        mem3            : out    vl_logic_vector(7 downto 0);
        mem4            : out    vl_logic_vector(7 downto 0);
        mem5            : out    vl_logic_vector(7 downto 0);
        mem6            : out    vl_logic_vector(7 downto 0);
        mem7            : out    vl_logic_vector(7 downto 0);
        c_data0         : out    vl_logic_vector(7 downto 0);
        c_data1         : out    vl_logic_vector(7 downto 0);
        c_data2         : out    vl_logic_vector(7 downto 0);
        c_data3         : out    vl_logic_vector(7 downto 0);
        c_addr0         : out    vl_logic_vector(7 downto 0);
        c_addr1         : out    vl_logic_vector(7 downto 0);
        c_addr2         : out    vl_logic_vector(7 downto 0);
        c_addr3         : out    vl_logic_vector(7 downto 0);
        c_hit           : out    vl_logic_vector(1 downto 0);
        c_LRU           : out    vl_logic_vector(1 downto 0);
        cache_hit       : out    vl_logic;
        C               : out    vl_logic;
        V               : out    vl_logic;
        Z               : out    vl_logic;
        stage0          : out    vl_logic_vector(14 downto 0);
        stage1          : out    vl_logic_vector(71 downto 0);
        stage0_rdy      : out    vl_logic;
        stage1_rdy      : out    vl_logic;
        stg1_instr      : out    vl_logic_vector(7 downto 0);
        stg0_instr      : out    vl_logic_vector(7 downto 0);
        pc_output       : out    vl_logic_vector(7 downto 0);
        acc_reg_out     : out    vl_logic_vector(7 downto 0);
        alu_out_w       : out    vl_logic_vector(7 downto 0);
        a_reg_out       : out    vl_logic_vector(7 downto 0);
        b_reg_out       : out    vl_logic_vector(7 downto 0);
        mar_out_w       : out    vl_logic_vector(7 downto 0);
        mdr_out_w       : out    vl_logic_vector(7 downto 0);
        num_shift_out   : out    vl_logic_vector(2 downto 0);
        shifter_out     : out    vl_logic_vector(7 downto 0);
        ch_output       : out    vl_logic_vector(7 downto 0);
        ch_target_rw    : out    vl_logic;
        ch_target_data  : out    vl_logic_vector(7 downto 0);
        ch_state        : out    vl_logic_vector(3 downto 0);
        ram_data_in     : out    vl_logic_vector(7 downto 0);
        ram_addr_in     : out    vl_logic_vector(7 downto 0)
    );
end processor;
