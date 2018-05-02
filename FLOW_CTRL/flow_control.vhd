library ieee;
use ieee.std_logic_1164.all;  

entity f_ctrl is
	port(CONST:in STD_LOGIC_VECTOR(7 downto 0);
	JMP:in BIT;
	CALL:in BIT;
	EMPTY:in BIT;
	FULL:in BIT;
	RET:in BIT;
	UP:out BIT;
	DOWN:out BIT;			   
	INP:in integer range 0 to 255;
	OUTP:out integer range 0 to 255;
	LOAD:out BIT);
end;

architecture f_ctrl of f_ctrl is
begin
	process(CONST,JMP,CALL,RET)
	variable rez:integer range 0 to 255 :=0;  
	variable re:integer range 0 to 255 :=0; 
	begin
		if(CONST'EVENT)then
			rez:=0;
			if(CONST(0)='1')then
				rez:=1;
			end if;	   
			if(CONST(1)='1')then
				rez:=rez + 2;
			end if;
			if(CONST(2)='1')then
				rez:=rez + 4;
			end if;
			if(CONST(3)='1')then
				rez:=rez + 8;
			end if;	 
			if(CONST(4)='1')then
				rez:=rez + 16;
			end if;	   
			if(CONST(5)='1')then
				rez:=rez + 32;
			end if;
			if(CONST(6)='1')then
				rez:=rez + 64;
			end if;
			if(CONST(7)='1')then
				rez:=rez + 128;
			end if;	
		end if;	
		if(JMP='1' and JMP'EVENT)then
			OUTP<=rez after 1 ns;
			LOAD<='1' after 3 ns;
		elsif(JMP='0' and JMP'EVENT)then
			LOAD<='0' after 1 ns;
		end if;	 
		if(CALL='1' and CALL'EVENT and FULL='0')then
			UP<='1' after 1 ns;
			OUTP<=rez after 2 ns;
			LOAD<='1' after 3 ns;
		elsif(CALL='0' and CALL'EVENT)then 
			UP<='0' after 1 ns;
			LOAD<='0' after 2 ns;
		end if;
		if(RET='1' and RET'EVENT and EMPTY='0')then
			DOWN<='1'after 1 ns;
			re:=INP;
			OUTP<=re after 2 ns;
			LOAD<='1' after 3 ns;
		elsif(RET='0' and RET'EVENT)then 
			DOWN<='0'after 1 ns;
			LOAD<='0' after 2 ns;
		end if;	 
	end process;
end;
	
	