`timescale 1ns / 1ps

module Testbed();
    reg clk;
    reg [3:0] data;
    reg rst = 0;
    reg en = 1;
    wire [6:0] output_crc;
    
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial en = 1;
    
 
    initial
    #50 $finish;
    
    initial
    begin
 
            data = 4'b1001;      
        #10 data = 4'b1011;
        #10 data = 4'b1000;
        #10 data = 4'b1010;

    end
    crc74 c1(.crc_en(en), .rst(rst), .clk(clk), .code(4'b1011), .data_in(data), .crc_out(output_crc));
    
endmodule

