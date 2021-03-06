library ieee;
use ieee.std_logic_1164.all;

entity DataPath is 
port ( clock: in std_logic; 
set_busy,clr_busy,ld_cnt,cnt_en,addr_sel,zero_we: in std_logic;
ld_low,ld_high :in std_logic;
addr: in std_logic_vector(5 downto 0);
din: in std_logic_vector(7 downto 0);
write: in std_logic;
--cnt_eq : out std_logic; 
aEQb : out std_logic;  
dout: out std_logic_vector(7 downto 0);
busy: out std_logic 
);
end DataPath;

architecture DataPath of DataPath is   

signal dout_R1_din_a,dout_R2_din,dout_counter,M1_addr:std_logic_vector(5 downto 0); 
--signal dina,dinb,dcnt,addrm: std_logic_vector(5 downto 0);
--signal dinm:std_logic_vector(7 downto 0);
signal M2_din:std_logic_vector(7 downto 0);
signal temp: std_logic;
 
begin
temp <= write or zero_we;
R1: entity work.registers  
--GENERIC MAP (size => 8)
port map (

load => ld_high, 
dinreg => addr,
--dout => dout
doutreg =>dout_R1_din_a 
);

R2: entity work.registers  
--GENERIC MAP (size => 8)
port map (

load => ld_low,
dinreg => addr,
--dout => dcnt
doutreg =>dout_R2_din
);

counter: entity work.UpCounter 
--GENERIC MAP (size => 6)
port map(

clock => clock,
--din => dcnt,
dincounter => dout_R2_din, 
load => ld_cnt, 
enable => cnt_en, 
--dout => dinb
doutcounter => dout_counter   
);

JKFF: entity work.jkflipflop port map(
clock => clock, 
j => set_busy,
k => clr_busy, 
q => busy  
);

M1: entity work.Mux2x1
GENERIC MAP (size => 6)
port map(

--d1 => dinb,
d1=>dout_counter,  
d0=> addr,  
selectbit => addr_sel,  
doutmux => M1_addr

);

M2:entity work.Mux2x1 
GENERIC MAP (size => 8)
port map(

d1 => (others=>'0'),  
d0 => din, 
selectbit => addr_sel,
doutmux => M2_din
);

M7: entity work.comparator 
GENERIC MAP (size => 6)
 
port map (
dina => dout_R1_din_a, 
dinb => dout_counter,
aEQb => aEQb
);
 
M8: entity work.memory 
generic map(data_width=> 8, addr_width => 6, memory_width => 64)    
port map ( 

addr => M1_addr, 
dinmemory => M2_din,
we => temp,  
doutmemory => dout 
);   

end Datapath ; 