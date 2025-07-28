module multi_op_processor_tb;
//--------struct to input the data and opcode
typedef struct{
    bit [1:0] opcode;   
    bit [7:0] data;     
}stimulus_t;
//------------dynamic array for stimulus
stimulus_t stim_arr[];
//------------queue to collect output from the module
bit[7:0] out[$];
//-----------associative array hold expected value from golden model
bit [7:0] expected_value[int];
///--------------INPUT PORTS-----------------
    bit  [7:0] data_in;
    bit [1:0] op_sel;
    bit [7:0] data_out;
    multi_op_processor DUT(.*);
//----------------tasks and functions--------
function void config_stim_storage(int size);
    stim_arr = new[size](stim_arr);
    out={};
    expected_value.delete();
endfunction
function automatic void generate_stimulus(ref stimulus_t dynamic_arr[]);
    foreach(dynamic_arr[i]) begin
        dynamic_arr[i].opcode = $random(); 
        dynamic_arr[i].data = $random(); 
    end
endfunction
task drivestim();
    foreach(stim_arr[i]) begin
        data_in = stim_arr[i].data;
        op_sel = stim_arr[i].opcode; 
        #1ns;
        out.push_back(dut.data_out);
    end
endtask
task automatic golden_model(ref bit [7:0] expected_value[int]);
    foreach(stim_arr[i]) begin
        case(stim_arr[i].opcode)
            2'b00: expected_value[i] = stim_arr[i].data + stim_arr[i].data; // ADD
            2'b01: expected_value[i] = stim_arr[i].data - stim_arr[i].data; // SUB
            2'b10: expected_value[i] = stim_arr[i].data * stim_arr[i].data; // MUL
            2'b11: expected_value[i] = stim_arr[i].data / (stim_arr[i].data + 1); // DIV (avoid division by zero)
        endcase
    end
endtask
task automatic check_result(bit [7:0] expected_value[int], bit [7:0] out[$]);
    foreach(expected_value[i]) begin
        if (expected_value[i] !== out[i]) begin
            $display("Mismatch at index %0d: Expected %0h, got %0h", i, expected_value[i], out[i]);
        end else begin
            $display("Match at index %0d: Value %0h", i, expected_value[i]);
        end
    end
endtask
task automatic reconfig(ref stimulus_t dyn[]);
 dyn.shuffle();
 out = {};
 expected_value.delete();

endtask
//-----------------initial block-----------------
initial begin

config_stim_storage(100); 
    generate_stimulus(stim_arr);
    drivestim();
    golden_model(expected_value);
    check_result(expected_value, out);

    #10ns;

    // Reconfigure and run again with new size
    reconfig(stim_arr);
    config_stim_storage(200); 
    generate_stimulus(stim_arr);
    drivestim();
    golden_model(expected_value);
    check_result(expected_value, out);

    $display("\n Simulation Done — 7alwa keda! 2t34t!!");
    $stop;


end
endmodule