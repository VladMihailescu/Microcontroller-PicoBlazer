entity XOR_8_BIT is
	port(A,B:in BIT_VECTOR(7 downto 0);
		 R:out BIT_VECTOR(7 downto 0);
		 CARRY_FLAG,ZERO_FLAG:out bit);
end XOR_8_BIT;


architecture XOR_8_BIT_ARCH of XOR_8_BIT is

begin
	R <= A xor B;   
	CARRY_FLAG <= '0'; 
	ZERO_FLAG <= 
	(not (A(0) xor B(1))) and
	(not (A(1) xor B(1))) and 
	(not (A(2) xor B(2))) and 
	(not (A(3) xor B(3))) and
	(not (A(4) xor B(4))) and
	(not (A(5) xor B(5))) and
	(not (A(6) xor B(6))) and
	(not (A(7) xor B(7)));	  
end XOR_8_BIT_ARCH;