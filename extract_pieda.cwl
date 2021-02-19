class: CommandLineTool
cwlVersion: v1.0
baseCommand: awk
arguments:
    - >
        BEGIN { OFS = ","; print "i", "j", "es", "ex", "ct_mix", "di", "q" }
        !read && /## PIEDA/ { read = 1; for (i = 0; i < 5; i++) getline }
        !read { next }
        NF == 0 { exit }
        read { $1 = $1;  print }
        END { exit !read }
stdout: $(inputs.pieda_name)
inputs:
    log:
        type: File
        inputBinding:
            position: 1
        streamable: true
    pieda_name:
        type: string
        default: pieda.txt
outputs:
    pieda:
        type: stdout