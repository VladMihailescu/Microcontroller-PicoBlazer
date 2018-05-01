library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity DELAY_BLACK_BOX is
	generic(
		NR_BITS: INTEGER := 8
	);
	
	port(
		CLK: in STD_LOGIC;
		INPUT: in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
		OUTPUT: out STD_LOGIC_VECTOR(NR_BITS - 1 downto 0)
	);
end entity DELAY_BLACK_BOX ;

architecture DELAY_BLACK_BOX_ARCHITECTURE of DELAY_BLACK_BOX is

--signal MEM:STD_LOGIC_VECTOR(NR_BITS - 1 downto 0) := "00000000";

begin
	process(CLK)
	begin
		if(CLK = '1' and CLK'EVENT) then
			OUTPUT <= INPUT;		
		end if;
	end process;
end architecture DELAY_BLACK_BOX_ARCHITECTURE;