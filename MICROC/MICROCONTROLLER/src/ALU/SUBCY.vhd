library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity SUBCY is
	generic(
		NR_BITS: INTEGER := 8
	);						  
	port(
		FIRST_NUMBER: in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
		SECOND_NUMBER: in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
		BORROW: inout STD_LOGIC; 						  
		ZERO_FLAG: out STD_LOGIC;
		RESULT: out STD_LOGIC_VECTOR(NR_BITS - 1 downto 0)
	);
end;													  
								  
architecture SUBCY_ARCHITECTURE of SUBCY is

signal INTERMEDIAR_RESULT: STD_LOGIC_VECTOR(NR_BITS downto 0);

begin
	INTERMEDIAR_RESULT <= std_logic_vector(unsigned('0' & FIRST_NUMBER) - unsigned('0' & SECOND_NUMBER) - unsigned("00000000" & BORROW));
	RESULT <= INTERMEDIAR_RESULT(NR_BITS - 1 downto 0);
	BORROW <= INTERMEDIAR_RESULT(NR_BITS);
	
	process(FIRST_NUMBER, SECOND_NUMBER, BORROW)
	variable INTERMEDIAR_RESULT_ZERO: STD_LOGIC_VECTOR(NR_BITS downto 0);  
	begin
		INTERMEDIAR_RESULT_ZERO := std_logic_vector(unsigned('0' & FIRST_NUMBER) - unsigned('0' & SECOND_NUMBER) - unsigned("00000000" & BORROW));
		if(INTERMEDIAR_RESULT_ZERO(NR_BITS - 1 downto 0) = "00000000") then
			ZERO_FLAG <= '1';
		else
			ZERO_FLAG <= '0';
		end if;
	end process;
end;