module samModule
  use iso_c_binding
  implicit none

  type, bind(C) :: samurai_config
     ! operation
     integer(C_INT) :: num_iterations = 1

     ! radar
     integer(C_INT) :: radar_skip = 1
     integer(C_INT) :: radar_stride = 3
     integer(C_INT) :: dynamic_stride = 0

     ! c   <options>
     integer(C_INT) :: spline_approximation = 2

     ! COAMPS-TC array grid dimensions for current grid
     !  (could be either nest 1, 2 or 3)
     integer(C_INT) :: nx = 4
     integer(C_INT) :: ny = 5
     integer(C_INT) :: nz = 10

     ! grid
     real(C_FLOAT) :: i_min = -50.0
     real(C_FLOAT) :: i_max = 50.0
     real(C_FLOAT) :: i_incr = 1.0
     real(C_FLOAT) :: j_min = -50.0
     real(C_FLOAT) :: j_max = 50.0
     real(C_FLOAT) :: j_incr = 1.0
     real(C_FLOAT) :: k_min = 0.0
     real(C_FLOAT) :: k_max = 16.0
     real(C_FLOAT) :: k_incr = 0.5

     ! background
     real(C_FLOAT) :: i_background_roi = 25.0
     real(C_FLOAT) :: j_background_roi  = 25.0

     ! radar
     real(C_FLOAT) :: i_reflectivity_roi = 1.0
     real(C_FLOAT) :: j_reflectivity_roi = 1.0
     real(C_FLOAT) :: k_reflectivity_roi = 1.0
     real(C_FLOAT) :: dbz_pseudow_weight = 0.0
     real(C_FLOAT) :: melting_zone_width = 1.0
     real(C_FLOAT) :: mixed_phase_dbz    = 20.0
     real(C_FLOAT) :: rain_dbz = 30.0

     ! parameters iter 1
     real(C_FLOAT) :: bg_rhou_error = 100.0 !5.0
     real(C_FLOAT) :: bg_rhov_error = 100.0 !5.0
     real(C_FLOAT) :: bg_rhow_error = 100.0 !5.0
     real(C_FLOAT) :: bg_tempk_error = 3.0  !1.0
     real(C_FLOAT) :: bg_qv_error = 3.0     !1.0
     real(C_FLOAT) :: bg_rhoa_error = 3.0   !1.0
     real(C_FLOAT) :: bg_qr_error = 3.0     !1.0
     real(C_FLOAT) :: mc_weight = 1.0       !1.0
     real(C_FLOAT) :: i_filter_length = 4.0 !2.0
     real(C_FLOAT) :: j_filter_length = 4.0 !2.0
     real(C_FLOAT) :: k_filter_length = 2.0 !2.0
     real(C_FLOAT) :: i_spline_cutoff = 2.0 !2.0
     real(C_FLOAT) :: j_spline_cutoff = 2.0 !2.0
     real(C_FLOAT) :: k_spline_cutoff = 2.0 !2.0
     real(C_FLOAT) :: i_max_wavenumber = -1.0 !-1.0
     real(C_FLOAT) :: j_max_wavenumber = -1.0 !-1.0
     real(C_FLOAT) :: k_max_wavenumber = -1.0 !-1.0

     ! observation errors
     real(C_FLOAT) :: dropsonde_rhou_error = 1.0
     real(C_FLOAT) :: dropsonde_rhov_error = 1.0
     real(C_FLOAT) :: dropsonde_rhow_error = 2.0
     real(C_FLOAT) :: dropsonde_tempk_error = 1.0
     real(C_FLOAT) :: dropsonde_qv_error = 0.5
     real(C_FLOAT) :: dropsonde_rhoa_error = 1.0
     real(C_FLOAT) :: flightlevel_rhou_error = 1.0
     real(C_FLOAT) :: flightlevel_rhov_error = 1.0
     real(C_FLOAT) :: flightlevel_rhow_error = 1.0
     real(C_FLOAT) :: flightlevel_tempk_error = 1.0
     real(C_FLOAT) :: flightlevel_qv_error = 0.5
     real(C_FLOAT) :: flightlevel_rhoa_error = 1.0
     real(C_FLOAT) :: insitu_rhou_error = 1.0
     real(C_FLOAT) :: insitu_rhov_error = 1.0
     real(C_FLOAT) :: insitu_rhow_error = 2.0
     real(C_FLOAT) :: insitu_tempk_error = 1.0
     real(C_FLOAT) :: insitu_qv_error = 0.5
     real(C_FLOAT) :: insitu_rhoa_error = 1.0
     real(C_FLOAT) :: sfmr_windspeed_error = 10.0
     real(C_FLOAT) :: qscat_rhou_error = 2.5
     real(C_FLOAT) :: qscat_rhov_error = 2.5
     real(C_FLOAT) :: ascat_rhou_error = 2.5
     real(C_FLOAT) :: ascat_rhov_error = 2.5
     real(C_FLOAT) :: amv_rhou_error = 10.0
     real(C_FLOAT) :: amv_rhov_error = 10.0
     real(C_FLOAT) :: lidar_sw_error = 1.0
     real(C_FLOAT) :: lidar_power_error = 50.0
     real(C_FLOAT) :: lidar_min_error = 1.0
     real(C_FLOAT) :: radar_sw_error = 1.0
     real(C_FLOAT) :: radar_fallspeed_error = 2.0
     real(C_FLOAT) :: radar_min_error = 1.0

     ! COAMPS-TC delta x and delta y for current grid
     real(C_FLOAT) :: delx
     real(C_FLOAT) :: dely

     !operation
     ! character(kind=C_CHAR, len=1) :: load_background = 0
     ! character(kind=C_CHAR, len=1) :: adjust_background = 0
     ! character(kind=C_CHAR, len=1) :: preprocess_obs = 1
     ! character(kind=C_CHAR, len=1) :: output_mish = 0
     ! character(kind=C_CHAR, len=1) :: output_txt = 0
     ! character(kind=C_CHAR, len=1) :: output_qc = 1
     ! character(kind=C_CHAR, len=1) :: output_netcdf = 1
     ! character(kind=C_CHAR, len=1) :: output_asi = 0

     character(kind=C_CHAR, len=1) :: load_background = C_NULL_CHAR
     character(kind=C_CHAR, len=1) :: adjust_background = C_NULL_CHAR
     character(kind=C_CHAR, len=1) :: preprocess_obs = '1'
     character(kind=C_CHAR, len=1) :: output_mish = C_NULL_CHAR
     character(kind=C_CHAR, len=1) :: output_txt = C_NULL_CHAR
     character(kind=C_CHAR, len=1) :: output_qc = '1'
     character(kind=C_CHAR, len=1) :: output_netcdf = '1'
     character(kind=C_CHAR, len=1) :: output_asi = C_NULL_CHAR
     character(kind=C_CHAR, len=1) :: output_COAMPS = '1'

     !  boundary conditions
     character(kind=C_CHAR, len=3) :: i_rhou_bcL = 'R0' // C_NULL_CHAR
     character(kind=C_CHAR, len=3) :: i_rhou_bcR= 'R0' // C_NULL_CHAR
     character(kind=C_CHAR, len=3) :: i_rhov_bcL= 'R0' // C_NULL_CHAR
     character(kind=C_CHAR, len=3) :: i_rhov_bcR= 'R0' // C_NULL_CHAR
     character(kind=C_CHAR, len=3) :: i_rhow_bcL= 'R0' // C_NULL_CHAR
     character(kind=C_CHAR, len=3) :: i_rhow_bcR= 'R0' // C_NULL_CHAR
     character(kind=C_CHAR, len=3) :: i_tempk_bcL= 'R0' // C_NULL_CHAR
     character(kind=C_CHAR, len=3) :: i_tempk_bcR= 'R0' // C_NULL_CHAR
     character(kind=C_CHAR, len=3) :: i_qv_bcL= 'R0' // C_NULL_CHAR
     character(kind=C_CHAR, len=3) :: i_qv_bcR= 'R0' // C_NULL_CHAR
     character(kind=C_CHAR, len=3) :: i_rhoa_bcL= 'R0' // C_NULL_CHAR
     character(kind=C_CHAR, len=3) :: i_rhoa_bcR= 'R0' // C_NULL_CHAR
     character(kind=C_CHAR, len=3) :: i_qr_bcL= 'R0' // C_NULL_CHAR
     character(kind=C_CHAR, len=3) :: i_qr_bcR= 'R0' // C_NULL_CHAR
     character(kind=C_CHAR, len=3) :: j_rhou_bcL= 'R0' // C_NULL_CHAR
     character(kind=C_CHAR, len=3) :: j_rhou_bcR= 'R0' // C_NULL_CHAR
     character(kind=C_CHAR, len=3) :: j_rhov_bcL= 'R0' // C_NULL_CHAR
     character(kind=C_CHAR, len=3) :: j_rhov_bcR= 'R0' // C_NULL_CHAR
     character(kind=C_CHAR, len=3) :: j_rhow_bcL= 'R0' // C_NULL_CHAR
     character(kind=C_CHAR, len=3) :: j_rhow_bcR= 'R0' // C_NULL_CHAR
     character(kind=C_CHAR, len=3) :: j_tempk_bcL= 'R0' // C_NULL_CHAR
     character(kind=C_CHAR, len=3) :: j_tempk_bcR= 'R0' // C_NULL_CHAR
     character(kind=C_CHAR, len=3) :: j_qv_bcL= 'R0' // C_NULL_CHAR
     character(kind=C_CHAR, len=3) :: j_qv_bcR= 'R0' // C_NULL_CHAR
     character(kind=C_CHAR, len=3) :: j_rhoa_bcL= 'R0' // C_NULL_CHAR
     character(kind=C_CHAR, len=3) :: j_rhoa_bcR= 'R0' // C_NULL_CHAR
     character(kind=C_CHAR, len=3) :: j_qr_bcL= 'R0' // C_NULL_CHAR
     character(kind=C_CHAR, len=3) :: j_qr_bcR= 'R0' // C_NULL_CHAR
     character(kind=C_CHAR, len=3) :: k_rhou_bcL= 'R0' // C_NULL_CHAR
     character(kind=C_CHAR, len=3) :: k_rhou_bcR= 'R0' // C_NULL_CHAR
     character(kind=C_CHAR, len=3) :: k_rhov_bcL= 'R0' // C_NULL_CHAR
     character(kind=C_CHAR, len=3) :: k_rhov_bcR= 'R0' // C_NULL_CHAR
     character(kind=C_CHAR, len=5) :: k_rhow_bcL= 'R1T0' // C_NULL_CHAR
     character(kind=C_CHAR, len=5) :: k_rhow_bcR= 'R1T0' // C_NULL_CHAR
     character(kind=C_CHAR, len=3) :: k_tempk_bcL= 'R0' // C_NULL_CHAR
     character(kind=C_CHAR, len=3) :: k_tempk_bcR= 'R0' // C_NULL_CHAR
     character(kind=C_CHAR, len=3) :: k_qv_bcL= 'R0' // C_NULL_CHAR
     character(kind=C_CHAR, len=3) :: k_qv_bcR= 'R0' // C_NULL_CHAR
     character(kind=C_CHAR, len=3) :: k_rhoa_bcL= 'R0' // C_NULL_CHAR
     character(kind=C_CHAR, len=3) :: k_rhoa_bcR= 'R0' // C_NULL_CHAR
     character(kind=C_CHAR, len=3) :: k_qr_bcL= 'R0' // C_NULL_CHAR
     character(kind=C_CHAR, len=3) :: k_qr_bcR= 'R0' // C_NULL_CHAR

     !c     operation   
     character (kind= C_CHAR, len=4) :: mode = "XYZ"// C_NULL_CHAR

     ! radar
     character (kind= C_CHAR, len=4) :: qr_variable = 'dbz' // C_NULL_CHAR
     character (kind= C_CHAR, len=4) :: radar_dbz = 'DBZ' // C_NULL_CHAR
     character (kind= C_CHAR, len=4) :: radar_vel = 'VG ' // C_NULL_CHAR
     character (kind= C_CHAR, len=4) :: radar_sw  = 'SW ' // C_NULL_CHAR

     ! radar
     character (kind= C_CHAR, len=5) :: mask_reflectivity = 'None' // C_NULL_CHAR

     ! background
     character (kind= C_CHAR, len=9) :: ref_time = '18:15:00' // C_NULL_CHAR

     ! background
     character (kind= C_CHAR, len=14) :: ref_statei = 'dunion_mt.snd' // C_NULL_CHAR

     ! operation
     !character (kind= C_CHAR, len=128) :: data_directory = &
     !     '/home/bpmelli/scratch/examplecase/vardata/45km/vardata0015_45km' // C_NULL_CHAR
     character (kind= C_CHAR, len=128) :: data_directory = &
          '/home/bpmelli/scratch/lineartrack/vardata' // C_NULL_CHAR
     
     character (kind= C_CHAR, len=128) :: output_directory = &
          '/home/bpmelli/scratch/sam_out' // C_NULL_CHAR

     ! projection
     character (kind= C_CHAR, len=32) :: projection = 'lambert_conformal_conic'//char(0)

  end type samurai_config
end module samModule
