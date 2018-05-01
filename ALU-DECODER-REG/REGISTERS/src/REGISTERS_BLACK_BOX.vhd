library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use types.all;

entity REGISTERS_BLACK_BOX is
	generic(
		NR_BITS: INTEGER:= 8;
		NR_OF_REGISTERS: INTEGER:= 16
	);
	port(	   
		RESET: in STD_LOGIC;
		ENABLE: in STD_LOGIC;
		CLK: in STD_LOGIC;
		
		REGISTER_UPDATE_INPUT: in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
		
		FIRST_MUX_SEL: in INTEGER;
		SECOND_MUX_SEL: in INTEGER;
		
		FIRST_REGISTER_OUT: out STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
		SECOND_REGISTER_OUT: out STD_LOGIC_VECTOR(NR_BITS - 1 downto 0)
		
	);
end entity REGISTERS_BLACK_BOX;

architecture REGISTERS_BLACK_BOX_ARCHITECTURE of REGISTERS_BLACK_BOX is

signal REGISTERS_MATRIX: matrix(NR_OF_REGISTERS - 1 downto 0) := 
("00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000");													

begin		 			
	
	MAIN_TAG:process(RESET, CLK)
	variable FIRST: INTEGER := 0;
	variable SECOND: INTEGER := 0;
	variable FIRST_VALUE: STD_LOGIC_VECTOR(NR_BITS - 1 downto 0) := "00000000";
	variable SECOND_VALUE: STD_LOGIC_VECTOR(NR_BITS - 1 downto 0) := "00000000";
	variable UPDATE_VALUE: STD_LOGIC_VECTOR(NR_BITS - 1 downto 0) := "00000000";
	begin			   
		if(CLK = '1' and CLK'EVENT) then
			FIRST := FIRST_MUX_SEL;
			SECOND := SECOND_MUX_SEL;
			
			
			if(FIRST >= 0 and FIRST < NR_OF_REGISTERS) then
				FIRST_VALUE := REGISTERS_MATRIX(FIRST);
			end if;
			if(SECOND >= 0 and SECOND < NR_OF_REGISTERS) then
				SECOND_VALUE := REGISTERS_MATRIX(SECOND);
			end if;						  
			
			UPDATE_VALUE := REGISTER_UPDATE_INPUT;
			
			FIRST_REGISTER_OUT <= FIRST_VALUE;
			SECOND_REGISTER_OUT <= SECOND_VALUE;  
			if(FIRST >= 0 and FIRST < NR_OF_REGISTERS) then
				REGISTERS_MATRIX(FIRST) <= UPDATE_VALUE;  
			end if;
		end if;
	end process MAIN_TAG;					   
	
end architecture REGISTERS_BLACK_BOX_ARCHITECTURE;