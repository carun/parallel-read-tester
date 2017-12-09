g++ --version
g++ -std=c++11 -O3 main.cpp -o cppmain -pthread
ldc2 --version
ldc2 main.d -of=dmain-ldc -O5
dmd --version
dmd main.d -of=dmain-dmd -O
num=1000000
iter=5
./cppmain $(nproc) $num $iter > /dev/null
echo --- LDC ---
./dmain-ldc $(nproc) $num $iter > /dev/null
echo --- DMD ---
./dmain-dmd $(nproc) $num $iter > /dev/null
