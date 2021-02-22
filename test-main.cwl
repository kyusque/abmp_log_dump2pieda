#!/usr/bin/env -S cwltool --outdir test --parallel
class: Workflow
cwlVersion: v1.0
inputs: {}
outputs:
    ajf:
        type: File
        outputSource: data/ajf
    log:
        type: File
        outputSource: data/log
    cpf:
        type: File
        outputSource: data/cpf
    fraginfo:
        type: File
        outputSource: main/fraginfo
    ifie:
        type: File
        outputSource: main/ifie
    pieda:
        type: File
        outputSource: main/pieda
steps:
    data:
        run: test-data2.cwl
        in: {}
        out:
            - ajf
            - log
            - cpf
            - pdb
    main:
        run: main.cwl
        in:
            log: data/log
        out:
            - fraginfo
            - ifie
            - pieda
requirements:
    SubworkflowFeatureRequirement: {}