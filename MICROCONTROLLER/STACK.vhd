library ieee;
use ieee.std_logic_1164.all;

entity STACK is
	port(A:in integer range 0 to 255;
	B:out integer range 0 to 255;
	UP:in BIT;
	DOWN:in BIT);
end;   		  
architecture STACK of STACK is 
type ARAY  is array (15 downto 0)of integer range 0 to 255;
signal data:ARAY;							 
begin 	   	
	process(UP,DOWN)
	variable num: Integer range 0 to 16:=0;
	variable full: STD_LOGIC:='0';
	variable empty: STD_LOGIC:='1';
	begin		
		if(UP='1' and full='0')then
			data(num)<=A;
			--B<=A;
			num:=num +1;
			empty:='0';
			if(num = 15)then
				full:='1';
			end if;
		elsif (DOWN='1' and empty='0')then
			num:=num -1; 
			B<=data(num);
			full:='0';
			if(num = 0)then
				empty:='1';
			end if;		
		end if;
	end process;
end;