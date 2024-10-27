mkdir -p build
cd build
cmake -DCMAKE_BUILD_TYPE=Debug -DWITH_QT6=ON ..
make -j$(nproc)
#sudo make install
