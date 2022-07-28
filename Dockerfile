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
RUN echo -ne "MQkxCjkJMQkxCTIKMQo=" | base64 -d > crashers/14_byte
ADD crashers/sigsegv_23_zero /app/brainflow/build/crashers/python_crasher
ADD brainoverflow.py /app/brainflow/build/
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py
RUN rm get-pip.py
RUN pip install brainflow pandas
CMD sh -c "/bin/bash"
