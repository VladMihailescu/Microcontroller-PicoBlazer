entity dec is
	port(A: in BIT_VECTOR(3 downto 0);	
	B:out integer range 0 to 15);
end;
architecture decoder of dec is
begin
	process(A)
	variable rez:integer range 0 to 15 :=0;   
	begin  
		rez:=0;
		if(A(0)='1')then
			rez:=1;
		end if;	   
		if(A(1)='1')then
			rez:=rez + 2;
		end if;
		if(A(2)='1')then
			rez:=rez + 4;
		end if;
		if(A(3)='1')then
			rez:=rez + 8;
		end if;	 
		B<=rez;
	end process;
end;