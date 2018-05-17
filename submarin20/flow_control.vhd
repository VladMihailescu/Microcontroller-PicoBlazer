library ieee;
use ieee.std_logic_1164.all;  

entity f_ctrl is
	port(CLK:in STD_LOGIC;
	CONST:in STD_LOGIC_VECTOR(7 downto 0);
	JMP:in STD_LOGIC;
	CALL:in BIT;
	RET:in BIT;			 
	CARRY:in STD_LOGIC;
	ZERO:in STD_LOGIC;
	S_FC:in STD_LOGIC_VECTOR(2 downto 0);
	UP:out BIT;
	DOWN:out BIT;			   
	INP:in integer range 0 to 255;
	OUTP:out integer range 0 to 255;
	LOAD:out BIT);
end;

architecture f_ctrl of f_ctrl is
begin
	process(CLK)
	variable rez:integer range 0 to 255 :=0;  
	--variable re:integer range 0 to 255 :=0; 
	begin 
		if(rising_edge(CLk)) then
			LOAD<='0';
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
		if(JMP='1' )then--and JMP'EVENT
			if(S_FC(2)='1')then
				case S_FC(1 downto 0) is
					when "00" =>
						if(ZERO='1')then 
							OUTP<=rez;
							LOAD<='1';--, '0' after 10 ns; 
						end if;
					when "01" =>
						if(ZERO='0')then 
							OUTP<=rez ;
							LOAD<='1';--, '0' after 10 ns; 
						end if;
					when "10" => 
						if(CARRY='1')then 
							OUTP<=rez ;
							LOAD<='1' ;--, '0' after 10 ns; 
						end if;
					when "11" =>
						if(CARRY='0')then 
							OUTP<=rez ;
							LOAD<='1' ;--, '0' after 10 ns; 
						end if;
					when others => null;
				end case;
			elsif(S_FC(2)='0')then 	
				OUTP<=rez;
				LOAD<='1';--, '0' after 10 ns;
			end if;
		--elsif(JMP='0' )then--and JMP'EVENT
--			LOAD<='0';
		end if;	 
		if(CALL='1' )then -- and CALL'EVENT
			if(S_FC(2)='1')then
				case S_FC(1 downto 0) is
					when "00" =>
						if(ZERO='1')then 
							UP<='1' ;--, '0' after 10ns;
							OUTP<=rez ;
							LOAD<='1';--, '0' after 10ns; 
						end if;
					when "01" =>
						if(ZERO='0')then 
							UP<='1';--, '0' after 10ns;
							OUTP<=rez;
							LOAD<='1';--, '0' after 10ns;
						end if;
					when "10" => 
						if(CARRY='1')then 
							UP<='1' ;--, '0' after 10ns;
							OUTP<=rez ;
							LOAD<='1';--, '0' after 10ns; 
						end if;
					when "11" =>
						if(CARRY='0')then 
							UP<='1' ;--, '0' after 10ns;
							OUTP<=rez;
							LOAD<='1';--, '0' after 10ns; 
						end if;
					when others => null;
				end case;
			elsif(S_FC(2)='0')then 	 
				UP<='1';--, '0' after 10ns;
				OUTP<=rez;
				LOAD<='1';--, '0' after 10ns;
			end if; 
		--elsif(CALL='0' )then --and CALL'EVENT
--			UP<='0';
--			LOAD<='0';
		end if;
		if(RET='1' )then	--and RET'EVENT
			if(S_FC(2)='1')then
				case S_FC(1 downto 0) is
					when "00" =>
						if(ZERO='1')then 
							DOWN<='1';--,'0' after 10ns;
							--re:=INP;
							OUTP<=INP + 1;	   
							LOAD<='1';--,'0' after 10ns;
						end if;
					when "01" =>
						if(ZERO='0')then 
							DOWN<='1';--,'0' after 10ns;
							--re:=INP;
							OUTP<=INP + 1;	   
							LOAD<='1';--,'0' after 10ns;
						end if;
					when "10" => 
						if(CARRY='1')then 
							DOWN<='1';--,'0' after 10ns;
							--re:=INP;
							OUTP<=INP + 1;	   	
							LOAD<='1';--,'0' after 10ns;
						end if;
					when "11" =>
						if(CARRY='0')then 
							DOWN<='1';--,'0' after 10ns;
							--re:=INP;
							OUTP<=INP + 1;	   
							LOAD<='1';--,'0' after 10ns; 
						end if;
					when others => null;
				end case;
			elsif(S_FC(2)='0')then 	 
				DOWN<='1';--,'0' after 10ns;
				--re:=INP;
				--wait for 10ns;
				OUTP<=INP + 1;
				LOAD<='1';--,'0' after 10ns;
			end if;
		--elsif(RET='0' )then --and RET'EVENT
--			DOWN<='0';
--			LOAD<='0';
		end if;
		--wait on CONST,JMP,CALL,RET; 
		end if;
	end process;
--	process(INP)
--	begin
--	end process;
end;
	
	