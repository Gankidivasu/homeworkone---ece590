library ieee; 
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
 
entity jkflipflop is 
port (clock,j,k: in std_logic;
	  dout: out std_logic 
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
elsif (j = '1' and k = '0') then 
tmp := '1';
elsif (j = '0' and k = '1') then 
tmp := '0';
else 
tmp := tmp;
end if;
end if;
--dout <= tmp;
end process; 
end jflipflop;




