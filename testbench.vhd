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

constant clk_period : time := 10 ns;

signal one: std_logic := '1'; 
signal zeroo: std_logic := '1'; 
signal address: std_logic_vector(5 downto 0) := "001000";




procedure writedata (a: in std_logic_vector(5 downto 0);
		     b: in std_logic_vector(7 downto 0);
		     ld_high_p: out std_logic;
		     ld_low_p: out std_logic; 
		     addr_p: out std_logic_vector(5 downto 0);
		     din_p: out std_logic_vector(7 downto 0);
		     zero_p: out std_logic;
		       write_p: out std_logic) is
begin 
ld_high_p := '0';
ld_low_p := '0';
addr_p := a ;
din_p := b; 
zero_p := '0';
write_p := '1';
end writedata;

procedure readdata (a: in std_logic_vector(5 downto 0);
		     b: in std_logic_vector(7 downto 0);
		     ld_high_p: out std_logic;
		     ld_low_p: out std_logic; 
		     addr_p: out std_logic_vector(5 downto 0);
		     din_p: out std_logic_vector(7 downto 0);
		     zero_p: out std_logic;
		       write_p: out std_logic) is
begin
-- wait until clock'event and clock = '1';
ld_high_p := '0';
ld_low_p := '0';
write_p := '0';
zero_p := '0';
din_p := (others => '1');
addr_p := a;
end readdata;

procedure zerodata (a: in std_logic_vector(5 downto 0);
		     b: in std_logic_vector(7 downto 0);
		     ld_high_p: out std_logic;
		     ld_low_p: out std_logic; 
		     addr_p: out std_logic_vector(5 downto 0);
		     din_p: out std_logic_vector(7 downto 0);
		     zero_p: out std_logic;
		       write_p: out std_logic) is
begin 
-- wait until clock'event and clock = '1';
write_p := '0';
zero_p := '0';
addr_p := a; 
ld_low_p := '1';
--wait for clk_period/5;
ld_low_p := '0';
addr_p := a; 
ld_high_p := '1';
--wait for clk_period/5;
ld_high_p := '0';
zero_p :='1';
addr_p := "111111";
din_p := "11111111";
end zerodata; 
--
--


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




stimuli: process (clock)
variable ld_high_var,ld_low_var,zero_var,write_var : std_logic; 
variable addr_var :std_logic_vector(5 downto 0);
variable din_var: std_logic_vector (7 downto 0);
variable j: integer :=0;
begin 
reset <= one; 

L1: for I in 1 to 3 loop
reset <= zeroo;

L2 : while (clock'event and clock = '1') loop
writedata("000100","00011100",ld_high_var,ld_low_var,addr_var,din_var,zero_var,write_var);
ld_high <= ld_high_var; 
ld_low <= ld_low_var;
addr <=addr_var;
din <= din_var; 
zero <= zero_var;
write <= write_var;
j:= j+1;
exit L2 when j = 1;
end loop L2;

L3 : while (clock'event and clock = '1') loop
readdata("000100", "11111110", ld_high_var,ld_low_var,addr_var,din_var,zero_var,write_var);
ld_high <= ld_high_var; 
ld_low <= ld_low_var;
addr <=addr_var;
din <= din_var; 
zero <= zero_var;
write <= write_var;
j:= j+1;
exit L3 when j = 4;
end loop L3;



L4: while(clock'event and clock ='1') loop
zerodata("000101", "11111110", ld_high_var,ld_low_var,addr_var,din_var,zero_var,write_var);
ld_high <= ld_high_var; 
ld_low <= ld_low_var;
addr <=addr_var;
din <= din_var; 
zero <= zero_var;
write <= write_var;
j:=j+1;
exit L4 when j = 6;
end loop L4;

end loop L1; 

end process;
end behaviour;