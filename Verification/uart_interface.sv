//import v_pkg::*;

interface uart_interface;
  logic clk;
  logic uclktx;
  logic uclkrx;
  logic rst;
  logic rx;
  logic [7:0] dintx;
  logic newdata;
  logic tx;
  logic [7:0] doutrx;
  logic donetx;
  logic donerx;
  
endinterface: uart_interface
