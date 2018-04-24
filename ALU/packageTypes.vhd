library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

package types is 	
	type matrix is array (NATURAL range <>, NATURAL RANGE <>) of STD_LOGIC;
end package;