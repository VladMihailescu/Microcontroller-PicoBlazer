library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all;
use types.all;

entity FLOW_BLACK_BOX is  
	port(	   
		MODE: in INTEGER;
		LOAD: in INTEGER; 
		
		COND: in INTEGER;
		SEL: in INTEGER;
		
		ZERO: in STD_LOGIC;
		CARRY: in STD_LOGIC;
		
		MODE_OUT: out INTEGER;
		LOAD_OUT: out INTEGER
	);
end entity FLOW_BLACK_BOX;		   	   

architecture FLOW_BLACK_BOX_ARCHITECTURE of FLOW_BLACK_BOX is

begin		
	PROC_TAG: process(MODE,LOAD,CARRY,ZERO,COND,SEL)
	
	begin
		if(MODE = 0) then
			MODE_OUT <= MODE;
			LOAD_OUT <= LOAD;
		else
			if(COND = 0) then
				MODE_OUT <= MODE;
				LOAD_OUT <= LOAD;
			else
				if(SEL = 0) then
					if(ZERO = '1') then
						MODE_OUT <= MODE;
						LOAD_OUT <= LOAD;
					else
						MODE_OUT <= 0;
						LOAD_OUT <= 0;
					end if;
				end if;	
				
				if(SEL = 1) then
					if(ZERO = '0') then
						MODE_OUT <= MODE;
						LOAD_OUT <= LOAD;
					else
						MODE_OUT <= 0;
						LOAD_OUT <= 0;
					end if;
				end if;	
				
				if(SEL = 2) then
					if(CARRY = '1') then
						MODE_OUT <= MODE;
						LOAD_OUT <= LOAD;
					else
						MODE_OUT <= 0;
						LOAD_OUT <= 0;
					end if;
				end if;			 
				
				if(SEL = 3) then
					if(CARRY = '0') then
						MODE_OUT <= MODE;
						LOAD_OUT <= LOAD;
					else
						MODE_OUT <= 0;
						LOAD_OUT <= 0;
					end if;
				end if;
			end if;
		end if;
	end process PROC_TAG;
end architecture FLOW_BLACK_BOX_ARCHITECTURE;