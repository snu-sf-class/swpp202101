## How to Build LLVM

Recommended setting:
- RAM: 8 GB or more
- HDD: More than 10GB free space
- OS:
  - Windows (please install WSL: https://docs.microsoft.com/en-us/windows/wsl/wsl2-install)
  - Linux
  - Mac OS

If you think your computer isn't powerful to do this, ask TAs via mail to provide a laptop.

#### Prerequisites

We'll use https://github.com/aqjune/llvmscript.

```
# Install dependencies
apt update
apt install git cmake ninja-build g++ python3-distutils zlib1g-dev libtinfo-dev libxml2-dev

# Clone llvmscript
git clone https://github.com/aqjune/llvmscript.git
cd llvmscript

# Let's clone LLVM source tree!
# Please edit "src" attribute at examples/llvm-12.0.json to specify where to clone LLVM project
python3 run.py clone --cfg examples/llvm-12.0.json

# Finally, build LLVM:
python3 run.py build --cfg examples/llvm-12.0.json --type relassert --core <# of cores to use>
# --type:
#   release: fast build, has no debug info
#   relassert: fast build, enables assertion checks (recommended)
#   debug: slow build, large binaries; you can debug llvm using gdb/lldb
# NOTE: if it aborts due to insufficient memory space, please re-try with
#       smaller number of cores (it will restart from the last state)
```

It is possible that building files may raise many warnings on the screen, but it is okay.

If build is successfully done, you must have `clang` and `opt` executable files at `llvm-12.0-releaseassert/bin`.

#### Troubleshootings

- If it fails with this error message, please remove `compiler-rt` from `llvm.json`:

```
CMake Error at (llvm 경로)/compiler-rt/test/builtins/CMakeLists.txt:55 (message):
  Target clang_rt.builtins_x86_64_osx does not exist
```
