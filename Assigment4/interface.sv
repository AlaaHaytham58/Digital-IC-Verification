interface uart_if(input logic clk, input logic rst_n);
    logic tx_start;
    logic[7:0] data_in;
    logic parity_en;
    logic even_parity;
    logic tx;
    logic tx_busy; 
   
   modport DUT(
        input tx_start, data_in, parity_en, even_parity,clk, rst_n,
        output tx, tx_busy
    );
    modport TEST(
        output tx_start, data_in, parity_en, even_parity,
        input tx, tx_busy,clk, rst_n
    );
   /* modport MONITOR(
        input tx_start, data_in, parity_en, even_parity,
        input tx, tx_busy
    );*/
    

endinterface