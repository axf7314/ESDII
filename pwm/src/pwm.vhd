
library ieee;
use ieee.std_logic_1164.all;      
use ieee.numeric_std.all;

entity pwm is
  generic (
    max_count       : integer := 25000000
  );
  port (
    clk             : in  std_logic; 
    reset           : in  std_logic;
    enable          : in  std_logic;
    period          : in  std_logic_vector(20 downto 0);
    duty            : in  std_logic_vector(20 downto 0);
    
    output          : out std_logic
  );  
end pwm;  

architecture beh of pwm  is

signal count_sig    : std_logic_vector(20 downto 0);
signal output_sig   : std_logic;

-- include an enable bit. When enable = 1 then pulse/output_sig toggles. 
-- when enable = 0 then pulse/output_sig stays at 0.

begin
process(clk,reset)
  begin
    if (reset = '1') then  --reset to 0
      count_sig <= (others => '0');
      output_sig <= '0';
    else if (clk'event and clk = '1') then
    if (enable = '1') then  --enable pulse
    count_sig <= std_logic_vector(unsigned(count_sig) + 1);
      if (count_sig > duty) then
        output_sig <= '0';
      if (count_sig = period) then 
        output_sig <= '1';
        count_sig <= (others => '0');
     end if;
      end if; 
      end if;
    end if;
    end if;
  end process;
  
  output <= output_sig;
end beh;