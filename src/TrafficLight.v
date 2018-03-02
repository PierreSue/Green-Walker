//////////////////////////////////////////////////////////////////////////////////
// Module Name: TrafficLight : Traffic Light Controller System with VGA
// Submodule: ButtonFSM, MP_Timer_Controller(Timer), Display_Controller(7sDecoder/7sDisplayer), VGADisplayer
//////////////////////////////////////////////////////////////////////////////////


module TrafficLight(
    //====================================================
    //=======           Input                       ======
    //====================================================
    input                   clk,        // 100 MHz clock
    input      [15:0]       sw,         // 16 Switches, sw[15] for asynchronous reset
    input                   btnU,       // Up     Button
    input                   btnD,       // Down   Button
    input                   btnL,       // Left   Button
    input                   btnR,       // Right  Button
    input                   btnC,
    //====================================================
    //=======           Output                      ======
    //====================================================
    //-----------Display_Controller-----
        //-----------VGADisplayer--------
    output     [3:0]        vgaRed, 
    output     [3:0]        vgaBlue,
    output     [3:0]        vgaGreen,
    output                  Hsync,
    output                  Vsync,
        //-----------SsDisplayer----------
    output     [6:0]        seg,         // Number
    output     [3:0]        an,          // Mux for 4 number 
    output                  dp,          // Dot point
    output     [15:0]       led          // 16 green LEDs
    );
    
    wire clk25; //25 MHz clock
    clk_wiz_0       ck0(.clk_in1(clk), .clk_out1(clk25), .reset(rst));
    
//=======================================
//=======          TODO            ======
//=======================================
wire de_btnU,de_btnD,de_btnL,de_btnR;
ButtonFSM(clk25,sw[15],btnU,de_btnU);
ButtonFSM(clk25,sw[15],btnD,de_btnD);
ButtonFSM(clk25,sw[15],btnL,de_btnL);
ButtonFSM(clk25,sw[15],btnR,de_btnR);

wire [2:0] cur_phase;
wire [3:0] seven_num;
wire [2:0] car_state;
wire [3:0] man_state;
wire minus_1;
MP_TimerController(clk25,sw[15],sw[14],0,0,0,0,cur_phase,seven_num,minus_1);
DisplayController(clk25,sw[15],cur_phase,seven_num,minus_1,btnU,btnD,btnL,btnR,btnC,car_state,man_state,seg,an,dp,led);
VGADisplayer(clk25,sw[15],car_state,man_state,vgaRed,vgaBlue,vgaGreen, Hsync,Vsync);
endmodule