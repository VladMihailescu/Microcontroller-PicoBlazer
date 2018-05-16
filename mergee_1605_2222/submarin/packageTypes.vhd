library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all;

package types is 	
	type matrix8 is array (INTEGER range <>) of STD_LOGIC_VECTOR(7 downto 0);
	type matrix16 is array (INTEGER range <>) of STD_LOGIC_VECTOR(15 downto 0);
end package; 