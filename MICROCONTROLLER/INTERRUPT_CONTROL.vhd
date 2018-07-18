library ieee;
use ieee.std_logic_1164.all;

entity INTERRUPT_CONTROL is
    port(INTERRUPT:in BIT;
    INT_FLAG:in std_logic;
    INT:out BIT);
end;

architecture  INTERRUPT_CONTROL of INTERRUPT_CONTROL is
begin
    INT<=INTERRUPT when INT_FLAG = '1';
end;