library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity controller is
	port (clock,zero,reset,cnt_eq:IN std_logic; 
			cnt_en,set_busy,
			clr_busy,ld_cnt,addr_sel,zero_we:OUT std_logic);
end controller; 

architecture Behavioral of controller is 


TYPE state_type IS (INITIAL,LOAD,WR);         
SIGNAL present_state,next_state: state_type;

begin

process(clock)
begin
	if rising_edge(clock) then 
			if reset='1' then 
				present_state<=INITIAL;
			else
				present_state<=next_state; 
			end if;
				
	end if; 
end process;

process(present_state)
begin
	case present_state is
		when INITIAL=> 
			set_busy <= '0';
			clr_busy<='1' ;
			ld_cnt<='0';
			cnt_en<='0';
			addr_sel<='0';
			zero_we<='0';
		when LOAD=>
			set_busy <='1';
			clr_busy<='0';
			ld_cnt<='1';
			cnt_en<='0';
			addr_sel<='0';
			zero_we<='0';
		when WR=>
			set_busy <= '1';
			clr_busy<='0';
			ld_cnt<='0';
			cnt_en<='1';
			addr_sel<='1';
			zero_we<='1';
	end case;
end process;


process (present_state,zero,cnt_eq)
begin
	case present_state is
		when INITIAL=>
			if zero='1' then 
				next_state <= LOAD;
			else 
				next_state <=INITIAL; 
			end if;
		when LOAD=>
			next_state <= WR;
		when WR=>
			if cnt_eq='1' then
				next_state <= INITIAL;
			else 
				next_state <= WR;
			end if; 
	end case;
end process;

end Behavioral; 

