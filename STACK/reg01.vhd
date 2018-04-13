 entity reg is
	 port(A:in BIT_VECTOR(7 downto 0);
	 CLK:in BIT;
	 Y:out BIT_VECTOR(7 downto 0));
end;
architecture registry of reg is
begin
	process(CLK)
	begin
		if(CLK='1' and CLK'EVENT)then
			Y<=A ;
		end if; 	 
		
	end process;
end;