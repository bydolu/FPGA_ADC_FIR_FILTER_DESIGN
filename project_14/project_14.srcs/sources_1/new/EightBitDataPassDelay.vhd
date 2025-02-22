
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity SixteenBitDataPassDelay is
    Port ( FastIn : in STD_LOGIC_VECTOR (15 downto 0);
           UpdateNow : in STD_LOGIC;
           HeldSample : out STD_LOGIC_VECTOR (15 downto 0));
end SixteenBitDataPassDelay;

architecture Behavioral of SixteenBitDataPassDelay is

component DFF is
 Port ( DATAIN     : in  STD_LOGIC;
        CLK        : in  STD_LOGIC;
        ENABLE     : in  STD_LOGIC;
        DATAOUT    : out STD_LOGIC := '0';
        NOTDATAOUT : out STD_LOGIC := '1' );        
end component;

begin

    FF1 : DFF
        port map( DATAIN     => FastIn(0),
                  CLK        => UpdateNow,
                  ENABLE     => '1',
                  DATAOUT    => HeldSample(0),
                  NOTDATAOUT => open );
    
    FF2 : DFF
        port map( DATAIN     => FastIn(1),
                  CLK        => UpdateNow,
                  ENABLE     => '1',
                  DATAOUT    => HeldSample(1),
                  NOTDATAOUT => open );
                  
    FF3 : DFF
        port map( DATAIN     => FastIn(2),
                  CLK        => UpdateNow,
                  ENABLE     => '1',
                  DATAOUT    => HeldSample(2),
                  NOTDATAOUT => open );
                  
    FF4 : DFF
        port map( DATAIN     => FastIn(3),
                  CLK        => UpdateNow,
                  ENABLE     => '1',
                  DATAOUT    => HeldSample(3),
                  NOTDATAOUT => open );
      
    FF5 : DFF
        port map( DATAIN     => FastIn(4),
                  CLK        => UpdateNow,
                  ENABLE     => '1',
                  DATAOUT    => HeldSample(4),
                  NOTDATAOUT => open );
    FF6 : DFF
        port map( DATAIN     => FastIn(5),
                  CLK        => UpdateNow,
                  ENABLE     => '1',
                  DATAOUT    => HeldSample(5),
                  NOTDATAOUT => open );
                  
    FF7 : DFF
        port map( DATAIN     => FastIn(6),
                  CLK        => UpdateNow,
                  ENABLE     => '1',
                  DATAOUT    => HeldSample(6),
                  NOTDATAOUT => open );
                  
    FF8: DFF    
        port map( DATAIN     => FastIn(7),
                  CLK        => UpdateNow,
                  ENABLE     => '1',
                  DATAOUT    => HeldSample(7),
                  NOTDATAOUT => open );
                  
    FF9: DFF    
        port map( DATAIN     => FastIn(8),
                  CLK        => UpdateNow,
                  ENABLE     => '1',
                  DATAOUT    => HeldSample(8),
                  NOTDATAOUT => open );                  
    FF10: DFF    
        port map( DATAIN     => FastIn(9),
                  CLK        => UpdateNow,
                  ENABLE     => '1',
                  DATAOUT    => HeldSample(9),
                  NOTDATAOUT => open );                  
    FF11: DFF    
        port map( DATAIN     => FastIn(10),
                  CLK        => UpdateNow,
                  ENABLE     => '1',
                  DATAOUT    => HeldSample(10),
                  NOTDATAOUT => open );                  
    FF12: DFF    
        port map( DATAIN     => FastIn(11),
                  CLK        => UpdateNow,
                  ENABLE     => '1',
                  DATAOUT    => HeldSample(11),
                  NOTDATAOUT => open );                  
    FF13: DFF    
        port map( DATAIN     => FastIn(12),
                  CLK        => UpdateNow,
                  ENABLE     => '1',
                  DATAOUT    => HeldSample(12),
                  NOTDATAOUT => open );                  
    FF14: DFF    
        port map( DATAIN     => FastIn(13),
                  CLK        => UpdateNow,
                  ENABLE     => '1',
                  DATAOUT    => HeldSample(13),
                  NOTDATAOUT => open );                  
    FF15: DFF    
        port map( DATAIN     => FastIn(14),
                  CLK        => UpdateNow,
                  ENABLE     => '1',
                  DATAOUT    => HeldSample(14),
                  NOTDATAOUT => open );                  
    FF16: DFF    
        port map( DATAIN     => FastIn(15),
                  CLK        => UpdateNow,
                  ENABLE     => '1',
                  DATAOUT    => HeldSample(15),
                  NOTDATAOUT => open );
    

end Behavioral;
