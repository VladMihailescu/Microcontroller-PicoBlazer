entity OR_8_BIT is
	port(A,B:in BIT_VECTOR(7 downto 0);
		 R:out BIT_VECTOR(7 downto 0);
		 CARRY_FLAG,ZERO_FLAG:out bit);
end OR_8_BIT;


architecture OR_8_BIT_ARCH of OR_8_BIT is

begin
	R <= A or B;   
	CARRY_FLAG <= '0'; 
	ZERO_FLAG <= 
	(not (A(0) or B(1))) and
	(not (A(1) or B(1))) and 
	(not (A(2) or B(2))) and 
	(not (A(3) or B(3))) and
	(not (A(4) or B(4))) and
	(not (A(5) or B(5))) and
	(not (A(6) or B(6))) and
	(not (A(7) or B(7)));	  
end OR_8_BIT_ARCH;