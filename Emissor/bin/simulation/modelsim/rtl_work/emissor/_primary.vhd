library verilog;
use verilog.vl_types.all;
entity emissor is
    port(
        CLK             : in     vl_logic;
        CLR             : in     vl_logic;
        CPU_event       : in     vl_logic_vector(4 downto 0);
        state           : out    vl_logic_vector(2 downto 0);
        \BUS\           : out    vl_logic_vector(5 downto 0)
    );
end emissor;
