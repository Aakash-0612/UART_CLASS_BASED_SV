import v_pkg::*;


class uart_scoreboard;

// =========== INSTANTIATION ===========
 
mailbox #(bit[7:0])driv_2_scb;
mailbox #(bit[7:0])mon_2_scb;

bit [7:0] dr_sc;
bit [7:0] mr_sc;

// =========== EVENT DECLARATIONS ===========

 
event scb_done;


// =========== CONSTRUCTOR ===========

function new (mailbox #(bit[7:0])driv_2_scb, mailbox #(bit[7:0])mon_2_scb);

this.driv_2_scb = driv_2_scb;
this.mon_2_scb = mon_2_scb;

endfunction: new

task run();
    forever begin
      
      driv_2_scb.get(dr_sc);
      mon_2_scb.get(mr_sc);
      
      $display("[SCO] : DRV : %0d MON : %0d", dr_sc, mr_sc);
      if(dr_sc == mr_sc)
        $display("DATA MATCHED");
      else
        $display("DATA MISMATCHED");
      
      $display("----------------------------------------");
      
     ->scb_done;
$display("[SCO]: scb_done event triggered."); // debug
 
    end
endtask: run
  
  
endclass: uart_scoreboard
