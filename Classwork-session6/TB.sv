
module tb
(arb_if.TEST arbif_tb);
initial begin 
    arbif_tb.grant=1;
    arbif_tb.request=0;

    $monitor("Time: %0t, Request: %b, Grant: %b, RST: %b", $time, arbif_tb.request, arbif_tb.grant, arbif_tb.rst);
end
endmodule