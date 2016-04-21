library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
entity datapath_controller_tb is 

end datapath_controller_tb;

  

architecture behaviour of datapath_controller_tb is 
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

signal addr_low,addr_high:std_logic_vector(5 downto 0) ; 

constant clk_period : time := 10 ns;


-- begin architecture
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

stimuli: process
begin
	zero<='0';       			--zero mode
	wait for 2*clk_period; 
	ld_low<='1'; addr<="000001";  addr_low<="000001";
	wait for 2*clk_period; 
	ld_low<='0';
	ld_high<='1'; addr<="000111"; addr_high<="000111"; 
		wait for 2*clk_period;
	zero<='1'; ld_high<='0'; 
	wait for (to_integer(unsigned(addr_high))-to_integer(unsigned(addr_low )))*clk_period;   
	zero<='0';   
	wait for 2*clk_period;  --normal mode
	addr<="001000"; write<='1'; din<="10101010"; 
	wait for 2*clk_period;  
	addr<="001011"; din<="01010101"; 
	wait for 2*clk_period; 
  write<='0'; 	 
	wait for 2*clk_period; 
	 addr<="001000"; 
	wait for 2*clk_period; 
	addr<="001011"; 
	wait for 2*clk_period; 
	wait for 2*clk_period;  
	wait for 2*clk_period; 
	wait for 2*clk_period; 
	wait for 2*clk_period; 
	wait for 2*clk_period; 
	wait for 2*clk_period; 
	wait;
end process;
 

end behaviour;