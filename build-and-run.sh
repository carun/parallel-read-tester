g++ --version
g++ -std=c++11 -O3 main.cpp -o cppmain -pthread
ldc2 --version
ldc2 main.d -of=dmain -O5
num=2000000
iter=200
./cppmain $(nproc) $num $iter > /dev/null
echo
./dmain $(nproc) $num $iter > /dev/null
