LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY RAM IS
	GENERIC(
		address_bits : INTEGER:= 4;
		words        : INTEGER:= 16;
		data_bits    : INTEGER:= 8
	);
	PORT(
		CLK       : IN STD_LOGIC;
		mem_read  : IN STD_LOGIC; -- 1 -> WRITE  0 -> READ
		mem_write : IN STD_LOGIC;
		address   : IN STD_LOGIC_VECTOR(address_bits - 1 DOWNTO 0);
		data_in   : IN STD_LOGIC_VECTOR(data_bits - 1 DOWNTO 0);
		data_out  : OUT STD_LOGIC_VECTOR(data_bits - 1 DOWNTO 0)
	);
END RAM;

ARCHITECTURE Behavioral OF RAM IS

TYPE memory IS ARRAY(0 TO words - 1) OF STD_LOGIC_VECTOR(data_bits - 1 DOWNTO 0);
SIGNAL ram1 : memory:=(
    "00001000",
	"00000010",
	"00001000",
	"00000010",
	"00000000",
	"00000000",
	"00000000",
	"00000000",
	"00000000",
	"00000000",
	"00000000",
	"00000000",
	"00000000",
	"00000000",
	"00000000",
	"00000000"
);

BEGIN 
	PROCESS(CLK)
	BEGIN 
		
			IF mem_write = '1' THEN
				ram1(TO_INTEGER(UNSIGNED(address))) <= data_in;
			END IF;
		
	END PROCESS;
	data_out <= ram1(TO_INTEGER(UNSIGNED(address))) when mem_read = '1' else (others => '0');
END Behavioral;
			
				