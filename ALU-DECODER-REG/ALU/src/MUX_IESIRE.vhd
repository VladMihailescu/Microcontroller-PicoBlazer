library IEEE;
use IEEE.STD_LOGIC_1164.all;   
use IEEE.STD_LOGIC_UNSIGNED.all;
use types.all;
										  
entity MUX_OUTPUT is 	
	generic(
		NR_INPUTS: INTEGER := 18;	--18 operatii						 
		NR_BITS: INTEGER := 8
		);
		
	port(
		INPUT_MATRIX: in matrix(NR_INPUTS - 1 downto 0);
		SELECTION: in INTEGER;
		OUTPUT: out STD_LOGIC_VECTOR(NR_BITS - 1 downto 0)
	);
end entity MUX_OUTPUT;
					
architecture MUX_OUTPUT_ARCHITECTURE of MUX_OUTPUT is						   
begin 			 	 									   
	process(INPUT_MATRIX, SELECTION)  
	begin
		if(SELECTION >= 0 and SELECTION < NR_INPUTS) then
			OUTPUT <= INPUT_MATRIX(SELECTION); 		  
		end if;
	end process;	  
end architecture MUX_OUTPUT_ARCHITECTURE;    