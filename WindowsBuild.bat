:msys1 and mingw32
:for msys2 you might wanna add -lmsys-2.0 to the static/no dependencies compilations
echo "*************** Building serial_example (assuming Mingw32)... ***************"
g++ -D_WIN32 -D__MINGW32__ -Iinclude/ src/serial.cc src/impl/win.cc src/impl/list_ports/list_ports_win.cc examples/serial_example.cc -o serial_example -lsetupapi -luuid
echo "*************** Building STATIC serial_example_s (assuming Mingw32)... ***************"
g++ -static -D_WIN32 -D__MINGW32__ -Iinclude/ src/serial.cc src/impl/win.cc src/impl/list_ports/list_ports_win.cc examples/serial_example.cc -o serial_example_s -static-libstdc++ -static-libgcc -lsetupapi -luuid
echo "*************** Building STATIC library: libserial.a (assuming Mingw32)... ***************"
g++ -D_WIN32 -D__MINGW32__ -Iinclude -c src/serial.cc src/impl/win.cc src/impl/list_ports/list_ports_win.cc
ar rcs libserial.a list_ports_win.o serial.o win.o
ranlib libserial.a
echo "*************** Building dynamic library: libserial.dll and libserial.dll.a (assuming Mingw32)... ***************"
g++ -shared -o libserial.dll -D_WIN32 -D__MINGW32__ -Iinclude src/serial.cc src/impl/win.cc -Wl,--out-implib,libserial.dll.a -lsetupapi -luuid
echo "*************** Building dynamic library with STATIC dependencies: libserial.dll and libserial.dll.a (assuming Mingw32)... ***************"
g++ -shared -o libserial_s.dll -D_WIN32 -D__MINGW32__ -Iinclude src/serial.cc src/impl/win.cc -Wl,--out-implib,libserial_s.dll.a -static-libstdc++ -static-libgcc -Wl,-Bstatic -lsetupapi -luuid
echo "*************** Done. ***************"