mkdir -p build
cd build
cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_INSTALL_LIBDIR=lib -DWITH_QT6=ON -DINSTALL_CONFIG=ON ..
make -j$(nproc)
sudo make install
