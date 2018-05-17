library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity SR1 is
	generic(
		NR_BITS:INTEGER := 8
	);						 
	port(
		FIRST_NUMBER:in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
		RESULT:out STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);	
		ZERO_FLAG: out STD_LOGIC;
		CARRY_FLAG: out STD_LOGIC
	);
end entity SR1;					  

architecture SR1_ARCHITECTURE of SR1 is
begin													 
	P1:process(FIRST_NUMBER)
	variable AUXILIAR: STD_LOGIC;
	variable INTERMEDIAR_RESULT_ZERO: STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
	begin												   
		AUXILIAR := FIRST_NUMBER(0);
		RESULT <= '1' & FIRST_NUMBER(NR_BITS - 1 downto 1);
		CARRY_FLAG <= AUXILIAR;
		
		ZERO_FLAG <= '0';
	end process P1;											
end architecture SR1_ARCHITECTURE;