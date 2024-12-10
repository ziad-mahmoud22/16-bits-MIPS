LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY register_file IS 
	GENERIC(
		data_bits    : INTEGER := 8;
		address_bits : INTEGER := 3;
		registers    : INTEGER := 8
	);
	PORT(
		CLK           : IN STD_LOGIC;
		reg_write     : IN STD_LOGIC;
		address_write : IN STD_LOGIC_VECTOR(address_bits - 1 DOWNTO 0);
		address_1     : IN STD_LOGIC_VECTOR(address_bits - 1 DOWNTO 0);
		address_2     : IN STD_LOGIC_VECTOR(address_bits - 1 DOWNTO 0);
		data_in       : IN STD_LOGIC_VECTOR(data_bits - 1 DOWNTO 0);
		data_out_1    : OUT STD_LOGIC_VECTOR(data_bits - 1 DOWNTO 0);
		data_out_2    : OUT STD_LOGIC_VECTOR(data_bits - 1 DOWNTO 0)
	);
END register_file;

ARCHITECTURE Behavioral OF register_file IS
    type mem is array(8-1 downto 0) of std_logic_vector(8-1 downto 0);
    SIGNAL register_file_1 : mem;
    BEGIN 
	   PROCESS(CLK)
	BEGIN 
		
        IF reg_write = '1' THEN
            register_file_1(TO_INTEGER(UNSIGNED(address_write))) <= data_in;

        END IF;
		    data_out_1 <= register_file_1(TO_INTEGER(UNSIGNED(address_1)));
	        data_out_2 <= register_file_1(TO_INTEGER(UNSIGNED(address_2)));
	END PROCESS;
	
	-- in any case(any opcode) we will read data form RF
END Behavioral;

					