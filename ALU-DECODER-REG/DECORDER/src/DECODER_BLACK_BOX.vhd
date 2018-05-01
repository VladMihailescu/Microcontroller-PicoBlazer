library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity DECODER_BLACK_BOX is
	generic(
		NR_BITS: INTEGER := 8; 			 
		INSTRUCTION_BITS: INTEGER := 16
	);						   
	port(
		CLK: in STD_LOGIC;
		RESET: in STD_LOGIC;
		INSTRUCTION: in STD_LOGIC_VECTOR(INSTRUCTION_BITS - 1 downto 0);
		
		CONSTANT_NUMBER: out STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
		REGISTER_FIRST_NUMBER: out INTEGER;	
		REGISTER_SECOND_NUMBER: out INTEGER;
		
		REG_ENABLE: out STD_LOGIC;				--0 - daca e jump/call etc
		RESET_ALL: out STD_LOGIC;
		
		ALU_INPUT_SEL: out INTEGER;
		ALU_OUTPUT_SEL: out INTEGER
	);								
end entity DECODER_BLACK_BOX;					


architecture DECODER_BLACK_BOX_ARCHITECTURE of DECODER_BLACK_BOX is

component DEC_VECTOR_TO_INTEGER is
	generic(
		NR_BITS: INTEGER := 4
	);
	port(
		INPUT: in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);	
		OUTPUT: out INTEGER
	);	
end component DEC_VECTOR_TO_INTEGER;		  

begin		  																							 
	MAIN_TAG:process(CLK)
	variable FIRST_REGISTER_INTEGER: INTEGER := 0;
	variable SECOND_REGISTER_INTEGER: INTEGER := 0;
	begin	   
		if(CLK = '1' and CLK'EVENT) then
			RESET_ALL <= '0';
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
		
			if(INSTRUCTION(15 downto 12) = "0100") then                                        --add sX, kk
				ALU_OUTPUT_SEL <= 0;                                                           --add 0 entry in mux
				ALU_INPUT_SEL <= 1;                                                            --constant	
				REG_ENABLE <= '1';
			end if;	
			
			if(INSTRUCTION(15 downto 12) = "1100" and INSTRUCTION(3 downto 0) = "0100") then   --add sX, sY
				ALU_OUTPUT_SEL <= 0;                                                           --add 0 entry in mux
				ALU_INPUT_SEL <= 0;                                                            --register	
				REG_ENABLE <= '1';
			end if;																						 
			
		    if(INSTRUCTION(15 downto 12) = "0101") then                                        --addcy sX, kk
				ALU_OUTPUT_SEL <= 1;                                                           --addcy 1 entry in mux
				ALU_INPUT_SEL <= 1;                                                            --constant	
				REG_ENABLE <= '1';
			end if;	
			
			if(INSTRUCTION(15 downto 12) = "1100" and INSTRUCTION(3 downto 0) = "0101") then   --addcy sX, sY
				ALU_OUTPUT_SEL <= 1;                                                           --addcy 1 entry in mux
				ALU_INPUT_SEL <= 0;                                                            --register	
				REG_ENABLE <= '1';
			end if;					 
			
			if(INSTRUCTION(15 downto 12) = "0001") then                                        --and sX, kk
				ALU_OUTPUT_SEL <= 2;                                                           --and 2 entry in mux
				ALU_INPUT_SEL <= 1;                                                            --constant	
				REG_ENABLE <= '1';
			end if;	
			
			if(INSTRUCTION(15 downto 12) = "1100" and INSTRUCTION(3 downto 0) = "0001") then   --and sX, sY
				ALU_OUTPUT_SEL <= 2;                                                           --and 2 entry in mux
				ALU_INPUT_SEL <= 0;                                                            --register	
				REG_ENABLE <= '1';
			end if;	
			
			if(INSTRUCTION(15 downto 12) = "0010") then                                        --or sX, kk
				ALU_OUTPUT_SEL <= 3;                                                           --or 3 entry in mux
				ALU_INPUT_SEL <= 1;                                                            --constant	
				REG_ENABLE <= '1';
			end if;	
			
			if(INSTRUCTION(15 downto 12) = "1100" and INSTRUCTION(3 downto 0) = "0010") then   --or sX, sY
				ALU_OUTPUT_SEL <= 3;                                                           --or 3 entry in mux
				ALU_INPUT_SEL <= 0;                                                            --register	
				REG_ENABLE <= '1';
			end if;	   		   
			
			if(INSTRUCTION(15 downto 12) = "0110") then                                        --sub sX, kk
				ALU_OUTPUT_SEL <= 4;                                                           --sub 4 entry in mux
				ALU_INPUT_SEL <= 1;                                                            --constant	
				REG_ENABLE <= '1';
			end if;	
			
			if(INSTRUCTION(15 downto 12) = "1100" and INSTRUCTION(3 downto 0) = "0110") then   --sub sX, sY
				ALU_OUTPUT_SEL <= 4;                                                           --sub 4 entry in mux
				ALU_INPUT_SEL <= 0;                                                            --register	
				REG_ENABLE <= '1';
			end if;				   
			
			if(INSTRUCTION(15 downto 12) = "0111") then                                        --subcy sX, kk
				ALU_OUTPUT_SEL <= 5;                                                           --subcy 5 entry in mux
				ALU_INPUT_SEL <= 1;                                                            --constant	
				REG_ENABLE <= '1';
			end if;	
			
			if(INSTRUCTION(15 downto 12) = "1100" and INSTRUCTION(3 downto 0) = "0111") then   --subcy sX, sY
				ALU_OUTPUT_SEL <= 5;                                                           --subcy 5 entry in mux
				ALU_INPUT_SEL <= 0;                                                            --register	
				REG_ENABLE <= '1';
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
			end if;		
			
			if(INSTRUCTION(15 downto 12) = "1101" and INSTRUCTION(7 downto 0) = "00001110") then--sr0 sX
				ALU_OUTPUT_SEL <= 7;                                                           --sr0 7 entry in mux
				ALU_INPUT_SEL <= 1;                                                            --nu conteaza	
				REG_ENABLE <= '1';
			end if;		 	
			
			if(INSTRUCTION(15 downto 12) = "1101" and INSTRUCTION(7 downto 0) = "00001111") then--sr1 sX
				ALU_OUTPUT_SEL <= 8;                                                           --sr1 8 entry in mux
				ALU_INPUT_SEL <= 1;                                                            --nu conteaza	
				REG_ENABLE <= '1';
			end if;	
			
			if(INSTRUCTION(15 downto 12) = "1101" and INSTRUCTION(7 downto 0) = "00001010") then--srX sX
				ALU_OUTPUT_SEL <= 9;                                                           --srX 9 entry in mux
				ALU_INPUT_SEL <= 1;                                                            --nu conteaza	
				REG_ENABLE <= '1';
			end if;			  
			
			if(INSTRUCTION(15 downto 12) = "1101" and INSTRUCTION(7 downto 0) = "00001000") then--srA sX
				ALU_OUTPUT_SEL <= 10;                                                           --srA 10 entry in mux
				ALU_INPUT_SEL <= 1;                                                             --nu conteaza	
				REG_ENABLE <= '1';
			end if;						 
			
			if(INSTRUCTION(15 downto 12) = "1101" and INSTRUCTION(7 downto 0) = "00001100") then--RR sX
				ALU_OUTPUT_SEL <= 11;                                                           --RR 11 entry in mux
				ALU_INPUT_SEL <= 1;                                                             --nu conteaza	
				REG_ENABLE <= '1';
			end if;	
			
			if(INSTRUCTION(15 downto 12) = "1101" and INSTRUCTION(7 downto 0) = "00000110") then--sl0 sX
				ALU_OUTPUT_SEL <= 12;                                                           --sl0 12 entry in mux
				ALU_INPUT_SEL <= 1;                                                             --nu conteaza	
				REG_ENABLE <= '1';
			end if;		 	
			
			if(INSTRUCTION(15 downto 12) = "1101" and INSTRUCTION(7 downto 0) = "00000111") then--sl1 sX
				ALU_OUTPUT_SEL <= 13;                                                           --sl1 13 entry in mux
				ALU_INPUT_SEL <= 1;                                                            --nu conteaza	
				REG_ENABLE <= '1';
			end if;	
			
			if(INSTRUCTION(15 downto 12) = "1101" and INSTRUCTION(7 downto 0) = "00000100") then--slX sX
				ALU_OUTPUT_SEL <= 14;                                                           --slX 14 entry in mux
				ALU_INPUT_SEL <= 1;                                                            --nu conteaza	
				REG_ENABLE <= '1';
			end if;			  
			
			if(INSTRUCTION(15 downto 12) = "1101" and INSTRUCTION(7 downto 0) = "00000000") then--slA sX
				ALU_OUTPUT_SEL <= 15;                                                           --slA 15 entry in mux
				ALU_INPUT_SEL <= 1;                                                             --nu conteaza	
				REG_ENABLE <= '1';
			end if;						 
			
			if(INSTRUCTION(15 downto 12) = "1101" and INSTRUCTION(7 downto 0) = "00000010") then--RL sX
				ALU_OUTPUT_SEL <= 16;                                                           --RL 16 entry in mux
				ALU_INPUT_SEL <= 1;                                                             --nu conteaza	
				REG_ENABLE <= '1';
			end if;	
			
			if(INSTRUCTION(15 downto 12) = "0000") then                                         --LOAD sX,kk
				ALU_OUTPUT_SEL <= 17;                                                           --LOAD 17 entry in mux
				ALU_INPUT_SEL <= 1;                                                             --constanta	
				REG_ENABLE <= '1';
			end if;																						   
			
			if(INSTRUCTION(15 downto 12) = "1100" and INSTRUCTION(3 downto 0) = "0000") then    --LOAD sX,sY
				ALU_OUTPUT_SEL <= 17;                                                           --LOAD 17 entry in mux
				ALU_INPUT_SEL <= 0;                                                             --nu conteaza	
				REG_ENABLE <= '1';
			end if;	
		end if;
	end process MAIN_TAG;												 									 
end architecture DECODER_BLACK_BOX_ARCHITECTURE;