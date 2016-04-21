library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
-- declaring outputs and inputs 
entity UpCounter is 
generic (size: INTEGER := 6);
port ( clock,load,enable: in std_logic; 
	   din : in std_logic_vector(size-1 downto 0);
	   dout: out std_logic_vector(size-1 downto 0));
end UpCounter; 
architecture UpCounter of UpCounter is 
signal registers: std_logic_vector (5 downto 0) := "000000";
begin 
dout <= registers; -- writing address value to output port i.e. read from upcounter. 
process(clock)
begin 
if (clock'event and clock = '1') then
if (load = '1') then
registers <= din;  -- writing the input to upcounter register 
elsif (enable = '1') then 
	registers <= registers + '1'; -- up counting 
end if;	
end if;
end process;
end UpCounter;