library ieee;
use ieee.std_logic_1164.all;  
entity test01 is
	port(
	ADDRESS:in integer range 0 to 255;
	RESET:out STD_LOGIC;
	S_MUX:out STD_LOGIC;
	SEL1:out STD_LOGIC_VECTOR(3 downto 0);	 
	SEL2:out STD_LOGIC_VECTOR(3 downto 0); 
	S_ALU:out STD_LOGIC_VECTOR(3 downto 0);	
	CONST:out STD_LOGIC_VECTOR(7 downto 0);
	CLK:in STD_LOGIC);
end;
architecture test01 of test01 is
component  decoder
	port(A:in STD_LOGIC_VECTOR(15 downto 0);
	RESET:out STD_LOGIC; 
	S_MUX:out STD_LOGIC;
	SEL1:out STD_LOGIC_VECTOR(3 downto 0);	 
	SEL2:out STD_LOGIC_VECTOR(3 downto 0); 
	S_ALU:out STD_LOGIC_VECTOR(3 downto 0);	
	CONST:out STD_LOGIC_VECTOR(7 downto 0);
	CLK:in STD_LOGIC);
end component;

component ram  
	port(ADDRESS:in integer range 0 to 255;
	OUTPUT:out STD_LOGIC_VECTOR(15 downto 0)
	); 
end component; 	  
component p_counter 
	port(ADDRESS:in integer range 0 to 255;
	CLK:in STD_LOGIC;
	OUTPUT:out integer range 0 to 255);
end component; 
signal count: integer range 0 to 255;
signal instruction: STD_LOGIC_VECTOR(15 downto 0);
begin 
	L1: ram port map(count,instruction);
	L2: p_counter port map (ADDRESS,CLK,count);
	L3: decoder port map(instruction,RESET,S_MUX,SEL1,SEL2,S_ALU,CONST,CLK);
end;