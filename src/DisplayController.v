//////////////////////////////////////////////////////////////////////////////////
// Submodule Name: DisplayController: 
// From cur_phase/num to VGADisplayer & SevenSegment & led/dp
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////inp_1
module inp_1 (
    //====================================================
    //=======           Output                      ======
    //====================================================
    output     [27:0]       out
    );               
    assign out[27] = 0;
    assign out[26] = 0;
    assign out[25] = 0;
    assign out[24] = 1;
    assign out[23] = 0;
    assign out[22] = 1;
    assign out[21] = 1;
    assign out[20] = 1;
    assign out[19] = 1;
    assign out[18] = 1;
    assign out[17] = 0;
    assign out[16] = 1;
    assign out[15] = 0;
    assign out[14] = 1;
    assign out[13] = 1;
    assign out[12] = 1;
    assign out[11] = 1;
    assign out[10] = 0;
    assign out[9] = 0;
    assign out[8] = 0;
    assign out[7] = 0;
    assign out[6] = 1;
    assign out[5] = 0;
    assign out[4] = 0;
    assign out[3] = 0;
    assign out[2] = 0;
    assign out[1] = 0;
    assign out[0] = 0;
      
endmodule

//////////////////////////////////////////////inp_8
module inp_8 (
    //====================================================
    //=======           Output                      ======
    //====================================================
    output     [27:0]       out
    );                  
    assign out[27] = 0;
    assign out[26] = 0;
    assign out[25] = 0;
    assign out[24] = 0;
    assign out[23] = 0;
    assign out[22] = 0;
    assign out[21] = 1;
    assign out[20] = 0;
    assign out[19] = 1;
    assign out[18] = 1;
    assign out[17] = 1;
    assign out[16] = 1;
    assign out[15] = 1;
    assign out[14] = 0;
    assign out[13] = 1;
    assign out[12] = 0;
    assign out[11] = 1;
    assign out[10] = 1;
    assign out[9] = 1;
    assign out[8] = 1;
    assign out[7] = 0;
    assign out[6] = 0;
    assign out[5] = 0;
    assign out[4] = 0;
    assign out[3] = 1;
    assign out[2] = 0;
    assign out[1] = 0;
    assign out[0] = 0;

endmodule

//////////////////////////////////////////////inp_16
module inp_16 (
    //====================================================
    //=======           Output                      ======
    //====================================================
    output     [27:0]       out
    );                  
    assign out[27] = 0;
    assign out[26] = 0;
    assign out[25] = 0;
    assign out[24] = 0;
    assign out[23] = 0;
    assign out[22] = 0;
    assign out[21] = 0;
    assign out[20] = 1;
    assign out[19] = 0;
    assign out[18] = 1;
    assign out[17] = 1;
    assign out[16] = 1;
    assign out[15] = 1;
    assign out[14] = 1;
    assign out[13] = 0;
    assign out[12] = 1;
    assign out[11] = 0;
    assign out[10] = 1;
    assign out[9] = 1;
    assign out[8] = 1;
    assign out[7] = 1;
    assign out[6] = 0;
    assign out[5] = 0;
    assign out[4] = 0;
    assign out[3] = 0;
    assign out[2] = 1;
    assign out[1] = 0;
    assign out[0] = 0;

endmodule

//////////////////////////////////////////////sel_inp
module sel_inp (
    //====================================================
    //=======           Input                       ======
    //====================================================
    input                  A,
    input                  B,
    input                  C,
    input                  D,
    input                  E,
    input     [27:0]       in1, //  1/8
    input     [27:0]       in2, //  1/16
    input     [27:0]       in3, //  1
    //====================================================
    //=======           Output                      ======
    //====================================================
    output     [27:0]       out
    
    );                  
    assign out[0] = (A&in1[0])|(B&in2[0])|( (C|D|E)&in3[0]) ;
    assign out[1] = (A&in1[1])|(B&in2[1])|( (C|D|E)&in3[1]) ;
    assign out[2] = (A&in1[2])|(B&in2[2])|( (C|D|E)&in3[2]) ;
    assign out[3] = (A&in1[3])|(B&in2[3])|( (C|D|E)&in3[3]) ;
    assign out[4] = (A&in1[4])|(B&in2[4])|( (C|D|E)&in3[4]) ;
    assign out[5] = (A&in1[5])|(B&in2[5])|( (C|D|E)&in3[5]) ;
    assign out[6] = (A&in1[6])|(B&in2[6])|( (C|D|E)&in3[6]) ;
    assign out[7] = (A&in1[7])|(B&in2[7])|( (C|D|E)&in3[7]) ;
    assign out[8] = (A&in1[8])|(B&in2[8])|( (C|D|E)&in3[8]) ;
    assign out[9] = (A&in1[9])|(B&in2[9])|( (C|D|E)&in3[9]) ;
    assign out[10] = (A&in1[10])|(B&in2[10])|( (C|D|E)&in3[10]) ;
    assign out[11] = (A&in1[11])|(B&in2[11])|( (C|D|E)&in3[11]) ;
    assign out[12] = (A&in1[12])|(B&in2[12])|( (C|D|E)&in3[12]) ;
    assign out[13] = (A&in1[13])|(B&in2[13])|( (C|D|E)&in3[13]) ;
    assign out[14] = (A&in1[14])|(B&in2[14])|( (C|D|E)&in3[14]) ;
    assign out[15] = (A&in1[15])|(B&in2[15])|( (C|D|E)&in3[15]) ;
    assign out[16] = (A&in1[16])|(B&in2[16])|( (C|D|E)&in3[16]) ;
    assign out[17] = (A&in1[17])|(B&in2[17])|( (C|D|E)&in3[17]) ;
    assign out[18] = (A&in1[18])|(B&in2[18])|( (C|D|E)&in3[18]) ;
    assign out[19] = (A&in1[19])|(B&in2[19])|( (C|D|E)&in3[19]) ;
    assign out[20] = (A&in1[20])|(B&in2[20])|( (C|D|E)&in3[20]) ;
    assign out[21] = (A&in1[21])|(B&in2[21])|( (C|D|E)&in3[21]) ;
    assign out[22] = (A&in1[22])|(B&in2[22])|( (C|D|E)&in3[22]) ;
    assign out[23] = (A&in1[23])|(B&in2[23])|( (C|D|E)&in3[23]) ;
    assign out[24] = (A&in1[24])|(B&in2[24])|( (C|D|E)&in3[24]) ;
    assign out[25] = (A&in1[25])|(B&in2[25])|( (C|D|E)&in3[25]) ;
    assign out[26] = (A&in1[26])|(B&in2[26])|( (C|D|E)&in3[26]) ;
    assign out[27] = (A&in1[27])|(B&in2[27])|( (C|D|E)&in3[27]) ;
endmodule



module Control_man(
    //====================================================
    //=======           Input                       ======
    //====================================================
    input            clk,        // 25 MHz clock
    input            rst,        // Asynchronus reset
    input    [2:0]   cur_phase,
    input            minus_1,
    //====================================================
    //=======           Output                      ======
    //====================================================
    output     [3:0] man_state
    );
    
    //====================================================
    //=========          TODO                     ========
    //====================================================    
    wire A_n,B_n,C_n,D_n;
    wire A_mux, B_mux, C_mux, D_mux;
    wire A,B,C,D;
    wire resetAdd;
    wire v, w, x, y, z ;
    
    assign v = ~cur_phase[0] & ~cur_phase[1] & ~cur_phase[2] ;
    assign w = cur_phase[0] & ~cur_phase[1] & ~cur_phase[2] ;
    assign x = ~cur_phase[0] & cur_phase[1] & ~cur_phase[2] ;
    assign y = cur_phase[0] & cur_phase[1] & ~cur_phase[2] ;
    assign z = ~cur_phase[0] & ~cur_phase[1] & cur_phase[2] ;
    wire [27:0] input_check;
    wire [27:0] input_1;
    wire [27:0] input_8;
    wire [27:0] input_16;
    inp_1(input_1);
    inp_8(input_8);
    inp_16(input_16);
    sel_inp(v, w, x, y, z, input_8, input_16, input_1, input_check);
    
    myTimer(clk,rst, minus_1, input_check ,resetAdd);
    
    MUX21(x|y|z, 0 , A_mux, A_n);
    MUX21(x|y|z, 0 , B_mux, B_n);
    MUX21(x|y|z, 0 , C_mux, C_n);
    MUX21(x|y|z, 0 , D_mux, D_n);    
    DFF(man_state[0],A_n,clk,rst,1);
    DFF(man_state[1],B_n,clk,rst,0);
    DFF(man_state[2],C_n,clk,rst,0);
    DFF(man_state[3],D_n,clk,rst,0);
    
    /*
    DFF(man_state[0],A_n,clk,rst,0);
    DFF(man_state[1],B_n,clk,rst,0);
    DFF(man_state[2],C_n,clk,rst,0);
    DFF(man_state[3],D_n,clk,rst,0);
    */
    assign A=~man_state[0];
    XOR2(man_state[0],man_state[1],B);
    XOR2(man_state[0]&man_state[1],man_state[2],C);
    assign D=man_state[0]&man_state[1]&man_state[2];    
    
    MUX21(resetAdd,A,man_state[0],A_mux);
    MUX21(resetAdd,B,man_state[1],B_mux);
    MUX21(resetAdd,C,man_state[2],C_mux);
    MUX21(resetAdd,D,man_state[3],D_mux);
    
endmodule

module DisplayController(
    //====================================================
    //=======           Input                       ======
    //====================================================
    input            clk,        // 25 MHz clock
    input            rst,        // Asynchronus reset
    input      [2:0] cur_phase,  // Current phase
    input      [3:0] seven_num,
    input            minus_1,
    input            btnU,       // Up     Button
    input            btnD,       // Down   Button
    input            btnL,       // Left   Button
    input            btnR,       // Right  Button
    input            btnC,
    //====================================================
    //=======           Output                      ======
    //====================================================
    // to VGADisplayer
    output     [2:0]  car_state,
    output     [3:0]  man_state,
    // from SevenSegment
    output     [6:0]  seg,
    output     [3:0]  an,
    output            dp,
    output     [15:0] led
    );
     
//=======================================
//=======          TODO            ======
//=======    Reuse SevenSegment    ======1
//=======================================
wire [3:0] _cur_phase;
assign _cur_phase[3]=0;
assign _cur_phase[0]=cur_phase[0];
assign _cur_phase[1]=cur_phase[1];
assign _cur_phase[2]=cur_phase[2];
wire [3:0] mask;
wire [3:0] garbage;
assign garbage=4'b0000;
//assign mask=4'b0101;
SevenSegment s1(clk, rst, garbage, _cur_phase , garbage, seven_num, 4'b1010, seg, dp, an);

assign car_state[2]= ~car_state[1]&~ car_state[0];
assign car_state[1]=~btnU & ~btnD & ~btnL & ~btnR & ~btnC;
assign car_state[0]= ( (cur_phase==3'b000) & btnD)|( (cur_phase==3'b001) & btnL)
                    |( (cur_phase==3'b011) & btnU)|( (cur_phase==3'b100) & btnR)|( (cur_phase==3'b010) & btnC);

assign man_state[3] = cur_phase[2];
assign man_state[2] = ~cur_phase[2]&(~cur_phase[1]|cur_phase[0]);
assign man_state[1] = ~cur_phase[2]&~cur_phase[1]&~cur_phase[0];
assign man_state[0] = ~cur_phase[2]&cur_phase[0];

assign led[0]=cur_phase[0];
assign led[1]=cur_phase[1];
assign led[2]=cur_phase[2];
assign led[12]=seven_num[0];
assign led[13]=seven_num[1];
assign led[14]=seven_num[2];
assign led[15]=seven_num[3];
assign led[3]=btnU;
assign led[4]=btnD;
assign led[5]=btnL;
assign led[6]=btnR;
assign led[7]=~cur_phase[0] & ~cur_phase[1] & ~cur_phase[2];
assign led[8]= cur_phase[0] & ~cur_phase[1] & ~cur_phase[2];
assign led[9]=car_state[2];
assign led[10]=car_state[1];
assign led[11]=car_state[0];

endmodule