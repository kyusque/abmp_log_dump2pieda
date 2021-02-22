#!/usr/bin/env cwltool
class: Workflow
cwlVersion: v1.0
inputs:
    log:
        type: File
outputs:
    fraginfo:
        type: File
        outputSource: fraginfo/fraginfo
steps:
    pull_fragmentation:
        run: pull_fragmentation_info.cwl
        in: 
            log: log
        out:
            - fragmentation
    fraginfo:
        run:
            class: CommandLineTool
            cwlVersion: v1.0
            baseCommand: awk
            arguments: 
                - >
                    function bool (x) { if (x ~ "^ +$") return "F"; else return "T" }
                    BEGIN { OFS = ","; print "chain","seq","frag","res", "side_chain","s_s","n_term","c_term","charge","info"}
                    !read && /Fragmentation Type/ { read = 1; getline; next } 
                    !read { next } 
                    NF < 1 { exit } 
                    NF > 7 { print 
                    substr($0, 1, 1), 
                    int(substr($0, 2, 4)), 
                    int(substr($0, 6, 7)), 
                    substr($0, 17, 3), 
                    bool(substr($0, 28, 1)), 
                    int(substr($0, 30, 3)), 
                    substr($0, 40, 1), 
                    substr($0, 49, 1), 
                    int(substr($0, 55, 2)), 
                    substr($0, 58) 
                    }
                    END { exit !read }
            stdout: fraginfo.txt
            inputs:
                log:
                    type: File
                    inputBinding:
                        position: 1
                    streamable: true
            outputs:
                fraginfo:
                    type: stdout
        in:
            log: pull_fragmentation/fragmentation
        out:
            - fraginfo
    