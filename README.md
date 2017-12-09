# Overview

C++'s `std::vector` supports parallel reads. I was just curious to see if D's `std.container.array.Array`
supports parallel reads as well.

All the times are average taken with 10+ runs.

Memory measurement with `grep VmRSS $(pgrep dmain)`
```
Threads: 8
Gallery size: 2000000
Iterations: 200
```

* Processor: (Skylake) Intel(R) Core(TM) i7-6770HQ CPU @ 2.60GHz
* OS: Ubuntu 17.10 64 bit

|Compiler       |g++ 7.2.0      |LDC 1.6.0          |DMD 2.077.1    |gdc 7.2.0  |
|---------------|---------------|-------------------|---------------|-----------|
|Load time      |3.5 seconds    |1.4 seconds        |3.8 seconds    |1.7 seconds|
|Search time    |6.5 seconds    |crash (6.9 seconds)|275 seconds    |185 seconds|
|Memory         |5878132 kB     |5878072 kB         |5878136 kB     |5877944 kB |

```
Threads: 16
Gallery size: 2000000
Iterations: 200
```

* Processor: (Haswell) Intel(R) Xeon(R) CPU E5-2630 v3 @ 2.40GHz
* OS: RHEL 7.3 64 bit

|Compiler       |g++ 4.8.5      |LDC 1.6.0          |DMD 2.077.1    |
|---------------|---------------|-------------------|---------------|
|Load time      |3.9 seconds    |2.1 seconds        |4.2 seconds    |
|Search time    |4.7 seconds    |crash (35 seconds) |328 seconds    |
|Memory         |               |                   |               |
