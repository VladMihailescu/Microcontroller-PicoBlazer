entity AND_8_BIT is
	port(A,B:in BIT_VECTOR(7 downto 0);
		 R:out BIT_VECTOR(7 downto 0);
		 CARRY_FLAG,ZERO_FLAG:out bit);
end AND_8_BIT;


architecture AND_8_BIT_ARCH of AND_8_BIT is

begin
	R <= A and B;   
	CARRY_FLAG <= '0'; 
	ZERO_FLAG <= 
	(not (A(0) and B(1))) and
	(not (A(1) and B(1))) and 
	(not (A(2) and B(2))) and 
	(not (A(3) and B(3))) and
	(not (A(4) and B(4))) and
	(not (A(5) and B(5))) and
	(not (A(6) and B(6))) and
	(not (A(7) and B(7)));	  
end AND_8_BIT_ARCH;