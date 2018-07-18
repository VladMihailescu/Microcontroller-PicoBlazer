
library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use types.all;

entity MUX_SUB is		
	port(A:in matrix8(15 downto 0);	 
	S:in STD_LOGIC_VECTOR (3 downto 0);
	B:out STD_LOGIC_VECTOR (7 downto 0));	  
end;
architecture MUX_SUB of MUX_SUB is  	
begin	
	process(S)
	variable sel:integer;
	begin
		sel:=to_integer(unsigned(S));
		B<=A(sel);
	end process;
end;



library ieee;
use ieee.std_logic_1164.all;
use types.all;

entity SUBMARIN is
	   port(						
	   		RESET: in STD_LOGIC; 
				
				SWITCH:in BIT;
	   		DATA_IN:in STD_LOGIC_VECTOR (3 downto 0);
       		ANODE : out STD_LOGIC_VECTOR (3 downto 0);
      		CATHODE : out STD_LOGIC_VECTOR (6 downto 0); 	   
			INTERRUPT:in BIT;
			CLK:in BIT;
			CLK_SWITCH:in STD_LOGIC
		);
end;  
architecture SUBMARIN of SUBMARIN is

component MUX_SUB 		
	port(A:in matrix8(15 downto 0);	 
		S:in STD_LOGIC_VECTOR (3 downto 0);
		B:out STD_LOGIC_VECTOR (7 downto 0));	  
end component; 

component AFISOR is
	port ( clock_100Mhz : in BIT;
		RESET : in STD_LOGIC; 
		DATA_IN:in STD_LOGIC_VECTOR (7 downto 0);
		SWITCH:in BIT;
		OUTPUT1:in integer range 0 to 255;
		OUTPUT2:in integer range 0 to 255;
      ANODE : out STD_LOGIC_VECTOR (3 downto 0);
      CATHODE : out STD_LOGIC_VECTOR (6 downto 0)
	);
end component; 	 

component MICROCONTROLLER_BLACK_BOX is
	port(						
		RESET: in STD_LOGIC; 
		REG_MATRIX: out matrix8(15 downto 0); 	   	
		CLK	:in STD_LOGIC;
		INTER:in BIT;
		OUTPUT1:out integer range 0 to 255;
		OUTPUT2:out integer range 0 to 255
	);	
end component;

signal REG_M: matrix8(15 downto 0);
signal DATA : STD_LOGIC_VECTOR (7 downto 0);
signal INTERUPT: BIT;
signal OTPT1,OTPT2: integer range 0 to 255;	  
signal AUX1,AUX2,AUX3:BIT;

begin  
	process(CLK)  
	begin  
		if CLK='1' and CLK'EVENT then 
			AUX1<=INTERRUPT;
			AUX2<=AUX1;
			AUX3<=AUX2;
			INTERUPT<= AUX1 and AUX2 and AUX3;
		end if;
	end process;  
	
	L1:MICROCONTROLLER_BLACK_BOX port map(
		RESET,
		REG_M,
		CLK_SWITCH,
		INTERUPT,
		OTPT1,
		OTPT2
	);
	L2:MUX_SUB port map(
		REG_M,
		DATA_IN,
		DATA
	);
	L3:AFISOR port map(
		CLK,
		RESET,
		DATA,
		SWITCH,
		OTPT1,
		OTPT2,
		ANODE,
		CATHODE
	);
end; 