
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY SARAM IS
	GENERIC (
		WIDTH: INTEGER := 4;
		WIDTHAD: INTEGER := 4
	);

	PORT (
		DATA: IN STD_LOGIC_VECTOR(WIDTH-1 DOWNTO 0);
		WADR: IN STD_LOGIC_VECTOR(WIDTHAD-1 DOWNTO 0);
		WCLK: IN STD_LOGIC;
		WE : IN STD_LOGIC;
		RADR: IN STD_LOGIC_VECTOR(WIDTHAD-1 DOWNTO 0);
		RCLK: IN STD_LOGIC;
		RE : IN STD_LOGIC;
		Q: OUT STD_LOGIC_VECTOR(WIDTH-1 DOWNTO 0)
	);
END SARAM;

ARCHITECTURE SYN OF SARAM IS
	-- row
	TYPE MEM IS ARRAY(0 TO (2**(WIDTHAD-1)-1)) OF
	-- col
	STD_LOGIC_VECTOR(WIDTH-1 DOWNTO 0);
	SIGNAL RAMTMP: MEM;
BEGIN
	WR: PROCESS(WCLK)
	BEGIN
		IF WCLK'EVENT AND WCLK = '1' THEN
			IF WE = '1' THEN
				RAMTMP(CONV_INTEGER(WADR)) <= DATA;
			END IF;
		END IF;
	END PROCESS;

	RD: PROCESS(RCLK)
	BEGIN
		IF RCLK'EVENT AND RCLK = '1' THEN
			IF RE = '1' THEN
				Q <= RAMTMP(CONV_INTEGER(RADR));
			END IF;
		END IF;
	END PROCESS;
END SYN;