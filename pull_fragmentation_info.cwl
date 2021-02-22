class: CommandLineTool
cwlVersion: v1.0
baseCommand: awk
arguments:
    - >
        !read && /##.*FRAGMENTATION/ { read = 1; print; next }
        !read { next }
        /##/ { exit }
        { print }
        END { exit !read }
stdout: $(inputs.fragmentation_name)
inputs:
    log:
        type: File
        inputBinding:
            position: 1
        streamable: true
    fragmentation_name:
        type: string
        default: fragmentation.txt
outputs:
    fragmentation:
        type: stdout