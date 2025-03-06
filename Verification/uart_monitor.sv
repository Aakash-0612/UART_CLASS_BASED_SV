import v_pkg::*;


class uart_monitor;


// =========== INSTANTIATION =========== 
virtual uart_interface vif; 
uart_trans tr;

mailbox #(bit [7:0])mon_2_scb;

bit [7:0] srx;
bit [7:0] rrx;


// =========== CONSTRUCTOR ===========

function new (mailbox #(bit [7:0])mon_2_scb);

$display(" ##### INSIDE THE UART MONITOR CONSTRUCTOR #####");
  this.mon_2_scb = mon_2_scb;
$display(" ##### EXITED THE UART MONITOR CONSTRUCTOR #####");
endfunction: new


//  =========== RUN TASK =========== 
task run();
forever begin

  @(posedge vif.uclktx);
  if ((vif.newdata == 1) && (vif.rx == 1))
    begin
      @(posedge vif.uclktx); // start getting data from tx from next clock tick

// CAPTURE 8 BITS OF DATA
      for(int i =0; i<=7; i++)
      begin
        @(posedge vif.uclktx);
        srx[i] = vif.tx;
      end
    $display("[MONITOR]: Data Sent on TX: %0d", srx);

mon_2_scb.put(srx);

end

 else if ((vif.newdata == 0) && (vif.rx == 0))
    begin
      wait(vif.donerx == 1);
   
   // READ RCVD DATA
      rrx = vif.doutrx;
      $display("[MONITOR]: Data RCVD on RX: %0d", rrx);
      @(posedge vif.uclktx);

mon_2_scb.put(rrx);

end

end
endtask: run
endclass: uart_monitor
