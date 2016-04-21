library ieee;
use ieee.std_logic_1164.all;
-- declaring inputs and outputs
entity Mux2x1 is 
generic(size : INTEGER := 8); -- parameterizing the size value 
port ( d1: in std_logic_vector(size-1 downto 0);
	   d0: in std_logic_vector(size-1 downto 0);
	   selectbit : in std_logic; 
	   dout : out std_logic_vector(size-1 downto 0)
);
end Mux2x1;

architecture Mux of Mux2x1 is 
begin 
dout <= d1 when (selectbit = '1') else d0; 
end Mux; 
