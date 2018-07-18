library ieee;
use ieee.std_logic_1164.all;

entity DECODER is
    port(A:in STD_LOGIC_VECTOR(15 downto 0);            --instructiune 16 biti        
    --------------------------------------------------------
    JMP:out STD_LOGIC:='0';                                --semnal call
    CALL:out BIT:='0';                                    --semnal jump
    RET:out BIT:='0';                                    --semnal return    
    S_FC:out STD_LOGIC_VECTOR(2 downto 0);                --selectie FC
    RESET:in STD_LOGIC;                                 --semnal reset(nefolosit)    
    INT_FLAG:OUT STD_LOGIC;
    FLOW_CONSTANT:out STD_LOGIC_VECTOR(7 downto 0);
    --------------------------------------------------------
    REGISTER_FIRST_NUMBER: out INTEGER;                       --selectie in/out registru      
    REGISTER_SECOND_NUMBER: out INTEGER;                   --selectie out2 registru          
    REG_ENABLE: out STD_LOGIC;                            --0 - daca e jump/call etc       
    ALU_INPUT_SEL: out INTEGER;                            --                              
    ALU_OUTPUT_SEL: out INTEGER;                        --                                   
    ALU_CONSTANT:out STD_LOGIC_VECTOR(7 downto 0);        --date constante                      
    -----------------------------------------------------
    PORT_ID_TOOGLE:OUT STD_LOGIC; 
    PORT_IN_OUT_TOOGLE:OUT STD_LOGIC;  
    PORT_CONSTANT:OUT STD_LOGIC_VECTOR(7 downto 0)
    );                            
end;         

architecture DECODER of DECODER is
function std_to_int(std:in STD_LOGIC_VECTOR(3 downto 0)) return integer is
variable rez:integer;
begin    
    rez:=0;
    if std(0)='1' then
        rez:=rez+1;
    end if;
    if std(1)='1' then
        rez:=rez+2;
    end if;
    if std(2)='1' then
        rez:=rez+4;
    end if;
    if std(3)='1' then
        rez:=rez+8;
    end if;    
    return rez;
end;
begin
    process(A)     
    variable SEL1: STD_LOGIC_VECTOR(3 downto 0);    
    variable SEL2: STD_LOGIC_VECTOR(3 downto 0); 
    variable S_ALU: STD_LOGIC_VECTOR(3 downto 0); 
    variable S_MUX: integer;
    variable S_SHIFT:STD_LOGIC_VECTOR(7 downto 0);
    begin      
        JMP<='0';
        CALL<='0';
        RET<='0';  
        if(A(15 downto 13)="100")then 
            REG_ENABLE <= '0';    
            ALU_INPUT_SEL<=3;
            case A(9 downto 8)is
                when "01" => 
                    JMP<='1';
                      FLOW_CONSTANT<=A(7 downto 0); 
                    S_FC<=A(12 downto 10); 
                when "11" => 
                    CALL<='1';
                    FLOW_CONSTANT<=A(7 downto 0);
                    S_FC<=A(12 downto 10); 
                when "00" =>
                    if A(15 downto 0)="1000000011110000" then        --RETURNI ENABLE
                           RET<='1'; 
                        S_FC<="000";
                        INT_FLAG <='1';
                    elsif A(15 downto 0)="1000000011010000" then    --RETURNI DISABLE
                        RET<='1'; 
                        S_FC<="000";
                        INT_FLAG <='0';
                    elsif A(15 downto 0)="1000000000110000" then       --ENABLE INTERRUPT
                        INT_FLAG <='1';                                   
                    elsif A(15 downto 0)="1000000000010000" then       --DISABLE INTERRUPT
                        INT_FLAG <='0';
                    else
                        RET<='1'; 
                        S_FC<=A(12 downto 10);
                    end if;
                when others =>null;
            end case; 
        elsif(A(15 downto 13)="101")then                               --INPUT PORT
            REG_ENABLE <= '1';      
            PORT_IN_OUT_TOOGLE<='0';
            if A(12)='0'then
                SEL1:=A(11 downto 8); 
                PORT_CONSTANT<=A(7 downto 0);
                PORT_ID_TOOGLE<='0';
            elsif  A(12)='1' then
                SEL1:=A(11 downto 8); 
                SEL2:=A(7 downto 4); 
                PORT_ID_TOOGLE<='1';
            end if;     
            REGISTER_FIRST_NUMBER<=std_to_int(SEL1);
            REGISTER_SECOND_NUMBER<=std_to_int(SEL2); 
        elsif(A(15 downto 13)="111")then                                --OUTPUT PORT
            REG_ENABLE <= '1';      
            PORT_IN_OUT_TOOGLE<='0';
            if A(12)='0'then
                SEL1:=A(11 downto 8); 
                PORT_CONSTANT<=A(7 downto 0);
                PORT_ID_TOOGLE<='0';
            elsif  A(12)='1' then
                SEL1:=A(11 downto 8); 
                SEL2:=A(7 downto 4); 
                PORT_ID_TOOGLE<='1';
            end if;     
            REGISTER_FIRST_NUMBER<=std_to_int(SEL1);
            REGISTER_SECOND_NUMBER<=std_to_int(SEL2);
        else 
            REG_ENABLE <= '1'; 
            case A(15 downto 12) is
                when "1100" =>     
                    S_MUX := 0;
                    SEL1:=A(11 downto 8); 
                    SEL2:=A(7 downto 4); 
                    S_ALU:=A(3 downto 0); 
                when "0000"|"0001"|"0010"|"0011"|"0100"|"0101"|"0110"|"0111"=>             
                    S_ALU:=A(15 downto 12);    
                    SEL1:=A(11 downto 8);
                    ALU_CONSTANT<=A(7 downto 0);
                    S_MUX := 1;
                when "1101"=>                                        --shift
                    S_ALU:=A(15 downto 12);    
                    SEL1:=A(11 downto 8); 
                    S_SHIFT:=A(7 downto 0);
                    S_MUX := 1;               
                when others =>    null;    
            end case;
            REGISTER_FIRST_NUMBER<=std_to_int(SEL1);
            REGISTER_SECOND_NUMBER<=std_to_int(SEL2);
            ALU_INPUT_SEL<=S_MUX;
            case S_ALU is
                when "0100" =>    ALU_OUTPUT_SEL <= 0;
                when "0101" =>    ALU_OUTPUT_SEL <= 1;
                when "0001" =>    ALU_OUTPUT_SEL <= 2; 
                when "0010" =>    ALU_OUTPUT_SEL <= 3;
                when "0110" =>    ALU_OUTPUT_SEL <= 4;  
                when "0111" =>    ALU_OUTPUT_SEL <= 5; 
                when "0011" =>    ALU_OUTPUT_SEL <= 6; 
                when "0000" =>    ALU_OUTPUT_SEL <= 17; 
                when "1101" => 
                    case S_SHIFT is
                        when "00001110" => ALU_OUTPUT_SEL <= 7; 
                        when "00001111" => ALU_OUTPUT_SEL <= 8; 
                        when "00001010" => ALU_OUTPUT_SEL <= 9; 
                        when "00001000" => ALU_OUTPUT_SEL <= 10;   
                        when "00001100" => ALU_OUTPUT_SEL <= 11; 
                        when "00000110" => ALU_OUTPUT_SEL <= 12; 
                        when "00000111" => ALU_OUTPUT_SEL <= 13; 
                        when "00000100" => ALU_OUTPUT_SEL <= 14; 
                        when "00000000" => ALU_OUTPUT_SEL <= 15;   
                        when "00000010" => ALU_OUTPUT_SEL <= 16; 
                        when others =>null;
                    end case;
                when others =>null;
            end case;  
            
        end if;                   
    end process;        
    
end;