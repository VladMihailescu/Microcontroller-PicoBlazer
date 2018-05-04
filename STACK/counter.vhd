library ieee;
use ieee.std_logic_1164.all;

entity counter is
	port(UP:in BIT;
	DOWN:in BIT;  
	Y:out Integer range 0 to 15:=0);
end;
architecture counter of counter is
signal FULL: STD_LOGIC:='0';
signal EMPTY: STD_LOGIC:='1';
begin
	process(UP,DOWN)
	variable num: Integer range 0 to 16:=0;
	begin
		if(UP='1' and UP'EVENT and FULL='0')then
			num:=num +1;
			EMPTY<='0';
			if(num = 15)then
				FULL<='1';
			end if;
			Y<=num;
		elsif (DOWN='1' and DOWN'EVENT and EMPTY='0')then
			num:=num -1; 
			FULL<='0';
			if(num = 0)then
				EMPTY<='1';
			end if;
			Y<=num;	
		end if;
	end process;
end;