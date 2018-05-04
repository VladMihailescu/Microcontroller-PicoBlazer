package type2 is
	type ARAY  is array (15 downto 0)of integer range 0 to 255;	   
end package; 


use type2.all; 		

entity dmux is		
	port(A:in integer range 0 to 255;	 
	S:in integer range 0 to 15;
	B:out ARAY);	  
end;
architecture dmux of dmux is  	
begin	
	process(S,A)
	begin  
		B(S)<=A;
	end process;
end;