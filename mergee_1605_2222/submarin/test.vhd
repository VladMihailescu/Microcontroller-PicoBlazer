library ieee;
use ieee.std_logic_1164.all;
use types.all;
entity test01 is
	port(						
		RESET: in STD_LOGIC; 
		REG_MATRIX: out matrix8(15 downto 0);
--	CARRY:inout STD_LOGIC;
--	ZERO:inout STD_LOGIC;
--	ADDRESS:in integer range 0 to 255;
--	RESET:out STD_LOGIC;
--	S_MUX:out STD_LOGIC;  
--	S_PORT:out STD_LOGIC_VECTOR(7 downto 0);
--	S_REG:out BIT;
--	SEL1:out STD_LOGIC_VECTOR(3 downto 0);	 
--	SEL2:out STD_LOGIC_VECTOR(3 downto 0); 
--	S_ALU:out STD_LOGIC_VECTOR(3 downto 0);		   	
	CLK:in STD_LOGIC;
	OUTPUT:out integer range 0 to 255);
end;  
use types.all;
architecture test01 of test01 is 
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

component CLK_DIVIDER is
	port(
		CLK: in STD_LOGIC;
		CLK_REGISTER: out STD_LOGIC;
		CLK_COUNTER: out BIT
	);
end component CLK_DIVIDER;

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
		
		SEL_MUX_INPUT: in INTEGER;	 	--muxul care alege registru/constanta
		SEL_MUX_OUTPUT: in INTEGER;	    --muxul care alege operatia care iese
		
		ZERO_FLAG: inout STD_LOGIC;
		CARRY_FLAG: inout STD_LOGIC;
		
		RESULT_OUTPUT: out STD_LOGIC_VECTOR(NR_BITS - 1 downto 0)
	);
end component ALU_BLACK_BOX; 
component decoder										 --decoder
		port(A:in STD_LOGIC_VECTOR(15 downto 0);--instructiune 16 biti 	   x
			JMP:out STD_LOGIC:='0';							--semnal call
			CALL:out BIT:='0';							--semnal jump
			RET:out BIT:='0';							--semnal return	
			S_FC:out STD_LOGIC_VECTOR(2 downto 0);	--selectie FC
			RESET:in STD_LOGIC; 					--semnal reset(nefolosit)
			REGISTER_FIRST_NUMBER: out INTEGER;	   --selectie in/out registru	  x
			REGISTER_SECOND_NUMBER: out INTEGER;   --selectie out2 registru		  x
			REG_ENABLE: out STD_LOGIC;				--0 - daca e jump/call etc 	  x
			ALU_INPUT_SEL: out INTEGER;				--							  x?
			ALU_OUTPUT_SEL: out INTEGER;			--							  x?
			CONST:out STD_LOGIC_VECTOR(7 downto 0)	--date constante	 		  x
);							   
end component;

component ram  										     --ram
	port(ADDRESS:in integer range 0 to 255;
	OUTPUT:out STD_LOGIC_VECTOR(15 downto 0)
	); 
end component; 	  

component p_counter 									 --p_counter
	port(ADDRESS:in integer range 0 to 255;
	LOAD:in BIT;
	CLK:in BIT;
	OUTPUT:out integer range 0 to 255);
end component;

component stack 										 --stack
	port(A:in integer range 0 to 255;
	B:out integer range 0 to 255;
	UP:in BIT;
	DOWN:in BIT);
end component; 

component f_ctrl  										  --f_ctrl
	port(CONST:in STD_LOGIC_VECTOR(7 downto 0);
	JMP:in STD_LOGIC;
	CALL:in BIT;
	RET:in BIT;		   	  
	CARRY:inout STD_LOGIC;
	ZERO:inout STD_LOGIC;
	S_FC:in STD_LOGIC_VECTOR(2 downto 0);
	UP:out BIT;
	DOWN:out BIT;			   
	INP:in integer range 0 to 255;
	OUTP:out integer range 0 to 255;
	LOAD:out BIT);
end component; 
--component FLAGS_BLACK_BOX is
--	port(	   
--		RESET: in STD_LOGIC;
--		CLK:in STD_LOGIC;
--		ZERO_FLAG: inout STD_LOGIC;
--		CARRY_FLAG: inout STD_LOGIC
--	);
--end component;

signal count1: integer range 0 to 255;
signal instruction1: STD_LOGIC_VECTOR(15 downto 0);	   
signal load1: BIT; 
signal addres1: integer range 0 to 255;
signal up1: BIT;
signal down1: BIT;		 
signal inp1: integer range 0 to 255;	 
signal cnst1: STD_LOGIC_VECTOR(7 downto 0);	
signal jump1: STD_LOGIC;
signal call1: BIT;
signal retrn1: BIT;
signal sel_flow_control: STD_LOGIC_VECTOR(2 downto 0);	
signal CLK_REGISTER: STD_LOGIC;
signal CLK_COUNTER: BIT; 
signal DECODER_REGISTER_FIRST_NUMBER: INTEGER;
signal DECODER_REGISTER_SECOND_NUMBER: INTEGER;
signal DECODER_REG_ENABLE: STD_LOGIC := '1';
signal DECODER_ALU_INPUT_SEL: INTEGER;
signal DECODER_ALU_OUTPUT_SEL: INTEGER;	
signal FLAGS_ZERO_FLAG: STD_LOGIC := '0';
signal FLAGS_CARRY_FLAG: STD_LOGIC := '0';	   
signal ALU_RESULT_OUTPUT: STD_LOGIC_VECTOR(7 downto 0);
signal REGISTER_FIRST_REGISTER_OUT: STD_LOGIC_VECTOR(7 downto 0);
signal REGISTER_SECOND_REGISTER_OUT: STD_LOGIC_VECTOR(7 downto 0);
begin 
	L1: ram port map(count1,instruction1);
	L2: p_counter port map (addres1,load1,CLK_COUNTER,count1);
	OUTPUT<=count1;
	L3: decoder port map(instruction1,jump1,call1,retrn1,sel_flow_control,RESET,
		DECODER_REGISTER_FIRST_NUMBER,
		DECODER_REGISTER_SECOND_NUMBER,
		DECODER_REG_ENABLE,
		DECODER_ALU_INPUT_SEL,
		DECODER_ALU_OUTPUT_SEL,
		cnst1);	
	L7: ALU_BLACK_BOX port map(
		REGISTER_FIRST_REGISTER_OUT,
		REGISTER_SECOND_REGISTER_OUT,
		cnst1,
		DECODER_ALU_INPUT_SEL,
		DECODER_ALU_OUTPUT_SEL,
		FLAGS_ZERO_FLAG,
		FLAGS_CARRY_FLAG,
		ALU_RESULT_OUTPUT);
	L8: REGISTERS_BLACK_BOX port map(
		RESET,
		DECODER_REG_ENABLE,
		CLK_REGISTER,
		ALU_RESULT_OUTPUT,
		DECODER_REGISTER_FIRST_NUMBER,
		DECODER_REGISTER_SECOND_NUMBER,
		REGISTER_FIRST_REGISTER_OUT,
		REGISTER_SECOND_REGISTER_OUT,
		REG_MATRIX);
	--L9: FLAGS_BLACK_BOX port map(RESET,CLK_REGISTER,FLAGS_ZERO_FLAG,FLAGS_CARRY_FLAG);
	L4: stack port map(count1,inp1,up1,down1); 
	L5: f_ctrl port map(cnst1,jump1,call1,retrn1,FLAGS_CARRY_FLAG,FLAGS_ZERO_FLAG,sel_flow_control,up1,down1,inp1,addres1,load1); 
	L6: CLK_DIVIDER port map(CLK,CLK_REGISTER,CLK_COUNTER);	 
	--process(RESET)
--	begin	  
--		if RESET='1' then					   
--			FLAGS_ZERO_FLAG<='0';
--			FLAGS_CARRY_FLAG<='0';
--		end if;
--	end process;
end;	  	