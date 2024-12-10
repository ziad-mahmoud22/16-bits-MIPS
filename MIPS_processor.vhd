LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;



ENTITY MIPS_processor IS 
	PORT(
		CLK : IN STD_LOGIC;
		reset : IN STD_LOGIC;
		--ram_output : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		--instruction : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		current_inst_address_test : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		--data_out_1_test, data_out_2_test : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		ALU_result_test : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		--write_data_reg : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		--next_inst_address_test : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		--cur_addr : out std_logic_vector(3 downto 0)
	);
END MIPS_processor;

ARCHITECTURE Behavioral OF MIPS_processor IS
---------------------- CU ------------------------------------------
	SIGNAL ALU_op     : STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL reg_dst    : STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL mem_to_reg : STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL branch_op  : STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL ALU_src    : STD_LOGIC;
	SIGNAL jump       : STD_LOGIC;
	SIGNAL reg_write  : STD_LOGIC;
	SIGNAL mem_read   : STD_LOGIC;
	SIGNAL mem_write  : STD_LOGIC;
--------------------- RF -------------------------------------------
	--SIGNAL reg_write  : STD_LOGIC;
	SIGNAL address_in : STD_LOGIC_VECTOR(2 DOWNTO 0);
	--SIGNAL address_1  : STD_LOGIC_VECTOR(address_bits - 1 DOWNTO 0);
	--SIGNAL address_2  : STD_LOGIC_VECTOR(address_bits - 1 DOWNTO 0);
	SIGNAL data_in    : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL data_out_1 : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL data_out_2 : STD_LOGIC_VECTOR(7 DOWNTO 0);
--------------------- ALU_CU ----------------------------------------
	--SIGNAL ALU_op  : STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL func    : STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL ALU_cnt : STD_LOGIC_VECTOR(2 DOWNTO 0);
--------------------- BR_CU -----------------------------------------
	--SIGNAL branch_op  : STD_LOGIC_VECTOR(1 DOWNTO 0);
	--SIGNAL data_in_1  : STD_LOGIC_VECTOR(data_bits - 1 DOWNTO 0);
	--SIGNAL data_in_2  : STD_LOGIC_VECTOR(data_bits - 1 DOWNTO 0);
	SIGNAL branch_cnt : STD_LOGIC;
---------------------- ROM-------------------------------------------
	--SIGNAL CLK      : STD_LOGIC;
	--SIGNAL address  : STD_LOGIC_VECTOR(address_bits - 1 DOWNTO 0);
	--SIGNAL inst_out : STD_LOGIC_VECTOR(instruction_bits - 1 DOWNTO 0); 
---------------------- RAM ------------------------------------------
	--SIGNAL mem_read  : STD_LOGIC;
	--SIGNAL mem_write : STD_LOGIC;
	--SIGNAL address   : STD_LOGIC_VECTOR(address_bits - 1 DOWNTO 0);
	--SIGNAL data_in   : STD_LOGIC_VECTOR(data_bits - 1 DOWNTO 0);
	SIGNAL data_out  : STD_LOGIC_VECTOR(7 DOWNTO 0);
----------------------- ALU -----------------------------------------
	--SIGNAL A, B   : STD_LOGIC_VECTOR(data_bits - 1 DOWNTO 0);
	--SIGNAL opcode : STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL ALU_result 	  : STD_LOGIC_VECTOR(7 DOWNTO 0);
------------------------ PC -----------------------------------------
	SIGNAL current_inst_address : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL next_inst_address : STD_LOGIC_VECTOR(3 DOWNTO 0);----****
	SIGNAL current_inst : STD_LOGIC_VECTOR(15 DOWNTO 0);
----------------------- others --------------------------------------
	--SIGNAL next_cnt : STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL second_operand : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL inc : STD_LOGIC_VECTOR(3 DOWNTO 0);
	Signal cu_flag : std_logic;
	signal cu_flag_1 : std_logic:='0';
	signal next_addr : std_logic_vector(3 downto 0);
----------------------- Components Declration ----------------------------------
COMPONENT CU IS
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
END COMPONENT;
COMPONENT ALU_CU IS
	PORT(
		ALU_op  : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		func    : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		ALU_cnt : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
	);
END COMPONENT;
COMPONENT ROM IS
	GENERIC(
		address_bits     : INTEGER := 4;
		words            : INTEGER := 16;
		instruction_bits : INTEGER := 16
	);
	PORT(
		address  : IN STD_LOGIC_VECTOR(address_bits - 1 DOWNTO 0);
		inst_out : OUT STD_LOGIC_VECTOR(instruction_bits - 1 DOWNTO 0)
	);
END COMPONENT;
COMPONENT RAM IS
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
END COMPONENT;
COMPONENT register_file IS
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
END COMPONENT;
COMPONENT ALU IS
	GENERIC(
		data_bits : INTEGER := 8
	);
	PORT(
		A, B       : IN STD_LOGIC_VECTOR(data_bits - 1 DOWNTO 0);
		opcode     : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		ALU_result : OUT STD_LOGIC_VECTOR(data_bits - 1 DOWNTO 0)
	);
END COMPONENT;

BEGIN
	process(clk,reset)
	begin 	
		  if(reset='1')then
		      next_inst_address<="0000";
		  else
		      if branch_cnt = '0' then  
			     next_inst_address <= STD_LOGIC_VECTOR(unsigned(next_inst_address) + "0001");
			  elsif branch_cnt = '1' then 
			     next_inst_address <= current_inst(3 downto 0);
			   end if;
		  end if;
	end process;
	------------------- Multiplexers -----------------------------------------------------------------
	--MUX_1
	current_inst_address <= next_inst_address;
	branch_cnt <= '0' when branch_op = "00" else
				  '1' when jump = '1' else 
				  '1' when ((branch_op = "01") and (data_out_1 = data_out_2)) else
				  '1' when ((branch_op = "10") and (data_out_1 > data_out_2)) else
				  '1' when ((branch_op = "11") and (data_out_1 < data_out_2)) else
				  '0';
	--MUX_2
	address_in <= current_inst(8 DOWNTO 6) WHEN reg_dst = "00" ELSE
				  current_inst(5 DOWNTO 3) WHEN reg_dst = "01" ELSE
				  current_inst(11 DOWNTO 9) WHEN reg_dst = "10";
	--MUX_3
	second_operand <= data_out_2 WHEN ALU_src = '0' ELSE
					  ("00" & current_inst(5 DOWNTO 0)) WHEN ALU_src = '1';
	--MUX_4
	data_in <= ALU_result WHEN mem_to_reg = "00" and reg_write = '1' ELSE
			   data_out WHEN mem_to_reg = "01" and reg_write = '1' ELSE
			   current_inst(7 DOWNTO 0) WHEN mem_to_reg = "10" and reg_write = '1';
	---------------------- Components initilization --------------------------------------------------
	CU_instance : CU PORT MAP(
		opcode     => current_inst(15 DOWNTO 12),
		ALU_op     => ALU_op,
		reg_dst    => reg_dst,
		mem_to_reg => mem_to_reg,
		branch_op  => branch_op,
		ALU_src    => ALU_src,
		jump       => jump,
		reg_write  => reg_write,
		mem_read   => mem_read,
		mem_write  => mem_write,
		flag => cu_flag
	);
	ALU_CU_instance : ALU_CU PORT MAP(
		ALU_op  => ALU_op,
		func    => current_inst(2 downto 0),
		ALU_cnt => ALU_cnt
	);
	ROM_instance : ROM PORT MAP(
		address  => current_inst_address,
		inst_out => current_inst
	);
	register_file_instance : register_file PORT MAP(
		CLK           => CLK,
		reg_write     => reg_write,
		address_write => address_in,
		address_1     => current_inst(11 DOWNTO 9),
		address_2     => current_inst(8 DOWNTO 6),
		data_in       => data_in,
		data_out_1    => data_out_1,
		data_out_2    => data_out_2
	);
	RAM_instance : RAM PORT MAP(
		CLK       => CLK,
		mem_read  => mem_read,
		mem_write => mem_write,
		address   => current_inst(3 DOWNTO 0), -- (8 : 0)
		data_in   => data_out_1,
		data_out  => data_out
	);
	ALU_instance : ALU PORT MAP(
		A          => data_out_1,
		B          => second_operand,
		opcode     => ALU_cnt,
		ALU_result => ALU_result 
	);
	-- output is M[1111] in RAM 
	--ram_output <= data_out;
	--instruction <= current_inst;
	current_inst_address_test <= current_inst_address;
	--data_out_1_test <= data_out_1; 
	--data_out_2_test <= data_out_2;
	ALU_result_test <= ALU_result;
	--write_data_reg  <= data_in;
	--next_inst_address_test <= next_inst_address;
END Behavioral;
