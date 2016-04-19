library ieee;
use ieee.std_logic_1164.all;

entity DataPath is 
port ( clock: in std_logic; 
ld_high,set_busy,clr_busy,ld_cnt,cnt_en,addr_sel,zero_We: in std_logic;
ld_low :in std_logic;
addr: in std_logic_vector(5 downto 0);
din: in std_logic_vector(7 downto 0);
writes: in std_logic;
cnt_eq : out std_logic; 
dout: out std_logic_vector(7 downto 0);
busy: out std_logic
);
end DataPath;
architecture DataPath of DataPath is   

signal dina,dinb,dcnt,addrm: std_logic_vector(5 downto 0);
signal dinm:std_logic_vector(7 downto 0);

begin
M1: entity work.registers  
GENERIC MAP (size => 8)
port map (

load => ld_high, 
din => addr,
dout => dout
);

M2: entity work.registers  
GENERIC MAP (size => 8)
port map (

load => ld_low,
din => addr,
dout => dcnt
);

M3: entity work.UpCounter 
GENERIC MAP (size => 6)
port map(
--clock => clock;
--dcnt => din;
--ld_cnt => load;
--cnt_en => enable;
--dinb => dout;

clock => clock,
din => dcnt, 
load => ld_cnt, 
enable => cnt_en, 
dout => dinb 
);

M4: entity work.jkflipflop port map(clock => clock, 
j => set_busy,
k => clr_busy, 
dout => busy  
);

M5: entity work.Mux2x1 
GENERIC MAP (size => 8)
port map(

d1 => dinb,  
d0 => addr, 
selectbit => addr_sel,  
dout => addrm

);

M6:entity work.Mux2x1 
GENERIC MAP (size => 8)
port map(

d1 => (others=>'0'),  
d0 => din, 
selectbit => addr_sel,
dout => dinm 
);

M7: entity work.comparator 
GENERIC MAP (size => 6)

port map (

dina => dina, 
dinb => dinb,
aEQb => cnt_eq
);
 
M8: entity work.memory 
generic map(data_width=> 8, addr_width => 6, memory_width => 64)    
port map ( 

addr => addrm, 
din => dinm,
writes => writes, 
dout => dout 
);  

end Datapath ; 