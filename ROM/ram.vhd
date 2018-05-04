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
	"0000000000000000",
	"1000110100000101",
	"0000000100000000",
	"1000110010000000",
	"0000000000000000",
	"0000000100000000",
	"0100000100100011",
	"1000111100000010",
	others => "0000000000000000" );
	
	begin
		OUTPUT<=data(ADDRESS);
	end process;
end;