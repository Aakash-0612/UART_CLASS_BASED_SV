import v_pkg::*;

class uart_driver;

// =========== INSTANTIATION =========== 
virtual uart_interface vif; 

mailbox #(uart_trans)gen_2_driv;
mailbox #(bit [7:0]) driv_2_scb; /// drv - sco

uart_trans tr;
// =========== EVENT DECLARATIONS =========== 

event driver_done;

bit [7:0] datarx; // VARIABLE TO STORE THE RCVD DATA WHILE DOING THE READ OPERATION


// =========== CONSTRUCTOR ===========

function new (mailbox #(bit [7:0])driv_2_scb, mailbox #(uart_trans)gen_2_driv);               // , event done); 

$display(" ##### INSIDE THE UART DRIVER CONSTRUCTOR #####");
this.gen_2_driv = gen_2_driv;
this.driv_2_scb = driv_2_scb;
//                                                                   this.done = done;
$display(" ##### EXITED THE UART DRIVER CONSTRUCTOR #####");
endfunction: new

//  =========== RESET STATE =========== 

task reset();
$display("[DRIVER]: ##### ENTERED RESET STATE IN DRIVER #####");
vif.rst <= 1;
vif.dintx <= 0;
vif.newdata <= 0;
vif.rx <= 1; // IDEAL VALUE

repeat(5) @(posedge vif.uclktx);

vif.rst <= 0;

@(posedge vif.uclktx);

$display("[DRIVER]: ##### EXITED RESET STATE AND RESET IS DONE #####");
//end
endtask: reset


//  =========== RUN TASK =========== 

task run();

forever begin

gen_2_driv.get(tr);

if (tr.oper == 0) // WRITE OPERATION / DATA TRANSMISSION
  begin
    @(posedge vif.uclktx);
    vif.rst <= 0;
    vif.newdata <= 1; // STARTING TO SEND DATA
    vif.rx <= 1; 
    vif.dintx = tr.dintx; // DATA RCVD FROM GEN

    @(posedge vif.uclktx);

    vif.newdata <= 0;
    driv_2_scb.put(tr.dintx);
    $display("[DRIVER]: Data Sent: %0d", tr.dintx);
      wait(vif.donetx == 1);
      $display("[DRIVER]: Triggering driver_done event for operation: %0d", tr.oper); // DEBUG

      -> driver_done;
  end

else if (tr.oper == 1)
  begin
    @(posedge vif.uclktx);
    vif.rst <= 0;
    vif.newdata <= 0;
    vif.rx <= 0; 
    @(posedge vif.uclktx);

    for(int i =0; i<=7; i++)
       begin
             @(posedge vif.uclkrx);
             vif.rx <= $urandom;
             datarx[i] = vif.rx;
       end
    driv_2_scb.put(datarx);
    $display("[DRIVER]: Data RCVD: %0d", datarx);
      wait(vif.donerx == 1);
      vif.rx <= 1; 
      $display("[DRIVER]: Triggering driver_done event for operation: %0d", tr.oper);  // DEBUG
      -> driver_done;
  end

end
endtask: run
endclass: uart_driver






