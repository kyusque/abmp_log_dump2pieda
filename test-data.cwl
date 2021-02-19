#!/usr/bin/env -S cwltool --outdir test --parallel
class: Workflow
cwlVersion: v1.0
inputs: {}
outputs:
    ajf:
        type: File
        outputSource: init/ajf
    log:
        type: File
        outputSource: abinitmp/log
    cpf:
        type: File
        outputSource: abinitmp/cpf
    pdb:
        type: File
        outputSource: abinitmp/pdb

steps:
    init:
        run:
            class: CommandLineTool
            cwlVersion: v1.0
            baseCommand: echo 
            arguments:
                - hoge
            inputs: {}
            outputs:
                ajf:
                    type: File
                    outputBinding:
                        glob: test.ajf
        in: {}
        out:
            - ajf
    abinitmp:
        run:
            class: CommandLineTool
            cwlVersion: v1.0
            baseCommand: abinitmp_smp
            arguments: null
            stdin: $(inputs.ajf.path)
            stdout: test.log
            inputs: 
                ajf:
                    type: File
                    streamable: true
            outputs:
                log:
                    type: stdout
                cpf:
                    type: File
                    outputBinding:
                        glob: test.cpf
                pdb:
                    type: File
                    outputBinding:
                        glob: test.pdb
        in: 
            ajf: init/ajf
        out:
            - log
            - cpf
            - pdb



requirements:
    InitialWorkDirRequirement:
        listing:
            - entryname: test.ajf
              entry: |
                &CNTRL
                Method='MP2'
                Memory=3000
                ReadGeom='test.pdb'
                WriteGeom='test.cpf'
                /
                &FMOCNTRL
                FMO='ON'
                NBody=2
                AutoFrag='ON'
                /
                &SCF
                MaxSCFenergy=1.0e-6
                MaxSCFdensity=1.0e-4
                MaxSCFcyc=1000
                /
                &BASIS
                BasisSet='STO-3G'
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
                PIEDA='YES'
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
            - entryname: test.pdb
              entry: |
                ATOM      1  N   LEU A   5      -3.133  -1.207  -2.038  1.00  0.05           N1+
                ATOM      2  CA  LEU A   5      -2.275  -0.079  -2.358  1.00  0.07           C  
                ATOM      3  C   LEU A   5      -1.927   0.691  -1.091  1.00  0.06           C  
                ATOM      4  O   LEU A   5      -1.071   1.570  -1.102  1.00  0.08           O  
                ATOM      5  CB  LEU A   5      -2.970   0.844  -3.363  1.00  0.09           C  
                ATOM      6  CG  LEU A   5      -3.050   0.318  -4.798  1.00  0.26           C  
                ATOM      7  CD1 LEU A   5      -3.768  -1.020  -4.848  1.00  1.43           C  
                ATOM      8  CD2 LEU A   5      -3.757   1.326  -5.687  1.00  1.25           C  
                ATOM      9  H1  LEU A   5      -2.654  -1.823  -1.397  1.00  0.05           H  
                ATOM     10  H2  LEU A   5      -3.357  -1.710  -2.885  1.00  0.05           H  
                ATOM     11  H3  LEU A   5      -3.984  -0.872  -1.610  1.00  0.05           H  
                ATOM     12  HA  LEU A   5      -1.368  -0.463  -2.797  1.00  0.07           H  
                ATOM     13  HB2 LEU A   5      -3.975   1.028  -3.013  1.00  0.09           H  
                ATOM     14  HB3 LEU A   5      -2.439   1.781  -3.380  1.00  0.09           H  
                ATOM     15  HG  LEU A   5      -2.050   0.176  -5.182  1.00  0.26           H  
                ATOM     16 HD11 LEU A   5      -3.192  -1.756  -4.309  1.00  1.43           H  
                ATOM     17 HD12 LEU A   5      -3.882  -1.332  -5.874  1.00  1.43           H  
                ATOM     18 HD13 LEU A   5      -4.742  -0.921  -4.391  1.00  1.43           H  
                ATOM     19 HD21 LEU A   5      -4.746   1.513  -5.298  1.00  1.25           H  
                ATOM     20 HD22 LEU A   5      -3.832   0.932  -6.689  1.00  1.25           H  
                ATOM     21 HD23 LEU A   5      -3.196   2.248  -5.703  1.00  1.25           H  
                ATOM     22  N   SER A   6      -2.614   0.354   0.000  1.00  0.05           N  
                ATOM     23  CA  SER A   6      -2.387   1.001   1.290  1.00  0.06           C  
                ATOM     24  C   SER A   6      -1.116   0.460   1.923  1.00  0.07           C  
                ATOM     25  O   SER A   6      -0.150   1.196   2.126  1.00  0.09           O  
                ATOM     26  CB  SER A   6      -3.576   0.771   2.223  1.00  0.07           C  
                ATOM     27  OG  SER A   6      -3.341   1.341   3.500  1.00  0.10           O  
                ATOM     28  H   SER A   6      -3.283  -0.357  -0.064  1.00  0.05           H  
                ATOM     29  HA  SER A   6      -2.270   2.060   1.116  1.00  0.06           H  
                ATOM     30  HB2 SER A   6      -4.456   1.229   1.797  1.00  0.07           H  
                ATOM     31  HB3 SER A   6      -3.743  -0.290   2.339  1.00  0.07           H  
                ATOM     32  HG  SER A   6      -4.073   1.918   3.732  1.00  0.10           H  
                ATOM     33  N   LYS A   7      -1.125  -0.832   2.244  1.00  0.08           N  
                ATOM     34  CA  LYS A   7       0.045  -1.474   2.821  1.00  0.10           C  
                ATOM     35  C   LYS A   7       1.215  -1.292   1.868  1.00  0.10           C  
                ATOM     36  O   LYS A   7       2.379  -1.311   2.267  1.00  0.12           O  
                ATOM     37  CB  LYS A   7      -0.219  -2.961   3.064  1.00  0.13           C  
                ATOM     38  CG  LYS A   7      -0.531  -3.739   1.792  1.00  0.15           C  
                ATOM     39  CD  LYS A   7      -0.896  -5.186   2.089  1.00  0.21           C  
                ATOM     40  CE  LYS A   7       0.280  -5.959   2.665  1.00  1.35           C  
                ATOM     41  NZ  LYS A   7      -0.044  -7.400   2.853  1.00  2.09           N1+
                ATOM     42  H   LYS A   7      -1.935  -1.362   2.086  1.00  0.08           H  
                ATOM     43  HA  LYS A   7       0.270  -0.988   3.760  1.00  0.10           H  
                ATOM     44  HB2 LYS A   7       0.655  -3.401   3.523  1.00  0.13           H  
                ATOM     45  HB3 LYS A   7      -1.058  -3.063   3.737  1.00  0.13           H  
                ATOM     46  HG2 LYS A   7      -1.361  -3.266   1.289  1.00  0.15           H  
                ATOM     47  HG3 LYS A   7       0.339  -3.722   1.152  1.00  0.15           H  
                ATOM     48  HD2 LYS A   7      -1.707  -5.202   2.802  1.00  0.21           H  
                ATOM     49  HD3 LYS A   7      -1.212  -5.660   1.172  1.00  0.21           H  
                ATOM     50  HE2 LYS A   7       1.118  -5.872   1.990  1.00  1.35           H  
                ATOM     51  HE3 LYS A   7       0.544  -5.529   3.621  1.00  1.35           H  
                ATOM     52  HZ1 LYS A   7      -0.862  -7.503   3.485  1.00  2.09           H  
                ATOM     53  HZ2 LYS A   7      -0.269  -7.839   1.937  1.00  2.09           H  
                ATOM     54  HZ3 LYS A   7       0.769  -7.897   3.273  1.00  2.09           H  
                ATOM     55  N   ILE A   8       0.871  -1.111   0.597  1.00  0.09           N  
                ATOM     56  CA  ILE A   8       1.852  -0.899  -0.457  1.00  0.10           C  
                ATOM     57  C   ILE A   8       2.317   0.558  -0.485  1.00  0.08           C  
                ATOM     58  O   ILE A   8       3.480   0.841  -0.766  1.00  0.08           O  
                ATOM     59  CB  ILE A   8       1.259  -1.276  -1.830  1.00  0.11           C  
                ATOM     60  CG1 ILE A   8       1.205  -2.801  -1.991  1.00  0.13           C  
                ATOM     61  CG2 ILE A   8       2.060  -0.644  -2.957  1.00  0.11           C  
                ATOM     62  CD1 ILE A   8       2.565  -3.471  -1.962  1.00  0.16           C  
                ATOM     63  H   ILE A   8      -0.084  -1.129   0.358  1.00  0.09           H  
                ATOM     64  HA  ILE A   8       2.701  -1.537  -0.264  1.00  0.10           H  
                ATOM     65  HC  ILE A   8       1.616   1.347  -0.255  1.00  0.08           H  
                ATOM     66  HB  ILE A   8       0.250  -0.883  -1.873  1.00  0.11           H  
                ATOM     67 HG12 ILE A   8       0.615  -3.219  -1.190  1.00  0.13           H  
                ATOM     68 HG13 ILE A   8       0.738  -3.039  -2.936  1.00  0.13           H  
                ATOM     69 HG21 ILE A   8       3.107  -0.870  -2.823  1.00  0.11           H  
                ATOM     70 HG22 ILE A   8       1.917   0.427  -2.940  1.00  0.11           H  
                ATOM     71 HG23 ILE A   8       1.723  -1.037  -3.904  1.00  0.11           H  
                ATOM     72 HD11 ILE A   8       3.173  -3.086  -2.767  1.00  0.16           H  
                ATOM     73 HD12 ILE A   8       2.442  -4.537  -2.079  1.00  0.16           H  
                ATOM     74 HD13 ILE A   8       3.047  -3.266  -1.018  1.00  0.16           H  
                TER      75      ILE A   8 
                END

