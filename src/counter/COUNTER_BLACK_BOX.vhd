library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use types.all;

entity COUNTER_BLACK_BOX is	   	
	generic(
		MODULO: INTEGER := 254
	);
	port(
		CLK: in STD_LOGIC;	 
		MODE: in INTEGER;	--0 numara, 1 load
		PARALLEL_LOAD: in INTEGER;
		RESET: in STD_LOGIC;
	    OUTPUT: inout INTEGER
	);
end entity COUNTER_BLACK_BOX;

architecture COUNTER_BLACK_BOX_ARCHITECTURE of COUNTER_BLACK_BOX is

begin						   
	process(CLK,RESET)		   	 	
	begin	   
		if(RESET = '1') then		
			OUTPUT <= 0;
		else
			if(rising_edge(CLK)) then
				if(MODE = 0) then
					OUTPUT <= OUTPUT + 1; 
					if(OUTPUT + 1 = MODULO) then
						OUTPUT <= 0;
					end if;
				else
					OUTPUT <= PARALLEL_LOAD;
					if(PARALLEL_LOAD < 0 or PARALLEL_LOAD >= MODULO) then
						OUTPUT <= 0;
					end if;	   
				end if;
			end if;	
		end if;
	end process;
end architecture COUNTER_BLACK_BOX_ARCHITECTURE;