library IEEE;
use IEEE.STD_LOGIC_1164.all;   
use IEEE.STD_LOGIC_UNSIGNED.all;
use types.all;
										  
entity SECOND_MUX is 	
	generic(
		NR_INPUTS: INTEGER := 16;	--18 operatii						 
		NR_BITS: INTEGER := 8
		);
		
	port(
		INPUT_MATRIX: in matrix(NR_INPUTS - 1 downto 0);
		SELECTION: in INTEGER;
		OUTPUT: out STD_LOGIC_VECTOR(NR_BITS - 1 downto 0)
	);
end entity SECOND_MUX;
					
architecture SECOND_MUX_ARCHITECTURE of SECOND_MUX is						   
begin 			 	 									   
	OUTPUT <= INPUT_MATRIX(SELECTION);	  
end architecture SECOND_MUX_ARCHITECTURE;    