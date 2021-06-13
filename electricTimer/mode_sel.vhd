-- select module

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY mode_sel IS
    PORT (CLK_HAND: IN STD_LOGIC;
		  SEL_EN : OUT STD_LOGIC;
		  SET_HOUR : OUT STD_LOGIC;
		  SET_MIN : OUT STD_LOGIC;
		  SET_SEC : OUT STD_LOGIC
	);
END mode_sel;

ARCHITECTURE behavioral OF mode_sel IS
	SIGNAL countsec : INTEGER RANGE 0 TO 3 := 0;
	SIGNAL sel_e : STD_LOGIC;
	SIGNAL sel_h : STD_LOGIC;
	SIGNAL sel_m : STD_LOGIC;
	SIGNAL sel_s : STD_LOGIC;
	
	BEGIN
		sel_mode:PROCESS(CLK_HAND)
		BEGIN
			IF CLK_HAND'EVENT AND CLK_HAND = '1' THEN
				IF countsec < 3 THEN
					countsec <= countsec + 1;
				ELSE
					countsec <= 0;
				END IF;
			END IF;
		END PROCESS;

		sel_e <= '0' WHEN countsec = 0 ELSE '1';
		sel_s <= '1' WHEN countsec = 1 ELSE '0';
		sel_m <= '1' WHEN countsec = 2 ELSE '0';
		sel_h <= '1' WHEN countsec = 3 ELSE '0';

		SEL_EN <= sel_e;
		SET_SEC <= sel_s;
		SET_MIN <= sel_m;
		SET_HOUR <= sel_h;

END behavioral;