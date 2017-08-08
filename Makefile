F90=gfortran
F77FLAGS= -g

CXX=g++
CXXFLAGS= -gdwarf-4

SAMURAI_LIB = /home/bpmelli/devel/samurai.mycoamps/build/release/lib/libsamurai.a
QT_LIBS = -L /home/bpmelli/.linuxbrew/opt/qt/lib -lQt5Core -lQt5Gui -lQt5Xml
OTHER_LIB = -Wl,-rpath,/home/bpmelli/.linuxbrew/opt/qt/lib:/home/bpmelli/.linuxbrew/lib -L /home/bpmelli/.linuxbrew/lib -lhdf5  -lnetcdf -lfftw3 -lnetcdf_c++ -lGeographic -lgomp


COBJS=driver.o

f90: sam.o $(SAMURAI_LIB)
	$(CXX) -o f90 sam.o $(SAMURAI_LIB) $(QT_LIBS) $(OTHER_LIB) -lgfortran 
sam.o: sam.f90 samModule.mod
	$(F90) $(F77FLAGS) -c sam.f90

samModule.mod: samModule.f90
	$(F90) -c samModule.f90

clean:
	rm -f *.o f90 *.mod *~
