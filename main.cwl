#!/usr/bin/env -S cwltool --parallel 
class: Workflow
cwlVersion: v1.0
inputs:
    log:
        type: File
outputs:
    fraginfo:
        type: File
        outputSource: extract_fraginfo/fraginfo
    ifie:
        type: File
        outputSource: extract_ifie/ifie
    pieda:
        type: File
        outputSource: extract_pieda/pieda
steps:
    extract_fraginfo:
        run: extract_fraginfo.cwl
        in:
            log: log
        out:
            - fraginfo
    extract_ifie:
        run: extract_ifie.cwl
        in:
            log: log
        out:
            - ifie
    extract_pieda:
        run: extract_pieda.cwl
        in:
            log: log
        out:
            - pieda
requirements:
    SubworkflowFeatureRequirement: {}
