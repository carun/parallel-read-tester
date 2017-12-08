g++ --version
g++ -O3 main.cpp -o cppmain -pthread
ldc2 --version
ldc2 main.d -of=dmain -O5
num=2000000
iter=200
./cppmain $num $iter > /dev/null
echo
./dmain $num $iter > /dev/null
