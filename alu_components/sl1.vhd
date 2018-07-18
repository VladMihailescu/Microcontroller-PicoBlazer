library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity SL1 is
    generic(
        NR_BITS:INTEGER := 8
    );                         
    port(
        FIRST_NUMBER:in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
        RESULT:out STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);    
        ZERO_FLAG: out STD_LOGIC;
        CARRY_FLAG: out STD_LOGIC
    );
end entity SL1;


architecture SL1_ARCHITECTURE of SL1 is
begin                                                     
    P1:process(FIRST_NUMBER)
    variable AUXILIAR: STD_LOGIC;
    variable INTERMEDIAR_RESULT_ZERO: STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
    begin                                                   
        AUXILIAR := FIRST_NUMBER(NR_BITS - 1);
        RESULT <= FIRST_NUMBER(NR_BITS - 2 downto 0) & '1';
        CARRY_FLAG <= AUXILIAR;
        
        INTERMEDIAR_RESULT_ZERO := FIRST_NUMBER(NR_BITS - 2 downto 0) & '1';
        ZERO_FLAG <= '0'; 
    end process P1;                                            
end architecture SL1_ARCHITECTURE;