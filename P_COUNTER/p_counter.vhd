library ieee;
use ieee.std_logic_1164.all;

entity p_counter is
	port(ADDRESS:in integer range 0 to 255;
	LOAD:in BIT;
	CLK:in BIT;
	OUTPUT:out integer range 0 to 255);
end;
architecture p_counter of p_counter is
begin
	process(CLK,LOAD)
	variable data:integer range 0 to 256:=255;	
	variable sem:BIT:='0';
	begin  	
		if(LOAD='1' and LOAD'EVENT)then
			data:=ADDRESS;	
			sem:='1';
		end if;	 
		if(CLK='1' and CLK'EVENT) then 
			if(sem='0')then
				data:=data+1;
			else
				sem:='0'; 
			end if;
			if data=256 then
				data :=0;
			end if;
			OUTPUT<=data;
		end if;	  
	end process ;
end;
			