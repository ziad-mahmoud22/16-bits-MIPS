LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Branch_CU IS
	GENERIC(
		data_bits : INTEGER := 8
	);
	PORT(
		branch_op     : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		data_in_1     : IN STD_LOGIC_VECTOR(data_bits - 1 DOWNTO 0);
		data_in_2     : IN STD_LOGIC_VECTOR(data_bits - 1 DOWNTO 0);
		branch_cnt    : OUT STD_LOGIC
	);
END Branch_CU;

ARCHITECTURE Behavioral OF Branch_CU IS
BEGIN
	PROCESS(data_in_1, data_in_2, branch_op)
	BEGIN 
		CASE branch_op IS
			WHEN "00" =>
				branch_cnt <= '0';
			WHEN "01" =>
				IF data_in_1 = data_in_2 THEN
					branch_cnt <= '1';
				ELSE
					branch_cnt <= '0';
				END IF;
			WHEN "10" =>
				IF data_in_1 > data_in_2 THEN
					branch_cnt <= '1';
				ELSE 
					branch_cnt <= '0';
				END IF;
			WHEN "11" =>
				IF data_in_1 < data_in_2 THEN
					branch_cnt <= '1';
				ELSE
					branch_cnt <= '0';
				END IF;
			WHEN OTHERS =>
				branch_cnt <= 'Z';
		END CASE;
	END PROCESS;
END Behavioral;

	