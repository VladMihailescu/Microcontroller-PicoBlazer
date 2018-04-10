use types.all;
entity  registru is
	port(A:in BIT_VECTOR(7 downto 0); 
	CLK: in BIT;
	S1:in BIT_VECTOR (3 downto 0);	 
	S2:in BIT_VECTOR (3 downto 0);
	Y:out BIT_VECTOR(7 downto 0));
end;
architecture registru of registru is	

component reg
	port(A:in BIT_VECTOR(7 downto 0);
	 CLK:in BIT;
	 Y:out BIT_VECTOR(7 downto 0));
end component;						  

component mux	
	port(A:in ARR;	 
	S:in integer range 0 to 15;
	B:out BIT_VECTOR(7 downto 0));	
end component;						  

component dmux	
	port(A:in BIT_VECTOR(7 downto 0);	 
	S:in integer range 0 to 15;
	B:out ARR);	
end component;					   

component dec	
	port(A: in BIT_VECTOR(3 downto 0);	
	B:out integer range 0 to 15);					
end component;					   

signal input :ARR;
signal output :ARR;	
signal sel1: integer range 0 to 15;
signal sel2: integer range 0 to 15;

begin	
	l1:dmux port map(A,	sel1, input);
	l2:mux port map(output,sel1,B);	   
	l3:mux port map(output,sel2,Y);
	l4:dec port map(S1,sel1);	  
	l5:dec port map(S2,sel2);
	l6:reg port map(input(0),CLK,output(0)); 
	l7:reg port map(input(1),CLK,output(1));  
	l8:reg port map(input(2),CLK,output(2)); 
	l9:reg port map(input(3),CLK,output(3)); 
	l10:reg port map(input(4),CLK,output(4)); 
	l11:reg port map(input(5),CLK,output(5)); 
	l12:reg port map(input(6),CLK,output(6)); 
	l13:reg port map(input(7),CLK,output(7)); 
	l14:reg port map(input(8),CLK,output(8)); 
	l15:reg port map(input(9),CLK,output(9)); 
	l16:reg port map(input(10),CLK,output(10)); 
	l17:reg port map(input(11),CLK,output(11)); 
	l18:reg port map(input(12),CLK,output(12)); 
	l19:reg port map(input(13),CLK,output(13)); 
	l20:reg port map(input(14),CLK,output(14)); 
	l21:reg port map(input(15),CLK,output(15));  
end;