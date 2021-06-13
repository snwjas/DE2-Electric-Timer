-- 

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY add_sub IS
    PORT (CLK : IN STD_LOGIC;
		  ADD_SUB : IN STD_LOGIC;
		  A, B : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		  Y : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		  CY : OUT STD_LOGIC;
		  OV : OUT STD_LOGIC
	);
END add_sub;

ARCHITECTURE behavioral OF add_sub IS
	SIGNAL Ci : STD_LOGIC;
	SIGNAL Bi, Cout, Yout : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
	Bi <= B WHEN ADD_SUB = '0' ELSE NOT(B);
	Ci <= ADD_SUB;

	Yout(0) <= A(0) XOR Bi(0) XOR Ci;
	Cout(0) <= (A(0) AND Bi(0)) OR (Bi(0) AND Ci) OR (A(0) AND Ci);

	GEN:FOR i IN 1 TO 3 GENERATE
		Yout(i) <= A(i) XOR Bi(i) XOR Cout(i - 1);
		Cout(i) <= ((A(i) AND Bi(i)) OR (Cout(i -1) AND A(i)) OR (Cout(i -1) AND Bi(i)));
	END GENERATE;

	PROCESS(CLK)
	BEGIN
		IF CLK'EVENT AND CLK = '1' THEN
			Y <= Yout;
			CY <= Cout(3);
			OV <= Cout(3) XOR Cout(2);
		END IF;
	END PROCESS;
END behavioral;