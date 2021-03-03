#!/usr/bin/env cwltool
class: Workflow
cwlVersion: v1.0
inputs: 
    pdb:
        type: File
    ligand_charge:
        type: string
        default: ""
outputs:
    fraginfo:
        type: File
        outputSource: extract_fraginfo/fraginfo

steps:
    abinitmp:
        run:
            class: CommandLineTool
            cwlVersion: v1.0
            baseCommand: sh
            arguments: 
                - -c 
                - abinitmp < $(inputs.pdb.nameroot).ajf
            stdout: $(inputs.pdb.nameroot)_autofrag.log
            inputs: 
                pdb:
                    type: File
                ligand_charge:
                    type: string
            outputs:
                log:
                    type: stdout
            requirements:
                InitialWorkDirRequirement:
                    listing:
                        - entryname: $(inputs.pdb.nameroot).ajf
                          entry: |
                            &CNTRL
                            Nprint=0
                            ReadGeom='$(inputs.pdb.path)'
                            /
                            &FMOCNTRL
                            FMO='ON'
                            NBody=2
                            AutoFrag='ON'
                            LigandCharge='$(inputs.ligand_charge)'
                            FragSizeAminoacid='/amino'
                            /
                            &SCF
                            /
                            &BASIS
                            /
                            &OPTCNTRL
                            /
                            &MFMO
                            /
                            &SCZV
                            /
                            &XUFF
                            /
                            &MP2
                            /
                            &MP2DNS
                            /
                            &MP2GRD
                            /
                            &MP3
                            /
                            &LMP2
                            /
                            &LRD
                            /
                            &DFT
                            /
                            &ANALYSIS
                            /
                            &BSSE
                            /
                            &FRAGPAIR
                            /
                            &SOLVATION
                            /
                            &PBEQ
                            /
                            &POP
                            /
                            &GRIDCNTRL
                            /
                            &MCP
                            /
                            &CIS
                            /
                            &CISGRD
                            /
                            &CAFI
                            /
                            &POL
                            /
                            &GF2
                            /
                            &CCPT
                            /
                            &XYZ
                            /
                            &FRAGMENT
                            /
                            &MDCNTRL
                            /
                            &VEL
                            /
                            &NHC
                            /
                            &TYPFRAG
                            /
        in: 
            pdb: pdb
            ligand_charge: ligand_charge
        out:
            - log
    extract_fraginfo:
        run: extract_fraginfo.cwl
        in:
            log: abinitmp/log
        out:
            - fraginfo
requirements:
    SubworkflowFeatureRequirement: {}

