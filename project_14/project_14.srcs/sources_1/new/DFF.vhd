----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.12.2018 23:00:13
-- Design Name: 
-- Module Name: DFF - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DFF is
    Port ( DATAIN     :  in STD_LOGIC;
           CLK        :  in STD_LOGIC;
           ENABLE     :  in STD_LOGIC;
           DATAOUT    : out STD_LOGIC :='0';
           NOTDATAOUT : out STD_LOGIC :='1');
end DFF;

architecture Behavioral of DFF is

begin
 dff: process (DATAIN,CLK)
begin
    if(rising_edge(CLK)) then
        if (ENABLE = '1') then
            DATAOUT    <= DATAIN;
            NOTDATAOUT <= not DATAIN;
end if;
end if;
end process dff;
end Behavioral;
