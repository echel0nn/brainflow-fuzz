##########################
####################FUZZ##

INCC = \
       $(shell find ../cpp_package/ -type d -name "inc" | sed s/^/-I/)
INCCC = \
       $(shell find ../src/ -type d -name "inc" | sed s/^/-I/)
INC = \
       $(shell find . -type f -name "*.cpp.o" | sed 's/^/ /')

test_brain: test.cpp
	afl-clang-fast++ -v test.cpp $(INC) ./CMakeFiles/BoardController.dir/third_party/ant_neuro/eemagine/sdk/wrapper.cc.o -o test  $(INCC) $(INCCC) -I../third_party/json/

test_harness: harness.cpp
	afl-clang-fast++ -v harness.cpp $(INC) ./CMakeFiles/BoardController.dir/third_party/ant_neuro/eemagine/sdk/wrapper.cc.o -o harness  $(INCC) $(INCCC) -I../third_party/json/
