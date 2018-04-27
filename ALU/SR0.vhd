library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity SR0 is
	generic(
		NR_BITS:INTEGER := 8
	);						 
	port(
		FIRST_NUMBER:in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
		RESULT:out STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);	
		ZERO_FLAG: out STD_LOGIC;
		CARRY_FLAG: out STD_LOGIC
	);
end entity SR0;					  

architecture SR0_ARCHITECTURE of SR0 is
begin													 
	P1:process(FIRST_NUMBER)
	variable AUXILIAR: STD_LOGIC;
	variable INTERMEDIAR_RESULT_ZERO: STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
	begin												   
		AUXILIAR := FIRST_NUMBER(0);
		RESULT <= '0' & FIRST_NUMBER(NR_BITS - 1 downto 1);
		CARRY_FLAG <= AUXILIAR;
		
		INTERMEDIAR_RESULT_ZERO := '0' & FIRST_NUMBER(NR_BITS - 1 downto 1);
		if(INTERMEDIAR_RESULT_ZERO = "00000000") then
			ZERO_FLAG <= '1';
		else
			ZERO_FLAG <= '0';
		end if;
	end process P1;											
end architecture SR0_ARCHITECTURE;