
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;


ENTITY register IS
	PORT(
		DATA : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		CLK : IN STD_LOGIC;
		WREN : IN STD_LOGIC;
		RDEN : IN STD_LOGIC;
		CLR : IN STD_LOGIC;
		Q : OUT STD_LOGIC_VECTOR(5 DOWNTO 0)
	);
END register;

ARCHITECTURE SYN OF register IS
	SIGNAL d : STD_LOGIC_VECTOR(5 DOWNTO 0);
BEGIN
	PROCESS(CLK, WREN, RDEN, CLR)
	BEGIN
		IF CLK'EVENT AND CLK = '1' THEN
			IF WREN = '1' THEN
				d <= DATA;
			ELSIF RDEN = '1' THEN
				Q <= d;
			ELSIF CLR = '1' THEN
				d <= (OTHERS => '0');
			END IF;
		END IF;
	END PROCESS;

END SYN;
