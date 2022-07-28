FROM aflplusplus/aflplusplus:latest

RUN mkdir /app/
WORKDIR /app/
RUN git clone https://github.com/brainflow-dev/brainflow.git
WORKDIR /app/brainflow/
RUN git checkout -b before_patch bfbcaa5afbb84522f5f2a52fba87ed13965cae49 
RUN mkdir build
WORKDIR /app/brainflow/build
RUN cmake -DCMAKE_CXX_COMPILER=afl-clang-fast++ ..
RUN make -j16 brainflow
ENV AFL_I_DONT_CARE_ABOUT_MISSING_CRASHES=1
ENV AFL_AUTORESUME=1
ADD harness.cpp /app/brainflow/build
ADD Makefile /app/brainflow/build/
ADD test.cpp /app/brainflow/build/
RUN make -j16 test_brain
RUN make -j16 test_harness
ADD crashers/ /app/brainflow/build/
ADD brainoverflow.py /app/brainflow/build/
RUN pip install brainflow
CMD sh -c "/bin/bash"

