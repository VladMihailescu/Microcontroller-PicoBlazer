library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity DEC_VECTOR_TO_INTEGER is
	generic(
		NR_BITS: INTEGER := 4
	);
	port(
		INPUT: in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);	
		OUTPUT: out INTEGER
	);
end;
architecture DEC_VECTOR_TO_INTEGER_ARCHITECTURE of DEC_VECTOR_TO_INTEGER is
begin
	MAIN:process(INPUT)
	variable REZ: INTEGER :=0;   
	begin  
		REZ := 0;
		if(INPUT(0)='1')then
			REZ := 1;
		end if;	   
		if(INPUT(1)='1')then
			REZ := REZ + 2;
		end if;
		if(INPUT(2)='1')then
			REZ := REZ + 4;
		end if;
		if(INPUT(3)='1')then
			REZ := REZ + 8;
		end if;	 
		OUTPUT <= REZ;
	end process MAIN;
end;