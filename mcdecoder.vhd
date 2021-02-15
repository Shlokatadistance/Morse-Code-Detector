library IEEE;
use IEEE.std_logic_1164.ALL;

entity mcdecoder is
    Port (dot:    in std_logic;
          dash:   in std_logic;
          lg:     in std_logic;
          wg:     in std_logic;
          valid:  in std_logic;
          dout:   out std_logic_VECTOR (7 downto 0);
          dvalid: out std_logic;
          error:  out std_logic;
          clr:    in std_logic;
          clk:    in std_logic);
end mcdecoder;

architecture Behavioral of mcdecoder is
   type state_type is (st1_reset, space, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, digit0, digit1, digit2, digit3, digit4, digit5, digit6, digit7, digit8, digit9, err);
   signal state, next_state : state_type;
begin
   --A clock process for state register
   proc_statereg: process (clk, clr)
   begin
      if (clr = '1') then
         -- jump to st1_reset state here
         state <= st1_reset;
     end if;
     if (clk'event and clk = '1') then
         state <= next_state;
      end if;
   end process;
   
   --MEALY State-Machine - Outputs based on state and inputs
   proc_output: process (state, lg, wg, valid)
   begin
      --insert statements to decode internal output signals
      --below is simple example
     if valid = '0' and state = space and wg = '1' then
            dvalid <= '1';
            dout <= "00100000";
     elsif (lg = '1' or wg = '1')  and valid = '1' then
        dvalid <= '1';
        if state = space and wg = '1' and valid = '1' then
            dout <= "00100000";
      -- Digits
      elsif state = digit0 then
          dout <= "00110000";
      elsif state = digit1 then
          dout <= "00110001";
      elsif state = digit2 then
          dout <= "00110010";
      elsif state = digit3 then
          dout <= "00110011";
      elsif state = digit4 then
          dout <= "00110100";
      elsif state = digit5 then
          dout <= "00110101";
      elsif state = digit6 then
          dout <= "00110110";
      elsif state = digit7 then
          dout <= "00110111";
      elsif state = digit8 then
          dout <= "00111000";
      elsif state = digit9 then
          dout <= "00111001";
        elsif state = A then
            dout <= "01000001";
        elsif state = B then
            dout <= "01000010";
        elsif state = C then
            dout <= "01000011";
        elsif state = D then
            dout <= "01000100";
        elsif state = E then
            dout <= "01000101";
        elsif state = F then
            dout <= "01000110";
        elsif state = G then
            dout <= "01000111";
        elsif state = H then
            dout <= "01001000";
        elsif state = I then
            dout <= "01001001";
        elsif state = J then
            dout <= "01001010";
        elsif state = K then
            dout <= "01001011";
        elsif state = L then
            dout <= "01001100";
        elsif state = M then
            dout <= "01001101";
        elsif state = N then
            dout <= "01001110";
        elsif state = O then
            dout <= "01001111";
        elsif state = P then
            dout <= "01010000";
        elsif state = Q then
            dout <= "01010001";
        elsif state = R then
            dout <= "01010010";
        elsif state = S then
            dout <= "01010011";
        elsif state = T then
            dout <= "01010100";
        elsif state = U then
            dout <= "01010101";
        elsif state = V then
            dout <= "01010110";
        elsif state = W then
            dout <= "01010111";
        elsif state = X then
            dout <= "01011000";
        elsif state = Y then
            dout <= "01011001";
        elsif state = Z then
            dout <= "01011010";
          -- Error states
        elsif state = err then
            dvalid <= '0';
            error <= '1';
        end if;
    else
        dvalid <= '0';
        if state = space then
            dout <= "00000001";
       end if;
    end if;
   end process;
   
   -- Next State Logic.
   proc_ns: process ( lg, wg, state, dot, dash, valid)
   begin
      --declare default state for next_state to avoid latches
      next_state <= state;  --default is staying in current state
	  
      if wg = '1' and valid = '1' then
        next_state <= space;
      elsif lg = '1' and valid = '1' then
        next_state <= st1_reset;
      else
          case (state) is
             when A =>
                if valid = '1' and dot = '1' then
                    next_state <= R;
                elsif valid = '1' and dash = '1' then
                    next_state <= W;
                else
                    next_state <= state;
                end if;
            when B =>
                if valid = '1' and dot = '1' then
                    next_state <= digit6;
                elsif valid = '1' and dash = '1' then
                    next_state <= err;
                else
                    next_state <= state;
                end if;
            when C =>
                if valid = '1' and dot = '1' then
                    next_state <= st1_reset;
                elsif valid = '1' and dash = '1' then
                    next_state <= st1_reset;
                else
                    next_state <= state;
                end if;
             when D =>
                   if valid = '1' and dot = '1' then
                       next_state <= B;
                   elsif valid = '1' and dash = '1' then
                       next_state <= X;
                   else
                       next_state <= state;
                   end if;
               when E =>
                   if valid = '1' and dot = '1' then
                       next_state <= I;
                   elsif valid = '1' and dash = '1' then
                       next_state <= A;
                   else
                       next_state <= state;
                   end if;
               when F =>
                   if valid = '1' and dot = '1' then
                       next_state <= st1_reset;
                   elsif valid = '1' and dash = '1' then
                       next_state <= st1_reset;
                   else
                       next_state <= state;
                   end if;
             when G =>
                      if valid = '1' and dot = '1' then
                          next_state <= Z;
                      elsif valid = '1' and dash = '1' then
                          next_state <= Q;
                      else
                          next_state <= state;
                      end if;
                  when H =>
                      if valid = '1' and dot = '1' then
                          next_state <= digit5;
                      elsif valid = '1' and dash = '1' then
                          next_state <= digit4;
                      else
                          next_state <= state;
                      end if;
                  when I =>
                      if valid = '1' and dot = '1' then
                          next_state <= S;
                      elsif valid = '1' and dash = '1' then
                          next_state <= U;
                      else
                          next_state <= state;
                      end if;
                   when J =>
                         if valid = '1' and dot = '1' then
                             next_state <= err;
                         elsif valid = '1' and dash = '1' then
                             next_state <= digit1;
                         else
                             next_state <= state;
                         end if;
                     when K =>
                         if valid = '1' and dot = '1' then
                             next_state <= C;
                         elsif valid = '1' and dash = '1' then
                             next_state <= Y;
                         else
                             next_state <= state;
                         end if;
                     when L =>
                         if valid = '1' and dot = '1' then
                             next_state <= st1_reset;
                         elsif valid = '1' and dash = '1' then
                             next_state <= st1_reset;
                         else
                             next_state <= state;
                         end if;
                        when M =>
                            if valid = '1' and dot = '1' then
                                next_state <= G;
                            elsif valid = '1' and dash = '1' then
                                next_state <= O;
                            else
                                next_state <= state;
                            end if;
                        when N =>
                            if valid = '1' and dot = '1' then
                                next_state <= D;
                            elsif valid = '1' and dash = '1' then
                                next_state <= K;
                            else
                                next_state <= state;
                            end if;
                        when O =>
                            if valid = '1' and dot = '1' then
                                next_state <= err;
                            elsif valid = '1' and dash = '1' then
                                next_state <= err;
                            else
                                next_state <= state;
                            end if;

                         when P =>
                               if valid = '1' and dot = '1' then
                                   next_state <= st1_reset;
                               elsif valid = '1' and dash = '1' then
                                   next_state <= st1_reset;
                               else
                                   next_state <= state;
                               end if;
                           when Q =>
                               if valid = '1' and dot = '1' then
                                   next_state <= st1_reset;
                               elsif valid = '1' and dash = '1' then
                                   next_state <= st1_reset;
                               else
                                   next_state <= state;
                               end if;
                           when R =>
                               if valid = '1' and dot = '1' then
                                   next_state <= L;
                               elsif valid = '1' and dash = '1' then
                                   next_state <= err;
                               else
                                   next_state <= state;
                               end if;
                         when S =>
                                  if valid = '1' and dot = '1' then
                                      next_state <= H;
                                  elsif valid = '1' and dash = '1' then
                                      next_state <= V;
                                  else
                                      next_state <= state;
                                  end if;
                              when T =>
                                  if valid = '1' and dot = '1' then
                                      next_state <= N;
                                  elsif valid = '1' and dash = '1' then
                                      next_state <= M;
                                  else
                                      next_state <= state;
                                  end if;
                              when U =>
                                  if valid = '1' and dot = '1' then
                                      next_state <= F;
                                  else
                                      next_state <= state;
                                  end if;

                               when V =>
                                     if valid = '1' and dot = '1' then
                                         next_state <= err;
                                     elsif valid = '1' and dash = '1' then
                                         next_state <= digit3;
                                     else
                                         next_state <= state;
                                     end if;
                                 when W =>
                                     if valid = '1' and dot = '1' then
                                         next_state <= P;
                                     elsif valid = '1' and dash = '1' then
                                         next_state <= J;
                                     else
                                         next_state <= state;
                                     end if;
                                 when X =>
                                     if valid = '1' and dot = '1' then
                                         next_state <= st1_reset;
                                     elsif valid = '1' and dash = '1' then
                                         next_state <= st1_reset;
                                     else
                                         next_state <= state;
                                     end if;
                                    when Y =>
                                        if valid = '1' and dot = '1' then
                                            next_state <= st1_reset;
                                        elsif valid = '1' and dash = '1' then
                                            next_state <= st1_reset;
                                        else
                                            next_state <= state;
                                        end if;
                                    when Z =>
                                        if valid = '1' and dot = '1' then
                                            next_state <= digit7;
                                        elsif valid = '1' and dash = '1' then
                                            next_state <= err;
                                        else
                                            next_state <= state;
                                        end if;
                                    when digit0 =>
                                        if valid = '1' and (dot = '1' or dash = '1') then
                                            next_state <= st1_reset;
                                        else
                                            next_state <= state;
                                        end if;
                                     when digit1 =>
                                           if valid = '1' and (dot = '1' or dash = '1') then
                                             next_state <= st1_reset;
                                           else
                                               next_state <= state;
                                           end if;
                                       when digit2 =>
                                           if valid = '1' and (dot = '1' or dash = '1') then
                                               next_state <= st1_reset;
                                           else
                                               next_state <= state;
                                           end if;
                                       when digit3 =>
                                           if valid = '1' and (dot = '1' or dash = '1') then
                                               next_state <= st1_reset;
                                           else
                                               next_state <= state;
                                           end if;
                                     when digit4 =>
                                       if valid = '1' and (dot = '1' or dash = '1') then
                                           next_state <= st1_reset;
                                       else
                                           next_state <= state;
                                       end if;
                                    when digit5 =>
                                          if valid = '1' and (dot = '1' or dash = '1') then
                                            next_state <= st1_reset;
                                          else
                                              next_state <= state;
                                          end if;
                                      when digit6 =>
                                          if valid = '1' and (dot = '1' or dash = '1') then
                                              next_state <= st1_reset;
                                          else
                                              next_state <= state;
                                          end if;
                                      when digit7 =>
                                          if valid = '1' and (dot = '1' or dash = '1') then
                                              next_state <= st1_reset;
                                          else
                                              next_state <= state;
                                          end if;
                                       when digit8 =>
                                          if valid = '1' and (dot = '1' or dash = '1') then
                                              next_state <= st1_reset;
                                          else
                                              next_state <= state;
                                          end if;
                                       when digit9 =>
                                             if valid = '1' and (dot = '1' or dash = '1') then
                                               next_state <= st1_reset;
                                             else
                                                 next_state <= state;
                                             end if;
                                        when err =>
                                            next_state <= st1_reset;
                                  when st1_reset =>
                                      if dot = '1' and valid = '1' then
                                          next_state <= E;
                                      elsif dash = '1' and valid = '1' then
                                          next_state <= T;
                                      else
                                          next_state <= state;
                                      end if;
                                    when space =>
                                        if valid = '1' and wg = '0' then
                                            next_state <= st1_reset;
                                            if dot = '1' and valid = '1' then
                                                next_state <= E;
                                            elsif dash = '1' and valid = '1' then
                                                next_state <= T;
                                            else
                                                next_state <= st1_reset;
                                            end if;
                                       else
                                          next_state <= st1_reset;
                                        end if;

          end case;
      end if;

   end process;

end Behavioral;