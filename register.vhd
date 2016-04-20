library ieee;
use ieee.std_logic_1164.all;

entity registers is 
--generic (size: INTEGER:= 6);
	port(load: in std_logic;
		 dinreg: in std_logic_vector(5 downto 0);
		 doutreg: out std_logic_vector(5 downto 0)
	);
end registers;

architecture registers of registers is 
signal reg : std_logic_vector (5 downto 0) := "000000";
begin 
doutreg <= reg; 
process(load,dinreg)
begin 
if (load = '1') then
reg <= dinreg;
end if;
end process;
end registers;	