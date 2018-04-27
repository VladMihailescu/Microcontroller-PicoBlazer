use types.all; 		

entity mux is		
	port(A:in ARR;	 
	CLK:in BIT;
	S:in integer range 0 to 15;		
	B:out BIT_VECTOR(7 downto 0));	  
end;
architecture mux of mux is  	
begin	
	process(S,CLk)
	begin  
		if(CLK='1' and CLK'EVENT)then
			B<=A(S); 
		end if;
	end process;
end;