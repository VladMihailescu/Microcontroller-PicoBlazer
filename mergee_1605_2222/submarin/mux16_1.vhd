use type2.all; 		

entity mux is		
	port(A:in ARAY;
	DWN:in BIT;
	S:in integer range 0 to 15;
	B:out integer range 0 to 255);	  
end;
architecture mux of mux is  	
begin	
	process(S)
	begin 
		if(DWN='1')then
			B<=A(S);
		end if;
	end process;
end;