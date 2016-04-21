library ieee; 
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- declaring port inputs and outputs  
entity jkflipflop is 
port (clock,j,k: in std_logic;
	  q: out std_logic 
);
end jkflipflop; 

architecture jflipflop of jkflipflop is 
begin 
process (clock)
variable tmp:std_logic;
begin
if (clock ='1' and clock'event) then  
if (j = '1' and k = '1') then 
tmp := not tmp; 
-- set the busy output				
elsif (j = '1' and k = '0') then 
tmp := '1';		
-- clear the busy output
elsif (j = '0' and k = '1') then 
tmp := '0';
else 
tmp := tmp;
end if;
end if;
-- busy output assignment
q <= tmp;
end process;  
end jflipflop;




