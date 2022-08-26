def _impl(ctx):
    node_toolchain = ctx.toolchains["@rules_nodejs//nodejs:toolchain_type"].nodeinfo
    output = ctx.actions.declare_file(str(ctx.attr.name) + ".txt")

    ctx.actions.run_shell(
        mnemonic = "RemoteAction",
        outputs = [output],
        inputs = [ctx.file.script],
        command = "{script} {node_bin} {out}".format(
            script = ctx.executable.script.path,
            node_bin = node_toolchain.target_tool_path,
            out = output.path,
        ),
        tools = node_toolchain.tool_files + ctx.files.data,
    )

    return DefaultInfo(
        files = depset([output]),
        runfiles = ctx.runfiles(files = [output, ctx.file.script] + ctx.files.data),
    )

remote_rule = rule(
    implementation = _impl,
    attrs = {
        "data": attr.label_list(mandatory = True),
        "script": attr.label(
            allow_single_file = True,
            default = Label("//bazel/remote_rule:script.sh"),
            executable = True,
            cfg = "exec",
            providers = [DefaultInfo],
        ),
    },
    provides = [DefaultInfo],
    toolchains = ["@rules_nodejs//nodejs:toolchain_type"],
)

