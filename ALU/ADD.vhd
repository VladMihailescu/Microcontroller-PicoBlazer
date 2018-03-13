entity ADD_8_BIT is
	port(A,B:in BIT_VECTOR(7 downto 0);
		 S:out BIT_VECTOR(7 downto 0);
		 CARRY_FLAG,ZERO_FLAG:out bit);
end ADD_8_BIT;



architecture ADD_8_BIT_ARCH of ADD_8_BIT is
signal CARRY: BIT_VECTOR(7 downto 0);

begin			 
	S(0) <= A(0) xor B(0);
	CARRY(0) <= A(0) and B(0);
	
	S(1) <= A(1) xor B(1) xor CARRY(0);
	CARRY(1) <= (A(1) and B(1)) or (CARRY(0) and (A(1) or B(1)));
	
	S(2) <= A(2) xor B(2) xor CARRY(1);
	CARRY(2) <= (A(2) and B(2)) or (CARRY(1) and (A(2) or B(2)));  
	
	S(3) <= A(3) xor B(3) xor CARRY(2);
	CARRY(3) <= (A(3) and B(3)) or (CARRY(2) and (A(3) or B(3)));
	
	S(4) <= A(4) xor B(4) xor CARRY(3);
	CARRY(4) <= (A(4) and B(4)) or (CARRY(3) and (A(4) or B(4)));  
	
	S(5) <= A(5) xor B(5) xor CARRY(4);
	CARRY(5) <= (A(5) and B(5)) or (CARRY(4) and (A(5) or B(5)));
	
	S(6) <= A(6) xor B(6) xor CARRY(5);
	CARRY(6) <= (A(6) and B(6)) or (CARRY(5) and (A(6) or B(6)));
	
	S(7) <= A(7) xor B(7) xor CARRY(6);
	CARRY(7) <= (A(7) and B(7)) or (CARRY(6) and (A(7) or B(7)));	
	
	ZERO_FLAG <= 
	(not (A(0) xor B(0))) and
	(not (A(1) xor B(1) xor CARRY(0))) and 
	(not (A(2) xor B(2) xor CARRY(1))) and 
	(not (A(3) xor B(3) xor CARRY(2))) and
	(not (A(4) xor B(4) xor CARRY(3))) and
	(not (A(5) xor B(5) xor CARRY(4))) and
	(not (A(6) xor B(6) xor CARRY(5))) and
	(not (A(7) xor B(7) xor CARRY(6)));
	CARRY_FLAG <= CARRY(7);
	
end	ADD_8_BIT_ARCH;