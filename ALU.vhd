LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
use ieee.std_logic_unsigned.all;

ENTITY ALU IS 
	GENERIC(
		data_bits : INTEGER := 8
	);
	PORT(
		A, B       : IN STD_LOGIC_VECTOR(data_bits - 1 DOWNTO 0);
		opcode     : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		ALU_result : OUT STD_LOGIC_VECTOR(data_bits - 1 DOWNTO 0)
	);
END ALU;

ARCHITECTURE Behavioral OF ALU IS
BEGIN
	PROCESS(A, B, opcode)
	BEGIN
		CASE opcode IS
			WHEN "000" =>
				ALU_result <= (A + B);
			WHEN "001" =>
				ALU_result <= (A - B);
			WHEN "010" =>
				ALU_result <= std_logic_vector(to_unsigned(to_integer(unsigned(A))*to_integer(unsigned(B)),8));
			WHEN "011" =>
				ALU_result <= std_logic_vector(to_unsigned(to_integer(unsigned(A))/to_integer(unsigned(B)),8));
			WHEN "100" =>
				ALU_result <= (A AND B);
			WHEN "101" =>
				ALU_result <= (A OR B);
			WHEN "110" =>
				ALU_result <= (A XOR B);
			WHEN "111" =>
				ALU_result <= (NOT A);
			WHEN OTHERS =>
				ALU_result <= ("00000000");
		END CASE;
	END PROCESS;
END Behavioral;