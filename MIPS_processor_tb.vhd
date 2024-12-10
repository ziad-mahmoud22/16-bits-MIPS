LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.std_logic_arith.ALL;

ENTITY MIPS_processor_tb IS
END MIPS_processor_tb;

ARCHITECTURE Behavioral OF MIPS_processor_tb IS
	component MIPS_processor
	port(CLK : IN STD_LOGIC;
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
	end component;
	
	signal clk_tb: std_logic:='0';
	constant clk_period :  TIME:= 6 ns;
	
	signal next_inst_address_test_tb: STD_LOGIC_VECTOR(3 DOWNTO 0);
	signal ram_output_tb: STD_LOGIC_VECTOR(7 DOWNTO 0);
	signal instruction_tb : STD_LOGIC_VECTOR(15 DOWNTO 0);
    signal current_inst_address_test_tb : STD_LOGIC_VECTOR(3 DOWNTO 0);
    signal data_out_1_test_tb, data_out_2_test_tb : STD_LOGIC_VECTOR(7 DOWNTO 0);
    signal ALU_result_test_tb : STD_LOGIC_VECTOR(7 DOWNTO 0);
    signal write_data_reg_tb : STD_LOGIC_VECTOR(7 DOWNTO 0);
    signal reset_tb: STD_LOGIC;
    signal cur_addr_tb: std_logic_vector(3 downto 0):="0000";
	
	begin
  	clk_tb <= NOT clk_tb AFTER clk_period/2;
	
	dut : MIPS_processor
    port map (CLK   => clk_tb,
              reset=> reset_tb,
              --ram_output => ram_output_tb,
              --instruction=> instruction_tb,
              current_inst_address_test=>current_inst_address_test_tb,
              --data_out_1_test=>data_out_1_test_tb,
              --data_out_2_test=>data_out_2_test_tb,
              ALU_result_test=>ALU_result_test_tb
              --write_data_reg=>write_data_reg_tb,
              --next_inst_address_test=>next_inst_address_test_tb,
              --cur_addr=>cur_addr_tb
              );
              
          
    clk_process :process

    begin

    	clk_tb <= '0';

    	wait for clk_period/2; 

    	clk_tb <= '1';

    	wait for clk_period/2;

    end process;
    stimuli : process
		begin
        reset_tb <= '1';
		wait for 15 ns;	
		
		reset_tb <= '0';
		wait for 10000 ns;
		wait;
    end process;
    
end Behavioral;