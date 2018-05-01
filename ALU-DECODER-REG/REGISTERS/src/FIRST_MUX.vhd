library IEEE;
use IEEE.STD_LOGIC_1164.all;   
use IEEE.STD_LOGIC_UNSIGNED.all;
use types.all;
										  
entity FIRST_MUX is 	
	generic(
		NR_INPUTS: INTEGER := 16;	--18 operatii						 
		NR_BITS: INTEGER := 8
		);
		
	port(
		INPUT_MATRIX: in matrix(NR_INPUTS - 1 downto 0);
		SELECTION: in INTEGER;
		OUTPUT: out STD_LOGIC_VECTOR(NR_BITS - 1 downto 0)
	);
end entity FIRST_MUX;
					
architecture FIRST_MUX_ARCHITECTURE of FIRST_MUX is						   
begin 			 	 									   
	OUTPUT <= INPUT_MATRIX(SELECTION);	  
end architecture FIRST_MUX_ARCHITECTURE;    