library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity SUB is
	generic(
		NR_BITS: INTEGER:= 8
	);							
	port(
		FIRST_NUMBER:in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
		SECOND_NUMBER: in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
		RESULT: out STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);	   
		ZERO_FLAG: out STD_LOGIC;
		BORROW: out STD_LOGIC
	);						
end;

architecture SUB_ARCHITECTURE of SUB is

signal INTERMEDIAR_RESULT: STD_LOGIC_VECTOR(NR_BITS downto 0);

begin
	INTERMEDIAR_RESULT <= std_logic_vector(unsigned('0' & FIRST_NUMBER) - unsigned('0' & SECOND_NUMBER));
	RESULT <= INTERMEDIAR_RESULT(NR_BITS - 1 downto 0);
	BORROW <= INTERMEDIAR_RESULT(NR_BITS);		   
	
	process(FIRST_NUMBER, SECOND_NUMBER)
	variable INTERMEDIAR_RESULT_ZERO: STD_LOGIC_VECTOR(NR_BITS downto 0);  
	begin
		INTERMEDIAR_RESULT_ZERO := std_logic_vector(unsigned('0' & FIRST_NUMBER) - unsigned('0' & SECOND_NUMBER));
		if(INTERMEDIAR_RESULT_ZERO(NR_BITS - 1 downto 0) = "00000000") then
			ZERO_FLAG <= '1';
		else
			ZERO_FLAG <= '0';
		end if;
	end process;
end;