library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

package types is 	
	type matrix is array (NATURAL range <>) of STD_LOGIC_VECTOR(7 downto 0);
end package;