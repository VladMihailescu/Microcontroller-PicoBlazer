library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all;
use types.all;

entity FLAGS_BLACK_BOX is
	port(	   
		RESET: in STD_LOGIC;
		
		ZERO_FLAG: inout STD_LOGIC;
		CARRY_FLAG: inout STD_LOGIC
	);
end entity FLAGS_BLACK_BOX;

architecture FLAGS_BLACK_BOX_ARCHITECTURE of FLAGS_BLACK_BOX is
begin
	PROC_TAG:process(RESET, ZERO_FLAG, CARRY_FLAG)
	begin
		if(RESET = '1') then
			ZERO_FLAG <= '0';
			CARRY_FLAG <= '0';
		else
			ZERO_FLAG <= ZERO_FLAG;
			CARRY_FLAG <= CARRY_FLAG;
		end if;
	end process PROC_TAG;
end architecture FLAGS_BLACK_BOX_ARCHITECTURE;