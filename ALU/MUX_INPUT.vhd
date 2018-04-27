library IEEE;
use IEEE.STD_LOGIC_1164.all;	
use IEEE.STD_LOGIC_UNSIGNED.all;
use types.all;
										  
entity MUX_INPUT is 	
	generic(
		NR_INPUTS: INTEGER := 2;	--0 - registru; 1 - constanta						 
		NR_BITS: INTEGER := 8
		);
	port(
		INPUT_MATRIX: in matrix(NR_INPUTS - 1 downto 0);
		SELECTION: in INTEGER;
		OUTPUT: out STD_LOGIC_VECTOR(NR_BITS - 1 downto 0)
	);
end entity MUX_INPUT;
					
architecture MUX_INPUT_ARCHITECTURE of MUX_INPUT is						   
begin 			
	
	OUTPUT <= INPUT_MATRIX(SELECTION); 	
	
end architecture MUX_INPUT_ARCHITECTURE;    