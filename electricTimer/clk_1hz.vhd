
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY clk_1hz IS
    PORT (CLK_27M : IN STD_LOGIC;
		  CLK_1 : OUT STD_LOGIC
	);
END clk_1hz;

ARCHITECTURE art OF clk_1hz IS
    SIGNAL countsec : INTEGER RANGE 0 TO 26999999 := 0;
    BEGIN
		clk_counter: PROCESS (CLK_27M)
		BEGIN
			IF CLK_27M'EVENT AND CLK_27M = '1' THEN
				IF countsec < 26999999 THEN
					countsec <= countsec + 1;
				ELSE
					countsec <= 0;
				END IF;
			END IF;
		END PROCESS;

		CLK_1 <= '0' WHEN countsec < 13500000 ELSE '1';

END art;