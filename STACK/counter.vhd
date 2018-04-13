entity counter is
	port(UP:in BIT;
	DOWN:in BIT;  
	FULL:inout BIT;
	EMPTY:inout BIT:='1';
	Y:out Integer range 0 to 16:=0);
end;
architecture counter of counter is
begin
	process(UP,DOWN)
	variable num: Integer range 0 to 16:=0;
	begin
		if(UP='1' and UP'EVENT and FULL='0')then
			num:=num +1;
			EMPTY<='0';
			if(num = 16)then
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