----------------------------------------------------------------------------------
-- Company: The University of Hong Kong
--
-- Engineer: Hui Chak Yan
-- 
-- Create Date: 2020/10/24 04:16:55 PM
--
-- Design Name: Universal Asynchronous Receiver / Transmitter
--
-- Module Name: UART - Behavioral
--
-- Project Name: Morse Code Decoder
--
-- Target Devices: 
--
-- Tool Versions: 
--
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
--
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
-- use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
-- library UNISIM;
-- use UNISIM.VComponents.all;

entity UART is
    Port (
			din:  in STD_LOGIC_VECTOR(7 downto 0);
			wen:  in STD_LOGIC;
			clk:  in STD_LOGIC;
			clr:  in STD_LOGIC;
			sout: out STD_LOGIC);
    end UART;

architecture Behavioral of UART is

type state_type is (reset, idle, stop, S0, S1, S2, S3, S4, S5, S6, S7);
signal state, next_state: state_type;

signal counter: integer := 0;
signal input: STD_LOGIC_VECTOR(7 downto 0);
signal flag: STD_LOGIC;

begin
proc_statereg: process (clk, clr)
	begin
		if (clr = '1') then
			state <= idle;
			counter <= 0;
		end if;
		if (clk = '1' and clk'event) then
			counter <= counter +1; 
			if (counter mod 5 = 0) then
				state<=next_state;
			end if;
		end if;
	end process;

proc_output: process (state)
	begin
		if (state = idle) then
			sout <= '1';
		elsif (state = reset) then
			sout <= '0';
		elsif (state = S0) then
			sout <= input(0);
		elsif (state = S1) then
			sout <= input(1);
		elsif (state = S2) then
			sout <= input(2);
		elsif (state = S3) then
			sout <= input(3);
		elsif (state = S4) then
			sout <= input(4);
		elsif (state = S5) then
			sout <= input(5);
		elsif (state = S6) then
			sout <= input(6);
		elsif (state = S7) then
			sout <= input(7);
		elsif (state = stop) then
			sout <= '1';
		end if;
    end process;
      
proc_ns: process(state, counter, wen)
    begin  
		if (wen = '1') then
			for i in 7 downto 0 loop
				input(i) <=  din(i);    
			end loop;
			flag <= '1';
        end if;
        if (counter mod 5 = 0) then
            if (state = idle and flag = '1') then 
                next_state <= reset;
            elsif (state = reset) then
                next_state <= S0;
            elsif (state = S0) then
                next_state <= S1;
            elsif (state = S1) then
                next_state <= S2;
            elsif (state = S2) then
                next_state <= S3;
            elsif (state = S3) then
                next_state <= S4;
            elsif (state = S4) then
                next_state <= S5;
            elsif (state = S5) then
                next_state <= S6; 
            elsif (state = S6) then
                next_state <= S7;   
            elsif (state = S7) then
                next_state <= stop;
            elsif (state = stop) then
                next_state <= reset;  
                flag <= '0';          
            end if;    
        end if;
    end process;
end Behavioral;