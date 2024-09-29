`timescale 1ns / 1ps

module crc74(crc_out, data_in, crc_en, rst, clk, code);

//inputs and outputs
output [6:0] crc_out;
input [3:0] data_in;
input [3:0] code;
input crc_en;
input rst;
input clk;

//register initialization
reg [3:0] rem = {4{1'b0}};
reg [3:0] old_dat = {4{1'b0}};
reg [6:0] crc = {6{1'b0}};;

//assigning codeword to output
assign crc_out = crc;


//always at positive edge of clock
always @(posedge clk)
begin
    if (clk)
        rem = data_in;  //new data input
        old_dat = rem;  //keeping a copy
end


//always at negative edge of clock
always @(negedge clk)
begin  
    if (crc_en)
        repeat (4)
        begin
            if (rem[3] == 1)
            begin
                rem = rem ^ code;   //XOR
            end    
            rem = rem << 1;     //left shift
         end
         crc = {old_dat,rem[3:1]};  //creating codeword
end



//always at positive edge of reset
always @(posedge rst)
begin
    if (rst)
    begin
        rem <= {4{1'b0}};
        crc <= {6{1'b0}};
    end
end

endmodule

