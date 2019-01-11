# Bazel IDE test

This is a dummy project to test Bazel integration with IDE such as Android
Studio and Xcode.

The project is a C++ projet, with a native SDK provided for iOS and Android
applications, and demo apps.

The goal is to have the IDE working the same way with bazel as with native build
system:
- source browsing
- app deployment
- debugging tools

# Remaining issues

Current environment:
- macOS High Sierra: 10.13.6
- bazel: 0.21.0
- [Android Studio plugin](https://plugins.jetbrains.com/plugin/9185-bazel): 2018.10.22.0.2
- Xcode: 10.1
- [Tulsi](https://tulsi.bazel.build/): revision [a21ddce35e3403ce5f9d7bba9b0f74500a861e52](https://github.com/bazelbuild/tulsi/commit/a21ddce35e3403ce5f9d7bba9b0f74500a861e52)

## Android Studio
- [ ] https://github.com/bazelbuild/intellij/issues/295

## Xcode
- [X] [Swift breakpoints](https://github.com/bazelbuild/tulsi/issues/15)
- [ ] [Objective-C breakpoints](https://github.com/bazelbuild/tulsi/issues/16)
- [ ] Cannot map source in profiling
