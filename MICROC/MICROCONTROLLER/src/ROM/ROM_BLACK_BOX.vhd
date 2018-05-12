	library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all; 
use types.all;

entity ROM is
	generic(
		NR_ADDRESSES:INTEGER := 256;
		WORD_LEN: INTEGER:= 16
	);						   
	port(
		ADDRESS: in INTEGER;
		OUTPUT: out STD_LOGIC_VECTOR(WORD_LEN - 1 downto 0)
	);
end entity ROM;											  

architecture ROM_ARCHITECTURE of ROM is

signal ROM_MATRIX: matrix16(0 to NR_ADDRESSES) := 
(
"0000000000000000",
"0100000000010000",
"0110000000000101",
"0010000000000000",
"0011000000000001",
"1101000000001110",
"1101000000001111",
"1101000000001100",
"1101000000000111",
"1101000000000110",
"1101000000000010",
others => "0000000000000000"
);

begin 
	process(ADDRESS)		
	begin	
		if(ADDRESS >= 0 and ADDRESS < 256) then
			OUTPUT <= ROM_MATRIX(ADDRESS);		  
		else   
			OUTPUT <= ROM_MATRIX(0);
		end if;
	end process;
end architecture ROM_ARCHITECTURE;
