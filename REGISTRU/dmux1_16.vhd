package types is
	type ARR  is array (15 downto 0)of BIT_VECTOR (7 downto 0);	   
end package;  


use types.all; 		

entity dmux is		
	port(A:in BIT_VECTOR(7 downto 0);	
	CLK:in BIT;
	S:in integer range 0 to 15;
	B:out ARR);	  
end;
architecture dmux of dmux is  	
begin	
	process(S,A,CLK)
	begin 
		if(CLK='1' and CLK'EVENT)then
			B(S)<=A; 
		end if;	
	end process;
end;