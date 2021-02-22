#!/usr/bin/env -S cwltool --outdir test --parallel
class: Workflow
cwlVersion: v1.0
inputs: {}
outputs:
    ifie:
        type: File
        outputSource: extract_fraginfo/fraginfo
steps:
    data:
        run: test-data2.cwl
        in: {}
        out:
            - ajf
            - log
            - pdb
            - cpf
    extract_fraginfo:
        run: extract_fraginfo.cwl
        in:
            log: data/log
        out:
            - fraginfo

requirements:
    SubworkflowFeatureRequirement: {}