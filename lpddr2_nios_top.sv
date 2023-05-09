`default_nettype none
module lpddr2_nios_top (
  // Reset and Clocks
    input   wire          max10_resetn
  , input   wire          clk50m_max10
  , input   wire          clk100m_lpddr2

  // LPDDR2
  , output  wire  [ 9:0]  lpddr2_ca
  , inout   wire  [15:0]  lpddr2_dq
  , output  wire  [ 1:0]  lpddr2_dm
  , inout   wire          lpddr2_dqs1n
  , inout   wire          lpddr2_dqs1
  , inout   wire          lpddr2_dqs0n
  , inout   wire          lpddr2_dqs0
  , output  wire          lpddr2_cke
  , output  wire          lpddr2_csn
  , inout   wire          lpddr2_ckn
  , inout   wire          lpddr2_ck

  // for LPDDR2 status
  , output  wire  [ 4:0]  user_led
);

//------------------------------------------------------------------------------
// Task / Function declaration
//------------------------------------------------------------------------------

  // none

//------------------------------------------------------------------------------
// Parameter declaration
//------------------------------------------------------------------------------

  // none

//------------------------------------------------------------------------------
// Variable declaration
//------------------------------------------------------------------------------

  logic w_emif_init_done;
  logic w_emif_cal_success;
  logic w_emif_cal_fail;

//------------------------------------------------------------------------------
// Architecture
//------------------------------------------------------------------------------

  lpddr2_nios lpddr2_nios (
      .clk_clk                                            ( clk50m_max10                  )
    , .reset_reset_n                                      ( max10_resetn                  )
    , .memory_mem_ca                                      ( lpddr2_ca                     )
    , .memory_mem_ck                                      ( lpddr2_ck                     )
    , .memory_mem_ck_n                                    ( lpddr2_ckn                    )
    , .memory_mem_cke                                     ( lpddr2_cke                    )
    , .memory_mem_cs_n                                    ( lpddr2_csn                    )
    , .memory_mem_dm                                      ( lpddr2_dm                     )
    , .memory_mem_dq                                      ( lpddr2_dq                     )
    , .memory_mem_dqs                                     ( {lpddr2_dqs1, lpddr2_dqs0}    )
    , .memory_mem_dqs_n                                   ( {lpddr2_dqs1n, lpddr2_dqs0n}  )
    , .mem_if_lpddr2_emif_0_pll_ref_clk_clk               ( clk100m_lpddr2                )
    , .mem_if_lpddr2_emif_0_pll_sharing_pll_mem_clk       ( /* open */                    )
    , .mem_if_lpddr2_emif_0_pll_sharing_pll_write_clk     ( /* open */                    )
    , .mem_if_lpddr2_emif_0_pll_sharing_pll_locked        ( /* open */                    )
    , .mem_if_lpddr2_emif_0_pll_sharing_pll_capture0_clk  ( /* open */                    )
    , .mem_if_lpddr2_emif_0_pll_sharing_pll_capture1_clk  ( /* open */                    )
    // emif status
    , .mem_if_lpddr2_emif_0_status_local_init_done        ( w_emif_init_done              )
    , .mem_if_lpddr2_emif_0_status_local_cal_success      ( w_emif_cal_success            )
    , .mem_if_lpddr2_emif_0_status_local_cal_fail         ( w_emif_cal_fail               )
  );

  // Pass => 'b011
  assign user_led = ~{2'h0, w_emif_cal_fail, w_emif_cal_success, w_emif_init_done};

endmodule
`default_nettype wire
