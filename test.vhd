library ieee;
use ieee.std_logic_1164.all;  
entity test01 is
	port( 
	CARRY:inout STD_LOGIC;
	ZERO:inout STD_LOGIC;
	ADDRESS:in integer range 0 to 255;
	RESET:out STD_LOGIC;
	S_MUX:out STD_LOGIC;  
	S_PORT:out STD_LOGIC_VECTOR(7 downto 0);
	S_REG:out BIT;
	SEL1:out STD_LOGIC_VECTOR(3 downto 0);	 
	SEL2:out STD_LOGIC_VECTOR(3 downto 0); 
	S_ALU:out STD_LOGIC_VECTOR(3 downto 0);	
	CLK:in BIT);
end;
architecture test01 of test01 is
component decoder										 --decoder
	port(A:in STD_LOGIC_VECTOR(15 downto 0);--instructiune 16 biti 
	JMP:out BIT;							--semnal jump
	CALL:out BIT;							--semnal call
	RET:out BIT;							--semnal return	
	S_FC:out STD_LOGIC_VECTOR(2 downto 0);	--selectie FC
	RESET:out STD_LOGIC; 					--semnal reset(nefolosit)
	S_MUX:out STD_LOGIC;					--selectie intre registru sau constanta ALU
	S_PORT:out STD_LOGIC_VECTOR(7 downto 0);--selectie port in/out 
	S_REG:out BIT;							--selectie intre registru sau port PAC
	SEL1:out STD_LOGIC_VECTOR(3 downto 0);	--selectie in/out registru
	SEL2:out STD_LOGIC_VECTOR(3 downto 0); 	--selectie out2 registru
	S_ALU:out STD_LOGIC_VECTOR(3 downto 0);	--selectie mux ALU
	CONST:out STD_LOGIC_VECTOR(7 downto 0)	--date constante
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
	JMP:in BIT;
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

signal count1: integer range 0 to 255;
signal instruction1: STD_LOGIC_VECTOR(15 downto 0);	   
signal load1: BIT; 
signal addres1: integer range 0 to 255;
signal up1: BIT;
signal down1: BIT;		 
signal inp1: integer range 0 to 255;	 
signal cnst1: STD_LOGIC_VECTOR(7 downto 0);	
signal jump1: BIT;
signal call1: BIT;
signal retrn1: BIT;
signal sel_flow_control: STD_LOGIC_VECTOR(2 downto 0);
begin 
	L1: ram port map(count1,instruction1);
	L2: p_counter port map (addres1,load1,CLK,count1);
	L3: decoder port map(instruction1,jump1,call1,retrn1,sel_flow_control,RESET,S_MUX,S_PORT,S_REG,SEL1,SEL2,S_ALU,cnst1);	 
	L4: stack port map(count1,inp1,up1,down1); 
	L5: f_ctrl port map(cnst1,jump1,call1,retrn1,CARRY,ZERO,sel_flow_control,up1,down1,inp1,addres1,load1); 	
end;	  	