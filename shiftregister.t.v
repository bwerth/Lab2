//------------------------------------------------------------------------
// Shift Register test bench
//------------------------------------------------------------------------
`include "shiftregister.v"

module testshiftregister();

    reg             clk;
    reg             peripheralClkEdge;
    reg             parallelLoad;
    wire[7:0]       parallelDataOut;
    wire            serialDataOut;
    reg[7:0]        parallelDataIn;
    reg             serialDataIn; 
    
    // Instantiate with parameter width = 8
    shiftregister #(8) dut(.clk(clk), 
    		           .peripheralClkEdge(peripheralClkEdge),
    		           .parallelLoad(parallelLoad), 
    		           .parallelDataIn(parallelDataIn), 
    		           .serialDataIn(serialDataIn), 
    		           .parallelDataOut(parallelDataOut), 
    		           .serialDataOut(serialDataOut));
    
    initial begin
       forever begin
          clk = !clk; #10;
       end
    end

    initial begin
    	parallelLoad = 1; parallelDataIn = 8'b10000000; #100;
        serialDataIn = 1; peripheralClkEdge = 1; parallelLoad = 0; #20;
        serialDataIn = 0; #200;
    end

endmodule

