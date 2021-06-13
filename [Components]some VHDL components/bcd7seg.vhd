-- 

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY bcd7seg IS
	PORT (BCD : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		  HEX : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END bcd7seg;

ARCHITECTURE behavioral OF bcd7seg IS
	SIGNAL dis : STD_LOGIC_VECTOR(6 DOWNTO 0);
	BEGIN
		seg : PROCESS(BCD)
		BEGIN
			CASE BCD IS
				WHEN "0000" => dis <= "1000000"; -- 0
				WHEN "0001" => dis <= "1111001"; -- 1
				WHEN "0010" => dis <= "0100100"; -- 2
				WHEN "0011" => dis <= "0110000"; -- 3
				WHEN "0100" => dis <= "0011001"; -- 4
				WHEN "0101" => dis <= "0010010"; -- 5
				WHEN "0110" => dis <= "0000010"; -- 6
				WHEN "0111" => dis <= "1111000"; -- 7
				WHEN "1000" => dis <= "0000000"; -- 8
				WHEN "1001" => dis <= "0010000"; -- 9
				WHEN "1010" => dis <= "0001000"; -- A
				WHEN "1011" => dis <= "0000011"; -- B
				WHEN "1100" => dis <= "1000110"; -- C
				WHEN "1101" => dis <= "0100001"; -- D
				WHEN "1110" => dis <= "0000110"; -- E
				WHEN OTHERS => dis <= "0001110"; -- F
			END CASE;
		END PROCESS;

		HEX <= dis;
END behavioral;