library ieee;
use ieee.std_logic_1164.all;
use ieee.Numeric_Std.all;

-- 64x8 memry block
-- declaring input and output 
entity memory is 
generic (data_width: INTEGER := 8; addr_width : INTEGER := 6 ; memory_width : INTEGER := 64);

	port(addr: in std_logic_vector(addr_width-1 downto 0);
		 din: in std_logic_vector(data_width-1 downto 0);
		 we:in std_logic ;
		 dout :out std_logic_vector(data_width-1 downto 0));
end memory;

architecture ram of memory is 
	type registers is array (0 to memory_width-1) of std_logic_vector(din'range); -- memory 64x8
	signal mem64x8 : registers;
begin  
dout <= mem64x8(to_integer(unsigned(addr)));  -- read the data from memory
process (din,we,addr)
begin
report "address="& integer'image(to_integer(unsigned(addr)));  -- print the address value to the console 
if (we = '1') then 
mem64x8(to_integer(unsigned(addr))) <= din; -- write data to memory
end if; 
end process;
end ram;	   