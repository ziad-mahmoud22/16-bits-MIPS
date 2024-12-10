LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY CU IS
	PORT(
		opcode     : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		ALU_op     : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		reg_dst    : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		mem_to_reg : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		branch_op  : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		ALU_src    : OUT STD_LOGIC;
		jump       : OUT STD_LOGIC;
		reg_write  : OUT STD_LOGIC;
		mem_read   : OUT STD_LOGIC;
		mem_write  : OUT STD_LOGIC;
		flag : in std_logic
	);
END CU;

ARCHITECTURE Behavioral OF CU IS 
BEGIN 
	PROCESS(opcode)
	BEGIN
		CASE opcode IS 
			WHEN "0000" =>
				ALU_op  <= "000";
				reg_dst <= "00";
				ALU_src <= '0';
				mem_to_reg <= "00";
				reg_write <= '0';
				mem_read <= '0';
				mem_write <= '0';
				jump <= '0';
				branch_op <= "00";
			WHEN "0001" => 
				ALU_op  <= "000";
				reg_dst <= "10";
				ALU_src <= '0';
				mem_to_reg <= "00";
				reg_write <= '1';
				mem_read <= '0';
				mem_write <= '0';
				jump <= '0';
				branch_op <= "00";
			WHEN "0010" =>
				ALU_op  <= "001";
				reg_dst <= "01";
				ALU_src <= '1';
				mem_to_reg <= "00";
				reg_write <= '1';
				mem_read <= '0';
				mem_write <= '0';
				jump <= '0';
				branch_op <= "00";
			WHEN "0011" =>
				ALU_op  <= "010";
				reg_dst <= "01";
				ALU_src <= '1';
				mem_to_reg <= "00";
				reg_write <= '1';
				mem_read <= '0';
				mem_write <= '0';
				jump <= '0';
				branch_op <= "00";
			WHEN "0100" =>
				ALU_op  <= "011";
				reg_dst <= "01";
				ALU_src <= '1';
				mem_to_reg <= "00";
				reg_write <= '1';
				mem_read <= '0';
				mem_write <= '0';
				jump <= '0';
				branch_op <= "00";
			WHEN "0101" =>
				ALU_op  <= "100";
				reg_dst <= "01";
				ALU_src <= '1';
				mem_to_reg <= "00";
				reg_write <= '1';
				mem_read <= '0';
				mem_write <= '0';
				jump <= '0';
				branch_op <= "00";
			WHEN "0110" =>
				ALU_op  <= "101";
				reg_dst <= "01";
				ALU_src <= '1';
				mem_to_reg <= "00";
				reg_write <= '1';
				mem_read <= '0';
				mem_write <= '0';
				jump <= '0';
				branch_op <= "00";
			WHEN "0111" =>
				ALU_op  <= "000";
				reg_dst <= "00";
				ALU_src <= '0';
				mem_to_reg <= "10";
				reg_write <= '1';
				mem_read <= '0';
				mem_write <= '0';
				jump <= '0';
				branch_op <= "00";
			WHEN "1000" =>
				ALU_op  <= "000";
				reg_dst <= "00";
				ALU_src <= '0';
				mem_to_reg <= "01";
				reg_write <= '1';
				mem_read <= '1';
				mem_write <= '0';
				jump <= '0';
				branch_op <= "00";
			WHEN "1001" =>
				ALU_op  <= "000";
				reg_dst <= "00";
				ALU_src <= '0';
				mem_to_reg <= "00";
				reg_write <= '0';
				mem_read <= '0';
				mem_write <= '1';
				jump <= '0';
				branch_op <= "00";
			WHEN "1010" =>
				ALU_op  <= "000";
				reg_dst <= "00";
				ALU_src <= '0';
				mem_to_reg <= "00";
				reg_write <= '0';
				mem_read <= '0';
				mem_write <= '0';
				jump <= '0';
				branch_op <= "01";
			WHEN "1011" =>
				ALU_op  <= "000";
				reg_dst <= "00";
				ALU_src <= '0';
				mem_to_reg <= "00";
				reg_write <= '0';
				mem_read <= '0';
				mem_write <= '0';
				jump <= '0';
				branch_op <= "10";
			WHEN "1100" =>
				ALU_op  <= "000";
				reg_dst <= "00";
				ALU_src <= '0';
				mem_to_reg <= "00";
				reg_write <= '0';
				mem_read <= '0';
				mem_write <= '0';
				jump <= '0';
				branch_op <= "11";
			WHEN "1111" =>
				ALU_op  <= "000";
				reg_dst <= "00";
				ALU_src <= '0';
				mem_to_reg <= "00";
				reg_write <= '0';
				mem_read <= '0';
				mem_write <= '0';
				jump <= '1';
				branch_op <= "00";
			WHEN OTHERS =>
				ALU_op  <= "ZZZ";
				reg_dst <= "ZZ";
				ALU_src <= 'Z';
				mem_to_reg <= "ZZ";
				reg_write <= 'Z';
				mem_read <= 'Z';
				mem_write <= 'Z';
				jump <= 'Z';
				branch_op <= "ZZ";
		END CASE;
	END PROCESS;
END Behavioral;	
			