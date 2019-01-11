#
# THIS FILE WAS GENERATED FROM build.gradle. DO NOT EDIT!
#

_gradle_jar_build_file_template = """\
# DO NOT EDIT: automatically generated BUILD file for gradle jar rule {rule_name}
java_import(
    name = 'library',
    jars = ['{artifact_filename}'],
    deps = [
{deps_string}
    ],
    srcjar = {srcjar},
    visibility = ['//visibility:public'],
)
filegroup(
    name = 'file',
    srcs = ['{artifact_filename}'],
    visibility = ['//visibility:public'],
)
"""

_gradle_aar_build_file_template = """\
# DO NOT EDIT: automatically generated BUILD file for gradle aar rule {rule_name}
aar_import(
    name = 'library',
    aar = '{artifact_filename}',
    deps = [
{deps_string}
    ],
    visibility = ['//visibility:public'],
)
filegroup(
    name = 'file',
    srcs = ['{artifact_filename}'],
    visibility = ['//visibility:public'],
)
"""

def _generate_build_file(ctx, template):
    deps_string = "\n".join(["'%s'," % dep for dep in ctx.attr.deps])
    contents = template.format(
        rule_name = ctx.name,
        artifact_filename = ctx.attr.filename,
        srcjar = ctx.attr.srcjar and "'%s'" % ctx.attr.srcjar or "None",
        deps_string = deps_string)
    ctx.file('BUILD.bazel', contents, False)

def _gradle_artifact_impl(ctx, build_template):
    ctx.download(ctx.attr.urls, output="./%s" % (ctx.attr.filename), sha256=ctx.attr.sha256)
    _generate_build_file(ctx, build_template)

def _gradle_jar_impl(ctx):
    _gradle_artifact_impl(ctx, _gradle_jar_build_file_template)

def _gradle_aar_impl(ctx):
    _gradle_artifact_impl(ctx, _gradle_aar_build_file_template)

_gradle_attrs = {
    "filename": attr.string(mandatory = True),
    "urls": attr.string_list(mandatory = True),
    "deps": attr.label_list(),
    "srcjar": attr.label(),
    "sha256": attr.string(mandatory = True),
}

_gradle_jar = repository_rule(
    implementation = _gradle_jar_impl,
    attrs = _gradle_attrs,
    local = False,
)

_gradle_aar = repository_rule(
    implementation = _gradle_aar_impl,
    attrs = _gradle_attrs,
    local = False,
)

def _maybe(repo_rule, name, **kwargs):
    if name not in native.existing_rules():
        repo_rule(name=name, **kwargs)

def android_repositories():
    _maybe(_gradle_jar,
        name = "android_arch_core_common_src",
        filename = "common-1.1.0-sources.jar",
        visibility = ["//visibility:public"],
        sha256 = "c0ff25b4cb61e7dee78ebd954f59792ba31021b518350f87186b2f94ad0398cc",
        urls = [
            "https://dl.google.com/dl/android/maven2/android/arch/core/common/1.1.0/common-1.1.0-sources.jar",
            "https://jcenter.bintray.com/android/arch/core/common/1.1.0/common-1.1.0-sources.jar",
            "https://repo.maven.apache.org/maven2/android/arch/core/common/1.1.0/common-1.1.0-sources.jar",
        ],
    )

    _maybe(_gradle_jar,
        name = "android_arch_core_common",
        filename = "common-1.1.0.jar",
        visibility = ["//visibility:public"],
        sha256 = "d34824b794bc92ff8f647a9bb13a7c73de920de5b47075b5d2c4f0770e9b8bfd",
        urls = [
            "https://dl.google.com/dl/android/maven2/android/arch/core/common/1.1.0/common-1.1.0.jar",
            "https://jcenter.bintray.com/android/arch/core/common/1.1.0/common-1.1.0.jar",
            "https://repo.maven.apache.org/maven2/android/arch/core/common/1.1.0/common-1.1.0.jar",
        ],
        srcjar = "@android_arch_core_common_src//:file",
    )

    _maybe(_gradle_aar,
        name = "android_arch_core_runtime",
        filename = "runtime-1.1.0.aar",
        visibility = ["//visibility:public"],
        sha256 = "83400f7575bcfb8a2eeec64e05590f037bfaed1e56aa3a4214d20e55878445e3",
        urls = [
            "https://dl.google.com/dl/android/maven2/android/arch/core/runtime/1.1.0/runtime-1.1.0.aar",
            "https://jcenter.bintray.com/android/arch/core/runtime/1.1.0/runtime-1.1.0.aar",
            "https://repo.maven.apache.org/maven2/android/arch/core/runtime/1.1.0/runtime-1.1.0.aar",
        ],
        deps = [
            "@android_arch_core_common//:library",
        ],
    )

    _maybe(_gradle_jar,
        name = "android_arch_lifecycle_common_src",
        filename = "common-1.1.0-sources.jar",
        visibility = ["//visibility:public"],
        sha256 = "6d9aa67b2203d8abe64854431fe9c1bba13552d3c20f965178eb253d370b1d9a",
        urls = [
            "https://dl.google.com/dl/android/maven2/android/arch/lifecycle/common/1.1.0/common-1.1.0-sources.jar",
            "https://jcenter.bintray.com/android/arch/lifecycle/common/1.1.0/common-1.1.0-sources.jar",
            "https://repo.maven.apache.org/maven2/android/arch/lifecycle/common/1.1.0/common-1.1.0-sources.jar",
        ],
    )

    _maybe(_gradle_jar,
        name = "android_arch_lifecycle_common",
        filename = "common-1.1.0.jar",
        visibility = ["//visibility:public"],
        sha256 = "614e31cfd33255dc4d5f5d8e62cfa6be2fbbc2a35643a79dc3ed008004c30807",
        urls = [
            "https://dl.google.com/dl/android/maven2/android/arch/lifecycle/common/1.1.0/common-1.1.0.jar",
            "https://jcenter.bintray.com/android/arch/lifecycle/common/1.1.0/common-1.1.0.jar",
            "https://repo.maven.apache.org/maven2/android/arch/lifecycle/common/1.1.0/common-1.1.0.jar",
        ],
        srcjar = "@android_arch_lifecycle_common_src//:file",
    )

    _maybe(_gradle_aar,
        name = "android_arch_lifecycle_livedata_core",
        filename = "livedata-core-1.1.0.aar",
        visibility = ["//visibility:public"],
        sha256 = "14e57ff8ffb65a80c7e72d91f2076acccdaf2970f234c6261e03a6127eb5206b",
        urls = [
            "https://dl.google.com/dl/android/maven2/android/arch/lifecycle/livedata-core/1.1.0/livedata-core-1.1.0.aar",
            "https://jcenter.bintray.com/android/arch/lifecycle/livedata-core/1.1.0/livedata-core-1.1.0.aar",
            "https://repo.maven.apache.org/maven2/android/arch/lifecycle/livedata-core/1.1.0/livedata-core-1.1.0.aar",
        ],
        deps = [
            "@android_arch_lifecycle_common//:library",
            "@android_arch_core_common//:library",
            "@android_arch_core_runtime//:library",
        ],
    )

    _maybe(_gradle_aar,
        name = "android_arch_lifecycle_runtime",
        filename = "runtime-1.1.0.aar",
        visibility = ["//visibility:public"],
        sha256 = "094fd793924dd6a5136753e599ac8174a8147f4a401386b694ba7d818c223e2e",
        urls = [
            "https://dl.google.com/dl/android/maven2/android/arch/lifecycle/runtime/1.1.0/runtime-1.1.0.aar",
            "https://jcenter.bintray.com/android/arch/lifecycle/runtime/1.1.0/runtime-1.1.0.aar",
            "https://repo.maven.apache.org/maven2/android/arch/lifecycle/runtime/1.1.0/runtime-1.1.0.aar",
        ],
        deps = [
            "@android_arch_lifecycle_common//:library",
            "@android_arch_core_common//:library",
        ],
    )

    _maybe(_gradle_aar,
        name = "android_arch_lifecycle_viewmodel",
        filename = "viewmodel-1.1.0.aar",
        visibility = ["//visibility:public"],
        sha256 = "6407c93a5ea9850661dca42a0068d6f3deccefd7228ee69bae1c35d70cbc2557",
        urls = [
            "https://dl.google.com/dl/android/maven2/android/arch/lifecycle/viewmodel/1.1.0/viewmodel-1.1.0.aar",
            "https://jcenter.bintray.com/android/arch/lifecycle/viewmodel/1.1.0/viewmodel-1.1.0.aar",
            "https://repo.maven.apache.org/maven2/android/arch/lifecycle/viewmodel/1.1.0/viewmodel-1.1.0.aar",
        ],
    )

    _maybe(_gradle_aar,
        name = "com_android_support_animated_vector_drawable",
        filename = "animated-vector-drawable-27.1.1.aar",
        visibility = ["//visibility:public"],
        sha256 = "59670473f6e98fda792f7bef25dd7292b0a3106031c7a5e30eb020bf26f077bd",
        urls = [
            "https://dl.google.com/dl/android/maven2/com/android/support/animated-vector-drawable/27.1.1/animated-vector-drawable-27.1.1.aar",
            "https://jcenter.bintray.com/com/android/support/animated-vector-drawable/27.1.1/animated-vector-drawable-27.1.1.aar",
            "https://repo.maven.apache.org/maven2/com/android/support/animated-vector-drawable/27.1.1/animated-vector-drawable-27.1.1.aar",
        ],
        deps = [
            "@com_android_support_support_vector_drawable//:library",
            "@com_android_support_support_core_ui//:library",
        ],
    )

    _maybe(_gradle_aar,
        name = "com_android_support_appcompat_v7",
        filename = "appcompat-v7-27.1.1.aar",
        visibility = ["//visibility:public"],
        sha256 = "0c7808fbbc5838d831e32e3c0a6f84e1f2c981deb8f11e010650f2b57923a335",
        urls = [
            "https://dl.google.com/dl/android/maven2/com/android/support/appcompat-v7/27.1.1/appcompat-v7-27.1.1.aar",
            "https://jcenter.bintray.com/com/android/support/appcompat-v7/27.1.1/appcompat-v7-27.1.1.aar",
            "https://repo.maven.apache.org/maven2/com/android/support/appcompat-v7/27.1.1/appcompat-v7-27.1.1.aar",
        ],
        deps = [
            "@com_android_support_support_annotations//:library",
            "@com_android_support_support_core_utils//:library",
            "@com_android_support_support_fragment//:library",
            "@com_android_support_support_vector_drawable//:library",
            "@com_android_support_animated_vector_drawable//:library",
        ],
    )

    _maybe(_gradle_aar,
        name = "com_android_support_constraint_constraint_layout",
        filename = "constraint-layout-1.1.2.aar",
        visibility = ["//visibility:public"],
        sha256 = "839a7e16fc50adfabaa8cb753e675ed63f94e1e91ba9115ce43b0d6a37fe8aa6",
        urls = [
            "https://dl.google.com/dl/android/maven2/com/android/support/constraint/constraint-layout/1.1.2/constraint-layout-1.1.2.aar",
            "https://jcenter.bintray.com/com/android/support/constraint/constraint-layout/1.1.2/constraint-layout-1.1.2.aar",
            "https://repo.maven.apache.org/maven2/com/android/support/constraint/constraint-layout/1.1.2/constraint-layout-1.1.2.aar",
        ],
        deps = [
            "@com_android_support_constraint_constraint_layout_solver//:library",
        ],
    )

    _maybe(_gradle_jar,
        name = "com_android_support_constraint_constraint_layout_solver",
        filename = "constraint-layout-solver-1.1.2.jar",
        visibility = ["//visibility:public"],
        sha256 = "55f82d93e188b5183b71f4f3bace5725c900b737c3514c841114e225627ff88f",
        urls = [
            "https://dl.google.com/dl/android/maven2/com/android/support/constraint/constraint-layout-solver/1.1.2/constraint-layout-solver-1.1.2.jar",
            "https://jcenter.bintray.com/com/android/support/constraint/constraint-layout-solver/1.1.2/constraint-layout-solver-1.1.2.jar",
            "https://repo.maven.apache.org/maven2/com/android/support/constraint/constraint-layout-solver/1.1.2/constraint-layout-solver-1.1.2.jar",
        ],
    )

    _maybe(_gradle_jar,
        name = "com_android_support_support_annotations_src",
        filename = "support-annotations-27.1.1-sources.jar",
        visibility = ["//visibility:public"],
        sha256 = "287cd8741c993b4d1e945ffefcf76f38a39b2ecdf65533b8d053f1064db388e4",
        urls = [
            "https://dl.google.com/dl/android/maven2/com/android/support/support-annotations/27.1.1/support-annotations-27.1.1-sources.jar",
            "https://jcenter.bintray.com/com/android/support/support-annotations/27.1.1/support-annotations-27.1.1-sources.jar",
            "https://repo.maven.apache.org/maven2/com/android/support/support-annotations/27.1.1/support-annotations-27.1.1-sources.jar",
        ],
    )

    _maybe(_gradle_jar,
        name = "com_android_support_support_annotations",
        filename = "support-annotations-27.1.1.jar",
        visibility = ["//visibility:public"],
        sha256 = "3365960206c3d2b09e845f555e7f88f8effc8d2f00b369e66c4be384029299cf",
        urls = [
            "https://dl.google.com/dl/android/maven2/com/android/support/support-annotations/27.1.1/support-annotations-27.1.1.jar",
            "https://jcenter.bintray.com/com/android/support/support-annotations/27.1.1/support-annotations-27.1.1.jar",
            "https://repo.maven.apache.org/maven2/com/android/support/support-annotations/27.1.1/support-annotations-27.1.1.jar",
        ],
        srcjar = "@com_android_support_support_annotations_src//:file",
    )

    _maybe(_gradle_aar,
        name = "com_android_support_support_compat",
        filename = "support-compat-27.1.1.aar",
        visibility = ["//visibility:public"],
        sha256 = "880ce01ff5be42b233ff8ec0c61cefb7dc3dc9500fea9e24423214813ac27ea2",
        urls = [
            "https://dl.google.com/dl/android/maven2/com/android/support/support-compat/27.1.1/support-compat-27.1.1.aar",
            "https://jcenter.bintray.com/com/android/support/support-compat/27.1.1/support-compat-27.1.1.aar",
            "https://repo.maven.apache.org/maven2/com/android/support/support-compat/27.1.1/support-compat-27.1.1.aar",
        ],
        deps = [
            "@com_android_support_support_annotations//:library",
            "@android_arch_lifecycle_runtime//:library",
        ],
    )

    _maybe(_gradle_aar,
        name = "com_android_support_support_core_ui",
        filename = "support-core-ui-27.1.1.aar",
        visibility = ["//visibility:public"],
        sha256 = "a3ae20e6d5dffba69ac97b99846d2738003af8563843d5f3c9dc4c35b4804241",
        urls = [
            "https://dl.google.com/dl/android/maven2/com/android/support/support-core-ui/27.1.1/support-core-ui-27.1.1.aar",
            "https://jcenter.bintray.com/com/android/support/support-core-ui/27.1.1/support-core-ui-27.1.1.aar",
            "https://repo.maven.apache.org/maven2/com/android/support/support-core-ui/27.1.1/support-core-ui-27.1.1.aar",
        ],
        deps = [
            "@com_android_support_support_annotations//:library",
            "@com_android_support_support_compat//:library",
            "@com_android_support_support_core_utils//:library",
        ],
    )

    _maybe(_gradle_aar,
        name = "com_android_support_support_core_utils",
        filename = "support-core-utils-27.1.1.aar",
        visibility = ["//visibility:public"],
        sha256 = "61036832c54e8701aae954fc3bf96d1d80bf8d9dd531bff77d72def456ba087a",
        urls = [
            "https://dl.google.com/dl/android/maven2/com/android/support/support-core-utils/27.1.1/support-core-utils-27.1.1.aar",
            "https://jcenter.bintray.com/com/android/support/support-core-utils/27.1.1/support-core-utils-27.1.1.aar",
            "https://repo.maven.apache.org/maven2/com/android/support/support-core-utils/27.1.1/support-core-utils-27.1.1.aar",
        ],
        deps = [
            "@com_android_support_support_annotations//:library",
            "@com_android_support_support_compat//:library",
        ],
    )

    _maybe(_gradle_aar,
        name = "com_android_support_support_fragment",
        filename = "support-fragment-27.1.1.aar",
        visibility = ["//visibility:public"],
        sha256 = "ec72d6ac36a1a0e6523bbddba33d73ffad070b9b3dd246cc44d8727a41ddb5e6",
        urls = [
            "https://dl.google.com/dl/android/maven2/com/android/support/support-fragment/27.1.1/support-fragment-27.1.1.aar",
            "https://jcenter.bintray.com/com/android/support/support-fragment/27.1.1/support-fragment-27.1.1.aar",
            "https://repo.maven.apache.org/maven2/com/android/support/support-fragment/27.1.1/support-fragment-27.1.1.aar",
        ],
        deps = [
            "@com_android_support_support_compat//:library",
            "@com_android_support_support_core_ui//:library",
            "@com_android_support_support_core_utils//:library",
            "@com_android_support_support_annotations//:library",
            "@android_arch_lifecycle_livedata_core//:library",
            "@android_arch_lifecycle_viewmodel//:library",
        ],
    )

    _maybe(_gradle_aar,
        name = "com_android_support_support_vector_drawable",
        filename = "support-vector-drawable-27.1.1.aar",
        visibility = ["//visibility:public"],
        sha256 = "1c0f421114cf4627cf208776d6eb4f76340c78b7e96fe6e12b3e6eb950caf1b9",
        urls = [
            "https://dl.google.com/dl/android/maven2/com/android/support/support-vector-drawable/27.1.1/support-vector-drawable-27.1.1.aar",
            "https://jcenter.bintray.com/com/android/support/support-vector-drawable/27.1.1/support-vector-drawable-27.1.1.aar",
            "https://repo.maven.apache.org/maven2/com/android/support/support-vector-drawable/27.1.1/support-vector-drawable-27.1.1.aar",
        ],
        deps = [
            "@com_android_support_support_annotations//:library",
            "@com_android_support_support_compat//:library",
        ],
    )

