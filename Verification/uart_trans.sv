import v_pkg::*;


`ifndef UART_TRANSACTION
`define UART_TRANSACTION


class uart_trans;

typedef enum{write = 0, read = 1} op_type;

// =========== INSTANTIATION =========== 

randc op_type oper;
rand bit [7:0] dintx;
bit rx;
bit newdata;
bit tx;
bit donetx;
bit donerx;
bit [7:0] doutrx;



endclass: uart_trans
`endif 

