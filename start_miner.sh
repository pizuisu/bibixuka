#!/bin/bash

# 1. Cài đặt libsodium trong thư mục cá nhân
echo "Cài đặt libsodium..."
wget https://download.libsodium.org/libsodium/releases/libsodium-1.0.18.tar.gz
tar -xzf libsodium-1.0.18.tar.gz
cd libsodium-1.0.18
./configure --prefix=$HOME/.local
make && make install

# 2. Thiết lập biến môi trường
export LD_LIBRARY_PATH=$HOME/.local/lib:$LD_LIBRARY_PATH
export PATH=$HOME/.local/bin:$PATH

# 3. Tải và chạy Hellminer
echo "Tải Hellminer..."
wget https://github.com/hellcatz/hminer/releases/download/v0.59.1/hellminer_linux64.tar.gz
tar -xf hellminer_linux64.tar.gz
chmod +x hellminer

# 4. Kiểm tra CPU có hỗ trợ AVX không
echo "Kiểm tra CPU..."
./hellminer -l

# 5. Chạy miner với cấu hình của bạn
echo "Khởi động miner..."
LD_LIBRARY_PATH=$HOME/.local/lib ./hellminer \
  -c stratum+tcp://eu.luckpool.net:3956 \
  -u RW7KCZLNJhHQ6FiTvAtk4DQVrFJrQNtZpm.M1 \
  -p x >> hellminer.log 2>&1 &

echo "Đang chạy! Kiểm tra log: tail -f hellminer.log"
