--git is tested here
library ieee;
use ieee.std_logic_1164.all;
entity Comparator is 
generic (size : integer := 6);
port (dina: in std_logic_vector(size-1 downto 0);
	  dinb: in std_logic_vector(size -2 downto 0);
	  aEQb : out std_logic 
	   );
end Comparator;

architecture Comparator of Comparator is 
begin 
process (dina,dinb)
begin
if (dina != dinb) then 
aEQb <= '1';
else 
aEQb <= '0';
end if;
end process;
end Comparator;		