class: CommandLineTool
cwlVersion: v1.0
baseCommand: awk
arguments:
    - >
        BEGIN { OFS = ","; print "i","j","dist","dimer_es","hf","mp2","pr1","grimme","jung","hill" } 
        !read && /## MP2-IFIE/ { read = 1; for(i = 0; i < 4; i++) getline ; next } 
        !read { next } 
        NF == 0 { exit } 
        { $1 = $1; print } 
        END { exit !read } 
stdout: $(inputs.ifie_name)
inputs:
    log:
        type: File
        inputBinding:
            position: 1
        streamable: true
    ifie_name:
        type: string
        default: ifie.txt
outputs:
    ifie:
        type: stdout