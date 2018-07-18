library ieee;
use ieee.std_logic_1164.all;  

entity FLOW_CONTROL is
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
end;

architecture FLOW_CONTROL of FLOW_CONTROL is
begin
    process(CLK)
    variable rez:integer range 0 to 255 :=0;  
    begin 
        if(rising_edge(CLk)) then
            LOAD<='0'; 
            LOADR<='0';
            UP<='0';
            DOWN<='0';          
            rez:=0;
            if(CONST(0)='1')then
                rez:=1;
            end if;       
            if(CONST(1)='1')then
                rez:=rez + 2;
            end if;
            if(CONST(2)='1')then
                rez:=rez + 4;
            end if;
            if(CONST(3)='1')then
                rez:=rez + 8;
            end if;     
            if(CONST(4)='1')then
                rez:=rez + 16;
            end if;       
            if(CONST(5)='1')then
                rez:=rez + 32;
            end if;
            if(CONST(6)='1')then
                rez:=rez + 64;
            end if;
            if(CONST(7)='1')then
                rez:=rez + 128;
            end if;
        if(JMP='1' )then
            if(S_FC(2)='1')then
                case S_FC(1 downto 0) is
                    when "00" =>
                        if(ZERO='1')then 
                            OUTP<=rez;
                            LOAD<='1';
                        end if;
                    when "01" =>
                        if(ZERO='0')then 
                            OUTP<=rez ;
                            LOAD<='1';
                        end if;
                    when "10" => 
                        if(CARRY='1')then 
                            OUTP<=rez ;
                            LOAD<='1' ; 
                        end if;
                    when "11" =>
                        if(CARRY='0')then 
                            OUTP<=rez ;
                            LOAD<='1' ; 
                        end if;
                    when others => null;
                end case;
            elsif(S_FC(2)='0')then     
                OUTP<=rez;
                LOAD<='1'; 
            end if;
        end if;     
        if(CALL='1' )then 
            if(S_FC(2)='1')then
                case S_FC(1 downto 0) is
                    when "00" =>
                        if(ZERO='1')then 
                            UP<='1' ;
                            OUTP<=rez ;
                            LOAD<='1'; 
                        end if;
                    when "01" =>
                        if(ZERO='0')then 
                            UP<='1';
                            OUTP<=rez;
                            LOAD<='1';
                        end if;
                    when "10" => 
                        if(CARRY='1')then 
                            UP<='1' ;
                            OUTP<=rez ;
                            LOAD<='1';
                        end if;
                    when "11" =>
                        if(CARRY='0')then 
                            UP<='1' ;
                            OUTP<=rez;
                            LOAD<='1';
                        end if;
                    when others => null;
                end case;
            elsif(S_FC(2)='0')then      
                UP<='1';
                OUTP<=rez;
                LOAD<='1';
            end if;                       
        end if;    
        if(INT='1' )then   
            UP<='1';
            OUTP<=20;
            LOAD<='1';                      
        end if;
        if(RET='1' )then
            if(S_FC(2)='1')then
                case S_FC(1 downto 0) is
                    when "00" =>
                        if(ZERO='1')then 
                            DOWN<='1';        
                            LOADR<='1';
                        end if;
                    when "01" =>
                        if(ZERO='0')then 
                            DOWN<='1';        
                            LOADR<='1'; 
                        end if;
                    when "10" => 
                        if(CARRY='1')then 
                            DOWN<='1';    
                            LOADR<='1'; 
                        end if;
                    when "11" =>
                        if(CARRY='0')then 
                            DOWN<='1';        
                            LOADR<='1'; 
                        end if;
                    when others => null;
                end case;
            elsif(S_FC(2)='0')then      
                DOWN<='1';        
                LOADR<='1'; 
            end if;     
        end if;     
        end if;                
    end process;  
end;
    
    