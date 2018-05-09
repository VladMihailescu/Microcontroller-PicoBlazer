library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all; 
use types.all;					 			  

entity CLK_DIVIDER is
	port(
		CLK: in STD_LOGIC;
		CLK_REGISTER: out STD_LOGIC;
		CLK_COUNTER: out STD_LOGIC
	);
end entity CLK_DIVIDER;


architecture CLK_DIVIDER_ARCHITECTURE of CLK_DIVIDER is

signal STATUS: INTEGER := 0;

begin
	process(CLK)
			
	begin
		if(rising_edge(CLK)) then
			if(STATUS = 0) then
				CLK_REGISTER <= '1';
				CLK_COUNTER <= '0';
				STATUS <= 1;
			end if;
			if(STATUS = 1) then
			 	CLK_REGISTER <= '0';
				CLK_COUNTER <= '1';
				STATUS <= 0;
			end if;
		else
			if(CLK = '0') then
				CLK_REGISTER <= '0';
				CLK_COUNTER <= '0';
			end if;
		end if;
	end process;
end architecture CLK_DIVIDER_ARCHITECTURE;