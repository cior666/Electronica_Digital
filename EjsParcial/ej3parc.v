module xornegado(
    input wire i0,
    input wire i1,
    output wire S
);
assign S= ~(i0 ^ i1);
endmodule 