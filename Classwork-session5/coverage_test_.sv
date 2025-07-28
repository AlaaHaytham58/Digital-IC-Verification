class coverage_test;

    rand logic [3:0] opcode;
    rand logic [7:0] data;
    bit clk;
    
    bit [3:0] opcode_post_rand;
    covergroup cg;
     cp_point :coverpoint opcode{
        bins alu_ops={4,5,6};
        bins load_str={1,2};
        bins misc_ops={0,3,7,8};
     }
     cp_range :coverpoint data{
        bins low={[0:63]};
        bins mid={[64:127]};
        bins high={[128:255]};
     }
     cp_transition: coverpoint opcode{
        bins load_to_str=(1=>2);
        bins alu_seq=(2=>4=>5);
     }
     cp_ignore:coverpoint opcode{
        ignore_bins resevedop={9,10,11,12};
        illegal_bins illegalop={15};
     }


    endgroup
    function new();
        cg = new();
    endfunction
endclass