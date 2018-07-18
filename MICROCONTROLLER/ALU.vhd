library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use types.all;

entity ALU_BLACK_BOX is                                          
    generic(
        NR_BITS: INTEGER := 8;
        INPUT_MUX_SEL_NUMBER: INTEGER := 2;
        OUTPUT_MUX_SEL_NUMBER: INTEGER := 18
    );
    port( 
        FIRST_REGISTER_INPUT: in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
        SECOND_REGISTER_INPUT: in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
        CONSTANT_INPUT: in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0); 
        
        SEL_MUX_INPUT: in INTEGER;         --muxul care alege registru/constanta
        SEL_MUX_OUTPUT: in INTEGER;        --muxul care alege operatia care iese
        
        ZERO_FLAG: out STD_LOGIC;
        CARRY_FLAG: out STD_LOGIC;
        
        RESULT_OUTPUT: out STD_LOGIC_VECTOR(NR_BITS - 1 downto 0)
    );
end entity ALU_BLACK_BOX;                                      

architecture ALU_BLACK_BOX_ARCHITECTURE of ALU_BLACK_BOX is

component MUX_INPUT is     
    generic(
        NR_INPUTS: INTEGER := 2;    --0 - registru; 1 - constanta                         
        NR_BITS: INTEGER := 8
        );
    port(
        INPUT_MATRIX: in matrix8(NR_INPUTS - 1 downto 0);
        SELECTION: in INTEGER;
        OUTPUT: out STD_LOGIC_VECTOR(NR_BITS - 1 downto 0)
    );
end component;


component ADD is
    generic(
        NR_BITS: INTEGER := 8
    );
    port(
        FIRST_NUMBER:in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
        SECOND_NUMBER:in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
        RESULT:out STD_LOGIC_VECTOR(NR_BITS - 1 downto 0); 
        ZERO_FLAG: out STD_LOGIC;
        CARRY:out STD_LOGIC
    );
end component; 

component ADDCY is
    generic(
        NR_BITS: INTEGER := 8
    );
    port(
        FIRST_NUMBER: in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
        SECOND_NUMBER: in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
        CARRY: inout STD_LOGIC;    
        ZERO_FLAG: out STD_LOGIC;
        RESULT: out STD_LOGIC_VECTOR(NR_BITS - 1 downto 0)
    );                        
end component;

component ANDD is
    generic(
        NR_BITS: INTEGER := 8
    );                          
    port(
    FIRST_NUMBER: in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
    SECOND_NUMBER: in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
    RESULT: inout STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
    ZERO_FLAG: out STD_LOGIC
    );
end component;    

component ORR is
    generic(
        NR_BITS: INTEGER := 8
    );                         
    port(
        FIRST_NUMBER: in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
        SECOND_NUMBER: in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
        RESULT: out STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
        ZERO_FLAG: out STD_LOGIC
    );
end component;    

component SUB is
    generic(
        NR_BITS: INTEGER:= 8
    );                            
    port(
        FIRST_NUMBER:in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
        SECOND_NUMBER: in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
        RESULT: out STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);       
        ZERO_FLAG: out STD_LOGIC;
        BORROW: out STD_LOGIC
    );                        
end component;     

component SUBCY is
    generic(
        NR_BITS: INTEGER := 8
    );                          
    port(
        FIRST_NUMBER: in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
        SECOND_NUMBER: in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
        BORROW: inout STD_LOGIC;                          
        ZERO_FLAG: out STD_LOGIC;
        RESULT: out STD_LOGIC_VECTOR(NR_BITS - 1 downto 0)
    );
end component;    

component XORR is
    generic(
        NR_BITS: INTEGER := 8
    );                         
    port(
        FIRST_NUMBER: in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
        SECOND_NUMBER: in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
        RESULT: out STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
        ZERO_FLAG: out STD_LOGIC
    );
end component;

component SR0 is
    generic(
        NR_BITS:INTEGER := 8
    );                         
    port(
        FIRST_NUMBER:in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
        RESULT:out STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);    
        ZERO_FLAG: out STD_LOGIC;
        CARRY_FLAG: out STD_LOGIC
    );
end component;        

component SR1 is
    generic(
        NR_BITS:INTEGER := 8
    );                         
    port(
        FIRST_NUMBER:in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
        RESULT:out STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);    
        ZERO_FLAG: out STD_LOGIC;
        CARRY_FLAG: out STD_LOGIC
    );
end component SR1;    

component SRX is
    generic(
        NR_BITS:INTEGER := 8
    );                         
    port(
        FIRST_NUMBER:in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
        RESULT:out STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);    
        ZERO_FLAG: out STD_LOGIC;
        CARRY_FLAG: out STD_LOGIC
    );
end component SRX;    

component SRAA is
    generic(
        NR_BITS:INTEGER := 8
    );                         
    port(
        FIRST_NUMBER:in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
        CARRY_IN: in STD_LOGIC;
        RESULT:out STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);    
        ZERO_FLAG: out STD_LOGIC;
        CARRY_OUT: out STD_LOGIC
    );
end component SRAA;

component RR is
    generic(
        NR_BITS:INTEGER := 8
    );                         
    port(
        FIRST_NUMBER:in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
        RESULT:out STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);    
        ZERO_FLAG: out STD_LOGIC;
        CARRY_FLAG: out STD_LOGIC
    );
end component RR;         

component SL0 is
    generic(
        NR_BITS:INTEGER := 8
    );                         
    port(
        FIRST_NUMBER:in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
        RESULT:out STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);    
        ZERO_FLAG: out STD_LOGIC;
        CARRY_FLAG: out STD_LOGIC
    );
end component SL0;        

component SL1 is
    generic(
        NR_BITS:INTEGER := 8
    );                         
    port(
        FIRST_NUMBER:in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
        RESULT:out STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);    
        ZERO_FLAG: out STD_LOGIC;
        CARRY_FLAG: out STD_LOGIC
    );
end component SL1;     

component SLX is
    generic(
        NR_BITS:INTEGER := 8
    );                         
    port(
        FIRST_NUMBER:in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
        RESULT:out STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);    
        ZERO_FLAG: out STD_LOGIC;
        CARRY_FLAG: out STD_LOGIC
    );
end component SLX;        

component SLAA is
    generic(
        NR_BITS:INTEGER := 8
    );                         
    port(
        FIRST_NUMBER:in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
        CARRY_IN: in STD_LOGIC;
        RESULT:out STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);    
        ZERO_FLAG: out STD_LOGIC;
        CARRY_OUT: out STD_LOGIC
    );
end component SLAA;

component RL is
    generic(
        NR_BITS:INTEGER := 8
    );                         
    port(
        FIRST_NUMBER:in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
        RESULT:out STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);    
        ZERO_FLAG: out STD_LOGIC;
        CARRY_FLAG: out STD_LOGIC
    );
end component;    

component LOAD is 
    generic(
        NR_BITS: INTEGER := 8
    );                          
    port(
        FIRST_NUMBER: in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
        RESULT: out STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
        ZERO_FLAG: out STD_LOGIC
    );
    
end component LOAD;

component MUX_OUTPUT is
    generic(
        NR_INPUTS: INTEGER := 18;    --17 operatii                         
        NR_BITS: INTEGER := 8
        );
        
    port(
        INPUT_MATRIX: in matrix8(NR_INPUTS - 1 downto 0);
        SELECTION: in INTEGER;
        OUTPUT: out STD_LOGIC_VECTOR(NR_BITS - 1 downto 0)
    );
end component MUX_OUTPUT;

component MUX_FLAGS is     
    generic(
        NR_INPUTS: INTEGER := 18;    --18 operatii                         
        NR_BITS: INTEGER := 1
        );
        
    port(
        INPUT_MATRIX: in STD_LOGIC_VECTOR(17 downto 0);
        SELECTION: in INTEGER;
        OUTPUT: out STD_LOGIC
    );
end component MUX_FLAGS;       

--
-- signals
--

signal SECOND_OPERAND: STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
signal AUXILIAR_MATRIX_INPUT: matrix8(INPUT_MUX_SEL_NUMBER - 1 downto 0);    


signal ADD_CARRY:    STD_LOGIC;
signal ADDCY_CARRY:  STD_LOGIC;
signal AND_CARRY:    STD_LOGIC;
signal OR_CARRY:     STD_LOGIC;
signal SUB_CARRY:    STD_LOGIC;
signal SUBCY_CARRY:  STD_LOGIC;
signal XOR_CARRY:    STD_LOGIC;
signal SR0_CARRY:    STD_LOGIC;
signal SR1_CARRY:    STD_LOGIC;
signal SRX_CARRY:    STD_LOGIC;
signal SRA_CARRY:    STD_LOGIC;
signal RR_CARRY:     STD_LOGIC;
signal SL0_CARRY:    STD_LOGIC;
signal SL1_CARRY:    STD_LOGIC;
signal SLX_CARRY:    STD_LOGIC;
signal SLA_CARRY:    STD_LOGIC;
signal RL_CARRY:     STD_LOGIC;      
signal LOAD_CARRY:   STD_LOGIC;

signal ADD_ZERO:    STD_LOGIC;
signal ADDCY_ZERO:  STD_LOGIC;
signal AND_ZERO:    STD_LOGIC;
signal OR_ZERO:     STD_LOGIC;
signal SUB_ZERO:    STD_LOGIC;
signal SUBCY_ZERO:  STD_LOGIC;
signal XOR_ZERO:    STD_LOGIC;
signal SR0_ZERO:    STD_LOGIC;
signal SR1_ZERO:    STD_LOGIC;
signal SRX_ZERO:    STD_LOGIC;
signal SRA_ZERO:    STD_LOGIC;
signal RR_ZERO:     STD_LOGIC;
signal SL0_ZERO:    STD_LOGIC;
signal SL1_ZERO:    STD_LOGIC;
signal SLX_ZERO:    STD_LOGIC;
signal SLA_ZERO:    STD_LOGIC;
signal RL_ZERO:     STD_LOGIC;      
signal LOAD_ZERO:   STD_LOGIC;

signal ADD_RESULT:    STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
signal ADDCY_RESULT:  STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
signal AND_RESULT:    STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
signal OR_RESULT:     STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
signal SUB_RESULT:    STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
signal SUBCY_RESULT:  STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
signal XOR_RESULT:    STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
signal SR0_RESULT:    STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
signal SR1_RESULT:    STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
signal SRX_RESULT:    STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
signal SRA_RESULT:    STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
signal RR_RESULT:     STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
signal SL0_RESULT:    STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
signal SL1_RESULT:    STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
signal SLX_RESULT:    STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
signal SLA_RESULT:    STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
signal RL_RESULT:     STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);      
signal LOAD_RESULT:   STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);

signal AUXILIAR_MATRIX_OUTPUT: matrix8(OUTPUT_MUX_SEL_NUMBER - 1 downto 0);    
signal AUXILIAR_ZERO_OUTPUT: STD_LOGIC_VECTOR(17 downto 0);
signal AUXILIAR_CARRY_OUTPUT: STD_LOGIC_VECTOR(17 downto 0);

begin            
    AUXILIAR_MATRIX_INPUT(0) <= SECOND_REGISTER_INPUT;
    AUXILIAR_MATRIX_INPUT(1) <= CONSTANT_INPUT;
    FIRST_MUX_TAG: MUX_INPUT port map(AUXILIAR_MATRIX_INPUT, SEL_MUX_INPUT, SECOND_OPERAND);
    
    ADD_TAG:    ADD   port map(FIRST_REGISTER_INPUT, SECOND_OPERAND, ADD_RESULT, ADD_ZERO, ADD_CARRY);
    ADDCY_TAG:  ADD   port map(FIRST_REGISTER_INPUT, SECOND_OPERAND, ADDCY_RESULT, ADDCY_ZERO, ADDCY_CARRY);
    AND_TAG:    ANDD  port map(FIRST_REGISTER_INPUT, SECOND_OPERAND, AND_RESULT, AND_ZERO);
    OR_TAG:     ORR   port map(FIRST_REGISTER_INPUT, SECOND_OPERAND, OR_RESULT, OR_ZERO);
    SUB_TAG:    SUB   port map(FIRST_REGISTER_INPUT, SECOND_OPERAND, SUB_RESULT, SUB_ZERO, SUB_CARRY);
    SUBCY_TAG:  SUB   port map(FIRST_REGISTER_INPUT, SECOND_OPERAND, SUBCY_RESULT, SUBCY_ZERO, SUBCY_CARRY);
    XOR_TAG:    XORR  port map(FIRST_REGISTER_INPUT, SECOND_OPERAND, XOR_RESULT, XOR_ZERO);
    SR0_TAG:    SR0   port map(FIRST_REGISTER_INPUT, SR0_RESULT, SR0_ZERO, SR0_CARRY);
    SR1_TAG:    SR1   port map(FIRST_REGISTER_INPUT, SR1_RESULT, SR1_ZERO, SR1_CARRY);
    SRX_TAG:    SRX   port map(FIRST_REGISTER_INPUT, SRX_RESULT, SRX_ZERO, SRX_CARRY);
    SRA_TAG:    SRX   port map(FIRST_REGISTER_INPUT, SRA_RESULT, SRA_ZERO, SRA_CARRY);
    RR_TAG:     RR    port map(FIRST_REGISTER_INPUT, RR_RESULT, RR_ZERO, RR_CARRY);
    SL0_TAG:    SL0   port map(FIRST_REGISTER_INPUT, SL0_RESULT, SL0_ZERO, SL0_CARRY);
    SL1_TAG:    SL1   port map(FIRST_REGISTER_INPUT, SL1_RESULT, SL1_ZERO, SL1_CARRY);
    SLX_TAG:    SLX   port map(FIRST_REGISTER_INPUT, SLX_RESULT, SLX_ZERO, SLX_CARRY);
    SLA_TAG:    SLX   port map(FIRST_REGISTER_INPUT, SLA_RESULT, SLA_ZERO, SLA_CARRY);
    RL_TAG:     RL    port map(FIRST_REGISTER_INPUT, RL_RESULT, RL_ZERO, RL_CARRY); 
    LOAD_TAG:   LOAD  port map(SECOND_OPERAND, LOAD_RESULT, LOAD_ZERO);
    
    AUXILIAR_MATRIX_OUTPUT(0)  <= ADD_RESULT;
    AUXILIAR_MATRIX_OUTPUT(1)  <= ADDCY_RESULT;      
    AUXILIAR_MATRIX_OUTPUT(2)  <= AND_RESULT;
    AUXILIAR_MATRIX_OUTPUT(3)  <= OR_RESULT;
    AUXILIAR_MATRIX_OUTPUT(4)  <= SUB_RESULT;
    AUXILIAR_MATRIX_OUTPUT(5)  <= SUBCY_RESULT;
    AUXILIAR_MATRIX_OUTPUT(6)  <= XOR_RESULT;      
    AUXILIAR_MATRIX_OUTPUT(7)  <= SR0_RESULT;
    AUXILIAR_MATRIX_OUTPUT(8)  <= SR1_RESULT;
    AUXILIAR_MATRIX_OUTPUT(9)  <= SRX_RESULT;
    AUXILIAR_MATRIX_OUTPUT(10) <= SRA_RESULT;
    AUXILIAR_MATRIX_OUTPUT(11) <= RR_RESULT;      
    AUXILIAR_MATRIX_OUTPUT(12) <= SL0_RESULT;
    AUXILIAR_MATRIX_OUTPUT(13) <= SL1_RESULT;
    AUXILIAR_MATRIX_OUTPUT(14) <= SLX_RESULT;
    AUXILIAR_MATRIX_OUTPUT(15) <= SLA_RESULT;
    AUXILIAR_MATRIX_OUTPUT(16) <= RL_RESULT;
    AUXILIAR_MATRIX_OUTPUT(17) <= LOAD_RESULT;    
    
    
    AUXILIAR_ZERO_OUTPUT(0)  <= ADD_ZERO;
    AUXILIAR_ZERO_OUTPUT(1)  <= ADDCY_ZERO;      
    AUXILIAR_ZERO_OUTPUT(2)  <= AND_ZERO;
    AUXILIAR_ZERO_OUTPUT(3)  <= OR_ZERO;
    AUXILIAR_ZERO_OUTPUT(4)  <= SUB_ZERO;
    AUXILIAR_ZERO_OUTPUT(5)  <= SUBCY_ZERO;
    AUXILIAR_ZERO_OUTPUT(6)  <= XOR_ZERO;      
    AUXILIAR_ZERO_OUTPUT(7)  <= SR0_ZERO;
    AUXILIAR_ZERO_OUTPUT(8)  <= SR1_ZERO;
    AUXILIAR_ZERO_OUTPUT(9)  <= SRX_ZERO;
    AUXILIAR_ZERO_OUTPUT(10) <= SRA_ZERO;
    AUXILIAR_ZERO_OUTPUT(11) <= RR_ZERO;      
    AUXILIAR_ZERO_OUTPUT(12) <= SL0_ZERO;
    AUXILIAR_ZERO_OUTPUT(13) <= SL1_ZERO;
    AUXILIAR_ZERO_OUTPUT(14) <= SLX_ZERO;
    AUXILIAR_ZERO_OUTPUT(15) <= SLA_ZERO;
    AUXILIAR_ZERO_OUTPUT(16) <= RL_ZERO;
    AUXILIAR_ZERO_OUTPUT(17) <= LOAD_ZERO;
    
    
    AUXILIAR_CARRY_OUTPUT(0)  <= ADD_CARRY;
    AUXILIAR_CARRY_OUTPUT(1)  <= ADDCY_CARRY;      
    AUXILIAR_CARRY_OUTPUT(2)  <= '0';
    AUXILIAR_CARRY_OUTPUT(3)  <= '0';
    AUXILIAR_CARRY_OUTPUT(4)  <= SUB_CARRY;
    AUXILIAR_CARRY_OUTPUT(5)  <= SUBCY_CARRY;
    AUXILIAR_CARRY_OUTPUT(6)  <= '0';      
    AUXILIAR_CARRY_OUTPUT(7)  <= SR0_CARRY;
    AUXILIAR_CARRY_OUTPUT(8)  <= SR1_CARRY;
    AUXILIAR_CARRY_OUTPUT(9)  <= SRX_CARRY;
    AUXILIAR_CARRY_OUTPUT(10) <= SRA_CARRY;
    AUXILIAR_CARRY_OUTPUT(11) <= RR_CARRY;      
    AUXILIAR_CARRY_OUTPUT(12) <= SL0_CARRY;
    AUXILIAR_CARRY_OUTPUT(13) <= SL1_CARRY;
    AUXILIAR_CARRY_OUTPUT(14) <= SLX_CARRY;
    AUXILIAR_CARRY_OUTPUT(15) <= SLA_CARRY;
    AUXILIAR_CARRY_OUTPUT(16) <= RL_CARRY;
    AUXILIAR_CARRY_OUTPUT(17) <= '0';
    
    
    ZERO_MUX_TAG: MUX_FLAGS port map(AUXILIAR_ZERO_OUTPUT, SEL_MUX_OUTPUT, ZERO_FLAG);
    CARRY_MUX_TAG: MUX_FLAGS port map(AUXILIAR_CARRY_OUTPUT, SEL_MUX_OUTPUT, CARRY_FLAG);
                                                                             
    SECOND_MUX_TAG: MUX_OUTPUT port map(AUXILIAR_MATRIX_OUTPUT, SEL_MUX_OUTPUT, RESULT_OUTPUT);
end architecture ALU_BLACK_BOX_ARCHITECTURE;