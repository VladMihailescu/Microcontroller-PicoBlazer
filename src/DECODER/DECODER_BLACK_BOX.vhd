library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use types.all;

entity DECODER_BLACK_BOX is
	generic(
		NR_BITS: INTEGER := 8; 			 
		INSTRUCTION_BITS: INTEGER := 16
	);						   
	port(
		INSTRUCTION: in STD_LOGIC_VECTOR(INSTRUCTION_BITS - 1 downto 0);
		               
		CONSTANT_NUMBER: out STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
		REGISTER_FIRST_NUMBER: out INTEGER;	
		REGISTER_SECOND_NUMBER: out INTEGER;
		
		REG_ENABLE: out STD_LOGIC;				--0 - daca e jump/call etc 
		
		ALU_INPUT_SEL: out INTEGER;
		ALU_OUTPUT_SEL: out INTEGER;
		
		FLOW_MODE: out INTEGER;
		FLOW_LOAD: out INTEGER;
		
		FLOW_COND: out INTEGER;
		FLOW_SEL: out INTEGER;
		
		ZERO_FLAG: in STD_LOGIC;
		CARRY_FLAG: in STD_LOGIC
	);								
end entity DECODER_BLACK_BOX;					


architecture DECODER_BLACK_BOX_ARCHITECTURE of DECODER_BLACK_BOX is	 	  

signal LAST_CONSTANT_NUMBER: STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
signal LAST_REGISTER_FIRST_NUMBER: INTEGER;	
signal LAST_REGISTER_SECOND_NUMBER: INTEGER;

signal LAST_REG_ENABLE: STD_LOGIC;				--0 - daca e jump/call etc 
		
signal LAST_ALU_INPUT_SEL: INTEGER;
signal LAST_ALU_OUTPUT_SEL: INTEGER;


begin		  																							 
	MAIN_TAG:process(INSTRUCTION)
	variable FIRST_REGISTER_INTEGER: INTEGER := 0;
	variable SECOND_REGISTER_INTEGER: INTEGER := 0;
	variable FLOW_PARALLEL_LOAD: INTEGER := 0; 
	
	begin	   	
		if(INSTRUCTION(15 downto 13) = "100") then
			REG_ENABLE <= '0';
			FLOW_MODE <= 1;	 
			FLOW_PARALLEL_LOAD := 0;
			
			CONSTANT_NUMBER <= LAST_CONSTANT_NUMBER;
			REGISTER_FIRST_NUMBER <= LAST_REGISTER_FIRST_NUMBER;
			REGISTER_SECOND_NUMBER <= LAST_REGISTER_SECOND_NUMBER;
			ALU_INPUT_SEL <= LAST_ALU_INPUT_SEL;
			ALU_OUTPUT_SEL <= LAST_ALU_OUTPUT_SEL;
			
			if(INSTRUCTION(0)='1')then
				FLOW_PARALLEL_LOAD := 1;
			end if;	   
			if(INSTRUCTION(1)='1')then
				FLOW_PARALLEL_LOAD := FLOW_PARALLEL_LOAD + 2;
			end if;
			if(INSTRUCTION(2)='1')then
				FLOW_PARALLEL_LOAD := FLOW_PARALLEL_LOAD + 4;
			end if;
			if(INSTRUCTION(3)='1')then
				FLOW_PARALLEL_LOAD := FLOW_PARALLEL_LOAD + 8;
			end if;	
			if(INSTRUCTION(4)='1')then
				FLOW_PARALLEL_LOAD := FLOW_PARALLEL_LOAD + 16;
			end if;	   
			if(INSTRUCTION(5)='1')then
				FLOW_PARALLEL_LOAD := FLOW_PARALLEL_LOAD + 32;
			end if;
			if(INSTRUCTION(6)='1')then
				FLOW_PARALLEL_LOAD := FLOW_PARALLEL_LOAD + 64;
			end if;
			if(INSTRUCTION(7)='1')then
				FLOW_PARALLEL_LOAD := FLOW_PARALLEL_LOAD + 128;
			end if;	
			
			FLOW_LOAD <= FLOW_PARALLEL_LOAD;
			
			if(INSTRUCTION(12) = '0') then
				FLOW_COND <= 0;	  
			else
				FLOW_COND <= 1;	  
			end if;			  
			
			if(INSTRUCTION(11 downto 10) = "00") then
				FLOW_SEL <= 0;
				if(ZERO_FLAG = '0') then
					REG_ENABLE <= '1';
					FLOW_MODE <= 0;
				end if;
			end if;
			if(INSTRUCTION(11 downto 10) = "01") then
				FLOW_SEL <= 1;
				if(ZERO_FLAG = '1') then
					REG_ENABLE <= '1';
					FLOW_MODE <= 0;
				end if;
			end if;
			if(INSTRUCTION(11 downto 10) = "10") then
				FLOW_SEL <= 2;
				if(CARRY_FLAG = '0') then
					REG_ENABLE <= '1';
					FLOW_MODE <= 0;
				end if;
			end if;
			if(INSTRUCTION(11 downto 10) = "11") then
				FLOW_SEL <= 3;
				if(CARRY_FLAG = '1') then
					REG_ENABLE <= '1';
					FLOW_MODE <= 0;
				end if;
			end if;
		else			
			REG_ENABLE <= '1';
			FLOW_MODE <= 0;
			
			CONSTANT_NUMBER <= INSTRUCTION(7 downto 0);
			
			FIRST_REGISTER_INTEGER := 0;
			if(INSTRUCTION(8)='1')then
				FIRST_REGISTER_INTEGER := 1;
			end if;	   
			if(INSTRUCTION(9)='1')then
				FIRST_REGISTER_INTEGER := FIRST_REGISTER_INTEGER + 2;
			end if;
			if(INSTRUCTION(10)='1')then
				FIRST_REGISTER_INTEGER := FIRST_REGISTER_INTEGER + 4;
			end if;
			if(INSTRUCTION(11)='1')then
				FIRST_REGISTER_INTEGER := FIRST_REGISTER_INTEGER + 8;
			end if;	 									   
			
			SECOND_REGISTER_INTEGER := 0;
			if(INSTRUCTION(4)='1')then
				SECOND_REGISTER_INTEGER := 1;
			end if;	   
			if(INSTRUCTION(5)='1')then
				SECOND_REGISTER_INTEGER := SECOND_REGISTER_INTEGER + 2;
			end if;
			if(INSTRUCTION(6)='1')then
				SECOND_REGISTER_INTEGER := SECOND_REGISTER_INTEGER + 4;
			end if;
			if(INSTRUCTION(7)='1')then
				SECOND_REGISTER_INTEGER := SECOND_REGISTER_INTEGER + 8;
			end if;	 
			
			REGISTER_FIRST_NUMBER <= FIRST_REGISTER_INTEGER;
			REGISTER_SECOND_NUMBER <= SECOND_REGISTER_INTEGER; 
			
			LAST_CONSTANT_NUMBER <= INSTRUCTION(7 downto 0);
			LAST_REGISTER_FIRST_NUMBER <= FIRST_REGISTER_INTEGER;
			LAST_REGISTER_SECOND_NUMBER <= SECOND_REGISTER_INTEGER;
		
			if(INSTRUCTION(15 downto 12) = "0100") then                                        --add sX, kk
				ALU_OUTPUT_SEL <= 0;                                                           --add 0 entry in mux
				ALU_INPUT_SEL <= 1;                                                            --constant	
				REG_ENABLE <= '1';	 
				
				LAST_ALU_OUTPUT_SEL <= 0;
				LAST_ALU_INPUT_SEL <= 1;
			end if;	
			
			if(INSTRUCTION(15 downto 12) = "1100" and INSTRUCTION(3 downto 0) = "0100") then   --add sX, sY
				ALU_OUTPUT_SEL <= 0;                                                           --add 0 entry in mux
				ALU_INPUT_SEL <= 0;                                                            --register	
				REG_ENABLE <= '1';	 
				
				LAST_ALU_OUTPUT_SEL <= 0;
				LAST_ALU_INPUT_SEL <= 0;
			end if;																						 
			
		    if(INSTRUCTION(15 downto 12) = "0101") then                                        --addcy sX, kk
				ALU_OUTPUT_SEL <= 1;                                                           --addcy 1 entry in mux
				ALU_INPUT_SEL <= 1;                                                            --constant	
				REG_ENABLE <= '1';	 
				
				LAST_ALU_OUTPUT_SEL <= 1;
				LAST_ALU_INPUT_SEL <= 1;
			end if;	
			
			if(INSTRUCTION(15 downto 12) = "1100" and INSTRUCTION(3 downto 0) = "0101") then   --addcy sX, sY
				ALU_OUTPUT_SEL <= 1;                                                           --addcy 1 entry in mux
				ALU_INPUT_SEL <= 0;                                                            --register	
				REG_ENABLE <= '1';
				
				LAST_ALU_OUTPUT_SEL <= 1;
				LAST_ALU_INPUT_SEL <= 0;
			end if;					 
			
			if(INSTRUCTION(15 downto 12) = "0001") then                                        --and sX, kk
				ALU_OUTPUT_SEL <= 2;                                                           --and 2 entry in mux
				ALU_INPUT_SEL <= 1;                                                            --constant	
				REG_ENABLE <= '1';
				
				LAST_ALU_OUTPUT_SEL <= 2;
				LAST_ALU_INPUT_SEL <= 1;
			end if;	
			
			if(INSTRUCTION(15 downto 12) = "1100" and INSTRUCTION(3 downto 0) = "0001") then   --and sX, sY
				ALU_OUTPUT_SEL <= 2;                                                           --and 2 entry in mux
				ALU_INPUT_SEL <= 0;                                                            --register	
				REG_ENABLE <= '1';	 
				
				LAST_ALU_OUTPUT_SEL <= 2;
				LAST_ALU_INPUT_SEL <= 0;
			end if;	
			
			if(INSTRUCTION(15 downto 12) = "0010") then                                        --or sX, kk
				ALU_OUTPUT_SEL <= 3;                                                           --or 3 entry in mux
				ALU_INPUT_SEL <= 1;                                                            --constant	
				REG_ENABLE <= '1';	 
				
				LAST_ALU_OUTPUT_SEL <= 3;
				LAST_ALU_INPUT_SEL <= 1;
			end if;	
			
			if(INSTRUCTION(15 downto 12) = "1100" and INSTRUCTION(3 downto 0) = "0010") then   --or sX, sY
				ALU_OUTPUT_SEL <= 3;                                                           --or 3 entry in mux
				ALU_INPUT_SEL <= 0;                                                            --register	
				REG_ENABLE <= '1';	 
				
				LAST_ALU_OUTPUT_SEL <= 3;
				LAST_ALU_INPUT_SEL <= 0;
			end if;	   		   
			
			if(INSTRUCTION(15 downto 12) = "0110") then                                        --sub sX, kk
				ALU_OUTPUT_SEL <= 4;                                                           --sub 4 entry in mux
				ALU_INPUT_SEL <= 1;                                                            --constant	
				REG_ENABLE <= '1';	 
				
				LAST_ALU_OUTPUT_SEL <= 4;
				LAST_ALU_INPUT_SEL <= 1;
			end if;	
			
			if(INSTRUCTION(15 downto 12) = "1100" and INSTRUCTION(3 downto 0) = "0110") then   --sub sX, sY
				ALU_OUTPUT_SEL <= 4;                                                           --sub 4 entry in mux
				ALU_INPUT_SEL <= 0;                                                            --register	
				REG_ENABLE <= '1';	 
				
				LAST_ALU_OUTPUT_SEL <= 4;
				LAST_ALU_INPUT_SEL <= 0;
			end if;				   
			
			if(INSTRUCTION(15 downto 12) = "0111") then                                        --subcy sX, kk
				ALU_OUTPUT_SEL <= 5;                                                           --subcy 5 entry in mux
				ALU_INPUT_SEL <= 1;                                                            --constant	
				REG_ENABLE <= '1';	 
				
				LAST_ALU_OUTPUT_SEL <= 5;
				LAST_ALU_INPUT_SEL <= 1;
			end if;	
			
			if(INSTRUCTION(15 downto 12) = "1100" and INSTRUCTION(3 downto 0) = "0111") then   --subcy sX, sY
				ALU_OUTPUT_SEL <= 5;                                                           --subcy 5 entry in mux
				ALU_INPUT_SEL <= 0;                                                            --register	
				REG_ENABLE <= '1';	 
				
				LAST_ALU_OUTPUT_SEL <= 5;
				LAST_ALU_INPUT_SEL <= 0;
			end if;																					    
			
			if(INSTRUCTION(15 downto 12) = "0011") then                                        --xor sX, kk
				ALU_OUTPUT_SEL <= 6;                                                           --xor 6 entry in mux
				ALU_INPUT_SEL <= 1;                                                            --constant	
				REG_ENABLE <= '1';
			end if;	
			
			if(INSTRUCTION(15 downto 12) = "1100" and INSTRUCTION(3 downto 0) = "0011") then   --xor sX, sY
				ALU_OUTPUT_SEL <= 6;                                                           --xor 6 entry in mux
				ALU_INPUT_SEL <= 0;                                                            --register
				REG_ENABLE <= '1';	 
				
				LAST_ALU_OUTPUT_SEL <= 6;
				LAST_ALU_INPUT_SEL <= 0;
			end if;		
			
			if(INSTRUCTION(15 downto 12) = "1101" and INSTRUCTION(7 downto 0) = "00001110") then--sr0 sX
				ALU_OUTPUT_SEL <= 7;                                                           --sr0 7 entry in mux
				ALU_INPUT_SEL <= 1;                                                            --nu conteaza	
				REG_ENABLE <= '1';	 
				
				LAST_ALU_OUTPUT_SEL <= 7;
				LAST_ALU_INPUT_SEL <= 1;
			end if;		 	
			
			if(INSTRUCTION(15 downto 12) = "1101" and INSTRUCTION(7 downto 0) = "00001111") then--sr1 sX
				ALU_OUTPUT_SEL <= 8;                                                           --sr1 8 entry in mux
				ALU_INPUT_SEL <= 1;                                                            --nu conteaza	
				REG_ENABLE <= '1';
					 
				LAST_ALU_OUTPUT_SEL <= 8;
				LAST_ALU_INPUT_SEL <= 1;
			end if;	
			
			if(INSTRUCTION(15 downto 12) = "1101" and INSTRUCTION(7 downto 0) = "00001010") then--srX sX
				ALU_OUTPUT_SEL <= 9;                                                           --srX 9 entry in mux
				ALU_INPUT_SEL <= 1;                                                            --nu conteaza	
				REG_ENABLE <= '1';	 
				
				LAST_ALU_OUTPUT_SEL <= 9;
				LAST_ALU_INPUT_SEL <= 1;
			end if;			  
			
			if(INSTRUCTION(15 downto 12) = "1101" and INSTRUCTION(7 downto 0) = "00001000") then--srA sX
				ALU_OUTPUT_SEL <= 10;                                                           --srA 10 entry in mux
				ALU_INPUT_SEL <= 1;                                                             --nu conteaza	
				REG_ENABLE <= '1'; 	 
				
				LAST_ALU_OUTPUT_SEL <= 10;
				LAST_ALU_INPUT_SEL <= 1;
			end if;						 
			
			if(INSTRUCTION(15 downto 12) = "1101" and INSTRUCTION(7 downto 0) = "00001100") then--RR sX
				ALU_OUTPUT_SEL <= 11;                                                           --RR 11 entry in mux
				ALU_INPUT_SEL <= 1;                                                             --nu conteaza	
				REG_ENABLE <= '1';	 
				
				LAST_ALU_OUTPUT_SEL <= 11;
				LAST_ALU_INPUT_SEL <= 1;
			end if;	
			
			if(INSTRUCTION(15 downto 12) = "1101" and INSTRUCTION(7 downto 0) = "00000110") then--sl0 sX
				ALU_OUTPUT_SEL <= 12;                                                           --sl0 12 entry in mux
				ALU_INPUT_SEL <= 1;                                                             --nu conteaza	
				REG_ENABLE <= '1';	 
				
				LAST_ALU_OUTPUT_SEL <= 12;
				LAST_ALU_INPUT_SEL <= 1;
			end if;		 	
			
			if(INSTRUCTION(15 downto 12) = "1101" and INSTRUCTION(7 downto 0) = "00000111") then--sl1 sX
				ALU_OUTPUT_SEL <= 13;                                                           --sl1 13 entry in mux
				ALU_INPUT_SEL <= 1;                                                            --nu conteaza	
				REG_ENABLE <= '1';	 
				
				LAST_ALU_OUTPUT_SEL <= 13;
				LAST_ALU_INPUT_SEL <= 1;
			end if;	
			
			if(INSTRUCTION(15 downto 12) = "1101" and INSTRUCTION(7 downto 0) = "00000100") then--slX sX
				ALU_OUTPUT_SEL <= 14;                                                           --slX 14 entry in mux
				ALU_INPUT_SEL <= 1;                                                            --nu conteaza	
				REG_ENABLE <= '1';		 
				
				LAST_ALU_OUTPUT_SEL <= 14;
				LAST_ALU_INPUT_SEL <= 1;
			end if;			  
			
			if(INSTRUCTION(15 downto 12) = "1101" and INSTRUCTION(7 downto 0) = "00000000") then--slA sX
				ALU_OUTPUT_SEL <= 15;                                                           --slA 15 entry in mux
				ALU_INPUT_SEL <= 1;                                                             --nu conteaza	
				REG_ENABLE <= '1';	 
				
				LAST_ALU_OUTPUT_SEL <= 15;
				LAST_ALU_INPUT_SEL <= 1;
			end if;						 
			
			if(INSTRUCTION(15 downto 12) = "1101" and INSTRUCTION(7 downto 0) = "00000010") then--RL sX
				ALU_OUTPUT_SEL <= 16;                                                           --RL 16 entry in mux
				ALU_INPUT_SEL <= 1;                                                             --nu conteaza	
				REG_ENABLE <= '1';	 
				
				LAST_ALU_OUTPUT_SEL <= 16;
				LAST_ALU_INPUT_SEL <= 1;
			end if;	
			
			if(INSTRUCTION(15 downto 12) = "0000") then                                         --LOAD sX,kk
				ALU_OUTPUT_SEL <= 17;                                                           --LOAD 17 entry in mux
				ALU_INPUT_SEL <= 1;                                                             --constanta	
				REG_ENABLE <= '1';	 
				
				LAST_ALU_OUTPUT_SEL <= 17;
				LAST_ALU_INPUT_SEL <= 1;
			end if;																						   
			
			if(INSTRUCTION(15 downto 12) = "1100" and INSTRUCTION(3 downto 0) = "0000") then    --LOAD sX,sY
				ALU_OUTPUT_SEL <= 17;                                                           --LOAD 17 entry in mux
				ALU_INPUT_SEL <= 0;                                                             --nu conteaza	
				REG_ENABLE <= '1';	 
				
				LAST_ALU_OUTPUT_SEL <= 17;
				LAST_ALU_INPUT_SEL <= 0;
			end if;	
		end if;
	end process MAIN_TAG;										  
end architecture DECODER_BLACK_BOX_ARCHITECTURE;