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
"0000000000000011",
"0000000100000100",
"0100000100000001",
"0110000000000001",
"1001010100000010",
"0100000000001010",
	others => "0000000000000000" );
	
	begin
		OUTPUT<=data(ADDRESS);
	end process;
end;