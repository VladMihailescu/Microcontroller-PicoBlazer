use types.all; 		

entity mux is		
	port(A:in ARR;	 
	S:in integer range 0 to 15;
	B:out BIT_VECTOR(7 downto 0));	  
end;
architecture mux of mux is  	
begin	
	process(S)
	begin  
		B<=A(S);
	end process;
end;