import v_pkg::*;


class uart_env;
 
    uart_generator gen;
    uart_driver drv;
    uart_monitor mon;
    uart_scoreboard sco; 
  
    
    event done;

    event nextgd; ///gen -> drv
  
    event nextgs;  /// gen -> sco
  
  mailbox #(uart_trans) gen_2_driv; ///gen - drv
  
  mailbox #(bit [7:0]) driv_2_scb; /// drv - sco
    
     
  mailbox #(bit [7:0]) mon_2_scb;  /// mon - sco
  
    virtual uart_interface vif;
 
  
  function new(virtual uart_interface vif);
       
    gen_2_driv = new();
    mon_2_scb = new();
    driv_2_scb = new();
    
    gen = new(gen_2_driv);
    drv = new(driv_2_scb,gen_2_driv);
    mon = new(mon_2_scb);
    sco = new(driv_2_scb,mon_2_scb);
    
    this.vif = vif;
    drv.vif = this.vif;
    mon.vif = this.vif;
    
    gen.scb_done = nextgs;
    sco.scb_done = nextgs;
    
    gen.driver_done = nextgd;
    drv.driver_done = nextgd;
 
  endfunction: new
  
  task pre_test();
    drv.reset();
  endtask: pre_test
  
  task test();
  fork
    gen.run();
    drv.run();
    mon.run();
    sco.run();
  join_any
  endtask: test
  
  task post_test();
    wait(gen.done.triggered);  
    $finish();
  endtask: post_test
  
  task run();
    pre_test();
    test();
    post_test();
  endtask: run
  
  
  
endclass: uart_env
