entity SUB_8_BIT is
	port(A,B:in BIT_VECTOR(7 downto 0);
		 D:out BIT_VECTOR(7 downto 0);
		 CARRY_FLAG,ZERO_FLAG:out bit);
end SUB_8_BIT;



architecture SUB_8_BIT_ARCH of SUB_8_BIT is

component ADD_8_BIT
	port(A,B:in BIT_VECTOR(7 downto 0);
		 S:out BIT_VECTOR(7 downto 0);
		 CARRY_FLAG,ZERO_FLAG:out bit);
end component;

signal CARRY: BIT_VECTOR(7 downto 0);
signal B_COMPL_1: BIT_VECTOR(7 downto 0);
signal B_COMPL_2: BIT_VECTOR(7 downto 0);
signal CF:bit;
signal ZF:bit;
signal AUX:bit;

begin			 	
	B_COMPL_1 <= not B;
	
	C1: ADD_8_BIT port map(B_COMPL_1, "00000001", B_COMPL_2, CF, ZF);
	C2: ADD_8_BIT port map(B_COMPL_2, A, D, AUX, ZERO_FLAG);
	
	CARRY_FLAG <= not AUX;
end	SUB_8_BIT_ARCH;