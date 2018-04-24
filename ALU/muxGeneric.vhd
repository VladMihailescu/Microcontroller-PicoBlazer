library IEEE;
use IEEE.STD_LOGIC_1164.all;
use types.all;
		 
										  
entity MUX_GENERIC is 	
	generic(
		NR_INPUTS: INTEGER := 16;						 
		NR_OF_BITI: INTEGER := 8
		);
		
	port(
		INPUT_MATRIX: in matrix(NR_INPUTS - 1 downto 0, NR_OF_BITI downto 0);
		SELECTION: in NATURAL;
		OUTPUT: out STD_LOGIC_VECTOR(NR_OF_BITI - 1 downto 0)
	);
end;
					
architecture MUX_GENERIC_ARCHITECTURE of MUX_GENERIC is						   
begin 									   
	process(SELECTION,INPUT_MATRIX)				 
	begin									
		for i in 7 downto 0 loop
			OUTPUT(i) <= INPUT_MATRIX(SELECTION,i);
		end loop;
	end process;
end;    