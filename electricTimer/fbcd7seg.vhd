-- 

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY fbcd7seg IS
	PORT (CLK : IN STD_LOGIC;
		  FLASH : IN STD_LOGIC;
		  BCD : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		  HEX : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END fbcd7seg;

ARCHITECTURE behavioral OF fbcd7seg IS
SIGNAL dis : STD_LOGIC_VECTOR(6 DOWNTO 0);

BEGIN
	synhex : PROCESS(CLK, FLASH, BCD)
	BEGIN
		IF FLASH = '1' THEN
			IF CLK = '0' THEN
				dis <= "1111111";
			ELSE
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
					WHEN OTHERS => dis <= "0010000"; -- 9
				END CASE;
			END IF;
		ELSE
			IF CLK'EVENT AND CLK = '1' THEN
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
					WHEN OTHERS => dis <= "0010000"; -- 9
				END CASE;
			END IF;
		END IF;
	END PROCESS;

	HEX <= dis;

END behavioral;