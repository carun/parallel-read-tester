private struct Data
{
    ulong id;
    // string      metadata;
    ubyte[3000] feature;
}

private enum ThreadCount = 8;

import std.stdio;
import std.container.array : Array;

__gshared Array!Data gallery; /// Global gallery store
__gshared ReadIterCount = 0; /// Number of times the gallery must be read

private void read(int tid)
{
    ulong totalIterations;
    foreach (_; 0 .. ReadIterCount)
    {
        ulong loopCount;
        foreach (ref item; gallery)
        {
            // let's make sure we read something so that the compiler optimization is avoided
            if (loopCount != item.id)
                stderr.writeln("loopCount: ", loopCount, " item.id: ", item.id);

            loopCount++;
            write(item.id);
        }
        totalIterations += loopCount;
    }

    synchronized stderr.writeln(tid, " ", totalIterations);
}

void main(string[] args)
{
    stderr.writeln("=== Starting D version ===");
    if (args.length != 3)
    {
        writefln("Usage: %s <array-size> <read-iter-count>", args[0]);
        return;
    }
    import std.datetime.stopwatch, std.conv : to;

    ReadIterCount = args[2].to!int;

    auto sw = StopWatch(AutoStart.yes);

    foreach (i; 0 .. args[1].to!ulong)
    {
        Data data;
        data.id = i;
        gallery.insertBack(data);
    }

    stderr.writeln("Took ", sw.peek, " to load ", gallery.length,
            " items. Gonna search in parallel...");
    sw.start;

    foreach (i; 0 .. ThreadCount)
    {
        import std.concurrency : spawn;

        spawn(&read, i);
    }
    sw.reset;
    import core.thread : thread_joinAll;

    thread_joinAll();
    stderr.writeln("Took ", sw.peek, " to search.");
}
