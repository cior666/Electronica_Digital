module ej3rv1(
    input wire clk,
    input wire reset,
    input wire Re,
    output reg [2:0] z
);

localparam S0=2'b00;
localparam S1=2'b01;
localparam S2=2'b10;
localparam S3=2'b11;

reg [2:0] state,next_state;

always @(posedge clk or posedge reset)
begin
    if(reset)
        state<=0;
    else 
        state<=next_state;
end 

always @* begin
    case (state)
        S0: begin 
            if(Re==0)
                next_state=S1;
            else
                next_state=S3;
        end
        S1: begin
            if(Re==0)
                next_state=S2;
            else 
                next_state=S0;
        end
        S2: begin
            if(Re==0)
                next_state=S3;
            else
                next_state=S1;
        end
        S3: begin
            if(Re==0)
                next_state=S0;
            else
                next_state=S2;
        end
        default: next_state=state;
    endcase
end

always@* begin
    case(state)
        S0: z = 3'b010;
        S1: z = 3'b001;
        S2: z = 3'b110;
        S3: z = 3'b101;
        default: z = 3'b010;
    endcase
end
endmodule

            
