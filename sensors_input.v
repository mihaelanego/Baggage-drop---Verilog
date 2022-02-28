module sensors_input(
    output reg [7:0] height,
    input [7:0] sensor1,
    input [7:0] sensor2,
    input [7:0] sensor3,
    input [7:0] sensor4
);
    always @(*) begin
        if(sensor1 == 0 || sensor3 == 0) begin
            height = (sensor2 + sensor4 + 1) >> 1;
        end else if(sensor2 == 0 || sensor4 == 0) begin
            height = (sensor1 + sensor3 + 1) >> 1;
        end else begin
            if(((sensor1 + sensor3) & 1) && ((sensor2 + sensor4) & 1))
                height = (((sensor1 + sensor3) >> 1) + ((sensor2 + sensor4) >> 1) + 2) >> 1;
            else
                height = (((sensor1 + sensor3) >> 1) + ((sensor2 + sensor4) >> 1) + 1) >> 1;
        end
    end
endmodule