--

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY electricTimer IS
	PORT (CLOCK_27 : IN STD_LOGIC;
		  KEY : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		  SW : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
		  HEX7, HEX6, HEX5, HEX4: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		  HEX3, HEX2, HEX1, HEX0: OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END electricTimer;

ARCHITECTURE Structure OF electricTimer IS
	COMPONENT clk_1hz
		PORT (CLK_27M : IN STD_LOGIC;
			  CLK_1 : OUT STD_LOGIC
		);
	END COMPONENT;

	COMPONENT mux21
		PORT (A, B, S : IN STD_LOGIC;
			  Y : OUT STD_LOGIC
		);
	END COMPONENT;

	COMPONENT mode_sel
		PORT (CLK_HAND: IN STD_LOGIC;
			  SEL_EN : OUT STD_LOGIC;
			  SET_HOUR : OUT STD_LOGIC;
			  SET_MIN : OUT STD_LOGIC;
			  SET_SEC : OUT STD_LOGIC
		);
	END COMPONENT;

	COMPONENT counter24_hour
		PORT (CLK : IN STD_LOGIC;
			  CLK_SEL : IN STD_LOGIC;
			  UP_DWN : IN STD_LOGIC;
			  CNT_EN : IN STD_LOGIC;
			  BCD1 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
			  BCD0 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
		);
	END COMPONENT;
	
	COMPONENT counter60_min_sec
		PORT (CLK : IN STD_LOGIC;
			  CLK_SEL : IN STD_LOGIC;
			  UP_DWN : IN STD_LOGIC;
			  CNT_EN : IN STD_LOGIC;
			  Co : OUT STD_LOGIC;
			  BCD1 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
			  BCD0 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT fbcd7seg
		PORT (CLK : IN STD_LOGIC;
			  FLASH : IN STD_LOGIC;
			  BCD : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			  HEX : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
		);
	END COMPONENT;

	SIGNAL clk_1 : STD_LOGIC;
	SIGNAL sel_en : STD_LOGIC;
	SIGNAL hour_set : STD_LOGIC;
	SIGNAL min_set : STD_LOGIC;
	SIGNAL sec_set : STD_LOGIC;
	SIGNAL mux21_out : STD_LOGIC;
	SIGNAL ci_sec : STD_LOGIC;
	SIGNAL ci_hour : STD_LOGIC;
	SIGNAL co_sec : STD_LOGIC;
	SIGNAL co_min : STD_LOGIC;
	SIGNAL bcd1_sec : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL bcd0_sec : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL bcd1_min : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL bcd0_min : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL bcd1_hour : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL bcd0_hour : STD_LOGIC_VECTOR(3 DOWNTO 0);

	BEGIN
		ci_sec <= NOT(hour_set OR min_set OR sec_set);
		ci_hour <= co_sec AND co_min;
		HEX1 <= "1111111";
		HEX0 <= "1111111";
		
		D1 : clk_1hz PORT MAP(CLOCK_27, clk_1); -- clock 1hz
		D2 : mode_sel PORT MAP(KEY(1), sel_en, hour_set, min_set, sec_set); -- mode selection
		D3 : mux21 PORT MAP(clk_1, KEY(0), sel_en, mux21_out); -- 2 to 1 mulyiplexing selector
		D4 : counter60_min_sec PORT MAP(mux21_out, sec_set, SW(0), ci_sec, co_sec, bcd1_sec, bcd0_sec); -- second
		D5 : counter60_min_sec PORT MAP(mux21_out, min_set, SW(0), co_sec, co_min, bcd1_min, bcd0_min); -- minute
		D6 : counter24_hour PORT MAP(mux21_out, hour_set, SW(0), ci_hour, bcd1_hour, bcd0_hour); -- hour
		D7 : fbcd7seg PORT MAP(clk_1, sec_set, bcd1_sec, HEX3);
		D8 : fbcd7seg PORT MAP(clk_1, sec_set, bcd0_sec, HEX2);
		D9 : fbcd7seg PORT MAP(clk_1, min_set, bcd1_min, HEX5);
		D10 : fbcd7seg PORT MAP(clk_1, min_set, bcd0_min, HEX4);
		D11 : fbcd7seg PORT MAP(clk_1, hour_set, bcd1_hour, HEX7);
		D12 : fbcd7seg PORT MAP(clk_1, hour_set, bcd0_hour, HEX6);

END Structure;