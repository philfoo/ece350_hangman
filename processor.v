module processor1(clock, reset, ps2_key_pressed, ps2_out, lcd_write, lcd_data, debug_data, debug_addr, alu_input1, alu_input2, alu_output, alu_opcode, test_output, write_reg, stored_pc, current_pc, instruction_num, test_regWrite, bypassa, bypassb, write_data);

	input 			clock, reset, ps2_key_pressed;
	input 	[7:0]	ps2_out;
	
	output 			lcd_write;
	output 	[31:0] 	lcd_data;
	
	// GRADER OUTPUTS - YOU MUST CONNECT TO YOUR DMEM
	output 	[31:0] 	debug_data;
	output	[11:0]	debug_addr;
	output[31:0] alu_input1, alu_input2, alu_output, stored_pc, current_pc, instruction_num, write_data; 
	output test_output, test_regWrite;
	output[4:0] alu_opcode, write_reg, bypassa, bypassb;

	
	
	
	
	// your processor here
	//
	//-------------------------Initiate PC register----------------------------------//
	wire[31:0] pcBeforeAdd, pcAfterAdd;
	wire bsWire;
	
	wire [31:0] select_pc;
	assign select_pc = changePC ? pcStage3 : pcAfterAdd;
	
	assign instruction_num = pcBeforeAdd;
	
	register PC(select_pc, pcBeforeAdd, ~stall, clock, reset);
	thirtytwo_bit_add inst_1(1'b0, pcBeforeAdd, 32'b1, pcAfterAdd, bsWire);
	
	wire[31:0] instruction;
	imem myimem(	.address 	(pcBeforeAdd[11:0]),
					.clken		(1'b1),
					.clock		(~clock) ,
					.q			(instruction) // change where output q goes...
	);
	
	wire[31:0] flush_instruction1;
	assign flush_instruction1 = changePC ? 32'b0 : instruction;
	
	//------------------------Initiate IF/ID pipeline register------------------------//
	wire[31:0] pcOut1;
	register PC1(pcAfterAdd, pcOut1, ~stall, clock, reset);
	
	wire[31:0] instructionOut1;
	register instruction1(flush_instruction1, instructionOut1, 1'b1, clock, reset);
	
	wire[4:0] opcode1, rd1, rs1, rt1, shiftamt1, aluop1;
	wire[16:0] immediate1;
	wire[26:0] target1;
	
	decodeInstruction inst0(instructionOut1, opcode1, rd1, rs1, rt1, shiftamt1, aluop1, immediate1, target1);
	
	//Figure out whether to read rs or rt
	wire readRDsignal;
	assign readRDsignal = (~opcode1[4] & ~opcode1[3] & ~opcode1[2] & opcode1[1] & ~opcode1[0]) | (~opcode1[4] & ~opcode1[3] & opcode1[2] & ~opcode1[1] & ~opcode1[0]) | (~opcode1[4] & ~opcode1[3] & opcode1[2] & opcode1[1] & ~opcode1[0]) | (~opcode1[4] & ~opcode1[3] & opcode1[2] & opcode1[1] & opcode1[0]);
	
	wire[31:0] data2_input;
	assign data2_input[4:0] = (readRDsignal) ? rd1 : rt1;
	assign data2_input[31:5] = 27'b0;
	
	//Stuff needed for register
	//To be filled in (3):
	wire writeEnable;
	wire[4:0] ctrl_writeReg;
	wire[31:0] data_writeReg;
	
	wire[31:0] data_readRegA, data_readRegB;
	regfile all_registers(~clock, writeEnable, reset, ctrl_writeReg, rs1, data2_input, data_writeReg, data_readRegA, data_readRegB);

	
	//Sign extend immediate (I-type)
	wire[31:0] signExtendImm;
	signExtend inst1(immediate1, signExtendImm);
	
	//Extended immediate (J-type)
	wire[31:0] extendedImmediate;
	assign extendedImmediate[31:27] = 1'b0;
	assign extendedImmediate[26:0] = target1;
	
	wire isIType = (~opcode1[4] & ~opcode1[3] & opcode1[2] & ~opcode1[1] & opcode1[0]) | (~opcode1[4] & ~opcode1[3] & ~opcode1[2] & opcode1[1] & ~opcode1[0]) | (~opcode1[4] & ~opcode1[3] & opcode1[2] & opcode1[1] & ~opcode1[0]) | (~opcode1[4] & ~opcode1[3] & opcode1[2] & opcode1[1] & opcode1[0]) | (~opcode1[4] & opcode1[3] & ~opcode1[2] & ~opcode1[1] & ~opcode1[0]);
	
	wire[31:0] finalImmediate;
	assign finalImmediate = isIType ? signExtendImm : extendedImmediate;
	
	wire[31:0] flush_instruction2;
	assign flush_instruction2 = (changePC) ? 32'b0 : instructionOut1;
	
	wire[31:0] flush_instruction3;
	assign flush_instruction3 = stall ? 32'b0: flush_instruction2;
	
	
	//----------------------Initiate ID/EX pipeline register-----------------------------//
	wire[31:0] pcOut2;
	register PC2(pcOut1, pcOut2, 1'b1, clock, reset);
	
	wire[31:0] data2_bits;
	register data2bits(data2_input, data2_bits, 1'b1, clock, reset);
	
	wire[31:0] instructionOut2;
	register instruction2(flush_instruction3, instructionOut2, 1'b1, clock, reset);
	
	//Get opcode for this segment and decode it
	wire[4:0] opcode2 = instructionOut2[31:27];
	wire useImm1, jump1, jal1, jr1, memWrite1, useMem1, bne1, blt1;
	generateSignals idex_inst(opcode2, useImm1, jump1, jal1, jr1, memWrite1, useMem1, bne1, blt1);
	
	wire[31:0] data1;
	register rs(data_readRegA, data1, 1'b1, clock, reset);
	
	wire[31:0] data2;
	register rt(data_readRegB, data2, 1'b1, clock, reset);
	
	wire[31:0] immOut1;
	register imm(finalImmediate, immOut1, 1'b1, clock, reset);
	
	//Adder for PC
	wire[31:0] adderResult;
	thirtytwo_bit_add pcadder(1'b0, pcOut2, immOut1, adderResult, bsWire);
	
	//Create branch signal
	//Check rd!=rs & rd < rs
	wire isNotEqual, isLessThan;
	wire[31:0] subtract_result;
	//subtract subtract_inst(data2, data1, subtract_result, bsWire, isNotEqual, isLessThan);
	subtract subtract_inst(data_operandB, data_operandA, subtract_result, bsWire, isNotEqual, isLessThan);
	
	wire[31:0] pcStage1, pcStage2, pcStage3;
	assign pcStage1 = ((bne1 & isNotEqual) | (blt1 & isLessThan)) ? adderResult : pcOut2;
	assign pcStage2 = (jump1 | jal1) ? immOut1 : pcStage1;
	assign pcStage3 = (jr1) ? data2 : pcStage2;
	
	//Decide whether to branch
	wire changePC = jump1 | jal1 | jr1 | (blt1 & isLessThan) | (bne1 & isNotEqual);
	assign test_output = changePC;
	
	//Create ALU opcode based on instruction
	wire[4:0] aluop;
	wire addisworlw;
	assign addisworlw = (~opcode2[4] & ~opcode2[3] & opcode2[2] & ~opcode2[1] & opcode2[0]) | (~opcode2[4] & ~opcode2[3] & opcode2[2] & opcode2[1] & opcode2[0]) | (~opcode2[4] & opcode2[3] & ~opcode2[2] & ~opcode2[1] & ~opcode2[0]);
	assign aluop = addisworlw ? 5'b0 : instructionOut2[6:2];
	
	
	//Bypassing and forwarding stuff for input a!!!!
	wire[31:0] data_operandA, bsWires; 
//	mux mux1(bypass_a, alu_result1, data_writeReg, data1, bsWires, bsWires, bsWires, data_operandA);
//	assign bypassa = bypass_a;
	
	wire[31:0] check_bypassA1;
	assign check_bypassA1 = a_signal1 ? alu_result1 : data1;
	assign data_operandA = a_signal2 ? data_writeReg : check_bypassA1;
	
	//Bypassing and forwarding for input b
	wire[31:0] intermediate_b;
//	mux mux2(bypass_b, alu_result1, data_writeReg, data2, bsWires, bsWires, bsWires, intermediate_b);
//	assign bypassb = bypass_b;
	wire[31:0] check_bypassB1;
	assign check_bypassB1 = b_signal1 ? alu_result1 : data2;
	assign intermediate_b = b_signal2 ? data_writeReg: check_bypassB1;
	
	//Decide on dataoperandB for ALU
	wire[31:0] data_operandB;
	assign data_operandB = (useImm1) ? immOut1 : intermediate_b;
	
	wire[31:0] alu_result;
	//pf50_alu alu_inst(data1, data_operandB, aluop, instructionOut2[11:7], alu_result, bsWire, bsWire);
	pf50_alu alu_inst(data_operandA, data_operandB, aluop, instructionOut2[11:7], alu_result);
	
	assign alu_input1 = data_operandA;
	assign alu_input2 = data_operandB;
	assign alu_output = alu_result;
	assign alu_opcode = aluop;
	
	
	//----------------------Initiate EX/MEM pipeline register------------------------//
	//Stuff for checking to branch
//	wire[31:0] data1_2;
//	register data1_1(data1, data1_2, 1'b1, clock, reset);
//	
//	wire[31:0] data2_2;
//	register data2_stuff(data2, data2_2, 1'b1, clock, reset);
	
//	wire isNotEqual1, isLessThan1;
//	wire[31:0] subtract_result1;
//	subtract subtract_inst1(data2_2, data1_2, subtract_result1, bsWire, isNotEqual1, isLessThan1);
	
	
	//Regular latch stuff
//	wire[31:0] pcChange3;
//	register modified_pc(pcStage3, pcChange3, 1'b1, clock, reset);
	
	wire[31:0] pcOut3;
	register old_pc(pcOut2, pcOut3, 1'b1, clock, reset);
	
	wire[31:0] alu_result1;
	register alu(alu_result, alu_result1, 1'b1, clock, reset);
	
	wire[31:0] data2_1;
	register data2reg(intermediate_b, data2_1, 1'b1, clock, reset);
	
	wire[31:0] instructionOut3;
	register instructionz(instructionOut2, instructionOut3, 1'b1, clock, reset);
	
	wire useImm2, jump2, jal2, jr2, memWrite2, useMem2, bne2, blt2;
	
	//Decode opcode for memWrite signal
	generateSignals blah(instructionOut3[31:27], useImm2, jump2, jal2, jr2, memWrite2, useMem2, bne2, blt2);
//	wire changePC = jump2 | jal2 | jr2 | (blt2 & isLessThan1) | (bne2 & isNotEqual1);
//	assign test_output = changePC;

	wire[31:0] data_in;
	assign data_in = bypass_c ? data_writeReg : data2_1;
	
	wire[31:0] memoryData;
	dmem mydmem( .address	(alu_result1[11:0]),
					.clock		(~clock),
					.data		(data_in),
					.wren		(memWrite2),	//need to fix this!
					.q			(memoryData) // change where output q goes...
	);
	
	
	
	//----------------------Initiate MEM/WB pipeline register-------------------------//
	wire[31:0] pcOut4;
	register final_inst(pcOut3, pcOut4, 1'b1, clock, reset);
	assign current_pc = pcOut4; //test
	
	wire[31:0] readData;
	register memData(memoryData, readData, 1'b1, clock, reset);
	
	wire[31:0] alu_result2;
	register aluagain(alu_result1, alu_result2, 1'b1, clock, reset);
	
	wire[31:0] instructionOut4;
	register instructiony(instructionOut3, instructionOut4, 1'b1, clock, reset);
	
	wire useImm3, jump3, jal3, jr3, memWrite3, useMem3, bne3, blt3;
	generateSignals blah1(instructionOut4[31:27], useImm3, jump3, jal3, jr3, memWrite3, useMem3, bne3, blt3);
	
	wire[31:0] regStage1;
	assign regStage1 = useMem3 ? readData : alu_result2;
	assign data_writeReg = jal3 ? pcOut4 : regStage1; //goes back to regfile
	
	assign write_data = data_writeReg;

	
	//Generate control signal for regWrite, goes back to regfile
	assign writeEnable = (~instructionOut4[31] & ~instructionOut4[30] & ~instructionOut4[29] & ~instructionOut4[28] & ~instructionOut4[27]) | (~instructionOut4[31] & ~instructionOut4[30] & instructionOut4[29] & ~instructionOut4[28] & instructionOut4[27]) | (~instructionOut4[31] & ~instructionOut4[30] & ~instructionOut4[29] & instructionOut4[28] & instructionOut4[27]) | (~instructionOut4[31] & instructionOut4[30] & ~instructionOut4[29] & ~instructionOut4[28] & ~instructionOut4[27]);
	assign test_regWrite = writeEnable; //test
	
	//chose bewteen register 31 and RD
	assign ctrl_writeReg = jal3 ? 5'b11111 : instructionOut4[26:22];
	assign write_reg = ctrl_writeReg; //test
	assign stored_pc = data_writeReg; //test
	//register(in, out, enable, clock, reset);
	
	//----------------------BYPASS CONTROL BLOCK-------------------------------//
	wire[4:0] a_signal1, a_signal2, b_signal1, b_signal2, c_signal;
	wire bypass_c;
	bypass byp(instructionOut2, instructionOut3, instructionOut4, data2_bits[4:0], a_signal1, a_signal2, b_signal1, b_signal2, c_signal);
	
	//----------------------STALL CONTROL BLOCK-------------------------------//
	wire stall;
	stall stal(instructionOut1, instructionOut2, rs1, data2_input, stall);
	
	//////////////////////////////////////
	////// THIS IS REQUIRED FOR GRADING
	// CHANGE THIS TO ASSIGN YOUR DMEM WRITE ADDRESS ALSO TO debug_addr
	assign debug_addr = (alu_result1[11:0]);
	// CHANGE THIS TO ASSIGN YOUR DMEM DATA INPUT (TO BE WRITTEN) ALSO TO debug_data
	assign debug_data = (data_in);
	////////////////////////////////////////////////////////////
	
		
	// You'll need to change where the dmem and imem read and write...

	
endmodule

module bypass(ex_stage_instruction, mem_stage_instruction, write_stage_instruction, data2, a_signal1, a_signal2, b_signal1, b_signal2, c_signal);
	input[31:0] ex_stage_instruction, mem_stage_instruction, write_stage_instruction;
	input[4:0] data2;
	output a_signal1, a_signal2, b_signal1, b_signal2;
	output c_signal;

	wire[4:0] ex_op, ex_rd, ex_rs, ex_rt, ex_shiftamt, ex_aluop, mem_op, mem_rd, mem_rs, mem_rt, mem_shiftamt, mem_aluop, write_op, write_rd, write_rs, write_rt, write_shiftamt, write_aluop;
	wire[16:0] ex_immediate, mem_immediate, write_immediate;
	wire[26:0] ex_target, mem_target, write_target;
	decodeInstruction inst1(ex_stage_instruction, ex_op, ex_rd, ex_rs, ex_rt, ex_shiftamt, ex_aluop, ex_immediate, ex_target);
	decodeInstruction inst2(mem_stage_instruction, mem_op, mem_rd, mem_rs, mem_rt, mem_shiftamt, mem_aluop, mem_immediate, mem_target);
	decodeInstruction inst3(write_stage_instruction, write_op, write_rd, write_rs, write_rt, write_shiftamt, write_aluop, write_immediate, write_target);
	
	//Part A
	wire ex_mem1, ex_write1, zero1, zero2;
	isEqual one(ex_rs, mem_rd, ex_mem1);
	isEqual two(ex_rs, write_rd, ex_write1);
	isEqual three1(mem_rd, 5'b00000, zero1);
	isEqual four1(write_rd, 5'b00000, zero2);
	
	assign a_signal1 = ex_mem1 & ~zero1;
	assign a_signal2 = ex_write1 & ~zero2; //Need to check if $rd == $r0
	
	
	//Part B
	wire ex_mem2, ex_write2;
	isEqual one1(data2, mem_rd, ex_mem2);
	isEqual two1(data2, write_rd, ex_write2);
	
	assign b_signal1 = ex_mem2 & ~zero1;
	assign b_signal2 = ex_write2 & ~zero2; //Need to check if $rd == $r0
	
	//Part C
	//Check if write back is at lw and mem is at sw
	wire right_commands = ((~write_op[4] & ~write_op[3] & write_op[2] & ~write_op[1] & write_op[0]) | (~write_op[4] & ~write_op[3] & ~write_op[2] & ~write_op[1] & ~write_op[0]) | (~write_op[4] & write_op[3] & ~write_op[2] & ~write_op[1] & ~write_op[0]) | (~write_op[4] & ~write_op[3] & ~write_op[2] & write_op[1] & write_op[0])) & (~mem_op[4] & ~mem_op[3] & mem_op[2] & mem_op[1] & mem_op[0]);
	
	//Check if rd is equal
	wire mem_write1;
	isEqual three(write_rd, mem_rd, mem_write1);
	assign c_signal = right_commands & mem_write1;
endmodule

module stall(if_stage_instruction, ex_stage_instruction, data1, data2, stall);
	input[31:0] if_stage_instruction, ex_stage_instruction;
	input[4:0] data1, data2;
	output stall;
	
	wire[4:0] ex_op, ex_rd, ex_rs, ex_rt, ex_shiftamt, ex_aluop, if_op, if_rd, if_rs, if_rt, if_shiftamt, if_aluop;
	wire[16:0] ex_immediate, if_immediate;
	wire[26:0] ex_target, if_target;
	
	decodeInstruction inst4(ex_stage_instruction, ex_op, ex_rd, ex_rs, ex_rt, ex_shiftamt, ex_aluop, ex_immediate, ex_target);
	decodeInstruction inst5(if_stage_instruction, if_op, if_rd, if_rs, if_rt, if_shiftamt, if_aluop, if_immediate, if_target);
	
	wire isEqual1, isEqual2, isZero;
	isEqual inst(data1, ex_rd, isEqual1);
	isEqual inst1(data2, ex_rd, isEqual2);
	isEqual inst2(ex_rd, 32'b0, isZero);
	
	wire dx_load, if_store;
	assign dx_load = ~ex_op[4] & ex_op[3] & ~ex_op[2] & ~ex_op[1] & ~ex_op[0];
	assign if_store = ~if_op[4] & ~if_op[3] & if_op[2] & if_op[1] & if_op[0];
	
	assign stall = (dx_load) & ((isEqual1 & ~isZero) | (isEqual2 & ~isZero)) & ~if_store;
endmodule

module isEqual(a, b, out);
	input[4:0] a,b;
	output out;
	
	wire[4:0] ex_ored = a^b;
	wire[5:0] intermediate_array;
	assign intermediate_array[0] = 1'b0;
	
	genvar i;
	generate
		for (i = 0; i < 5; i = i + 1) begin:loop1
			assign intermediate_array[i+1] = (intermediate_array[i] | ex_ored[i]);
		end
	endgenerate
	
	assign out = ~intermediate_array[5];
endmodule

module decodeInstruction(instruction, opcode, rd, rs, rt, shiftamt, aluop, immediate, target);
	input[31:0] instruction;
	output[4:0] opcode, rd, rs, rt, shiftamt, aluop;
	output[16:0] immediate;
	output[26:0] target;
	
	assign opcode = instruction[31:27];
	assign rd = instruction[26:22];
	assign rs = instruction[21:17];
	assign rt = instruction[16:12];
	assign shiftamt = instruction[11:7];
	assign aluop = instruction[6:2];
	assign immediate = instruction [16:0];
	assign target = instruction[26:0];
endmodule

module signExtend(in, out);
	input[16:0] in;
	output[31:0] out;
	
	assign out[16:0] = in;
	assign out[31:17] = in[16];
endmodule

module generateSignals(o, useImm, jump, jal, jr, memWrite, useMem, bne, blt);
	input[4:0] o;
	output useImm, jump, jal, jr, memWrite, useMem, bne, blt;
	
	assign useImm = (~o[4] & ~o[3] & o[2] & ~o[1] & o[0]) | (~o[4] & ~o[3] & o[2] & o[1] & o[0]) | (~o[4] & o[3] & ~o[2] & ~o[1] & ~o[0]);
	assign jump = (~o[4] & ~o[3] & ~o[2] & ~o[1] & o[0]);
	assign jal = (~o[4] & ~o[3] & ~o[2] & o[1] & o[0]);
	assign jr = ~o[4] & ~o[3] & o[2] & ~o[1] & ~o[0];
	assign memWrite = ~o[4] & ~o[3] & o[2] & o[1] & o[0];
	assign useMem = ~o[4] & o[3] & ~o[2] & ~o[1] & ~o[0];
	assign bne = ~o[4] & ~o[3] & ~o[2] & o[1] & ~o[0];
	assign blt = ~o[4] & ~o[3] & o[2] & o[1] & ~o[0];
endmodule

module processor2(inputA, inputB, out);
	input[31:0] inputA, inputB;
	output[31:0] out;
	wire bsWire, bsWire1;
	
	pf50_alu inst1(inputA, inputB, 5'b0, 5'b0, out, bsWire, bsWire1);
endmodule
