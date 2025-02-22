library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FLOW_METER_SYSTEM is
    Port ( ADC : in STD_LOGIC_VECTOR (1 downto 0);
           clk : in STD_LOGIC;
           an : out STD_LOGIC_VECTOR (3 downto 0);
           seg : out STD_LOGIC_VECTOR (7 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0):= (others => '0')
           );
end FLOW_METER_SYSTEM;

architecture Behavioral of FLOW_METER_SYSTEM is

component xadc_wiz_0 is
  port( daddr_in   :   in  STD_LOGIC_VECTOR (6 downto 0);
        den_in     :   in  STD_LOGIC;
        di_in      :   in  STD_LOGIC_VECTOR (15 downto 0);
        dwe_in     :   in  STD_LOGIC;
        do_out     :   out STD_LOGIC_VECTOR (15 downto 0);
        drdy_out   :   out STD_LOGIC;
        dclk_in    :   in  STD_LOGIC;
        reset_in   :   in  STD_LOGIC;
        vauxp3     :   in  STD_LOGIC;
        vauxn3     :   in  STD_LOGIC;
        busy_out   :   out STD_LOGIC;
        channel_out:   out STD_LOGIC_VECTOR (4 downto 0);
        eoc_out    :   out STD_LOGIC;
        eos_out    :   out STD_LOGIC;
        alarm_out  :   out STD_LOGIC;
        vp_in      :   in  STD_LOGIC;
        vn_in      :   in  STD_LOGIC );
end component;     


COMPONENT fir_compiler_0
  PORT (
    aclk : IN STD_LOGIC;
    s_axis_data_tvalid : IN STD_LOGIC;
    s_axis_data_tready : OUT STD_LOGIC;
    s_axis_data_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    m_axis_data_tvalid : OUT STD_LOGIC;
    m_axis_data_tdata : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
  );
END COMPONENT;


component sseg_dec is
  port( ALU_VAL : in std_logic_vector (15 downto 0);
        SIGN    : in std_logic;
        VALID   : in std_logic;
        CLK     : in std_logic;
        DISP_EN : out std_logic_vector (3 downto 0);
        SEGMENTS: out std_logic_vector (7 downto 0) );
        
end component;

component clk_div2 is
  port  ( clk : in std_logic;
          sclk: out std_logic );
          
end component;

component SixteenBitDataPassDelay is
  port ( FastIn     : in STD_LOGIC_VECTOR (15 downto 0);
         UpdateNow  : in STD_LOGIC;
         HeldSample : out STD_LOGIC_VECTOR (15 downto 0) );
end component;

component EightBitBarMeter is
  port ( BarDatIn  : in  STD_LOGIC_VECTOR (15 downto 0);
         BarDatOut : out STD_LOGIC_VECTOR (15 downto 0):= "0000000000000000" );
end component;

signal ADCintcon      : STD_LOGIC_VECTOR (15 downto 0);
signal ADCslowintcon  : STD_LOGIC_VECTOR (15 downto 0);
signal EnableInt      : STD_LOGIC:='1';
signal ReadyInt       : STD_LOGIC;
signal SlowClock      : STD_LOGIC;
signal s_axis_data_tready : std_logic;
signal s_axis_data_tvalid : std_logic;
signal s_axis_data_tdata  : std_logic_vector(7 downto 0);  -- 8-bit giriþ
signal m_axis_data_tvalid : std_logic;
signal m_axis_data_tdata  : std_logic_vector(23 downto 0); -- FIR çýkýþý
signal filtered_output    : std_logic_vector(23 downto 0);  -- Filtrelenmiþ veri
signal adc_out            :std_logic_vector(15 downto 0);

begin
        clockDiv: clk_div2
            port map ( clk => CLK,
                       sclk=> SlowClock );
        ADCimp: xadc_wiz_0           
        
            port map ( 
                        daddr_in     => "0010011",      -- Kanal adresi (19: aux kanal 3)
                        den_in       => EnableInt,      -- Veri enable sinyali
                        di_in        => (others => '0'), -- Veri giriþi (kullanýlmýyor)
                        dwe_in       => '0',            -- Yazma enable (yazma yapýlmýyor)
                        do_out       => ADCintcon,      -- ADC çýkýþ verisi
                        drdy_out     => open,           -- Veri hazýr sinyali
                        dclk_in      => clk,            -- Saat giriþi
                        reset_in     => '0',            -- Reset sinyali
                        vauxp3       => ADC(0),         -- Analog giriþ (+)
                        vauxn3       => ADC(1),         -- Analog giriþ (-)
                        busy_out     => open,           -- Meþgul sinyali
                        channel_out  => open,           -- Aktif kanal göstergesi
                        eoc_out      => EnableInt,      -- Dönüþüm sonu sinyali
                        eos_out      => open,           -- Tarama sonu sinyali
                        alarm_out    => open,           -- Alarm sinyali
                        vp_in        => '0',            -- Referans voltaj (+)
                        vn_in        => '0'             -- Referans voltaj (-)
                       );
              
                           
        fir_filter : fir_compiler_0
        
            PORT MAP  ( aclk => clk,
                        s_axis_data_tvalid => EnableInt,
                        s_axis_data_tready => s_axis_data_tready,
                        s_axis_data_tdata => ADCintcon,
                        m_axis_data_tvalid => m_axis_data_tvalid,
                        m_axis_data_tdata => m_axis_data_tdata );
        
        Delaytimer: SixteenBitDataPassDelay
            port map ( FastIn     => ADCintcon (15 downto 0),
                       UpdateNow  => SlowClock,
                       HeldSample => ADCslowintcon (15 downto 0) );
        SSegDisp: sseg_dec
            port map ( ALU_VAL     => ADCslowintcon (15 downto 0),
                       SIGN        => '0',
                       VALID       => '1',
                       CLK         => clk,
                       DISP_EN     => an,
                     SEGMENTS    => seg ); 
        Barmeter: EightBitBarMeter
            port map ( BarDatIn  => ADCintcon (15 downto 0),
                       BarDatOut => led (15 downto 0) );
                                

end Behavioral;
