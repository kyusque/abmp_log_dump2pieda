#!/usr/bin/env -S cwltool --outdir test --parallel
class: Workflow
cwlVersion: v1.0
inputs: {}
outputs:
    pieda:
        type: File
        outputSource: extract_pieda/pieda
steps:
    data:
        run: test-data.cwl
        in: {}
        out:
            - ajf
            - log
            - pdb
            - cpf
    extract_pieda:
        run: extract_pieda.cwl
        in:
            log: data/log
        out:
            - pieda

requirements:
    SubworkflowFeatureRequirement: {}