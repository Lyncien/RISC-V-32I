import os, sys, codecs
i_type_funct3 = {'000':'addi', '010':'slti', '011':'sltiu', '100':'xori', '110':'ori', '111':'andi', '001':'slli', '101':'srli'}
r_type_funct3 = {'000':'add ', '010':'slt ', '011':'sltu', '100':'xor ', '110':'or  ', '111':'and ', '001':'sll ', '101':'srl '}
load_funct3 = {'000':'lb  ', '001':'lh  ', '010':'lw  ', '100':'lbu ', '101':'lhu '}
save_funct3 = {'000':'sb  ', '001':'sh  ', '010':'sw  '}
branch_funct3 = {'000':'beq ', '001':'bne ', '100':'blt ', '101':'bge ', '110':'bltu', '111':'bgeu'}
reg = ['zero', 'ra', 'sp', 'gp', 'tp', 't0', 't1', 't2', 's0/fp', 's1', 'a0', 'a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'a7', 's2', 's3', 's4', 's5', 's6', 's7', 's8', 's9', 's10', 's11', 't3', 't4', 't5', 't6']
def showreg(regbin):
	return '{:>4s}'.format(reg[int(regbin, 2)]) + '($' + '{:2d}'.format(int(regbin, 2)) + ')'
#def showinst(op, b1, b2, b3):
	#return op + '\t' + showreg(b1) + '\t' + showreg(b2) + '\t' + str(int(iimm, 2))
def showimm(immbin):
	return '{:>10s}'.format(hex(int(immbin, 2))[2:].zfill(8)) + '(' + '{:10d}'.format(int(immbin, 2)) + ')'
def trans(filepath):
	f = codecs.open(filepath, 'r+', 'utf-8')
	lines = f.read().split('\n')
	#print(lines)
	f.close()
	f = open(filepath[:-5] + '.txt', 'w+')
	for i, line in enumerate(lines):
		if not line: continue
		
		bline = bin(int(line, 16))[2:].zfill(32)
		#print(bline, bline[0:7])
		b = bline[::-1]
		opcode = b[0:7][::-1]
		rd = b[7:12][::-1]
		funct3 = b[12:15][::-1]
		rs1 = b[15:20][::-1]
		rs2 = b[20:25][::-1]
		funct7 = b[25:32][::-1]
		
		#simm = funct7 + rd
		
		inst = ''
		if opcode == '0010011':
			inst = i_type_funct3[funct3]
			if inst == 'srli' and funct7 == '0100000':
				inst = 'srai'
			if inst == 'srli' or inst == 'srai' or inst == 'slli':
				iimm = rs2
			else:
				iimm = b[31] * 20 + funct7 + rs2
			inst += '\t' + showreg(rd) + '\t' + showreg(rs1) + '\t' + showimm(iimm)
		elif opcode == '0110011':
			inst = r_type_funct3[funct3]
			if inst == 'srl ' and funct7 == '0100000':
				inst = 'sra '
			if inst == 'add ' and funct7 == '0100000':
				inst = 'sub '
			inst += '\t' + showreg(rd) + '\t' + showreg(rs1) + '\t' + showreg(rs2)
		elif opcode == '0000011':
			inst = load_funct3[funct3]
			iimm = b[31] * 20 + funct7 + rs2
			inst += '\t' + showreg(rd) + '\t' + showreg(rs1) + '\t' + showimm(iimm)
		elif opcode == '0100011':
			inst = save_funct3[funct3]
			simm = b[31] * 20 + funct7 + rd
			inst += '\t' + showreg(rs2) + '\t' + showreg(rs1) + '\t' + showimm(simm)
		elif opcode == '1100011':
			inst = branch_funct3[funct3]
			bimm = b[31] * 20 + b[7] + b[25:31][::-1] + b[8:12][::-1] + '0'
			inst += '\t' + showreg(rs1) + '\t' + showreg(rs2) + '\t' + showimm(bimm)
		elif opcode == '1101111':
			inst = 'jal '
			jimm = b[31] * 12 + b[12:20][::-1] + b[20] + b[21:31][::-1] + '0'
			inst += '\t' + showreg(rd) + '\t' + showimm(jimm)
		elif opcode == '1100111':
			inst = 'jalr'
			iimm = b[31] * 20 + funct7 + rs2
			inst += '\t' + showreg(rd) + '\t' + showreg(rs1) + '\t' + showimm(iimm)
		elif opcode == '0110111':
			inst = 'lui '
			uimm = b[12:32][::-1] + '000000000000'
			inst += '\t' + showreg(rd) + '\t' + showimm(uimm)
		elif opcode == '0010111':
			inst = 'auipc'
			uimm = b[12:32][::-1] + '000000000000'
			inst += '\t' + showreg(rd) + '\t' + showimm(uimm)
		f.write('{:>5d}\t{:>5}\t\t0x'.format(i, hex(4 * i)) + line + '\t' + bline + '\t' + inst  + '\n')
	f.close()
rootdir = sys.path[0]
l = os.listdir(rootdir) #列出文件夹下所有的目录与文件
for i in range(len(l)):
	filepath = os.path.join(rootdir,l[i])
	if os.path.isfile(filepath) and filepath[-5:] == '.inst':
		print(filepath)
		trans(filepath)
#os.system('pause')
