library verilog;
use verilog.vl_types.all;
entity pri_encoder_4_1 is
    port(
        i               : in     vl_logic_vector(3 downto 0);
        \out\           : out    vl_logic_vector(1 downto 0);
        dis             : out    vl_logic
    );
end pri_encoder_4_1;
