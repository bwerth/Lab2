//------------------------------------------------------------------------
// Input Conditioner
//    1) Synchronizes input to clock domain
//    2) Debounces input
//    3) Creates pulses at edge transitions
//------------------------------------------------------------------------

module inputconditioner
(clk,noisysignal,conditioned,positiveedge,negativeedge);

    parameter counterwidth = 3; // Counter size, in bits, >= log2(waittime)
    parameter waittime = 3;     // Debounce delay, in clock cycles

    input clk;
    input noisysignal;
    output reg conditioned;
    output reg positiveedge;
    output reg negativeedge;
    
    reg[counterwidth-1:0] counter = 0;
    reg synchronizer0 = 0;
    reg synchronizer1 = 0;
    reg conditioned1 = 0;
    
    always @(posedge clk ) begin
		if(conditioned1 == 0 && conditioned == 1) begin
			negativeedge = 1;
		end else if (conditioned1 == 1 && conditioned == 0) begin
			positiveedge = 1;
        end else if (positiveedge == 1 || negativeedge == 1) begin
            positiveedge = 0;
            negativeedge = 0;
        end
        if(conditioned1 == synchronizer1)
            counter <= 0;
        else begin
            if( counter == waittime) begin
                counter <= 0;
                conditioned1 <= synchronizer1;
            end
            else 
                counter <= counter+1;
        end
        synchronizer0 <= noisysignal;
        synchronizer1 <= synchronizer0;
		conditioned <= conditioned1;
    end
endmodule



