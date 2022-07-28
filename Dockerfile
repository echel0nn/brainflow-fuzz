FROM aflplusplus/aflplusplus:latest

RUN mkdir /app/
WORKDIR /app/
RUN git clone https://github.com/brainflow-dev/brainflow.git
WORKDIR /app/brainflow/
RUN git checkout -b before_patch bfbcaa5afbb84522f5f2a52fba87ed13965cae49 
RUN mkdir build
WORKDIR /app/brainflow/build
RUN cmake -DCMAKE_CXX_COMPILER=afl-clang-fast++ ..
RUN make -j16 Brainflow
ENV AFL_I_DONT_CARE_ABOUT_MISSING_CRASHES=1
ENV AFL_AUTORESUME=1
ADD harness.cpp /app/brainflow/build
ADD Makefile_2 /app/brainflow/build/
ADD test.cpp /app/brainflow/build/
RUN cat Makefile_2 >> Makefile
RUN make -j16  test_brain
RUN make -j16  test_harness
ADD ./fuzz.sh /app/brainflow/build/
RUN mkdir crashers
RUN mkdir samples
ADD ./test.csv samples/test.csv
ADD ./b64_14_bytes b64_14_bytes
ADD ./b64_1168_python_crasher b64_1168_python_crasher
RUN base64 -d b64_14_bytes > crashers/14_bytes
RUN base64 -d b64_1168_python_crasher > crashers/1168_python_crasher
RUN rm b64_14_bytes
RUN rm b64_1168_python_crasher
ADD brainoverflow.py /app/brainflow/build/
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py
RUN rm get-pip.py
RUN pip install brainflow pandas
CMD sh -c "/bin/bash"

