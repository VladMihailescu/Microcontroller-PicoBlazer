library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity LOAD is 
    generic(
        NR_BITS: INTEGER := 8
    );                          
    port(
        FIRST_NUMBER: in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
        RESULT: out STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
        ZERO_FLAG: out STD_LOGIC
    );
    
end entity LOAD;

architecture LOAD_ARCHITECTURE of LOAD is

begin
    RESULT <= FIRST_NUMBER;
    
    process(FIRST_NUMBER)                                                       
    begin            
        if(FIRST_NUMBER = "00000000") then
            ZERO_FLAG <= '1';
        else
            ZERO_FLAG <= '0';
        end if;
    end process;

end architecture LOAD_ARCHITECTURE;