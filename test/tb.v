`timescale 1ns / 1ps

module tt_um_single_neuron_tb;

    // Inputs
    reg  [7:0] ui_in;
    reg  [7:0] uio_in;
    reg         ena;
    reg         clk;
    reg         rst_n;

    // Outputs
    wire [7:0] uo_out;
    wire [7:0] uio_out;
    wire [7:0] uio_oe;

    // Instantiate the Unit Under Test (UUT)
    tt_um_single_neuron uut (
        .ui_in(ui_in),
        .uo_out(uo_out),
        .uio_in(uio_in),
        .uio_out(uio_out),
        .uio_oe(uio_oe),
        .ena(ena),
        .clk(clk),
        .rst_n(rst_n)
    );

    initial begin
        // Initialize Inputs
        ui_in = 8'b0;
        uio_in = 8'b0;
        ena = 1;      // Enable the design
        clk = 0;      // Start clock low
        rst_n = 1;    // Deassert reset

        // Test cases for AND gate
        $display("Testing AND gate neuron:");
        $display("-----------------------");
        $display("Time | ui_in[1] | ui_in[0] | uo_out[0] (Expected)");

        // Case 1: X1=0, X2=0 -> Y=0
        ui_in[0] = 1'b0;
        ui_in[1] = 1'b0;
        #10;
        $display("%t   | %b        | %b        | %b (%b)", $time, ui_in[1], ui_in[0], uo_out[0], 1'b0);

        // Case 2: X1=1, X2=0 -> Y=0
        ui_in[0] = 1'b1;
        ui_in[1] = 1'b0;
        #10;
        $display("%t   | %b        | %b        | %b (%b)", $time, ui_in[1], ui_in[0], uo_out[0], 1'b0);

        // Case 3: X1=0, X2=1 -> Y=0
        ui_in[0] = 1'b0;
        ui_in[1] = 1'b1;
        #10;
        $display("%t   | %b        | %b        | %b (%b)", $time, ui_in[1], ui_in[0], uo_out[0], 1'b0);

        // Case 4: X1=1, X2=1 -> Y=1
        ui_in[0] = 1'b1;
        ui_in[1] = 1'b1;
        #10;
        $display("%t   | %b        | %b        | %b (%b)", $time, ui_in[1], ui_in[0], uo_out[0], 1'b1);

        $finish; // End simulation
    end

    // Clock generation (not strictly needed for combinational, but good practice)
    always #5 clk = ~clk;

endmodule
