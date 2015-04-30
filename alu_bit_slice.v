// 1-Bit Slice of an ALU using structual coding
// Uses 4x1MUX, 2x1MUX, and BFA
// FUNCTION TABLE
// c2 c1 c0 |    f
//  0  0  0 | ai+bi+ci
//  0  0  1 | ai+~bi+ci
//  0  1  0 | ~ai
//  0  1  1 | ~bi
//  1  0  0 | ai | bi
//  1  0  1 | ai | ~bi
//  1  1  0 | ai & bi
//  1  1  1 | ai & ~bi

// INSTANTIATED MODULES (Names, portlist for mapping)
// module hw1_2x1_MUX_behav(s,i1,i0,o);
// module hw1_4x1_MUX_RTL(i,s,o);
// module hw1_BFA_gate(a,b,cin,s,cout);

module alu_bit_slice(c, ai, bi, ci, co, f);
	input	[2:0]	c;
	input			ai,bi,ci;
	output			co,f;

	wire	[7:0]	w;
	//w[0] = ~bi
	//w[1] = ~ai
	//w[2] = M1 output bi mux
	//w[3] = M2 output ai mux
	//w[4] = ai & M1
	//w[5] = ai | M1
	//w[6]
	//w[7] = BFA sum
	
	hw1_BFA_gate 		BFA(ai, w[2], ci, w[7], co);
	hw1_2x1_MUX_behav	M1(c[0], {w[0], bi}, w[2]);
	hw1_2x1_MUX_behav	M2(c[0], {w[0], w[1]}, w[3]);
	hw1_4x1_MUX_RTL	M3({w[4], w[5], w[3], w[7]}, c[2:1], f);
	
	and (w[4], ai, w[2]);
	or	(w[5], ai, w[2]);
	not (w[0], bi);
	not (w[1], ai);
	
endmodule