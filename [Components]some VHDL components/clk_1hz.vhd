
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY clk_1hz IS
    PORT (CLOCK_27MHZ : IN STD_LOGIC;
		  CLOCK_1HZ : OUT STD_LOGIC
	);
END clk_1hz;

ARCHITECTURE behavioral OF clk_1hz IS
    SIGNAL countsec : INTEGER RANGE 0 TO 26999999 := 0;
    BEGIN
		clk_counter: PROCESS (CLOCK_27MHZ)
		BEGIN
			IF CLOCK_27MHZ'EVENT AND CLOCK_27MHZ = '1' THEN
				IF countsec < 26999999 THEN
					countsec <= countsec + 1;
				ELSE
					countsec <= 0;
				END IF;
			END IF;
		END PROCESS;

		CLOCK_1HZ <= '0' WHEN countsec < 13500000 ELSE '1';
END behavioral;