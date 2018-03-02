`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Submodule Name: Timer, when set=1 the timer will initiate cur_sec to sec; set=0 the cur will countdown
//////////////////////////////////////////////////////////////////////////////////

module Timer(
    //====================================================
    //=======           Input                       ======
    //====================================================
    input                   clk,     // 25 MHz clock
    input                   rst,     // Asynchronus reset
    input                   set,     // set the starting time countdown timer
    input      [3:0]        new_sec, // new starting time (0-9)
    //====================================================
    //=======           Output                      ======
    //====================================================
    output reg [3:0]        cur_sec  // if set=0, shows current time, if set=1, shows current setting time
    );
    
    reg [30:0] counter, next_counter;
    reg [3:0]  next_cur_sec;
    reg        switch_flag;
    
    always@(*) begin
        switch_flag = (counter == 25000000); // 1 sec for 25 MHz clock
        if(set) begin
            next_counter = 0;
            next_cur_sec     = new_sec;
        end
        else begin
            next_counter = (switch_flag)?0:counter+1;
            next_cur_sec = (switch_flag)? ((cur_sec==0)?0:cur_sec-1) : cur_sec;
        end
    end
    
    always@(posedge clk or posedge rst) begin
        if(rst) begin
            counter <= 0;
            cur_sec <= 4;
        end
        else begin
            counter <= next_counter;
            cur_sec <= next_cur_sec;
        end
    end
endmodule

module adder (
    //====================================================
    //=======           Input                       ======
    //====================================================
    
    input                   set,
    input                   resetAdd,
    input                   preAdd,
    input                   clk,
    input                   rst,
    //====================================================
    //=======           Output                      ======
    //====================================================
    output                  A,
    output                  B,
    output                  C,
    output                  D
    );                  
    
    wire A_n,B_n,C_n,D_n;
    wire [3:0] w;
    
    //=======           A                      ======
    MUX21(preAdd,~A,A,w[0]);
    MUX21(set|resetAdd,0,w[0],A_n);
    DFF(A,A_n,clk,rst,0);
    //=======           B                      ======
    MUX21(A&preAdd,~B,B,w[1]);
    MUX21(set|resetAdd,0,w[1],B_n);
    DFF(B,B_n,clk,rst,0);
    //C
    MUX21(A&B&preAdd,~C,C,w[2]);
    MUX21(set|resetAdd,0,w[2],C_n);
    DFF(C,C_n,clk,rst,0);
    //=======           D                      ======
    MUX21(A&B&C&preAdd,~D,D,w[3]);
    MUX21(set|resetAdd,0,w[3],D_n);
    DFF(D,D_n,clk,rst,0);
endmodule

module subtracter (
    //====================================================
    //=======           Input                       ======
    //====================================================
    input                   set,
    input                   resetAdd,
    input                   clk,
    input                   rst,
    input   [3:0]           new_sec, 
    //====================================================
    //=======           Output                      ======
    //====================================================
    output                  A,
    output                  B,
    output                  C,
    output                  D
    );                  
    
    wire [3:0] w;
    //=======           A                      ======
    MUX21(resetAdd,~A,A,w[0]);
    MUX21(set,new_sec[0],w[0],A_n);
    DFF(A,A_n,clk,rst,0);
    //=======           B                      ======
    MUX21(resetAdd&~A,~B,B,w[1]);
    MUX21(set,new_sec[1],w[1],B_n);
    DFF(B,B_n,clk,rst,0);
    //C
    MUX21(resetAdd&~A&~B,~C,C,w[2]);
    MUX21(set,new_sec[2],w[2],C_n);
    DFF(C,C_n,clk,rst,0);
    //=======           D                      ======
    MUX21(resetAdd&~A&~B&~C,~D,D,w[3]);
    MUX21(set,new_sec[3],w[3],D_n);
    DFF(D,D_n,clk,rst,0);
endmodule

module MP_Timer(
 
    //====================================================
    //=======           Input                       ======
    //====================================================
    input                   clk,     // 25 MHz clock
    input                   rst,     // Asynchronus reset
    input                   set,     // set the starting time countdown timer
    input      [3:0]        new_sec, // new starting time (0-9)
    //====================================================
    //=======           Output                      ======
    //====================================================
    output  [3:0]        cur_sec  // if set=0, shows current time, if set=1, shows current setting time
    );
    //====================================================
    //======        TODO                        ==========
	//====================================================
	wire [27:0] adderW;
	wire [5:0] ck;
	wire [9:0] ckcd;
	wire resetAdd;
	
	AND4(adderW[0],adderW[1],adderW[2],adderW[3],ck[0]);
	AND4(adderW[4],adderW[5],adderW[6],adderW[7],ck[1]);
	AND4(adderW[8],adderW[9],adderW[10],adderW[11],ck[2]);
	AND4(adderW[12],adderW[13],adderW[14],adderW[15],ck[3]);
	AND4(adderW[16],adderW[17],adderW[18],adderW[19],ck[4]);
	AND4(adderW[20],adderW[21],adderW[22],adderW[23],ck[5]);
	
	adder(set,resetAdd,1,clk,rst,adderW[0],adderW[1],adderW[2],adderW[3]);
    adder(set,resetAdd,ck[0],clk,rst,adderW[4],adderW[5],adderW[6],adderW[7]);
    adder(set,resetAdd,ck[0]&ck[1],clk,rst,adderW[8],adderW[9],adderW[10],adderW[11]);
    adder(set,resetAdd,ck[0]&ck[1]&ck[2],clk,rst,adderW[12],adderW[13],adderW[14],adderW[15]); 
    adder(set,resetAdd,ck[0]&ck[1]&ck[2]&ck[3],clk,rst,adderW[16],adderW[17],adderW[18],adderW[19]);
    adder(set,resetAdd,ck[0]&ck[1]&ck[2]&ck[3]&ck[4],clk,rst,adderW[20],adderW[21],adderW[22],adderW[23]);
    adder(set,resetAdd,ck[0]&ck[1]&ck[2]&ck[3]&ck[4]&ck[5],clk,rst,adderW[24],adderW[25],adderW[26],adderW[27]);
    
    AND4(~adderW[0]  , ~adderW[1]  , ~adderW[2]  , ~adderW[3]  ,ckcd[0]);
    AND4(~adderW[4]  , ~adderW[5]  ,  adderW[6]  , ~adderW[7]  ,ckcd[1]);
    AND4(~adderW[8]  , ~adderW[9]  , ~adderW[10] ,  adderW[11] ,ckcd[2]);
    AND4( adderW[12] ,  adderW[13] ,  adderW[14] , ~adderW[15] ,ckcd[3]);
    AND4( adderW[16] , ~adderW[17] ,  adderW[18] ,  adderW[19] ,ckcd[4]);
    AND4( adderW[20] ,  adderW[21] ,  adderW[22] , ~adderW[23] ,ckcd[5]);
    AND4( adderW[24] , ~adderW[25] , ~adderW[26] , ~adderW[27] ,ckcd[6]);
    AND4( ckcd[0],ckcd[1],ckcd[2],ckcd[3],ckcd[7]);
    AND3( ckcd[4],ckcd[5],ckcd[6],ckcd[8]);
    AND2( ckcd[7],ckcd[8],ckcd[9]);
    assign resetAdd=ckcd[9]&(~cur_sec[0]|~cur_sec[1]|~cur_sec[2]|~cur_sec[3]);//cur_sec!=1111
    
    subtracter(set,resetAdd,clk,rst,new_sec,cur_sec[0],cur_sec[1],cur_sec[2],cur_sec[3]);
endmodule

module myTimer(
 
    //====================================================
    //=======           Input                       ======
    //====================================================
    input                   clk,     // 25 MHz clock
    input                   rst,     // Asynchronus reset
    input                   z,     // set the starting time countdown timer
    input      [27:0]       count_sec,
    //input      [3:0]        new_sec, // new starting time (0-9)
    //====================================================
    //=======           Output                      ======
    //====================================================
    //output  [3:0]        cur_sec  // if set=0, shows current time, if set=1, shows current setting time
    output               resetAdd 
    );
    //====================================================
    //======        TODO                        ==========
	//====================================================
	wire [27:0] adderW;
    wire [27:0] _adderW;   
	wire [5:0] ck;
	//wire   ckcd;
    wire [9:0] ckcd;
        //wire resetAdd;
    
        AND4(adderW[0],adderW[1],adderW[2],adderW[3],ck[0]);
        AND4(adderW[4],adderW[5],adderW[6],adderW[7],ck[1]);
        AND4(adderW[8],adderW[9],adderW[10],adderW[11],ck[2]);
        AND4(adderW[12],adderW[13],adderW[14],adderW[15],ck[3]);
        AND4(adderW[16],adderW[17],adderW[18],adderW[19],ck[4]);
        AND4(adderW[20],adderW[21],adderW[22],adderW[23],ck[5]);
        
        adder a1(0,resetAdd,1,clk,rst|z,adderW[0],adderW[1],adderW[2],adderW[3]);
        adder a2(0,resetAdd,ck[0],clk,rst|z,adderW[4],adderW[5],adderW[6],adderW[7]);
        adder a3(0,resetAdd,ck[0]&ck[1],clk,rst|z,adderW[8],adderW[9],adderW[10],adderW[11]);
        adder a4(0,resetAdd,ck[0]&ck[1]&ck[2],clk,rst|z,adderW[12],adderW[13],adderW[14],adderW[15]); 
        adder a5(0,resetAdd,ck[0]&ck[1]&ck[2]&ck[3],clk,rst|z,adderW[16],adderW[17],adderW[18],adderW[19]);
        adder a6(0,resetAdd,ck[0]&ck[1]&ck[2]&ck[3]&ck[4],clk,rst|z,adderW[20],adderW[21],adderW[22],adderW[23]);
        adder a7(0,resetAdd,ck[0]&ck[1]&ck[2]&ck[3]&ck[4]&ck[5],clk,rst|z,adderW[24],adderW[25],adderW[26],adderW[27]);
            /*
        AND4(~adderW[0]  , ~adderW[1]  , ~adderW[2]  ,  adderW[3]  ,ckcd[0]);
        AND4(~adderW[4]  , ~adderW[5]  , ~adderW[6]  , ~adderW[7]  ,ckcd[1]);
        AND4( adderW[8]  ,  adderW[9]  ,  adderW[10] ,  adderW[11] ,ckcd[2]);
        AND4(~adderW[12] ,  adderW[13] , ~adderW[14] ,  adderW[15] ,ckcd[3]);
        AND4( adderW[16] ,  adderW[17] ,  adderW[18] ,  adderW[19] ,ckcd[4]);
        AND4(~adderW[20] ,  adderW[21] , ~adderW[22] , ~adderW[23] ,ckcd[5]);
        AND4(~adderW[24] , ~adderW[25] , ~adderW[26] , ~adderW[27] ,ckcd[6]);
        AND4( ckcd[0],ckcd[1],ckcd[2],ckcd[3],ckcd[7]);
        AND3( ckcd[4],ckcd[5],ckcd[6],ckcd[8]);
        AND2( ckcd[7],ckcd[8],ckcd[9]);
        assign resetAdd=ckcd[9];//&(cur_sec[0]|cur_sec[1]|cur_sec[2]|cur_sec[3]);//cur_sec!=0000
        */
	/*
	AND4(adderW[0],adderW[1],adderW[2],adderW[3],ck[0]);
	AND4(adderW[4],adderW[5],adderW[6],adderW[7],ck[1]);
	AND4(adderW[8],adderW[9],adderW[10],adderW[11],ck[2]);
	AND4(adderW[12],adderW[13],adderW[14],adderW[15],ck[3]);
	AND4(adderW[16],adderW[17],adderW[18],adderW[19],ck[4]);
	AND4(adderW[20],adderW[21],adderW[22],adderW[23],ck[5]);
	
	adder(set,resetAdd,1,clk,rst,adderW[0],adderW[1],adderW[2],adderW[3]);
    adder(set,resetAdd,ck[0],clk,rst,adderW[4],adderW[5],adderW[6],adderW[7]);
    adder(set,resetAdd,ck[0]&ck[1],clk,rst,adderW[8],adderW[9],adderW[10],adderW[11]);
    adder(set,resetAdd,ck[0]&ck[1]&ck[2],clk,rst,adderW[12],adderW[13],adderW[14],adderW[15]); 
    adder(set,resetAdd,ck[0]&ck[1]&ck[2]&ck[3],clk,rst,adderW[16],adderW[17],adderW[18],adderW[19]);
    adder(set,resetAdd,ck[0]&ck[1]&ck[2]&ck[3]&ck[4],clk,rst,adderW[20],adderW[21],adderW[22],adderW[23]);
    adder(set,resetAdd,ck[0]&ck[1]&ck[2]&ck[3]&ck[4]&ck[5],clk,rst,adderW[24],adderW[25],adderW[26],adderW[27]);
    */
    assign resetAdd=(adderW==count_sec)?1:0;
  /*
        XNOR2(adderW[0],count_sec[0],_adderW[0]);
        XNOR2(adderW[1],count_sec[1],_adderW[1]);
        XNOR2(adderW[2],count_sec[2],_adderW[2]);
        XNOR2(adderW[3],count_sec[3],_adderW[3]);
        XNOR2(adderW[4],count_sec[4],_adderW[4]);
        XNOR2(adderW[5],count_sec[5],_adderW[5]);
        XNOR2(adderW[6],count_sec[6],_adderW[6]);
        XNOR2(adderW[7],count_sec[7],_adderW[7]);
        XNOR2(adderW[8],count_sec[8],_adderW[8]);
        XNOR2(adderW[9],count_sec[9],_adderW[9]);
        XNOR2(adderW[10],count_sec[10],_adderW[10]);
        XNOR2(adderW[11],count_sec[11],_adderW[11]);    
        XNOR2(adderW[12],count_sec[12],_adderW[12]);
        XNOR2(adderW[13],count_sec[13],_adderW[13]);
        XNOR2(adderW[14],count_sec[14],_adderW[14]);
        XNOR2(adderW[15],count_sec[15],_adderW[15]);
        XNOR2(adderW[16],count_sec[16],_adderW[16]);
        XNOR2(adderW[17],count_sec[17],_adderW[17]);
        XNOR2(adderW[18],count_sec[18],_adderW[18]);
        XNOR2(adderW[19],count_sec[19],_adderW[19]);
        XNOR2(adderW[20],count_sec[20],_adderW[20]);
        XNOR2(adderW[21],count_sec[21],_adderW[21]);
        XNOR2(adderW[22],count_sec[22],_adderW[22]);
        XNOR2(adderW[23],count_sec[23],_adderW[23]);
        XNOR2(adderW[24],count_sec[24],_adderW[24]);
        XNOR2(adderW[25],count_sec[25],_adderW[25]);
        XNOR2(adderW[26],count_sec[26],_adderW[26]);
        XNOR2(adderW[27],count_sec[27],_adderW[27]);
        assign ckcd= _adderW[0]&_adderW[1]&_adderW[2]&_adderW[3]&_adderW[4]&_adderW[5]&_adderW[6]&_adderW[7]&_adderW[8]&_adderW[9]&_adderW[10]&_adderW[11]&_adderW[12]&_adderW[13]&_adderW[14]&_adderW[15]&_adderW[16]&_adderW[17]&_adderW[18]&_adderW[19]&_adderW[20]&_adderW[21]&_adderW[22]&_adderW[23]&_adderW[24]&_adderW[25]&_adderW[26]&_adderW[27];
        
        DFF(resetAdd, ckcd, clk , rst, 0);*/
        //assign resetAdd=ckcd;//&(cur_sec[0]|cur_sec[1]|cur_sec[2]|cur_sec[3]);//cur_sec!=0000
    
    //subtracter(set,resetAdd,clk,rst,new_sec,cur_sec[0],cur_sec[1],cur_sec[2],cur_sec[3]);
endmodule