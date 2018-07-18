library IEEE;
use IEEE.std_logic_1164.all; 

package in_out_mat is 
    type matrice is array (0 to 255) of STD_LOGIC_VECTOR(7 downto 0);
end package ; 


library IEEE;
use IEEE.std_logic_1164.all;
use in_out_mat.all;

entity input is
    port(IN_MAT: in matrice;
        ENABLE:in STD_LOGIC;
        SEL:in STD_LOGIC_VECTOR(7 downto 0);
        OUT_DATA:out STD_LOGIC_VECTOR(7 downto 0)
    );      
end;

architecture input of input is
begin
    process(IN_MAT,SEL,ENABLE)
    variable selection: integer range 0 to 255;
    begin 
    if ENABLE='1' then
        selection:=0;
        if SEL(0)='1' then
            selection:=selection + 1;
        end if;
        if SEL(1)='1' then
            selection:=selection + 2;
        end if;
        if SEL(2)='1' then
            selection:=selection + 4;
        end if;
        if SEL(3)='1' then
            selection:=selection + 8;
        end if;
        if SEL(4)='1' then
            selection:=selection + 16;
        end if;
        if SEL(5)='1' then
            selection:=selection + 32;
        end if; 
        if SEL(6)='1' then
            selection:=selection + 64;
        end if; 
        if SEL(7)='1' then
            selection:=selection + 128;
        end if;
        OUT_DATA<=IN_MAT(selection); 
    end if;
    end process;
end; 


library IEEE;
use IEEE.std_logic_1164.all;  
use in_out_mat.all;

entity output is
    port(IN_DATA: in STD_LOGIC_VECTOR(7 downto 0); 
        ENABLE:in STD_LOGIC;
        SEL:in STD_LOGIC_VECTOR(7 downto 0);
        OUT_MAT:out matrice
    );      
end;

architecture output of output is
begin
    process(IN_DATA,SEL,ENABLE)
    variable selection: integer range 0 to 255;
    begin
    if ENABLE='1' then
        selection:=0;
        if SEL(0)='1' then
            selection:=selection + 1;
        end if;
        if SEL(1)='1' then
            selection:=selection + 2;
        end if;
        if SEL(2)='1' then
            selection:=selection + 4;
        end if;
        if SEL(3)='1' then
            selection:=selection + 8;
        end if;
        if SEL(4)='1' then
            selection:=selection + 16;
        end if;
        if SEL(5)='1' then
            selection:=selection + 32;
        end if; 
        if SEL(6)='1' then
            selection:=selection + 64;
        end if; 
        if SEL(7)='1' then
            selection:=selection + 128;
        end if;
        OUT_MAT(selection)<=IN_DATA;
    end if;
    end process;
end;