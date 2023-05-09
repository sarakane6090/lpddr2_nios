create_clock -name {clk100m_lpddr2} -period 10.000 -waveform { 0.000 5.000 } [get_ports {clk100m_lpddr2}]
create_clock -name {clk50m_max10} -period 20.000 -waveform { 0.000 10.000 } [get_ports {clk50m_max10}]
