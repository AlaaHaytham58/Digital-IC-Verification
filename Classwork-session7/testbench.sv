module tb;

bit clk;
bit rst;
bit start;
bit ready;
bit enable;
bit done;
bit write;
bit ack;
bit ack2;
bit valid;
bit d_valid;
bit [2:0] data_out;
bit [2:0] data_in;
bit error;
bit lock;
bit unlock;
bit grant;
bit request;
bit go;
bit op_done;
bit wr_en;
bit rd_en;
bit flag;
bit input_valid;
bit output_valid;
bit load;
bit [7:0] data;
bit req;
bit gnt;
bit packet_start;
bit header;
bit full;
bit overflow;
bit burst_start;
bit burst_end;
bit data_valid;
bit [2:0] a, b;
bit out;

int counter;
int rand_delay1;
int rand_delay2;
  

  assert_lab dut(.*);

  initial begin
    clk = 0;
    forever #2ns clk = ~clk;
  end  

  initial begin
    rand_delay1 = $urandom_range(1,3);
    rand_delay2 = $urandom_range(2,4);
  end


//***************************************************************************


  // 1. Check that when start rises, ready becomes high exactly 3 cycles later.
   initial begin
 
    repeat(4) begin
      #1ns;
      repeat(2)@(negedge clk);
      start <= 1;
      repeat(2) @(negedge clk);
      ready <= 1;
      repeat(2) @(negedge clk);
      start <= 0;
      ready <= 0;
   end  
  end
  


//***************************************************************************

  // // 2. Ensure that whenever enable goes high, done eventually follows.
  // initial begin
  //   #1ns;
  //   repeat(3)@(negedge clk);
  //   enable <= 1;
  //   repeat(10)@(negedge clk);
  //   done <= 1;
  // end

//***************************************************************************

  // // 3. When write is high, ack must be high within 2 to 4 cycles.
  // initial begin
  //   #10ns;
  //   @(negedge clk);
  //   write <= 1;
  //   repeat(rand_delay2) @(negedge clk);
  //   ack <= 1;
  // end

//***************************************************************************

 // // 4. After a rising edge of rst, valid must stay low for at least 5 cycles.
 //  initial begin
 //    #15ns;
 //    @(negedge clk);
 //    rst <= 1;
 //    @(negedge clk);
 //    rst <= 0;
 //    repeat(3) @(negedge clk);
 //    valid <= 1;
 //  end

//***************************************************************************

  // 5. Check that data_out is stable during valid being high.
  // initial begin
  //   #25ns;
  //   @(negedge clk);
  //   data_out <= 3'b101;
  //   @(negedge clk);
  //   valid <= 1;
    
  //   // #4ns;
  //   // data_out <= 3'b111;        //TODO::UNCOMMENT TO FAIL
   
  //   repeat(4) @(negedge clk);
  //   valid <= 0;
  // end

//***************************************************************************

 // 6. Ensure that if data_in changes, valid becomes high the next cycle.
  // initial begin
  //   // rst = 0;          //TODO::UNCOMMENT TO GUARD START ISSUE
  //   // #10;
  //   // rst = 1;
  //   #35ns;
  //   @(negedge clk);
  //   data_in <= 3'b001;
  //   @(negedge clk);
  //   d_valid <= 1;
  //   @(negedge clk);
  //   d_valid <= 0;
  // end

//***************************************************************************
  
// // 22. After burst_start, data_valid must occur exactly 4 times (with possible stalls), then burst_end.
  
//   initial begin
//    #40ns;
//     @(negedge clk);
//    burst_start <= 1;
//    @(negedge clk);
//    burst_start <= 0;

//    repeat(2) @(negedge clk);
//    data_valid <= 1; @(negedge clk); data_valid <= 0;
//    repeat(1) @(negedge clk);
//    data_valid <= 1; @(negedge clk); data_valid <= 0;
//    repeat(1) @(negedge clk);
//    data_valid <= 1; @(negedge clk); data_valid <= 0;
//    data_valid <= 1; @(negedge clk); data_valid <= 0;
//     //repeat(2) @(negedge clk);     //TODO::UNCOMMENT TO NON-CONSECUTIVE PRACTICE (=4)
//    burst_end <= 1;
//   end
  
//***************************************************************************  
  
  initial begin   //ENDING BLOCK
    #200ns;
    $stop;
  end 


endmodule
