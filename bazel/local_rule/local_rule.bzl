def _impl(ctx):
    node_toolchain = ctx.toolchains["@rules_nodejs//nodejs:toolchain_type"].nodeinfo
    output = ctx.actions.declare_file(str(ctx.attr.name) + ".txt")

    ctx.actions.run_shell(
        mnemonic = "LocalAction",
        outputs = [output],
        inputs = [],
        command = "{script} {node_bin} {out}".format(
            script = ctx.executable.script.path,
            node_bin = node_toolchain.target_tool_path,
            out = output.path,
        ),
        execution_requirements = {
            "no-remote-exec": "1",
        },
        tools = node_toolchain.tool_files,
    )

    return DefaultInfo(
        files = depset([output]),
        runfiles = ctx.runfiles(files = [output, ctx.file.script])
    )

local_rule = rule(
    implementation = _impl,
    attrs = {
        "script": attr.label(
            allow_single_file = True,
            default = Label("//bazel/local_rule:script.sh"),
            executable = True,
            cfg = "exec",
            providers = [DefaultInfo],
        ),
    },
    provides = [DefaultInfo],
    toolchains = ["@rules_nodejs//nodejs:toolchain_type"],
)

