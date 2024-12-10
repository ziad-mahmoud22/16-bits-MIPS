LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ALU_CU IS
	PORT(
		ALU_op  : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		func    : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		ALU_cnt : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
	);
END ALU_CU;

ARCHITECTURE Behavioral OF ALU_CU IS
BEGIN
	PROCESS(ALU_op, func)
	BEGIN
		CASE ALU_op IS
			WHEN "000" => 
				ALU_cnt <= func;
			WHEN "001" => 
				ALU_cnt <= "000";
			WHEN "010" =>
				ALU_cnt <= "001";
			WHEN "011" =>
				ALU_cnt <= "100";
			WHEN "100" => 
				ALU_cnt <= "101";
			WHEN "101" =>
				ALU_cnt <= "110";
			WHEN OTHERS =>
				ALU_cnt <= "000";
		END CASE;
	END PROCESS;
END Behavioral;