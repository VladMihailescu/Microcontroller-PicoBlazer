library IEEE;
use IEEE.std_logic_1164.all; 

entity PORT_CONTROL is
    port(CONST_IN:in STD_LOGIC_VECTOR(7 downto 0);
        ENABLE:in STD_LOGIC; 
        REG_IN:in STD_LOGIC_VECTOR(7 downto 0);
        CONST_REG_SEL:in STD_LOGIC;
        IN_OUT_SEL:in STD_LOGIC;
        SEL_OUTPUT:out STD_LOGIC_VECTOR(7 downto 0);
        SEL_INPUT:out STD_LOGIC_VECTOR(7 downto 0)
    );
end;

architecture PORT_CONTROL of PORT_CONTROL is
begin
    process(CONST_IN,ENABLE,REG_IN,CONST_REG_SEL,IN_OUT_SEL)
    variable selection:STD_LOGIC_VECTOR(7 downto 0);
    begin
        if ENABLE='1' then
            if CONST_REG_SEL='0' then                 --port_id se afla in intrarea CONST_IN
                selection:=CONST_IN;
            elsif CONST_REG_SEL='1' then             --port_id se afla in intrarea REG_IN 
                selection:=REG_IN;
            end if;
            if IN_OUT_SEL='0' then                     --se folosesc porturile de intrare
                SEL_INPUT<=selection;
            elsif IN_OUT_SEL='1' then                --se folosesc porturile de iesire
                SEL_OUTPUT<=selection;
            end if;
        end if;
    end process;
end;