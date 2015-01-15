#!/bin/bash
echo "*************** Building serial_example... ***************"
g++ -D__linux__ -Iinclude/ src/serial.cc src/impl/unix.cc src/impl/list_ports/list_ports_linux.cc examples/serial_example.cc -o serial_example -lrt
echo "*************** Building STATIC serial_example_s... ***************"
g++ -static -D__linux__ -Iinclude/ src/serial.cc src/impl/unix.cc src/impl/list_ports/list_ports_linux.cc examples/serial_example.cc -o serial_example_s -lrt -lpthread
echo "*************** Building STATIC library: libserial.a... ***************"
g++ -c -D__linux__ -Iinclude/ src/serial.cc src/impl/unix.cc src/impl/list_ports/list_ports_linux.cc
ar rcs libserial.a list_ports_linux.o serial.o unix.o
ranlib libserial.a
echo "*************** Building dynamic library: libserial.so... ***************"
g++ -shared -Wl,-soname,libserial.so -o libserial.so -D__linux__ -Iinclude/ src/serial.cc src/impl/unix.cc src/impl/list_ports/list_ports_linux.cc
echo "*************** Building dynamic library with STATIC dependencies: libserial_s.so... ***************"
g++ -shared -Wl,-soname,libserial_s.so -o libserial_s.so -D__linux__ -Iinclude/ src/serial.cc src/impl/unix.cc src/impl/list_ports/list_ports_linux.cc -static-libstdc++ -static-libgcc -Wl,-Bstatic -lrt -lpthread
echo "*************** Done. ***************"
