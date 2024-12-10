LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY PC IS
	GENERIC(
		address_bits : INTEGER := 4
	);
	PORT(
		CLK    : IN STD_LOGIC;
		next_inst_addr : OUT STD_LOGIC_VECTOR(address_bits - 1 	DOWNTO 0)
	);
END PC;

ARCHITECTURE Behavioral OF PC IS
signal current_signal :STD_LOGIC_VECTOR(address_bits - 1 DOWNTO 0):="0000";
BEGIN
	PROCESS(CLK)
	BEGIN
		IF RISING_EDGE(CLK) THEN
			current_signal <= STD_LOGIC_VECTOR(unsigned(current_signal) + to_unsigned(1, 4));
		END IF;
	END PROCESS;
	next_inst_addr <= current_signal; 
END Behavioral;