//`ifndef UART_GENERATOR
//`define UART_GENERATOR

import v_pkg::*;



class uart_generator;


// =========== INSTANTIATION =========== 

uart_trans tr;
mailbox #(uart_trans) gen_2_driv;
int count;

// =========== EVENT DECLARATIONS =========== 

event done;
event driver_done;
event scb_done;

// =========== CONSTRUCTOR =========== 

function new (mailbox #(uart_trans) gen_2_driv);       //, event done);

$display(" ##### INSIDE THE UART GENERATOR CONSTRUCTOR #####");

tr = new ();
this.gen_2_driv = gen_2_driv;
                                                                //this.done = done;
$display(" ##### EXITED THE UART GENERATOR CONSTRUCTOR #####");
endfunction: new

//  =========== RUN TASK =========== 
task run;

$display ("[GEN]: INSIDE GENERATOR");
repeat(count) begin
  if (tr.randomize) 
    $display("[GEN]: RANDOMISATION IS SUCCESSFUL");
  else 
    $error("[GEN]: RANDOMISATION FAILED");
  
gen_2_driv.put(tr);

$display("[GEN]: Operation: %0s Din: %0d", tr.oper.name(), tr.dintx);


$display("[GEN]: Waiting for driver_done..."); // DEBUG
@(driver_done);
$display("[GEN]: DRIVER GOT COMPLETED"); //DEBUG
#5 scb_done.triggered;
# 10 $display("[GEN]: SCOREBOARD GOT COMPLETED"); //DEBUG

end

-> done;
$display("[GEN]: GENERATION COMPLETED");

endtask

endclass: uart_generator
