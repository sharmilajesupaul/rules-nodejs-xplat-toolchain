# Rules NodeJS XPlat Toolchain

First, add your engflow cluster info to `./.bazelrc`

Then, to repro the issue, on macOS, run:
```
bazel build --config=remote :remote_rule
```

```
WARNING: Option 'host_javabase' is deprecated
WARNING: Option 'javabase' is deprecated
WARNING: Option 'host_java_toolchain' is deprecated
INFO: Streaming build results to: https://.../invocation/6aa8da2f-d309-4e1f-88d8-c28da12d9ba5
INFO: Analyzed target //:remote_rule (5 packages loaded, 152 targets configured).
INFO: Found 1 target...
ERROR: /Users/sharmila_jesupaul/bazel-rules-nodejs-repro/BUILD.bazel:5:11: LocalAction local_rule.txt failed: (Exit 126): bash failed: error executing command /bin/bash -c 'bazel/local_rule/script.sh external/nodejs_linux_amd64/bin/nodejs/bin/node bazel-out/darwin-fastbuild/bin/local_rule.txt'
bazel/local_rule/script.sh: line 7: external/nodejs_linux_amd64/bin/nodejs/bin/node: cannot execute binary file
Target //:remote_rule failed to build
Use --verbose_failures to see the command lines of failed build steps.
INFO: Elapsed time: 3.523s, Critical Path: 0.02s
INFO: 2 processes: 2 internal.
INFO: Streaming build results to: https://engflow-canary.musta.ch/invocation/6aa8da2f-d309-4e1f-88d8-c28da12d9ba5
FAILED: Build did NOT complete successfully
```

Note the line: `bash failed: error executing command /bin/bash -c 'bazel/local_rule/script.sh external/nodejs_linux_amd64/bin/nodejs/bin/node bazel-out/darwin-fastbuild/bin/local_rule.txt'`

A linux binary is being used on macOS.