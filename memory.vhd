library ieee;
use ieee.std_logic_1164.all;
use ieee.Numeric_Std.all;

 
entity memory is 
generic (data_width: INTEGER := 8; addr_width : INTEGER := 6 ; memory_width : INTEGER := 64);

	port(addr: in std_logic_vector(addr_width-1 downto 0);
		 dinmemory: in std_logic_vector(data_width-1 downto 0);
		 we:in std_logic ;
		 doutmemory :out std_logic_vector(data_width-1 downto 0));
end memory;

architecture ram of memory is 
	type registers is array (0 to memory_width-1) of std_logic_vector(dinmemory'range);
	signal mem64x8 : registers;
begin  
doutmemory <= mem64x8(to_integer(unsigned(addr)));
process (dinmemory,we,addr)
begin
if (we = '1') then 
mem64x8(to_integer(unsigned(addr))) <= dinmemory;
end if; 
end process;
end ram;	   