library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity ANDD is
	generic(
		NR_BITS: INTEGER := 8
	);						  
	port(
		FIRST_NUMBER: in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
		SECOND_NUMBER: in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
		RESULT: inout STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
		ZERO_FLAG: out STD_LOGIC
	);
end;						 

architecture ANDD_ARCHITECTURE of ANDD is										  

begin
	RESULT <= FIRST_NUMBER and SECOND_NUMBER; 
	
	process(FIRST_NUMBER, SECOND_NUMBER)
	variable INTERMEDIAR_RESULT_ZERO: STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);  
	begin
		INTERMEDIAR_RESULT_ZERO := FIRST_NUMBER and SECOND_NUMBER;
		if(INTERMEDIAR_RESULT_ZERO = "00000000") then
			ZERO_FLAG <= '1';
		else
			ZERO_FLAG <= '0';
		end if;
	end process;
end;