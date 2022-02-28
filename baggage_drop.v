module baggage_drop (
    output  [6 : 0]   seven_seg1, 
    output  [6 : 0]   seven_seg2,
    output  [6 : 0]   seven_seg3,
    output  [6 : 0]   seven_seg4,
    output  [0 : 0]   drop_activated,
    input    [7 : 0]   sensor1,
    input    [7 : 0]   sensor2,
    input    [7 : 0]   sensor3,
    input    [7 : 0]   sensor4,
    input    [15: 0]   t_lim,
    input              drop_en
);

    wire [7:0] height;
    wire [15:0] height_time;
    reg  [15:0] drop_time;

    always @(*) begin
        drop_time = height_time >> 1;    
    end

    sensors_input sens (
        .height(height),
        .sensor1(sensor1),
        .sensor2(sensor2),
        .sensor3(sensor3),
        .sensor4(sensor4)
    );

    square_root sqrt (
        .in(height),
        .out(height_time)
    );

    display_and_drop disp (
        .t_lim(t_lim),
        .t_act(drop_time),
        .drop_en(drop_en),
        .drop_activated(drop_activated),
        .seven_seg1(seven_seg1),
        .seven_seg2(seven_seg2),
        .seven_seg3(seven_seg3),
        .seven_seg4(seven_seg4)
    );
endmodule