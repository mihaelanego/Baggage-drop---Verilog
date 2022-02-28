module display_and_drop (
    output reg [6 : 0]   seven_seg1, 
    output reg [6 : 0]   seven_seg2,
    output reg [6 : 0]   seven_seg3,
    output reg [6 : 0]   seven_seg4,
    output reg [0 : 0]   drop_activated,
    input wire    [15: 0]   t_act,
    input  wire   [15: 0]   t_lim,
    input              drop_en
);
    parameter letter_c = 7'b011_1001;
    parameter letter_d = 7'b101_1110;
    parameter letter_h = 7'b111_0110;
    parameter letter_l = 7'b011_1000;
    parameter letter_o = 7'b101_1100;
    parameter letter_p = 7'b111_0011;
    parameter letter_r = 7'b101_0000;
    parameter letter_t = 7'b111_1000;
    parameter letter_space = 7'b000_0000;
    
    reg [7:0] height_int;
    reg [7:0] height_float;

    reg [7:0] limit_int;
    reg [7:0] limit_float;

    always @(*) begin
        height_int = t_act[15:8];
        height_float = t_act[7:0];

        limit_int = t_lim[15:8];
        limit_float = t_lim[7:0];
        
        if(!drop_en) begin
            seven_seg1 = letter_c;
            seven_seg2 = letter_o;
            seven_seg3 = letter_l;
            seven_seg4 = letter_d;
        end else begin
            if(height_int < limit_int) begin
                drop_activated[0] = 1;
            end else if(height_int == limit_int) begin
                if(height_float < limit_float) begin
                    drop_activated[0] = 1;
                end else begin
                    drop_activated[0] = 0;
                end
            end else begin
                drop_activated[0] = 0;
            end

            if(drop_activated[0]) begin
                seven_seg1 = letter_d;
                seven_seg2 = letter_r;
                seven_seg3 = letter_o;
                seven_seg4 = letter_p;
            end else begin
                seven_seg1 = letter_space;
                seven_seg2 = letter_h;
                seven_seg3 = letter_o;
                seven_seg4 = letter_t;
            end
        end
    end
endmodule