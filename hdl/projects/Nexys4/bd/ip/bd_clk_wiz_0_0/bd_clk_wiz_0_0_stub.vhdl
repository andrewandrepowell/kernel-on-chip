-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.4 (win64) Build 1756540 Mon Jan 23 19:11:23 MST 2017
-- Date        : Fri Apr 14 18:35:38 2017
-- Host        : LAPTOP-IQ9G3D1I running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               C:/Users/andrewandre/Documents/GitHub/kernel-on-chip/hdl/projects/Nexys4/bd/ip/bd_clk_wiz_0_0/bd_clk_wiz_0_0_stub.vhdl
-- Design      : bd_clk_wiz_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bd_clk_wiz_0_0 is
  Port ( 
    clk_ref_i : out STD_LOGIC;
    resetn : in STD_LOGIC;
    clk_in1 : in STD_LOGIC
  );

end bd_clk_wiz_0_0;

architecture stub of bd_clk_wiz_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_ref_i,resetn,clk_in1";
begin
end;
