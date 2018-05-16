library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity p_counter is
	port(ADDRESS:in integer range 0 to 255;
	LOAD:in BIT;
	CLK:in BIT;
	OUTPUT:out integer range 0 to 255);
end;
architecture p_counter of p_counter is 
signal data:integer range 0 to 256:=0; 
begin					   
	process(CLK)
	--variable data:integer range 0 to 256:=0;	
	--variable sem:BIT:='0';
	begin  	
--		if(LOAD='1')then --and LOAD'EVENT
--			data<=ADDRESS;	
			--sem:='1';
		if(CLK='1' and CLK'EVENT) then 
			if(LOAD='1')then
				data<=ADDRESS;
			--if(sem='0')then
			else data<=data+1;
			--else
			--	sem:='0'; 
			--end if;
			end if;
			if data=256 then
				data <=0;
			end if;	
		end if;		 
			OUTPUT<=data;
	end process ;
end;
			