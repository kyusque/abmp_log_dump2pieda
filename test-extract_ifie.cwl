#!/usr/bin/env -S cwltool --outdir test --parallel
class: Workflow
cwlVersion: v1.0
inputs: {}
outputs:
    ifie:
        type: File
        outputSource: extract_ifie/ifie
steps:
    data:
        run: test-data.cwl
        in: {}
        out:
            - ajf
            - log
            - pdb
            - cpf
    extract_ifie:
        run: extract_ifie.cwl
        in:
            log: data/log
        out:
            - ifie

requirements:
    SubworkflowFeatureRequirement: {}