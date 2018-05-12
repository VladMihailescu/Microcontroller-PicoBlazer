library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all; 
use types.all;

entity D is
	generic(
		NR_BITS: INTEGER := 8
	);						   
	port(						
		CLK: in STD_LOGIC;
		D: in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0); 
		RESET: in STD_LOGIC;
	
		Q: out STD_LOGIC_VECTOR(NR_BITS - 1 downto 0)
	);
end entity D;											  

architecture D_ARCHITECTURE of D is

begin
	process(CLK,RESET)
	begin
		if(RESET = '1') then
			Q <= "00000000";
		end if;
		if(rising_edge(CLK)) then
			Q <= D;
		end if;
	end process;

end architecture D_ARCHITECTURE;
