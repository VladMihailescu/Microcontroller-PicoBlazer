library ieee;
use ieee.std_logic_1164.all;

entity decoder is
	port(A:in STD_LOGIC_VECTOR(15 downto 0);--instructiune 16 biti 
	JMP:out BIT:='0';							--semnal call
	CALL:out BIT:='0';							--semnal jump
	RET:out BIT:='0';							--semnal return	
	S_FC:out STD_LOGIC_VECTOR(2 downto 0);	--selectie FC
	RESET:out STD_LOGIC; 					--semnal reset(nefolosit)
	S_MUX:out STD_LOGIC;					--selectie intre registru sau constanta ALU
	S_PORT:out STD_LOGIC_VECTOR(7 downto 0);--selectie port in/out 
	S_REG:out BIT;							--selectie intre registru sau port PAC
	SEL1:out STD_LOGIC_VECTOR(3 downto 0);	--selectie in/out registru
	SEL2:out STD_LOGIC_VECTOR(3 downto 0); 	--selectie out2 registru
	S_ALU:out STD_LOGIC_VECTOR(3 downto 0);	--selectie mux ALU
	CONST:out STD_LOGIC_VECTOR(7 downto 0)
);	--date constante						
end;		 


--deci merge pe op aritmetico-logice
architecture decoder of decoder is
begin
	process(A)
	begin  	
		JMP<='0';
		CALL<='0';
		RET<='0';  
			if(A(15 downto 13)="100")then  
				case A(9 downto 8)is
					when "01" => 
						JMP<='1';
					   	CONST<=A(7 downto 0); 
						S_FC<=A(12 downto 10); 
					when "11" => 
						CALL<='1';
					   	CONST<=A(7 downto 0);
						S_FC<=A(12 downto 10); 
					when "00" =>	 
						RET<='1'; 
					when others =>null;
				end case;
			end if;
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
				when "1010"=>	 		    --input port
					S_REG<='0';
					S_ALU<=A(15 downto 12);	
					SEL1<=A(11 downto 8);
					S_PORT<=A(7 downto 0);
				when "1011"=>	 
					S_REG<='1';			     --input reg
					S_ALU<=A(15 downto 12);	
					SEL1<=A(11 downto 8);
					SEL2<=A(7 downto 4);
				when others =>	RESET<='0';	
			end case; 
	end process;		
	
end;