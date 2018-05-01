library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

library ALU;
library DECORDER;
library REGISTERS;

entity MICROCONTROLLER_BLACK_BOX is
	generic(
		NR_BITS: INTEGER := 8;		 
		INSTRUCTION_BITS: INTEGER := 16
	);
	port(
		CLK: in STD_LOGIC;
		RESET: in STD_LOGIC;
	
		--nu am ram inca
		INSTRUCTION: in STD_LOGIC_VECTOR(INSTRUCTION_BITS - 1 downto 0)
	);
end entity MICROCONTROLLER_BLACK_BOX;

architecture MICROCONTROLLER_BLACK_BOX_ARCHITECTURE of MICROCONTROLLER_BLACK_BOX is

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

component DECODER_BLACK_BOX is
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
end component DECODER_BLACK_BOX; 

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
		SECOND_REGISTER_OUT: out STD_LOGIC_VECTOR(NR_BITS - 1 downto 0)
		
	);
end component REGISTERS_BLACK_BOX;	

component DELAY_BLACK_BOX is
	generic(
		NR_BITS: INTEGER := 8
	);
	
	port(
		CLK: in STD_LOGIC;
		INPUT: in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
		OUTPUT: out STD_LOGIC_VECTOR(NR_BITS - 1 downto 0)
	);
end component DELAY_BLACK_BOX ;

---ce iese din decoder
signal DECODER_CONSTANT_NUMBER:      STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);    --intra in alu 
signal DECODER_REG_ENABLE:           STD_LOGIC;                                 --intra in registers
signal DECODER_RESET:                STD_LOGIC;                                 --intra in registers
signal DECODER_ALU_INPUT_SEL:        INTEGER := 0;                              --intra in alu
signal DECODER_ALU_OUTPUT_SEL:       INTEGER := 0;                              --intra in alu
signal DECODER_REGISTER_FIRST_SEL:   INTEGER := 0;                              --intra in registers
signal DECODER_REGISTER_SECOND_SEL:  INTEGER := 0;                              --intra in registers

---ce iese din alu
signal ALU_RESULT_OUTPUT:            STD_LOGIC_VECTOR(NR_BITS - 1 downto 0) := "00000000";    --intra in registers

---ce iese din registers
signal REGISTERS_FIRST_REG_OUT:      STD_LOGIC_VECTOR(NR_BITS - 1 downto 0) := "00000000";    --intra in alu
signal REGISTERS_SECOND_REG_OUT:     STD_LOGIC_VECTOR(NR_BITS - 1 downto 0) := "00000000";	--intra in alu

--zero & carry flag
signal ZERO_FLAG: STD_LOGIC:= '0';
signal CARRY_FLAG: STD_LOGIC:= '0';

signal DELAYED_ALU_RESULT_OUTPUT:    STD_LOGIC_VECTOR(NR_BITS - 1 downto 0) := "00000000";

begin
	ALU_TAG: ALU_BLACK_BOX port map(
		REGISTERS_FIRST_REG_OUT,
		REGISTERS_SECOND_REG_OUT,
		DECODER_CONSTANT_NUMBER,
		DECODER_ALU_INPUT_SEL,
		DECODER_ALU_OUTPUT_SEL,
		ZERO_FLAG,
		CARRY_FLAG,
		ALU_RESULT_OUTPUT
	);			  
					  
	REGISTERS_TAG: REGISTERS_BLACK_BOX port map(
		RESET,
		DECODER_REG_ENABLE,	
		CLK,
		ALU_RESULT_OUTPUT,
		DECODER_REGISTER_FIRST_SEL,
		DECODER_REGISTER_SECOND_SEL, 
		REGISTERS_FIRST_REG_OUT,
		REGISTERS_SECOND_REG_OUT
	);		
	
	DECODER_TAG: DECODER_BLACK_BOX port map(
		CLK,
		RESET, 
		INSTRUCTION,
		DECODER_CONSTANT_NUMBER,
		DECODER_REGISTER_FIRST_SEL,
		DECODER_REGISTER_SECOND_SEL,
		DECODER_REG_ENABLE,
		DECODER_RESET,
		DECODER_ALU_INPUT_SEL,
		DECODER_ALU_OUTPUT_SEL
	);
	
end architecture MICROCONTROLLER_BLACK_BOX_ARCHITECTURE;