library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity SUBCY is
    generic(
        NR_BITS: INTEGER := 8
    );                          
    port(
        FIRST_NUMBER: in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
        SECOND_NUMBER: in STD_LOGIC_VECTOR(NR_BITS - 1 downto 0);
        BORROW: inout STD_LOGIC;                           
        ZERO_FLAG: out STD_LOGIC;
        RESULT: out STD_LOGIC_VECTOR(NR_BITS - 1 downto 0)
    );
end;                                                      
                                  
architecture SUBCY_ARCHITECTURE of SUBCY is

signal INTERMEDIAR_RESULT: STD_LOGIC_VECTOR(NR_BITS downto 0);

begin
    RESULT <= INTERMEDIAR_RESULT(NR_BITS - 1 downto 0);
    BORROW <= INTERMEDIAR_RESULT(NR_BITS);
end;