library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
entity testbench is 

end testbench;



architecture behaviour of testbench is 
 -- component declaration for uut

Component datapath_controller
port( clock: in std_logic; 
zero,reset: in std_logic;
ld_low,ld_high :in std_logic;
addr: in std_logic_vector(5 downto 0);
din: in std_logic_vector(7 downto 0);
write: in std_logic;
dout: out std_logic_vector(7 downto 0);
busy: out std_logic  );
end component;

signal clock,zero,reset,ld_low,ld_high,write : std_logic := '0';
signal addr: std_logic_vector(5 downto 0) := "000000";
signal din :std_logic_vector(7 downto 0) := "00000000";
signal dout : std_logic_vector(7 downto 0) := "00000000";
signal busy : std_logic := '0';

constant clk_period : time := 50 ns;

signal one: std_logic := '1'; 
signal zeroo: std_logic := '1'; 
signal address: std_logic_vector(5 downto 0) := "001000";

begin 

uut : datapath_controller port map (
clock => clock,
zero => zero,
reset => reset,
ld_low => ld_low,
ld_high => ld_high,
write => write,
addr => addr, 
din => din,
dout => dout, 
busy => busy
);


-- clock process 
clk_process: process 
begin 
	clock <='0';
	wait for clk_period/2;
	clock <= '1';
	wait for clk_period/2;
end process;


-- stimuli process 
stimuli_process: process 
begin 

for I in 0 to 1 loop 
zero <= '1';
ld_low <= one;
ld_high <= zeroo; 
for j in 0 to 10 loop 
addr <= address;
write <= one;
din <= "01000000";
end loop; 
one <= not one;
zeroo <=  not zeroo;
address <= address + "000101"; 
end loop;

end process;
end behaviour;