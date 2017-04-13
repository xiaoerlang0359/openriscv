//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2014 leishangwen@163.com                       ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////
// Module:  LLbit_reg
// File:    LLbit_reg.v
// Author:  Lei Silei, shyoshyo
// E-mail:  leishangwen@163.com, shyoshyo@qq.com
// Description: 保存LLbit，用在SC、LL指令中
// Revision: 1.0
//////////////////////////////////////////////////////////////////////

`include "defines.v"

module LLbit_reg(
	input wire clk,
	input wire rst_n,
	
	// 异常是否发生
	input wire flush,

	//写端口
	input wire LLbit_i,
	input wire we,
	
	//读端口1
	output reg LLbit_o
);

	// LL bit 寄存器的值
	reg LLbit;
	always @ (posedge clk or negedge rst_n)
		if (rst_n == `RstEnable)
			LLbit <= 1'b0;
		else if((flush == 1'b1))
			LLbit <= 1'b0;
		else if((we == `WriteEnable))
			LLbit <= LLbit_i;
			
	always @ (*)
		if (rst_n == `RstEnable)
			LLbit_o <= 1'b0;
		// else if(flush == 1'b1)
		// 	LLbit_o <= 1'b0;
		else if(we == `WriteEnable)
			LLbit_o <= LLbit_i;
		else
			LLbit_o <= LLbit;


endmodule