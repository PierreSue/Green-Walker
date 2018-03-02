//////////////////////////////////////////////////////////////////////////////////
// Submodule Name: MP_TimerController, handle cur_phase , phase0_t~phase4_t
//////////////////////////////////////////////////////////////////////////////////
module Shifter(
 
    //====================================================
    //=======           Input                       ======
    //====================================================
    input                   clk,
    input                   rst,
    input                   set,
    input                   left,
    input                   right,
    input                   minus_1,
    //====================================================
    //=======           Output                      ======
    //====================================================
    output  [4:0]        cur_sec  // if set=0, shows current time, if set=1, shows current setting time
    );
    //====================================================
    //======        TODO                        ==========
	//====================================================
	wire A, B, C, D, E ;
	wire check_1, check_16 ;
	wire _left, _right, _left_minus_1 ;
	assign _left_minus_1=left|minus_1;
	assign check_1 = ~E & ~D & ~C & ~B & A;
	assign check_16 = E & ~D & ~C & ~B & ~A;
	assign _left  = ~(check_16 & set) & _left_minus_1 ;
	assign _right = ~(check_1 & set) & right ;
	DFF(A, (A&~_left&~_right)|(_left&E)|(_right&B) , clk , rst , 1);
	DFF(B, (B&~_left_minus_1&~right)|(_left_minus_1&A)|(right&C) , clk , rst , 0);
	DFF(C, (C&~_left_minus_1&~right)|(_left_minus_1&B)|(right&D) , clk , rst , 0);
	DFF(D, (D&~_left_minus_1&~right)|(_left_minus_1&C)|(right&E) , clk , rst , 0);
	DFF(E, (E&~_left&~_right)|(_left&D)|(_right &A) , clk , rst , 0);
	assign cur_sec[0] = A ;
	assign cur_sec[1] = B ;
	assign cur_sec[2] = C ;
	assign cur_sec[3] = D ;
	assign cur_sec[4] = E ;
	
endmodule

module UDcounter (
    //====================================================
    //=======           Input                       ======
    //====================================================
    input                   Up,
    input                   Down,
    input                   clk,
    input                   rst,
    input                   phase,//only when phase==1 update sec
    //====================================================
    //=======           Output                      ======
    //====================================================
    output                  A,
    output                  B,
    output                  C,
    output                  D
    );                  
    
    wire [40:0] w;
    
    AND4(~A,~B,~C,~D,w[0]);
    AND4(A,~B,~C,D,w[2]);
    //=======           A                      ======
    MUX21(w[0],0,Down,w[1]);
    MUX21(w[2],0,Up,w[3]);
    OR2(w[1],w[3],w[4]);
    XOR2(w[4],A,w[5]);
    MUX21(phase,w[5],A,w[12]);
    DFF(A,w[12],clk,rst,1);
    //=======           B                      ======
    MUX21(w[0],0,Down,w[6]);
    MUX21(w[2],0,Up,w[7]);
    AND2(w[6],~A,w[8]);
    AND2(w[7],A,w[9]);
    OR2(w[8],w[9],w[10]);
    XOR2(w[10],B,w[11]);
    MUX21(phase,w[11],B,w[13]);
    DFF(B,w[13],clk,rst,0);
    //C
    MUX21(w[2],0,Up,w[21]);
    AND3(w[21],B,A,w[22]);
    MUX21(w[0],0,Down,w[23]);
    AND3(w[23],~B,~A,w[24]);
    XOR2(w[22]|w[24],C,w[25]);
    MUX21(phase,w[25],C,w[26]);
    DFF(C,w[26],clk,rst,0);
    //=======           D                      ======
    MUX21(w[0],0,Down,w[31]);
    MUX21(w[2],0,Up,w[32]);
    AND4(w[31],~C,~B,~A,w[33]);
    AND4(w[32],C,B,A,w[34]);
    OR2(w[33],w[34],w[35]);
    XOR2(w[35],D,w[36]);
    MUX21(phase,w[36],D,w[37]);
    DFF(D,w[37],clk,rst,0);
endmodule


module MP_TimerController(
    //====================================================
    //=======           Input                       ======
    //====================================================
    input                   clk, // 25 MHz clock
    input                   rst, // Asynchronus reset
    input                   set, // 1 for set mode
    input                   buttonU, // Button Up
    input                   buttonD, // Button Down
    input                   buttonL, // Button Left
    input                   buttonR, // Button Right
    //====================================================
    //=======           Output                      ======
    //====================================================
    output     [2:0]        cur_phase,  // current phase for Display_Controller
    output     [3:0]        seven_num,   // seven_num for Display_Controller    
    output                  minus_1
    );
    
//=======================================
//=======          TODO            ======
//=======       Reuse Timer        ======
//=======================================
wire [4:0] _shifter;
wire [3:0] numA;
wire [3:0] numB;
wire [3:0] numC;
wire [3:0] numD;
wire [3:0] numE;
wire A,B,C,D,E;
wire minus_1_DFF, minus_1_DFF_MUX ;
wire not_4_AND , not_4_AND_XOR, not_4_AND_DFF, tmp2;
wire [3:0] num_control;
wire [27:0] input_check;
wire tmp;//between 2 dff

Shifter(clk,rst,set,buttonL,buttonR,minus_1,_shifter);

assign A=_shifter[0];
assign B=_shifter[1];
assign C=_shifter[2];
assign D=_shifter[3];
assign E=_shifter[4];

UDcounter(buttonU,buttonD,clk,rst,A&set,numA[0],numA[1],numA[2],numA[3]);//phase=0
UDcounter(buttonU,buttonD,clk,rst,B&set,numB[0],numB[1],numB[2],numB[3]);//phase=1
UDcounter(buttonU,buttonD,clk,rst,C&set,numC[0],numC[1],numC[2],numC[3]);//phase=2
UDcounter(buttonU,buttonD,clk,rst,D&set,numD[0],numD[1],numD[2],numD[3]);//phase=3
UDcounter(buttonU,buttonD,clk,rst,E&set,numE[0],numE[1],numE[2],numE[3]);//phase=4

assign minus_1= seven_num[0]& seven_num[1]& seven_num[2]& seven_num[3];//when cur_sec=1111
//DFF(tmp, minus_1, clk, rst,0);
//DFF(tmp2, tmp, clk, rst,0);
//DFF(minus_1_DFF, tmp2, clk, rst,0);
MUX21(set, 1, minus_1|buttonL|buttonR, minus_1_DFF_MUX);

assign num_control[0] = (A&numA[0]) | (B&numB[0]) | (C&numC[0]) | (D&numD[0]) | (E&numE[0]);
assign num_control[1] = (A&numA[1]) | (B&numB[1]) | (C&numC[1]) | (D&numD[1]) | (E&numE[1]);
assign num_control[2] = (A&numA[2]) | (B&numB[2]) | (C&numC[2]) | (D&numD[2]) | (E&numE[2]);
assign num_control[3] = (A&numA[3]) | (B&numB[3]) | (C&numC[3]) | (D&numD[3]) | (E&numE[3]);

MP_Timer(clk, rst, minus_1_DFF_MUX, num_control, seven_num);
assign cur_phase[0]=B|D;
assign cur_phase[1]=C|D;
assign cur_phase[2]=E;
endmodule