# SPEC Configs

## Installing WASI-SDK

WASI-SDK can be installed by cloning and building the 
project as explained [here](https://github.com/WebAssembly/wasi-sdk?tab=readme-ov-file#build).

SPEC building can error as:

```
wasm-ld: error: cannot open <...>/wasi-sdk/build/install/lib/clang/21/lib/wasm32-unknown-wasi/libclang_rt.builtins.a: No such file or directory
```

The workaround we can do is:

```shell
mkdir build/install/lib/clang/21/lib
cp build/install/clang-resource-dir/lib/* build/install/lib/clang/21/lib
```

