library ieee;
use ieee.std_logic_1164.all;
-- declaring the inputs and outputs
entity registers is 
generic (size: INTEGER:= 6);
	port(load: in std_logic;
		 din: in std_logic_vector(size-1 downto 0);
		 dout: out std_logic_vector(size-1 downto 0)
	);
end registers;

architecture registers of registers is 
signal reg : std_logic_vector (size-1 downto 0) := "000000";
begin  
dout <= reg; -- reading from the register 
process(load,din) 
begin 
if (load = '1') then
reg <= din; -- writing address in to the register
end if;
end process;   
end registers;	