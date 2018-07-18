library ieee;
use ieee.std_logic_1164.all;  

library ieee;
use ieee.std_logic_1164.all;                               
entity ROM is
    port(ADDRESS:in integer range 0 to 255;
    OUTPUT:out STD_LOGIC_VECTOR(15 downto 0)
    ); 
end;    

architecture ROM of ROM is
type INTERNAL  is array (0 to 255)of STD_LOGIC_VECTOR (15 downto 0);
begin
    process(ADDRESS)
    variable data: INTERNAL:=(
        "1000000000110000",
        "1000110100000101",
        "0100001100000010",
        "0100010100000100",
        "1000110010000000",
        "0100000000000001",
        "1000111100000010",
        "0000111100000000",
        "0000111100000000",
        "0000111100000000",
        "0000111100000000",
        "0000111100000000",
        "0000111100000000",
        "0000111100000000",
        "0000111100000000",
        "0000111100000000",
        "0000111100000000",
        "0000111100000000",
        "0000111100000000",
        "0000111100000000",
        "0000001000000011",
        "1000000011010000",
    others => "0000000000000000" );
    
    begin
        OUTPUT<=data(ADDRESS);
    end process;
end;