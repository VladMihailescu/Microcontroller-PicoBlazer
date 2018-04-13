entity stack is
	port(A:in BIT_VECTOR(7 downto 0);
	B:out BIT_VECTOR(7 downto 0);
	UP:in BIT;
	DOWN:in BIT;
	EMPTY:inout BIT;
	FULL:inout BIT;
	CLK:in BIT);
end;   
use types.all;
architecture stack of stack is 
component dmux
	port(A:in BIT_VECTOR(7 downto 0);	 
	S:in integer range 0 to 15;
	B:out ARR);	  
end component;	 

component counter 
	port(UP:in BIT;
	DOWN:in BIT;  
	FULL:inout BIT;
	EMPTY:inout BIT:='1';
	Y:out Integer range 0 to 16:=0);
end component; 

component mux 		
	port(A:in ARR;	 
	S:in integer range 0 to 15;
	B:out BIT_VECTOR(7 downto 0));	  
end component;

component reg 
	 port(A:in BIT_VECTOR(7 downto 0);
	 CLK:in BIT;
	 Y:out BIT_VECTOR(7 downto 0));
end component; 

signal input :ARR;

signal output :ARR;	

signal sel: integer range 0 to 15;
	 
begin 
	l1:dmux port map(A,	sel, input);
	
	l2:mux port map(output,sel,B);
	l4:counter port map(UP,DOWN,FULL,EMPTY,sel);	
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