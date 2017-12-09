num=2000000
iter=200

# g++ --version
# dmd --version
# ldc2 --version
# gdc --version

g++ -std=c++11 -O3 main.cpp -o cppmain -pthread
ldc2 main.d -of=dmain-ldc -O5
dmd main.d -of=dmain-dmd -O
gdc main.d -o dmain-gdc -O3

./cppmain $(nproc) $num $iter
echo --- LDC ---
./dmain-ldc $(nproc) $num $iter
echo --- DMD ---
./dmain-dmd $(nproc) $num $iter
echo --- GDC ---
./dmain-gdc $(nproc) $num $iter
