library verilog;
use verilog.vl_types.all;
entity alu_bitslice is
    port(
        a               : in     vl_logic;
        b               : in     vl_logic;
        c               : in     vl_logic_vector(2 downto 0);
        c_in            : in     vl_logic;
        c_out           : out    vl_logic;
        f_out           : out    vl_logic
    );
end alu_bitslice;
