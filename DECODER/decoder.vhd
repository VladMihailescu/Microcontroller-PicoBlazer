library ieee;
use ieee.std_logic_1164.all;

entity decoder is
	port(A:in STD_LOGIC_VECTOR(15 downto 0);
	RESET:out STD_LOGIC; 
	S_MUX:out STD_LOGIC;
	SEL1:out STD_LOGIC_VECTOR(3 downto 0);	 
	SEL2:out STD_LOGIC_VECTOR(3 downto 0); 
	S_ALU:out STD_LOGIC_VECTOR(3 downto 0);	
	CONST:out STD_LOGIC_VECTOR(7 downto 0);
	CLK:in STD_LOGIC);
end;		 


--deci merge pe op aritmetico-logice
architecture decoder of decoder is
begin
	process(CLK)
	begin
		if(CLK='1' and CLK'EVENT) then	
			case A(15 downto 12) is
				when "1100" => 	
					S_MUX<='1';
					SEL1<=A(11 downto 8); 
					SEL2<=A(7 downto 4); 
					S_ALU<=A(3 downto 0); 
				when "0000"=>			   --load
					S_ALU<=A(15 downto 12);	
					SEL1<=A(11 downto 8);
					CONST<=A(7 downto 0);
					S_MUX<='0';
				when "0001"=>			   --and
					S_ALU<=A(15 downto 12);	
					SEL1<=A(11 downto 8);
					CONST<=A(7 downto 0);
					S_MUX<='0';
				when "0010"=>			   --or
					S_ALU<=A(15 downto 12);	
					SEL1<=A(11 downto 8);
					CONST<=A(7 downto 0);
					S_MUX<='0';
				when "0011"=>			   --xor
					S_ALU<=A(15 downto 12);	
					SEL1<=A(11 downto 8);
					CONST<=A(7 downto 0);
					S_MUX<='0';
				when "0100"=>				--add
					S_ALU<=A(15 downto 12);	
					SEL1<=A(11 downto 8);
					CONST<=A(7 downto 0);
					S_MUX<='0';
				when "0101"=>				--addcy
					S_ALU<=A(15 downto 12);	
					SEL1<=A(11 downto 8);
					CONST<=A(7 downto 0);
					S_MUX<='0';
				when "0110"=>				--sub
					S_ALU<=A(15 downto 12);	
					SEL1<=A(11 downto 8);
					CONST<=A(7 downto 0);
					S_MUX<='0';	  
				when "0111"=>				--subcy
					S_ALU<=A(15 downto 12);	
					SEL1<=A(11 downto 8);
					CONST<=A(7 downto 0);
					S_MUX<='0';
				when "1101"=>				--shift	
					SEL1<=A(11 downto 8);  
					S_MUX<='0';
				when others =>	RESET<='0';	
			end case;
		end if;
	end process;		
	
end;