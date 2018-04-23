use types.all;
entity  registru is
	port(A:in BIT_VECTOR(7 downto 0); 
	CLK: in BIT;
	S1:in BIT_VECTOR (3 downto 0);	 
	S2:in BIT_VECTOR (3 downto 0);
	B:out BIT_VECTOR(7 downto 0);
	Y:out BIT_VECTOR(7 downto 0));
end;
architecture registru of registru is	  					  

component mux	
	port(A:in ARR;	 		   
	CLK:in BIT;
	S:in integer range 0 to 15;
	B:out BIT_VECTOR(7 downto 0));	
end component;						  

component dmux	
	port(A:in BIT_VECTOR(7 downto 0);	
	CLK:in BIT;
	S:in integer range 0 to 15;
	B:out ARR);	
end component;					   

component dec	
	port(A: in BIT_VECTOR(3 downto 0);	
	B:out integer range 0 to 15);					
end component;					   

signal input :ARR;	 	
signal sel1: integer range 0 to 15;
signal sel2: integer range 0 to 15;

begin	
	l1:dmux port map(A,CLK,	sel1, input);
	l2:mux port map(input,CLK,sel1,B);	   
	l3:mux port map(input,CLK,sel2,Y);
	l4:dec port map(S1,sel1);	  
	l5:dec port map(S2,sel2);		  
end;