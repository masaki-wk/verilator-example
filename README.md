# verilator-example

A simple example of how to use Verilator.

## Prerequisites

- Verilator 5.006 or later
- C++ compiler
- GNU Make
- VCD file viewer, e.g. GTKwave (only for viewing signal dumps)

## How to use

Run `make` in the sim/ directory to build and run the simulation.

```shell
$ cd sim
$ make
verilator --cc --exe --build -j 0 -Wall --trace sim_main.cpp top.sv ../src/Counter.sv
make[1]: Entering directory '.../verilator-example/sim/obj_dir'
...
make[1]: Leaving directory '.../verilator-example/sim/obj_dir'
./obj_dir/Vtop +trace
Start tracing to dump.vcd...
- top.sv:41: Verilog $finish
```

If successfull, a signal dump file `dump.vcd` will be created.
