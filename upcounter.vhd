library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity UpCounter is 
generic (size: INTEGER := 6);
port ( clock,load,enable: in std_logic; 
	   dincounter : in std_logic_vector(size-1 downto 0);
	   doutcounter: out std_logic_vector(size-1 downto 0));
end UpCounter; 
architecture UpCounter of UpCounter is 
signal registers: std_logic_vector (5 downto 0) := "000000";
begin 
doutcounter <= registers;
process(clock)
begin 
if (clock'event and clock = '1') then
if (load = '1') then
registers <= dincounter;
elsif (enable = '1') then 
	registers <= registers + '1';
end if;	
end if;
end process;
end UpCounter;