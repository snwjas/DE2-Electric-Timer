--

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY decode38 IS
    PORT (CLK : IN STD_LOGIC;
		  DIN : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		  DOUT : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END decode38;

ARCHITECTURE behavioral OF decode38 IS
	SIGNAL do : STD_LOGIC_VECTOR(7 DOWNTO 0);
	BEGIN
		dec : PROCESS(CLK, DIN)
		BEGIN
			IF CLK'EVENT AND CLK = '1' THEN
				CASE DIN IS
					WHEN "000" => do <= "10000000"; -- add
					WHEN "001" => do <= "01000000"; -- sub
					WHEN "010" => do <= "00100000"; -- and
					WHEN "011" => do <= "00010000"; -- or
					WHEN "100" => do <= "00001000"; -- not
					WHEN "101" => do <= "00000100"; -- nand
					WHEN "110" => do <= "00000010"; -- nor
					WHEN OTHERS => do <= "00000001"; -- xor
				END CASE;
			END IF;
		END PROCESS;
		DOUT <= do;
END behavioral;
