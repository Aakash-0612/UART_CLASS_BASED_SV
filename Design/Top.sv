`timescale 1ns / 1ps
 
module uart_top
#(
parameter clk_freq = 1000000,
parameter baud_rate = 9600
)
(
  input clk,rst, 
  input rx,
  input [7:0] dintx,
  input newdata,
  output tx, 
  output [7:0] doutrx,
  output donetx,
  output donerx
    );
    
uarttx 
#(clk_freq, baud_rate) 
utx   
(clk, rst, newdata, dintx, tx, donetx);   
 
uartrx 
#(clk_freq, baud_rate)
rtx
(clk, rst, rx, donerx, doutrx);    
    
    
endmodule
