#include <cstdint>
#include <cstring>
#include <vector>
#include <thread>
#include <iostream>
#include <mutex>
#include <chrono>

struct Data
{
    uint64_t id;
    // std::string data;
    // std::string metadata;
    char feature[3000];
};

std::vector<Data> gallery;
std::mutex mtx;

const int ThreadCount = 8;
int ReadIterCount = 0;

void read(int tid)
{
    uint64_t totalIterations = 0;
    for (int i = 0; i < ReadIterCount; i++)
    {
        char buff[3000];
        uint64_t loopCount = 0;
        for (auto& item : gallery)
        {
            if (loopCount != item.id)
                std::cerr << "loopCount: " << loopCount << " item.id: " << item.id << std::endl;
            loopCount++;
            memcpy(buff, item.feature, sizeof(item.feature));
            // damn the IO
            //std::cout << item.id;
        }
        totalIterations += loopCount;
    }
    std::lock_guard<std::mutex> _(mtx);
    std::cerr << tid << " " << totalIterations << std::endl;
}

int main(int argc, char* args[])
{
    std::cerr << "=== Starting CPP version ===" << std::endl;
    if (argc != 3)
    {
        std::cout << "Usage: " << args[0] << " <array-size> <read-iter-count>" << std::endl;
        return 0;
    }
    uint64_t arrayCount = atol(args[1]);
    ReadIterCount = atoi(args[2]);
    auto start = std::chrono::system_clock::now();
    for (int i = 0; i < arrayCount; ++i)
    {
        Data data;
        data.id = i;
        gallery.emplace_back(data);
    }
    auto end = std::chrono::system_clock::now();

    std::chrono::duration<double> elapsed_seconds = end - start;
    std::cerr << "Took " << elapsed_seconds.count() << " to load " << args[1] << " items. Gonna search in parallel..." << std::endl;

    std::thread t[ThreadCount];

    for (int i = 0; i < ThreadCount; ++i)
        t[i] = std::thread(read, i);

    start = std::chrono::system_clock::now();
    for (int i = 0; i < ThreadCount; ++i)
        t[i].join();
    end = std::chrono::system_clock::now();
    elapsed_seconds = end - start;
    std::cerr << "Took " << elapsed_seconds.count() << " to search" << std::endl << std::flush;
    return 0;
}
