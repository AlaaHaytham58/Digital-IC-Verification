class stimulus;
    rand bit[7:0] cmd;
    rand bit[7:0] payload;
    bit clk;
    constraint cmd_c
    {
        cmd inside {CMD_READ,CMD_WRITE,CMD_RESET};
        cmd dist {CMD_READ:= 3, CMD_WRITE:= 5, CMD_RESET:= 1};
    }
    constraint payload_c
    {
        foreach (payload[i]) 
            payload[i] inside {[8'h10:8'h20]};
        
    }
    function void pre_randomaization();
        $display("Pre-randomization: cmd = %h, payload = %h", cmd, payload );
    endfunction
    function void post_randomization();
        $display("Pre-randomization: cmd = %h, payload = %h", cmd, payload );
    endfunction
    task drive(ref logic [7:0] sig);
     @(posedge clk);
        sig=cmd;
        foreach (payload[i]) begin
             @(posedge clk);
            sig = payload[i];
            $display("Driving payload[%0d] = %0d", i, payload[i]);
        end
    endtask
    
endclass
typedefine enum logic[7:0] {
    CMD_NOP = 8'h00,
    CMD_READ = 8'h01,
    CMD_WRITE = 8'h02,
    CMD_RESET = 8'hFF
}cmd_e;