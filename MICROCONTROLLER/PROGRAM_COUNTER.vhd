library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity PROGRAM_COUNTER is
	port(ADDRESS:in integer range 0 to 255;	
	RESET: in STD_LOGIC; 
	INP:in integer range 0 to 255;
	LOAD:in BIT;
	LOADR:in BIT;
	CLK:in BIT;
	OUTPUT:out integer range 0 to 255;
	OUTPUT_STACK:out integer range 0 to 255
	);
end;
architecture PROGRAM_COUNTER of PROGRAM_COUNTER is
begin					   
	process(CLK,RESET)
	variable data:integer range 0 to 256:=0;	
	begin  	
		if(RESET='1')then 
			data:=0;
		elsif(CLK='1' and CLK'EVENT) then 
			if(LOAD='1')then
				OUTPUT_STACK<=data;
				data:=ADDRESS;			
			elsif(LOADR='1')then
				data:=INP+1;		 
			else data:=data+1;	   
			end if;
			if data=256 then
				data :=0;
			end if;	
		end if;		 
			OUTPUT<=data;
	end process ;
end;
			