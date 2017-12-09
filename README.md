# Overview

C++'s `std::vector` supports parallel reads. I was just curious to see if D's `std.container.array.Array`
supports parallel reads as well.

All the times are average taken with 10+ runs.

```
Threads: 8
Gallery size: 2000000
Iterations: 200
```

Processor: (Skylake) Intel(R) Xeon(R) CPU E5-2630 v3 @ 2.40GHz

|Compiler     |g++ 7.2.0	  |LDC 1.6.0	  |DMD 2.077.1  |
|-------------|-------------|-------------|-------------|
|Load time    |3.5 seconds	|1.5 seconds  |	            |
|Search time  |6.3 seconds	|6.5 seconds  |	            |
|Memory       |           	|		          |             |

```
Threads: 16
Gallery size: 2000000
Iterations: 200
```

Processor: (Haswell) Intel(R) Xeon(R) CPU E5-2630 v3 @ 2.40GHz

|Compiler     |g++ 4.8.5    |LDC 1.6.0  |DMD 2.077.1  |
|-------------|-------------|-----------|-------------|
|Load time	  |3.9 seconds  |crash      |4.2 seconds  |
|Search time  |4.7 seconds  |crash      |Never ending |
|Memory       |             |           |             |
