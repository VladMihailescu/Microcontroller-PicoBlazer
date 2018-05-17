
library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use types.all;

entity mux_sub is		
	port(A:in matrix8(15 downto 0);	 
	S:in STD_LOGIC_VECTOR (3 downto 0);
	B:out STD_LOGIC_VECTOR (7 downto 0));	  
end;
architecture mux_sub of mux_sub is  	
begin	
	process(S)
	variable sel:integer;
	begin
		sel:=to_integer(unsigned(S));
		B<=A(sel);
	end process;
end;



library ieee;
use ieee.std_logic_1164.all;
use types.all;

entity submarin is
	   port(						
	   		RESET: in STD_LOGIC; 
	   		data_in:in STD_LOGIC_VECTOR (3 downto 0);
       		anode : out STD_LOGIC_VECTOR (3 downto 0);
      		cathode : out STD_LOGIC_VECTOR (6 downto 0); 	
			CLK:in BIT;
			CLK_switch:in STD_LOGIC);
end;  
architecture submarin of submarin is  
component mux_sub 		
	port(A:in matrix8(15 downto 0);	 
	S:in STD_LOGIC_VECTOR (3 downto 0);
	B:out STD_LOGIC_VECTOR (7 downto 0));	  
end component; 

component afisor is
	port ( clock_100Mhz : in BIT;
		reset : in STD_LOGIC; 
		data_in:in STD_LOGIC_VECTOR (7 downto 0);
		OUTPUT:in integer range 0 to 255;
        anode : out STD_LOGIC_VECTOR (3 downto 0);
        cathode : out STD_LOGIC_VECTOR (6 downto 0));
end component; 
component test01 is
	port(						
		RESET: in STD_LOGIC; 
		REG_MATRIX: out matrix8(15 downto 0);		   	
		CLK:in STD_LOGIC;
		OUTPUT:out integer range 0 to 255);
end component;	
signal REG_M: matrix8(15 downto 0);
signal data : STD_LOGIC_VECTOR (7 downto 0);
signal OTPT: integer range 0 to 255;
begin 
	L1:test01 port map(RESET,REG_M,CLK_switch,OTPT);
	L2:mux_sub port map(REG_M,data_in,data);
	L3:afisor port map(CLK,RESET,data,OTPT,anode,cathode);
end; 