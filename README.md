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
- bazel: 0.19.0
- [Android Studio plugin](https://plugins.jetbrains.com/plugin/9185-bazel): 2018.10.22.0.2
- Xcode: 10.1
- [Tulsi](https://tulsi.bazel.build/): revision 5efe35fd73e80550d9b4d1d65adb3584082f9f04

## Android Studio
- [ ] https://github.com/bazelbuild/intellij/issues/295

## Xcode
- [ ] https://github.com/bazelbuild/tulsi/issues/15
- [ ] https://github.com/bazelbuild/tulsi/issues/16
