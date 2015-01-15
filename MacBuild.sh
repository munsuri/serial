#!/bin/bash
#you might want to add -D__MACH__ or -fPIC "-stdlib=libstdc++" (mac default is libc++)
echo "*************** Building serial_example... ***************"
g++ -D__APPLE__ -arch x86_64 -mmacosx-version-min=10.6 -Iinclude/ src/serial.cc src/impl/unix.cc src/impl/list_ports/list_ports_osx.cc examples/serial_example.cc -o serial_example -framework CoreFoundation -framework Foundation -framework IOKit
echo "*************** Building STATIC library: libserial.a... ***************"
g++ -c -D__APPLE__ -Iinclude/ src/serial.cc src/impl/unix.cc src/impl/list_ports/list_ports_osx.cc
ar rcs libserial.a list_ports_osx.o serial.o unix.o
ranlib libserial.a
echo "*************** Building dynamic library: libserial.dylib... ***************"
g++ -dynamiclib -o libserial.dylib -D__APPLE__ -Iinclude/ src/serial.cc src/impl/unix.cc src/impl/list_ports/list_ports_osx.cc -framework CoreFoundation -framework Foundation -framework IOKit
echo "*************** Done. ***************"
