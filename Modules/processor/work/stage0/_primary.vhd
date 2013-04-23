library verilog;
use verilog.vl_types.all;
entity stage0 is
    generic(
        T0              : vl_logic_vector(0 to 15) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1);
        T1              : vl_logic_vector(0 to 15) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0);
        T2              : vl_logic_vector(0 to 15) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi0);
        T3              : vl_logic_vector(0 to 15) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi0);
        T4              : vl_logic_vector(0 to 15) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0);
        T5              : vl_logic_vector(0 to 15) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0);
        T6              : vl_logic_vector(0 to 15) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        T7              : vl_logic_vector(0 to 15) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        T8              : vl_logic_vector(0 to 15) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        T9              : vl_logic_vector(0 to 15) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        T10             : vl_logic_vector(0 to 15) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        T11             : vl_logic_vector(0 to 15) := (Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        T12             : vl_logic_vector(0 to 15) := (Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        T13             : vl_logic_vector(0 to 15) := (Hi0, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        T14             : vl_logic_vector(0 to 15) := (Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        T15             : vl_logic_vector(0 to 15) := (Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        CP0             : vl_logic_vector(0 to 20) := (Hi1, Hi0, Hi1, Hi1, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi1, Hi0, Hi0, Hi1, Hi0, Hi1, Hi1, Hi0, Hi1, Hi1, Hi0);
        CP1             : vl_logic_vector(0 to 20) := (Hi1, Hi0, Hi0, Hi1, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi0, Hi0, Hi1, Hi1, Hi0, Hi1, Hi1, Hi0);
        CP2             : vl_logic_vector(0 to 20) := (Hi1, Hi0, Hi0, Hi1, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi0, Hi0, Hi1, Hi0, Hi0, Hi1, Hi0, Hi0);
        CP3             : vl_logic_vector(0 to 20) := (Hi1, Hi0, Hi1, Hi1, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi0, Hi1, Hi1, Hi1, Hi0, Hi1, Hi1, Hi0);
        CP4             : vl_logic_vector(0 to 20) := (Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi1, Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi0, Hi0, Hi1, Hi1, Hi0, Hi1, Hi1, Hi0);
        CP5             : vl_logic_vector(0 to 20) := (Hi1, Hi0, Hi0, Hi1, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi0, Hi0, Hi1, Hi1, Hi0, Hi1, Hi1, Hi0);
        CP6             : vl_logic_vector(0 to 20) := (Hi1, Hi1, Hi0, Hi1, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi0, Hi0, Hi1, Hi1, Hi0, Hi1, Hi1, Hi0);
        CP7             : vl_logic_vector(0 to 20) := (Hi1, Hi0, Hi0, Hi1, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi0, Hi0, Hi1, Hi1, Hi0, Hi1, Hi1, Hi0);
        CP8             : vl_logic_vector(0 to 20) := (Hi1, Hi0, Hi0, Hi1, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi0, Hi0, Hi1, Hi1, Hi0, Hi1, Hi1, Hi0);
        CP9             : vl_logic_vector(0 to 20) := (Hi1, Hi0, Hi0, Hi1, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi0, Hi0, Hi1, Hi1, Hi0, Hi1, Hi1, Hi0);
        CP10            : vl_logic_vector(0 to 20) := (Hi1, Hi0, Hi1, Hi1, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi0, Hi1, Hi1, Hi0);
        CP11            : vl_logic_vector(0 to 20) := (Hi1, Hi0, Hi0, Hi1, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi0, Hi0, Hi1, Hi1, Hi0, Hi1, Hi1, Hi0);
        CP12            : vl_logic_vector(0 to 20) := (Hi1, Hi0, Hi0, Hi1, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi0, Hi0, Hi1, Hi0, Hi0, Hi1, Hi0, Hi0);
        CP13            : vl_logic_vector(0 to 20) := (Hi1, Hi0, Hi0, Hi1, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi0, Hi0, Hi1, Hi0, Hi1, Hi1, Hi0, Hi1);
        CP14            : vl_logic_vector(0 to 20) := (Hi1, Hi0, Hi0, Hi1, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi0, Hi0, Hi1, Hi1, Hi0, Hi1, Hi1, Hi0);
        CP15            : vl_logic_vector(0 to 20) := (Hi1, Hi0, Hi1, Hi1, Hi0, Hi1, Hi0, Hi1, Hi1, Hi0, Hi1, Hi1, Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1);
        BRA             : vl_logic_vector(0 to 4) := (Hi0, Hi0, Hi1, Hi1, Hi0);
        JMP             : vl_logic_vector(0 to 4) := (Hi0, Hi0, Hi1, Hi1, Hi1);
        BSR             : vl_logic_vector(0 to 4) := (Hi1, Hi0, Hi1, Hi0, Hi1);
        RTS             : vl_logic_vector(0 to 4) := (Hi0, Hi1, Hi0, Hi0, Hi0);
        RTI             : vl_logic_vector(0 to 4) := (Hi0, Hi1, Hi0, Hi0, Hi1);
        LMSK            : vl_logic_vector(0 to 4) := (Hi0, Hi1, Hi1, Hi1, Hi0);
        BEQ             : vl_logic_vector(0 to 2) := (Hi0, Hi0, Hi0);
        BNE             : vl_logic_vector(0 to 2) := (Hi0, Hi0, Hi1)
    );
    port(
        clk             : in     vl_logic;
        clr             : in     vl_logic;
        instr           : in     vl_logic_vector(7 downto 0);
        data_in         : in     vl_logic_vector(7 downto 0);
        i_pending       : in     vl_logic;
        ccr_z           : in     vl_logic;
        stg1_state      : in     vl_logic;
        stg0_state      : out    vl_logic;
        ctrl            : out    vl_logic_vector(20 downto 0);
        pc_out          : out    vl_logic_vector(7 downto 0);
        itr_mask        : out    vl_logic_vector(3 downto 0);
        stage0          : out    vl_logic_vector(15 downto 0);
        stg0_instr      : out    vl_logic_vector(7 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of T0 : constant is 1;
    attribute mti_svvh_generic_type of T1 : constant is 1;
    attribute mti_svvh_generic_type of T2 : constant is 1;
    attribute mti_svvh_generic_type of T3 : constant is 1;
    attribute mti_svvh_generic_type of T4 : constant is 1;
    attribute mti_svvh_generic_type of T5 : constant is 1;
    attribute mti_svvh_generic_type of T6 : constant is 1;
    attribute mti_svvh_generic_type of T7 : constant is 1;
    attribute mti_svvh_generic_type of T8 : constant is 1;
    attribute mti_svvh_generic_type of T9 : constant is 1;
    attribute mti_svvh_generic_type of T10 : constant is 1;
    attribute mti_svvh_generic_type of T11 : constant is 1;
    attribute mti_svvh_generic_type of T12 : constant is 1;
    attribute mti_svvh_generic_type of T13 : constant is 1;
    attribute mti_svvh_generic_type of T14 : constant is 1;
    attribute mti_svvh_generic_type of T15 : constant is 1;
    attribute mti_svvh_generic_type of CP0 : constant is 1;
    attribute mti_svvh_generic_type of CP1 : constant is 1;
    attribute mti_svvh_generic_type of CP2 : constant is 1;
    attribute mti_svvh_generic_type of CP3 : constant is 1;
    attribute mti_svvh_generic_type of CP4 : constant is 1;
    attribute mti_svvh_generic_type of CP5 : constant is 1;
    attribute mti_svvh_generic_type of CP6 : constant is 1;
    attribute mti_svvh_generic_type of CP7 : constant is 1;
    attribute mti_svvh_generic_type of CP8 : constant is 1;
    attribute mti_svvh_generic_type of CP9 : constant is 1;
    attribute mti_svvh_generic_type of CP10 : constant is 1;
    attribute mti_svvh_generic_type of CP11 : constant is 1;
    attribute mti_svvh_generic_type of CP12 : constant is 1;
    attribute mti_svvh_generic_type of CP13 : constant is 1;
    attribute mti_svvh_generic_type of CP14 : constant is 1;
    attribute mti_svvh_generic_type of CP15 : constant is 1;
    attribute mti_svvh_generic_type of BRA : constant is 1;
    attribute mti_svvh_generic_type of JMP : constant is 1;
    attribute mti_svvh_generic_type of BSR : constant is 1;
    attribute mti_svvh_generic_type of RTS : constant is 1;
    attribute mti_svvh_generic_type of RTI : constant is 1;
    attribute mti_svvh_generic_type of LMSK : constant is 1;
    attribute mti_svvh_generic_type of BEQ : constant is 1;
    attribute mti_svvh_generic_type of BNE : constant is 1;
end stage0;
