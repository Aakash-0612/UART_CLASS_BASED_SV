import v_pkg::*;
`include "uart_interface.sv"
`timescale 1ns/1ps
module tb;

    // Declare the interface
    uart_interface vif();

    // Instantiate the DUT (Device Under Test)
    uart_top #(1000000, 9600) dut (
        vif.clk, vif.rst, vif.rx, vif.dintx, vif.newdata, 
        vif.tx, vif.doutrx, vif.donetx, vif.donerx
    );

    // Clock generation
    initial begin
        vif.clk = 0; // Initialize clock to 0
    end

    always #10 vif.clk = ~vif.clk; // Toggle clock every 10ns

//CALLING ENV HANDLE
uart_env env;

    // Instantiate the environment (assumes uart_env class exists)
    initial begin
        env = new(vif); // Create an instance of uart_env
        env.gen.count = 5; // Example test parameter
        env.run(); // Run the test sequence
    end

    // Waveform dumping
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb); // Dump all signals in the tb module
    end

    // Assign signals between DUT and interface
    assign vif.uclktx = dut.utx.uclk;  // Connect internal signals
    assign vif.uclkrx = dut.rtx.uclk;

endmodule: tb

