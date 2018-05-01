use type2.all; 		

entity mux is		
	port(A:in ARAY;	 
	S:in integer range 0 to 15;
	B:out integer range 0 to 255);	  
end;
architecture mux of mux is  	
begin	
	process(S)
	begin  
		B<=A(S);
	end process;
end;