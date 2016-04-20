library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity datapath_controller is
port( clock: in std_logic; 
zero,reset: in std_logic;
ld_low,ld_high :in std_logic;
addr: in std_logic_vector(5 downto 0);
din: in std_logic_vector(7 downto 0);
write: in std_logic;
dout: out std_logic_vector(7 downto 0);
busy: out std_logic  );
end datapath_controller;

architecture Behavioral of datapath_controller is
signal set_busy,clr_busy,ld_cnt,cnt_en,addr_sel,zero_we,aEQb_cnt_eq:std_logic; 
begin

controller: entity work.controller 
	port map (clock =>clock,zero=>zero,reset=>reset,cnt_eq=>aEQb_cnt_eq,  
			cnt_en=>cnt_en,set_busy=>set_busy,
			clr_busy=>clr_busy,ld_cnt=>ld_cnt,addr_sel=>addr_sel,zero_we=>zero_we);

datapath: entity work.DataPath 
port map( clock=>clock, 
set_busy=>set_busy,clr_busy=>clr_busy,ld_cnt=>ld_cnt,cnt_en=>cnt_en,addr_sel=>addr_sel,zero_we=>zero_we,
ld_low=>ld_low,ld_high=>ld_high,
addr=>addr, 
din=>din,
write=>write, 
aEQb=>aEQb_cnt_eq, 
dout=>dout,
busy=>busy
);  

end Behavioral; 

 