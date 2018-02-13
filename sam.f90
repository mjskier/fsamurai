program main
  use samModule
  use iso_c_binding
  include "samurai_cdef.f90"
  
  type(samurai_config) :: config
  type(c_ptr) :: driver

  integer :: nx, ny, nsigma
  !  real(c_float), allocatable :: sigmas(:)
  real(c_float) :: sigmas(42)
  
  real(c_float), allocatable :: lats(:, :), longs(:, :)
  real(c_float), allocatable :: u1(:, :, :), v1(:, :, :)
  real(c_float), allocatable :: w1(:, :, :)
  real(c_float), allocatable :: th1(:, :, :), p1(:, :, :)

  real(c_float), allocatable :: usam(:, :, :), vsam(:, :, :)
  real(c_float), allocatable :: wsam(:, :, :)	
  real(c_float), allocatable :: thsam(:, :, :), psam(:, :, :)

  real :: f1, f2, f3, f4, f5, f6, f7, f8

  real :: i_min, i_max, i_incr
  real :: j_min, j_max, j_incr

  character (kind=c_char, len=10) :: cdtg = "2015092912"
  integer :: delta = 15
  integer ::iter1 = 60
  
  integer :: status
  
  namelist /sigs/ sigmas

  ! nx = config%nx
  ! ny = config%ny
  nx = 4
  ny = 5
  nsigma = 42

  i_min = -50.0
  i_max = 50.0
  i_incr = 1.0
  
  j_min = -50.0
  j_max = 50.0
  j_incr = 1.0

  ! allocate( sigmas(nsigma) )
  allocate( lats(nx, ny), stat = status )
  allocate( longs(nx, ny), stat = status  )

  allocate( u1(nx, ny, nsigma), stat = status)
  allocate( v1(nx, ny, nsigma), stat = status)
  allocate( w1(nx, ny, nsigma), stat = status)
  allocate( th1(nx, ny, nsigma), stat = status)
  allocate( p1(nx, ny, nsigma), stat = status)
  
  allocate( usam(nx, ny, nsigma), stat = status)
  allocate( vsam(nx, ny, nsigma), stat = status)
  allocate( wsam(nx, ny, nsigma), stat = status)
  allocate( thsam(nx, ny, nsigma), stat = status)
  allocate( psam(nx, ny, nsigma), stat = status)
  
  ! Read sigmas using a namelist
  open(7, file="data/sigmas.txt", status='old')
  read(7, nml = sigs)
  close(7)
  
  ! Read and populate the data arrays
  open(8, file="data/sam.input", status='old', action = 'read')

  ! For testing
  ! Put known values in so that we can test that The C++ side uses the arrays correctly
  
  do i = 1, nx, 1
     do j = 1, ny, 1
        do k = 1, nsigma
           lats(i, j) = i
           longs(i, j) = i * 100 + j * 10 + k
           u1(i, j, k) = i * 100 + j * 10 + k
           v1(i, j, k) = i * 100 + j * 10 + k
           w1(i, j, k) = i * 100 + j * 10 + k
           th1(i, j, k) = i * 100 + j * 10 + k
           p1(i, j, k) = i * 100 + j * 10 + k
           write(*, 100) i, j, k, u1(i, j, k), v1(i, j, k), w1(i, j, k)
           
           ! This is how the arrays could be initialized with values read from a file
           ! read(8, *) lats(i, j), longs(i, j), &
           !      u1(i, j, k), v1(i, j, k), w1(i, j, k), &
           !      th1(i, j, k), p1(i, j, k)
           
        end do
     end do
  end do
  close(8)

  ! Get a handle to varderiver3d.
  ! If you want to initialize with values in the config structure
  ! use this call
  ! driver = create_vardriver3d_c(config, LOGICAL(.FALSE., C_BOOL))

  ! To initialize from an xml config file, use this call instead
  driver = create_vardriver3d_from_xml_c(C_CHAR_"./samurai_basic_cylind.xml"//C_NULL_CHAR, LOGICAL(.FALSE., C_BOOL))
  
  if( .not. c_associated(driver) ) then
     print *, 'Error creating driver from config file'
     call EXIT(1)
  end if

  ! Run the driver with a given set of input.
  ! This procedure can be called multiple times with different input.

  ! This is a function, so check the return value
  
  if( .not. run_vardriver3d_c(driver, &
       nx, ny, nsigma, &
       cdtg, delta, iter1, &
       i_min, i_max, i_incr, &
       j_min, j_max, j_incr, &
       sigmas, lats, longs, &
       u1, v1, w1, th1, p1, &
       usam, vsam, wsam, thsam, psam)) then
     print *, "run_vardriver3d_c was not successful."
     call EXIT(1)
  endif

  ! If we get here, the run was successful
  ! Print the output arrays to make sure we can handle data from the C++ side correctly
  
  do i = 1, nx, 1
     do j = 1, ny, 1
        do k = 1, nsigma
           write(*, 200) i, j, k, usam(i, j, k), vsam(i, j, k), wsam(i, j, k), &
                thsam(i, j, k), psam(i, j, k)
        end do
     end do
  end do
  
  ! All done, delete the driver
  
  call delete_vardriver3d_c(driver)

100 format('(', i3,  ',', i3, ', ', i3, ') ', 'u: ', f7.2, ' v: ', f7.2, ' w: ', f7.2)
200 format('(', i3,  ',', i3, ', ', i3, ') ', 'u: ', f7.2, ' v: ', f7.2, ' w: ', f7.2, &
         ' t: ', f7.2, 'p: ', f7.2)
  
end program main
