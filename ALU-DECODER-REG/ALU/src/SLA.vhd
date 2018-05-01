library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity SLAA is
	generic(
		NR_BITS:INTEGER := 8
	);						 
	port(
		FIRST_NUMBER:in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
		CARRY_IN: in STD_LOGIC;
		RESULT:out STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);	
		ZERO_FLAG: out STD_LOGIC;
		CARRY_OUT: out STD_LOGIC
	);
end entity SLAA;					  

architecture SLAA_ARCHITECTURE of SLAA is
begin													 
	P1:process(FIRST_NUMBER)
	variable AUXILIAR: STD_LOGIC;
	variable INTERMEDIAR_RESULT_ZERO: STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
	begin												   
		AUXILIAR := FIRST_NUMBER(NR_BITS - 1);
		RESULT <= FIRST_NUMBER(NR_BITS - 2 downto 0) & CARRY_IN;
		CARRY_OUT <= AUXILIAR;
		
		INTERMEDIAR_RESULT_ZERO := FIRST_NUMBER(NR_BITS - 2 downto 0) & CARRY_IN;
		if(INTERMEDIAR_RESULT_ZERO = "00000000") then
			ZERO_FLAG <= '1';
		else
			ZERO_FLAG <= '0';
		end if;
	end process P1;											
end architecture SLAA_ARCHITECTURE;