workspace(name = "co_ffreling_bazelide")

load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository", "new_git_repository")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")

http_archive(
    name = "bazel_skylib",
    sha256 = "b5f6abe419da897b7901f90cbab08af958b97a8f3575b0d3dd062ac7ce78541f",
    strip_prefix = "bazel-skylib-0.5.0",
    type = "tar.gz",
    urls = ["https://github.com/bazelbuild/bazel-skylib/archive/0.5.0.tar.gz"],
)

load("@bazel_skylib//lib:versions.bzl", "versions")

versions.check("0.16.1")

git_repository(
    name = "bazel_skylib",
    commit = "0b40ea7b13ad2a05d09f36680708900aa43b9fa6",
    remote = "https://github.com/bazelbuild/bazel-skylib.git",
)

git_repository(
    name = "build_bazel_rules_apple",
    commit = "8de147088c67328f2043e2fedd8cb14d490634ae",
    remote = "https://github.com/znly/rules_apple.git",
)

git_repository(
    name = "build_bazel_rules_swift",
    remote = "https://github.com/bazelbuild/rules_swift.git",
    tag = "0.4.0",
)

git_repository(
    name = "build_bazel_tulsi",
    commit = "d5d7a1e0fa6eeeee548b6b2eb850b6d922967825",
    remote = "https://github.com/bazelbuild/tulsi.git",
)

git_repository(
    name = "com_google_googletest",
    commit = "ed8d02cfc689f26b65e6deb585561c59615b05de",
    remote = "https://github.com/google/googletest.git",
)

http_archive(
    name = "com_google_benchmark",
    sha256 = "61ae07eb5d4a0b02753419eb17a82b7d322786bb36ab62bd3df331a4d47c00a7",
    strip_prefix = "benchmark-1.4.1",
    urls = ["https://github.com/google/benchmark/archive/v1.4.1.zip"],
)

android_sdk_repository(
    name = "androidsdk",
    api_level = 26,
	path = "/Users/ffreling/Library/Android/sdk",
)

android_ndk_repository(
    name = "androidndk",
    api_level = 21,
	path = "/Users/ffreling/Library/Android/sdk/ndk-r16b",
)

maven_jar(
    name = "junit4",
    artifact = "junit:junit:4.12",
)

load(
    "@build_bazel_rules_swift//swift:repositories.bzl",
    "swift_rules_dependencies",
)

swift_rules_dependencies()
