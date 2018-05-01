library ieee;
use ieee.std_logic_1164.all;

entity p_counter is
	port(ADDRESS:in integer range 0 to 255;
	CLK:in STD_LOGIC;
	OUTPUT:out integer range 0 to 255);
end;
architecture p_counter of p_counter is
begin
	process(CLK,ADDRESS)
	variable data:integer range 0 to 256:=255;
	begin  
		if(CLK='1' and CLK'EVENT) then
			if(ADDRESS'EVENT)then
				data:=ADDRESS;
			else
				data:=data+1;
			end if;	
			if data=256 then
				data :=0;
			end if;
			OUTPUT<=data;
		end if;	 
	end process ;
end;
			