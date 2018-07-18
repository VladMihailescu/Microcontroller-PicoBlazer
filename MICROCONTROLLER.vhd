library ieee;
use ieee.std_logic_1164.all;
use types.all;				  

entity MICROCONTROLLER_BLACK_BOX is
	port(						
		RESET: in STD_LOGIC; 
		REG_MATRIX: out matrix8(15 downto 0); 	   	
		CLK	:in STD_LOGIC;
		INTER:in BIT;
		OUTPUT1:out integer range 0 to 255;
		OUTPUT2:out integer range 0 to 255
	);	 
end;  		  

use types.all;
architecture MICROCONTROLLER_BLACK_BOX of MICROCONTROLLER_BLACK_BOX is   
---------------------------------------------------------------------------------------------------------
component REGISTERS_BLACK_BOX is
	generic(
		NR_BITS: INTEGER:= 8;
		NR_OF_REGISTERS: INTEGER:= 16
	);
	port(	   
		RESET: in STD_LOGIC;
		ENABLE: in STD_LOGIC;
		CLK: in STD_LOGIC;
		
		REGISTER_UPDATE_INPUT: in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
		
		FIRST_MUX_SEL: in INTEGER;
		SECOND_MUX_SEL: in INTEGER;
		
		FIRST_REGISTER_OUT: out STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
		SECOND_REGISTER_OUT: out STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
		
		REGISTER_MATRIX_OUT: out matrix8(15 downto 0)
	);
end component REGISTERS_BLACK_BOX;	
---------------------------------------------------------------------------------------------------------

component CLK_DIVIDER is
	port(
		CLK: in STD_LOGIC;
		CLK_REGISTER: out STD_LOGIC;
		CLK_FLOW: out STD_LOGIC;
		CLK_COUNTER: out BIT
	);
end component CLK_DIVIDER;	   
---------------------------------------------------------------------------------------------------------

component ALU_BLACK_BOX is										  
	generic(
		NR_BITS: INTEGER := 8;
		INPUT_MUX_SEL_NUMBER: INTEGER := 2;
		OUTPUT_MUX_SEL_NUMBER: INTEGER := 18
	);
	port( 
		FIRST_REGISTER_INPUT: in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
		SECOND_REGISTER_INPUT: in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
		CONSTANT_INPUT: in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0); 
		
		SEL_MUX_INPUT: in INTEGER;	 					--muxul care alege registru/constanta
		SEL_MUX_OUTPUT: in INTEGER;	    				--muxul care alege operatia care iese
		
		ZERO_FLAG: out STD_LOGIC;
		CARRY_FLAG: out STD_LOGIC;
		
		RESULT_OUTPUT: out STD_LOGIC_VECTOR(NR_BITS - 1 downto 0)
	);
end component ALU_BLACK_BOX; 									  
---------------------------------------------------------------------------------------------------
component DECODER 
	port(A:in STD_LOGIC_VECTOR(15 downto 0);			--instructiune 16 biti 	   
	--------------------------------------------------------
	JMP:out STD_LOGIC:='0';								--semnal call
	CALL:out BIT:='0';									--semnal jump
	RET:out BIT:='0';									--semnal return	
	S_FC:out STD_LOGIC_VECTOR(2 downto 0);				--selectie FC
	RESET:in STD_LOGIC; 								--semnal reset(nefolosit)	
	INT_FLAG:out STD_LOGIC;
	FLOW_CONSTANT:out STD_LOGIC_VECTOR(7 downto 0);									     
	--------------------------------------------------------
	REGISTER_FIRST_NUMBER: out INTEGER;	   				--selectie in/out registru	 
	REGISTER_SECOND_NUMBER: out INTEGER;   				--selectie out2 registru		
	REG_ENABLE: out STD_LOGIC;							--0 - daca e jump/call etc 	  
	ALU_INPUT_SEL: out INTEGER;							--							 
	ALU_OUTPUT_SEL: out INTEGER;						--							 	 
	ALU_CONSTANT:out STD_LOGIC_VECTOR(7 downto 0);		--date constante  
	--------------------------------------------------------
	PORT_ID_TOOGLE:out STD_LOGIC; 
	PORT_IN_OUT_TOOGLE:out STD_LOGIC;  
	PORT_CONSTANT:out STD_LOGIC_VECTOR(7 downto 0)
	);			   
end component;
---------------------------------------------------------------------------------------------------------
component ROM  										    --ram
	port(ADDRESS:in integer range 0 to 255;
	OUTPUT:out STD_LOGIC_VECTOR(15 downto 0)
	); 
end component; 	  					   		  				  
---------------------------------------------------------------------------------------------------------
component PROGRAM_COUNTER 								--p_counter
	port(ADDRESS:in integer range 0 to 255;			 
	RESET: in STD_LOGIC; 
	INP:in integer range 0 to 255;
	LOAD:in BIT;
	LOADR:in BIT;
	CLK:in BIT;
	OUTPUT:out integer range 0 to 255;
	OUTPUT_STACK:out integer range 0 to 255
	);
end component; 
---------------------------------------------------------------------------------------------------------
							 					
component STACK 										--stack
	port(A:in integer range 0 to 255;
	B:out integer range 0 to 255;
	UP:in BIT;
	DOWN:in BIT);
end component; 
---------------------------------------------------------------------------------------------------------
component FLOW_CONTROL 									--f_ctrl
	port(CLK:in STD_LOGIC;
	CONST:in STD_LOGIC_VECTOR(7 downto 0);
	JMP:in STD_LOGIC;
	CALL:in BIT;
	INT:in BIT;
	RET:in BIT;			 
	CARRY:in STD_LOGIC;
	ZERO:in STD_LOGIC;
	S_FC:in STD_LOGIC_VECTOR(2 downto 0);
	UP:out BIT;
	DOWN:out BIT;			   	 
	OUTP:out integer range 0 to 255;
	LOAD:out BIT;
	LOADR:out BIT);
end component; 	   
--------------------------------------------------------------------------------------------------------- 
component INTERRUPT_CONTROL 
	port(INTERRUPT:in BIT;
	INT_FLAG:in std_logic;
	INT:out BIT);
end component;																		 
--------------------------------------------------------------------------------------------------------- 
component PORT_CONTROL 
	port(CONST_IN:in STD_LOGIC_VECTOR(7 downto 0);
		ENABLE:in STD_LOGIC; 
		REG_IN:in STD_LOGIC_VECTOR(7 downto 0);
		CONST_REG_SEL:in STD_LOGIC;
		IN_OUT_SEL:in STD_LOGIC;
		SEL_OUTPUT:out STD_LOGIC_VECTOR(7 downto 0);
		SEL_INPUT:out STD_LOGIC_VECTOR(7 downto 0)
	);
end component;																  
--------------------------------------------------------------------------------------------------------- 
signal COUNT1: integer range 0 to 255;
signal O_STACK: integer range 0 to 255;	 
signal S_OUTPUT,S_INPUT: STD_LOGIC_VECTOR(7 downto 0);
signal INSTRUCTION1: STD_LOGIC_VECTOR(15 downto 0);	   
signal LOAD1,LOADR1: BIT; 
signal ADDRES1: integer range 0 to 255;
signal UP1: BIT;
signal DOWN1: BIT;		 
signal INP1: integer range 0 to 255;	 
signal CONSTANT_FLOW: STD_LOGIC_VECTOR(7 downto 0);
signal CONSTANT_ALU: STD_LOGIC_VECTOR(7 downto 0);
signal CONSTANT_PORT: STD_LOGIC_VECTOR(7 downto 0);	
signal JUMP1: STD_LOGIC; 
signal INT1:  BIT;
signal CALL1: BIT;
signal RETRN1: BIT;
signal SEL_FLOW_CONTROL: STD_LOGIC_VECTOR(2 downto 0);	
signal CLK_REGISTER: STD_LOGIC;	
signal CLK_FL: STD_LOGIC;
signal CLK_COUNTER: BIT; 
signal DECODER_REGISTER_FIRST_NUMBER: INTEGER;
signal DECODER_REGISTER_SECOND_NUMBER: INTEGER;
signal DECODER_REG_ENABLE,DECODER_PORT_ENABLE: STD_LOGIC := '1';
signal DECODER_ALU_INPUT_SEL: INTEGER;
signal DECODER_ALU_OUTPUT_SEL: INTEGER;	
signal FLAGS_ZERO_FLAG: STD_LOGIC := '0';
signal FLAGS_CARRY_FLAG: STD_LOGIC := '0';	 
signal FLAGS_INTERRUPT_FLAG: STD_LOGIC := '0';
signal ALU_RESULT_OUTPUT: STD_LOGIC_VECTOR(7 downto 0);
signal REGISTER_FIRST_REGISTER_OUT: STD_LOGIC_VECTOR(7 downto 0);
signal REGISTER_SECOND_REGISTER_OUT: STD_LOGIC_VECTOR(7 downto 0);
signal PORT_INOUT,PORT_REG_CONST: STD_LOGIC;
---------------------------------------------------------------------------------------------------------
begin 
	L1: ROM port map(
		COUNT1,
		INSTRUCTION1
	);
	L2: PROGRAM_COUNTER port map(
		ADDRES1,
		RESET,
		INP1,
		LOAD1,
		LOADR1,
		CLK_COUNTER,
		COUNT1,
		O_STACK
	);
		OUTPUT1<=count1;
		OUTPUT2<=inp1; 
		
	L3: DECODER port map(
		INSTRUCTION1,
		JUMP1,
		CALL1,
		RETRN1,
		SEL_FLOW_CONTROL,
		RESET,
		FLAGS_INTERRUPT_FLAG,
		CONSTANT_FLOW,
		DECODER_REGISTER_FIRST_NUMBER,
		DECODER_REGISTER_SECOND_NUMBER,
		DECODER_REG_ENABLE,
		DECODER_ALU_INPUT_SEL,
		DECODER_ALU_OUTPUT_SEL,
		CONSTANT_ALU,
		PORT_INOUT,
		PORT_REG_CONST,
		CONSTANT_PORT
		);	
	L7: ALU_BLACK_BOX port map(
		REGISTER_FIRST_REGISTER_OUT,
		REGISTER_SECOND_REGISTER_OUT,
		CONSTANT_ALU,
		DECODER_ALU_INPUT_SEL,
		DECODER_ALU_OUTPUT_SEL,
		FLAGS_ZERO_FLAG,
		FLAGS_CARRY_FLAG,
		ALU_RESULT_OUTPUT
	);
	L8: REGISTERS_BLACK_BOX port map(
		RESET,
		DECODER_REG_ENABLE,
		CLK_REGISTER,
		ALU_RESULT_OUTPUT,
		DECODER_REGISTER_FIRST_NUMBER,
		DECODER_REGISTER_SECOND_NUMBER,
		REGISTER_FIRST_REGISTER_OUT,
		REGISTER_SECOND_REGISTER_OUT,
		REG_MATRIX
	);
	L9: PORT_CONTROL port map(
		CONSTANT_PORT,
		DECODER_PORT_ENABLE,
		REGISTER_SECOND_REGISTER_OUT,
		PORT_REG_CONST,
		PORT_INOUT,
		S_OUTPUT,
		S_INPUT
	);
	L4: STACK port map(
		O_STACK,
		INP1,
		UP1,
		DOWN1
	); 
	L5: FLOW_CONTROL port map(
		CLK_FL,
		CONSTANT_FLOW,
		JUMP1,
		CALL1,
		INT1,
		RETRN1,
		FLAGS_CARRY_FLAG,
		FLAGS_ZERO_FLAG,
		SEL_FLOW_CONTROL,
		UP1,
		DOWN1,
		ADDRES1,
		LOAD1,
		LOADR1
	); 
	L6: CLK_DIVIDER port map(
		CLK,
		CLK_REGISTER,
		CLK_FL,
		CLK_COUNTER
	);	 
	L10: INTERRUPT_CONTROL port map(
		INTER,
		FLAGS_INTERRUPT_FLAG,
		INT1
	);
end;	  	