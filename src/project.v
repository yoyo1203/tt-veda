// This is a single neuron acting as an AND gate
// It calculates (input_0 * 1) + (input_1 * 1) - 1
// If the result is >= 1, output 1, else 0.

module tt_um_single_neuron (
    input  wire [7:0] ui_in,    // Dedicated inputs - use first two for X1, X2
    output wire [7:0] uo_out,   // Dedicated outputs - use first for Y
    input  wire [7:0] uio_in,   // Bidirectional inputs - unused for this example
    output wire [7:0] uio_out,  // Bidirectional outputs - unused for this example
    output wire [7:0] uio_oe,   // Bidirectional output enable - unused for this example
    input  wire       ena,      // Enable signal (usually always high for combinational logic)
    input  wire       clk,      // Clock (unused for combinational logic)
    input  wire       rst_n     // Asynchronous reset active low (unused for combinational logic)
);

    // Internal wires for clarity
    wire x1_in; // Corresponds to ui_in[0]
    wire x2_in; // Corresponds to ui_in[1]

    // Assign inputs from the dedicated input bus
    assign x1_in = ui_in[0];
    assign x2_in = ui_in[1];

    // Weights and Bias (implicitly fixed for this simple combinational logic)
    // W1 = 1, W2 = 1, Bias = -1
    // For binary inputs, multiplication is just the input value.
    // Sum = X1 + X2 - 1

    // Calculate the weighted sum
    // For binary inputs, X1 * 1 is just X1.
    // The sum can be 0+0-1 = -1
    //                  0+1-1 = 0
    //                  1+0-1 = 0
    //                  1+1-1 = 1
    // We are looking for a sum >= 1 for output '1'.
    // This maps directly to (X1 && X2)
    wire [1:0] sum; // Need 2 bits to store values from -1 to 1 (using 2's complement for negative)

    // A purely combinational approach for AND gate
    assign uo_out[0] = x1_in & x2_in; // This is the simplest way to implement the AND logic

    // Tie unused outputs to 0
    assign uo_out[7:1] = 8'b0;
    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0; // Disable bidirectional outputs

endmodule
