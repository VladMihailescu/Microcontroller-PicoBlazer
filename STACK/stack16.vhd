entity stack is
	port(A:in integer range 0 to 255;
	B:out integer range 0 to 255;
	UP:in BIT;
	DOWN:in BIT;
	EMPTY:inout BIT;
	FULL:inout BIT;
	CLK:in BIT);
end;   
use type2.all;
architecture stack of stack is 
component dmux
	port(A:in integer range 0 to 255;	 
	S:in integer range 0 to 15;
	B:out ARAY);	  
end component;	 

component counter 
	port(UP:in BIT;
	DOWN:in BIT;  
	FULL:inout BIT;
	EMPTY:inout BIT:='1';
	Y:out Integer range 0 to 16:=0);
end component; 

component mux 		
	port(A:in ARAY;	 
	S:in integer range 0 to 15;
	B:out integer range 0 to 255);	  
end component;

 

signal data :ARAY;
					  

signal sel: integer range 0 to 15;
	 
begin 
	l1:dmux port map(A,	sel, data);
	
	l2:mux port map(data,sel,B);
	l4:counter port map(UP,DOWN,FULL,EMPTY,sel);	
	
end;