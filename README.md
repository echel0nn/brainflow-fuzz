# brainflow-fuzz
an attempt to fuzz stream write/read 

1) `git clone https://github.com/brainflow-dev/brainflow.git`
2) `mkdir build`
3) `cd build`
4) `cmake -DCMAKE_CXX_COMPILER=afl-clang-fast++ ..`
5) create `Makefile` & save

```
##########################
###############TEST-CASE##

INCC = \
       $(shell find ../cpp_package/ -type d -name "inc" | sed s/^/-I/)
INCCC = \
       $(shell find ../src/ -type d -name "inc" | sed s/^/-I/)
INC = \
       $(shell find . -type f -name "*.cpp.o" | sed 's/^/ /')

test_brain: test.cpp
	afl-clang-fast++ -v test.cpp $(INC) ./CMakeFiles/BoardController.dir/third_party/ant_neuro/eemagine/sdk/wrapper.cc.o -o test  $(INCC) $(INCCC) -I../third_party/json/
#########################
```
6) `make test_brain`
7) `./test` [test](./test.cpp)

8) Prepare [harness.cpp](./harness.cpp)

```
test_harness: harness.cpp
	afl-clang-fast++ -v harness.cpp $(INC) ./CMakeFiles/BoardController.dir/third_party/ant_neuro/eemagine/sdk/wrapper.cc.o -o harness  $(INCC) $(INCCC) -I../third_party/json/
```
9) run afl-fuzz with default settings: `AFL_AUTORESEUME=1 afl-fuzz -D -L0 -i samples/ -t 80 -o sync_dir -M fuzzer00 -- ./harness @@`
