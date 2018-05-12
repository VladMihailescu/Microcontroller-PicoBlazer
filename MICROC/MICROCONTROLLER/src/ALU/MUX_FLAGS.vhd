library IEEE;
use IEEE.STD_LOGIC_1164.all;   
use IEEE.NUMERIC_STD.all;
use types.all;
										  
entity MUX_FLAGS is 	
	generic(
		NR_INPUTS: INTEGER := 18;	--18 operatii						 
		NR_BITS: INTEGER := 1
		);
		
	port(
		INPUT_MATRIX: in STD_LOGIC_VECTOR(17 downto 0);
		SELECTION: in INTEGER;
		OUTPUT: out STD_LOGIC
	);
end entity MUX_FLAGS;
					
architecture MUX_FLAGS_ARCHITECTURE of MUX_FLAGS is						   
begin 			 	 									   
	process(INPUT_MATRIX, SELECTION)  
	begin
		if(SELECTION >= 0 and SELECTION < NR_INPUTS) then
			OUTPUT <= INPUT_MATRIX(SELECTION); 		  
		end if;
	end process;	  
end architecture MUX_FLAGS_ARCHITECTURE;    