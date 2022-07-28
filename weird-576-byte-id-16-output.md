`/home/dante/brainoverflow.py id\:000016\,sig\:07\,src\:000010\,time\:28990834\,execs\:64400173\,op\:MOpt_havoc\,rep\:8`

```
id:000016,sig:07,src:000010,time:28990834,execs:64400173,op:MOpt_havoc,rep:8

double free or corruption (out)
Aborted (core dumped)
```

`./brainoverflow.py id\:000016\,sig\:07\,src\:000010\,time\:28990834\,execs\:64400173\,op\:MOpt_havoc\,rep\:8`

```
id:000016,sig:07,src:000010,time:28990834,execs:64400173,op:MOpt_havoc,rep:8
```

`$ python brainoverflow.py 576_double_free` <- same file

```
576_double_free
```

`$ python /home/dante/brainoverflow.py 576_double_free` <- same file

```
576_double_free

double free or corruption (out)
Aborted (core dumped)
```

