library ieee;
use ieee.std_logic_1164.all;  
--warning nu stiu daca merge
entity f_ctrl is
	port(CONST:in STD_LOGIC_VECTOR(7 downto 0);
	JMP:in BIT;
	CALL:in BIT;
	RET:in BIT;
	EMPTY:in BIT;
	FULL:in BIT; 
	CARRY:inout BIT;
	ZERO:inout BIt;
	S_FC:in STD_LOGIC_VECTOR(2 downto 0);
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
			if(S_FC(2)='1')then
				case S_FC(1 downto 0) is
					when "00" =>
						if(ZERO='1')then 
							OUTP<=rez after 1 ns;
							LOAD<='1' after 3 ns, '0' after 10 ns; 
						end if;
					when "01" =>
						if(ZERO='0')then 
							OUTP<=rez after 1 ns;
							LOAD<='1' after 3 ns, '0' after 10 ns; 
						end if;
					when "10" => 
						if(CARRY='1')then 
							OUTP<=rez after 1 ns;
							LOAD<='1' after 3 ns, '0' after 10 ns; 
						end if;
					when "11" =>
						if(CARRY='0')then 
							OUTP<=rez after 1 ns;
							LOAD<='1' after 3 ns, '0' after 10 ns; 
						end if;
					when others => null;
				end case;
			elsif(S_FC(2)='0')then 	
				OUTP<=rez after 1 ns;
				LOAD<='1' after 3 ns, '0' after 10 ns;
			end if;		 
		--elsif(JMP='0' and JMP'EVENT)then
			--LOAD<='0' after 1 ns;
		end if;	 
		if(CALL='1' and CALL'EVENT and FULL='0')then 
			if(S_FC(2)='1')then
				case S_FC(1 downto 0) is
					when "00" =>
						if(ZERO='1')then 
							UP<='1' after 1 ns, '0' after 10ns;
							OUTP<=rez after 2 ns;
							LOAD<='1' after 3 ns, '0' after 10ns; 
						end if;
					when "01" =>
						if(ZERO='0')then 
							UP<='1' after 1 ns, '0' after 10ns;
							OUTP<=rez after 2 ns;
							LOAD<='1' after 3 ns, '0' after 10ns;
						end if;
					when "10" => 
						if(CARRY='1')then 
							UP<='1' after 1 ns, '0' after 10ns;
							OUTP<=rez after 2 ns;
							LOAD<='1' after 3 ns, '0' after 10ns; 
						end if;
					when "11" =>
						if(CARRY='0')then 
							UP<='1' after 1 ns, '0' after 10ns;
							OUTP<=rez after 2 ns;
							LOAD<='1' after 3 ns, '0' after 10ns; 
						end if;
					when others => null;
				end case;
			elsif(S_FC(2)='0')then 	 
				UP<='1' after 1 ns, '0' after 10ns;
				OUTP<=rez after 2 ns;
				LOAD<='1' after 3 ns, '0' after 10ns;
			end if; 
		--elsif(CALL='0' and CALL'EVENT)then 
			--UP<='0' after 1 ns;
			--LOAD<='0' after 2 ns;
		end if;
		if(RET='1' and RET'EVENT and EMPTY='0')then	
			if(S_FC(2)='1')then
				case S_FC(1 downto 0) is
					when "00" =>
						if(ZERO='1')then 
							DOWN<='1'after 1 ns,'0' after 10ns;
							re:=INP;
							OUTP<=re after 2 ns;
							LOAD<='1' after 3 ns,'0' after 10ns;
						end if;
					when "01" =>
						if(ZERO='0')then 
							DOWN<='1'after 1 ns,'0' after 10ns;
							re:=INP;
							OUTP<=re after 2 ns;
							LOAD<='1' after 3 ns,'0' after 10ns;
						end if;
					when "10" => 
						if(CARRY='1')then 
							DOWN<='1'after 1 ns,'0' after 10ns;
							re:=INP;
							OUTP<=re after 2 ns;
							LOAD<='1' after 3 ns,'0' after 10ns;
						end if;
					when "11" =>
						if(CARRY='0')then 
							DOWN<='1'after 1 ns,'0' after 10ns;
							re:=INP;
							OUTP<=re after 2 ns;
							LOAD<='1' after 3 ns,'0' after 10ns; 
						end if;
					when others => null;
				end case;
			elsif(S_FC(2)='0')then 	 
				DOWN<='1'after 1 ns,'0' after 10ns;
				re:=INP;
				OUTP<=re after 2 ns;
				LOAD<='1' after 3 ns,'0' after 10ns;
			end if; 
		--elsif(RET='0' and RET'EVENT)then 
			--DOWN<='0'after 1 ns;
			--LOAD<='0' after 2 ns;
		end if;	 
	end process;
end;
	
	
