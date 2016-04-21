library ieee;
use ieee.std_logic_1164.all;

entity DataPath is 
-- declaring inputs and ouputs to datapath
port ( clock: in std_logic; 
set_busy,clr_busy,ld_cnt,cnt_en,addr_sel,zero_we: in std_logic;
ld_low,ld_high :in std_logic;
addr: in std_logic_vector(5 downto 0);
din: in std_logic_vector(7 downto 0);
write: in std_logic; 
aEQb : out std_logic;  
dout: out std_logic_vector(7 downto 0);
busy: out std_logic 
);
end DataPath; 
 
architecture DataPath of DataPath is   

signal dout_R1_din_a,dout_R2_din,dout_counter,M1_addr:std_logic_vector(5 downto 0); 
signal M2_din:std_logic_vector(7 downto 0);
signal we:std_logic; 

begin
we<=write or zero_we;     

-- register module portmap
R1: entity work.registers  
GENERIC MAP (size => 6)
port map (  

load => ld_high, 
din => addr,
--dout => dout
dout=>dout_R1_din_a  
);

-- register module portmap
R2: entity work.registers  
GENERIC MAP (size => 6)
port map (

load => ld_low,
din => addr,
--dout => dcnt
dout=>dout_R2_din
);

-- upcounter module portmap
counter: entity work.UpCounter 
GENERIC MAP (size => 6)
port map(

clock => clock,
--din => dcnt,
din => dout_R2_din, 
load => ld_cnt, 
enable => cnt_en, 
--dout => dinb
dout => dout_counter   
);

-- jkflipflop module portmap
JKFF: entity work.jkflipflop port map(
clock => clock, 
j => set_busy,
k => clr_busy, 
q => busy  
);

-- mux module portmap
M1: entity work.Mux2x1 
GENERIC MAP (size => 6)
port map(

--d1 => dinb,
d1=>dout_counter,  
d0=> addr,  
selectbit => addr_sel,  
dout => M1_addr

);
-- mux module portmap
M2:entity work.Mux2x1 
GENERIC MAP (size => 8)
port map(

d1 => (others=>'0'),  
d0 => din, 
selectbit => addr_sel,
dout => M2_din
);

-- comparator module portmap
M7: entity work.comparator 
GENERIC MAP (size => 6)
 
port map (
dina => dout_R1_din_a, 
dinb => dout_counter,
aEQb => aEQb
);
 
-- memory module portmap
M8: entity work.memory 
generic map(data_width=> 8, addr_width => 6, memory_width => 64)    
port map ( 

addr => M1_addr, 
din => M2_din,
we => we,   
dout => dout 
);   

end Datapath ; 