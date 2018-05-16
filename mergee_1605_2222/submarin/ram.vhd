library ieee;
use ieee.std_logic_1164.all;  
package type_r is
	type INTERNAL  is array (0 to 255)of STD_LOGIC_VECTOR (15 downto 0);	   
end package; 

library ieee;
use ieee.std_logic_1164.all;			   				
entity ram is
	port(ADDRESS:in integer range 0 to 255;
	OUTPUT:out STD_LOGIC_VECTOR(15 downto 0)
	); 
end;
use type_r.all;
architecture ram of ram is
begin
	process(ADDRESS)
	variable data: INTERNAL:=(
"0000000000001010",
"0100000100010000",
"0110000000000001",
"1100000100010011",
"1100001000000010",
"0000010100001111",
"0000010000010010",
"1100010101000001",
"0100000000001010",
"0100000100001010",
"1100000000010110",
"1101000000001110",
"1101000100000111",
	others => "0000000000000000" );
	
	begin
		OUTPUT<=data(ADDRESS);
	end process;
end;