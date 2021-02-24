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
    atom2frag:
        type: File
        outputSource: atom2frag/atom2frag
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
                    { print 
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
    atom2frag:
        run:
            class: CommandLineTool
            cwlVersion: v1.0
            baseCommand: awk
            arguments:
                - >
                    BEGIN { OFS=","; print "atom", "frag" }
                    !nfrag && /NUMBER OF FRAGMENTS/ { nfrag = $5; getline; getline; next } 
                    !nfrag { next } 
                    NF < 1 { exit } 
                    { if (tmp = int(substr($0, 9, 5))) {f = tmp; j = 3} else j = 1;  for (i = j ; i <= NF; i++) atom[$i] = f } 
                    END { for (i = 1; i <= length(atom); i++) print i, atom[i]; exit !nfrag }
            stdout: atom2frag.txt
            inputs:
                section:
                    type: File
                    inputBinding:
                        position: 1
                    streamable: true
            outputs:
                atom2frag:
                    type: stdout
        in:
            section: pull_fragmentation/fragmentation
        out:
            - atom2frag
    
